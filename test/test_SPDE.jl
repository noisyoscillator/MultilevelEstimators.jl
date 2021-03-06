## test_SPDE.jl

ϵ₁= 0.1
ϵ₂= 0.005

## Monte Carlo, single qoi
@testset "MC, single qoi               " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mc(continuate=true)
        run(estimator,ϵ₁)
    end
end

## Monte Carlo, multiple qoi
@testset "MC, multiple qoi             " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mc_multiple(continuate=true)
        run(estimator,ϵ₁)
    end
end

## Multilevel Monte Carlo, single qoi
@testset "MLMC, single qoi             " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mlmc(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Multilevel Monte Carlo, multiple qoi
@testset "MLMC, multiple qoi           " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mlmc_multiple(continuate=true)
        run(estimator,ϵ₂)
    end
end

## Quasi-Monte Carlo, single qoi
@testset "QMC, single qoi              " begin
    @suppress begin
        estimator = init_lognormal_diffusion_qmc(continuate=true)
        run(estimator,ϵ₁)
    end
end

# Quasi-Monte Carlo, multiple qoi
@testset "QMC, multiple qoi            " begin
    @suppress begin
        estimator = init_lognormal_diffusion_qmc_multiple(continuate=true)
        run(estimator,ϵ₁)
    end
end

## Multilevel Quasi-Monte Carlo, single qoi
@testset "MLQMC, single qoi            " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mlqmc(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Multilevel Quasi-Monte Carlo, multiple qoi
@testset "MLQMC, multiple qoi          " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mlqmc_multiple(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Multi-Index Monte Carlo, single qoi
@testset "MIMC, single qoi             " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mimc(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Multi-Index Monte Carlo, multiple qoi
@testset "MIMC, multiple qoi           " begin
    @suppress begin
        estimator = init_lognormal_diffusion_mimc_multiple(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Multi-Index Quasi-Monte Carlo, single qoi
@testset "MIQMC, single qoi            " begin
    @suppress begin
        estimator = init_lognormal_diffusion_miqmc(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Multi-Index Quasi-Monte Carlo, multiple qoi
@testset "MIQMC, multiple qoi          " begin
    @suppress begin
        estimator = init_lognormal_diffusion_miqmc_multiple(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Adaptive Multi-Index Monte Carlo, single qoi
@testset "AMIMC, single qoi            " begin
    @suppress begin
        estimator = init_lognormal_diffusion_amimc(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Adaptive Multi-Index Monte Carlo, multiple qoi
@testset "AMIMC, multiple qoi          " begin
    @suppress begin
        estimator = init_lognormal_diffusion_amimc_multiple(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Adaptive Multi-Index Quasi-Monte Carlo, single qoi
@testset "AMIQMC, single qoi           " begin
    @suppress begin
        estimator = init_lognormal_diffusion_amiqmc(continuate=true)
        run(estimator,ϵ₂)
    end
end

# Adaptive Multi-Index Quasi-Monte Carlo, multiple qoi
@testset "AMIQMC, multiple qoi         " begin
    @suppress begin
        estimator = init_lognormal_diffusion_amiqmc_multiple(continuate=true)
        run(estimator,ϵ₂)
    end
end
