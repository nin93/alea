require "../core/cerr"
require "./rnorm"

module Alea
  struct Random
    # Generate a *log-normal-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the underlying normal distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the underlying normal distribution;
    #   usually mentioned as **`σ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `sigma` is negative or zero.
    def lognormal(loc = 0.0, sigma = 1.0)
      __lognormal64 loc, sigma
    end

    # Run-time argument sanitizer for `#lognormal`.
    private def __lognormal64(loc : Number, sigma : Number) : Float64
      Alea.param_check(sigma, :<=, 0.0, :sigma, :lognormal)

      if loc.class < Float
        Alea.sanity_check(loc, :loc, :lognormal)
      end

      if sigma.class < Float
        Alea.sanity_check(sigma, :sigma, :lognormal)
      end

      __next_lognormal64(next_normal * sigma.to_f64 + loc.to_f64)
    end

    # Generate a *log-normal-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#lognormal`.
    #
    # **@notes**:
    # * `loc` is `0.0`.
    # * `sigma` is `1.0`.
    def next_lognormal : Float64
      __next_lognormal64 next_normal
    end

    # Generate a *log-normal-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#lognormal`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the underlying normal distribution;
    #   usually mentioned as **`μ`**.
    #
    # **@notes**:
    # * `sigma` is `1.0`.
    def next_lognormal(loc : Float64) : Float64
      __next_lognormal64(next_normal + loc)
    end

    # Generate a *log-normal-distributed*, pseudo-random `Float64`.
    # Unparsed version of `#lognormal`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the underlying normal distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the underlying normal distribution;
    #   usually mentioned as **`σ`**.
    def next_lognormal(loc : Float64, sigma : Float64) : Float64
      __next_lognormal64(next_normal * sigma + loc)
    end

    # Generate a *log-normal-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `lognormal`.
    private def __next_lognormal64(norm : Float64) : Float64
      Math.exp(norm)
    end
  end
end
