## SPDE_multigrid_sample.jl : sample functions for lognormal diffusion problem, with multigrid

## solver ##
function SPDE_mg_solve(Z::Matrix{T}) where {T<:Real}

    A = elliptic2d(exp.(Z))

    b = ones(size(A,1)) # rhs
    mg = V_cycle(A,size(Z).-1) # mg structure
    mg.grids[1].b .= b # copy rhs

    FMG(mg.grids,2,2,1,1,GaussSeidel()), reverse!(getfield.(mg.grids,:sz))
end

# custom FMG routine that returns coarse solutions
function FMG(grids::Vector{G} where {G<:SimpleMultigrid.Grid}, ν₀::Int, ν₁::Int, ν₂::Int, grid_ptr::Int, smoother::SimpleMultigrid.Smoother)
    if grid_ptr == length(grids)
        grids[grid_ptr].x .= zeros(grids[grid_ptr].x)
        sol = Vector{Vector{eltype(grids[1].x)}}()
    else
        grids[grid_ptr+1].b .= grids[grid_ptr].R*grids[grid_ptr].b
        sol = FMG(grids,ν₀,ν₁,ν₂,grid_ptr+1,smoother)
        grids[grid_ptr].x .= SimpleMultigrid.P(SimpleMultigrid.Cubic(),grids[grid_ptr+1].sz...)*grids[grid_ptr+1].x # FMG with cubic interpolation
    end
	# V-cycling
    for i in 1:ν₀
        SimpleMultigrid.μ_cycle!(grids,1,ν₁,ν₂,grid_ptr,smoother)
    end
	# safety
	if SimpleMultigrid.norm_of_residu(grids[grid_ptr]) >= 1/prod(grids[grid_ptr].sz)
		grids[grid_ptr].x .= grids[grid_ptr].A\grids[grid_ptr].b # exact solve
	end
	push!(sol,copy(grids[grid_ptr].x)) 
    return sol
end

## sample functions ##
for mode in ["single" "multiple"]
    ex = :(
           function $(Symbol("SPDE_sample_mg_",mode))(index::Index, ξ::Vector{T} where {T<:Real}, data::SPDE_Data)

               # extract grf
               grf = data[index]

               # solve
               Zf = sample(grf,xi=ξ[1:randdim(grf)]) # compute GRF
	       	   Qf = $(Symbol("SPDE_single_sample_mg_",mode))(Zf)

			   # safety
			   while !(is_valid_sample_mg(Qf))
				    Zf = sample(grf,xi=randn(size(ξ))) # recompute GRF
	       	   		Qf = $(Symbol("SPDE_single_sample_mg_",mode))(Zf)
			   end

               # compute difference
			   dQ = deepcopy(Qf)
			   for ℓ in 0:length(dQ)-1
				   index_ = Index(ℓ)
				   for (key,value) in diff(index_)
				   	   dQ[(index_.+1)...] += value*Qf[(key.+1)...]
				   end
			   end

               return (dQ,Qf)
           end
          )
    eval(ex)
    ex = :(
           function $(Symbol("SPDE_single_sample_mg_",mode))(Z::Matrix{T}) where {T<:Real}
               (sol,szs) = $(Symbol("SPDE_mg_solve"))(Z)
	       $(Symbol("SPDE_",mode,"_qoi")).(sol,szs)
           end
          )
    eval(ex)
end

function is_valid_sample_mg(Qf)
	check = true
	for i in 1:length(Qf)
		if any(j->j>1||j<0,Qf[i])
			check = false
		end
	end 
	return check
end