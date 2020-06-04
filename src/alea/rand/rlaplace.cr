require "../core/cerr"

module Alea
  struct Random
    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `scale` is negative or zero.
    def laplace(loc = 0.0, scale = 1.0)
      __laplace64 loc, scale
    end

    # Run-time argument sanitizer for `#laplace`.
    private def __laplace64(loc : Number, scale : Number) : Float64
      Alea.param_check(scale, :<=, 0.0, :scale, :laplace)

      if loc.class < Float
        Alea.sanity_check(loc, :loc, :laplace)
      end

      if scale.class < Float
        Alea.sanity_check(scale, :scale, :laplace)
      end

      __next_laplace64 * scale.to_f64 + loc.to_f64
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unparsed version of `laplace`.
    #
    # **@notes**:
    # * `loc` is `0.0`.
    # * `scale` is `1.0`.
    def next_laplace : Float64
      __next_laplace64
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unparsed version of `laplace`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    #
    # **@notes**:
    # * `scale` is `1.0`.
    def next_laplace(loc : Float64) : Float64
      __next_laplace64 + loc
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unparsed version of `laplace`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`b`**.
    def next_laplace(loc : Float64, scale : Float64) : Float64
      __next_laplace64 * scale + loc
    end

    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `laplace`.
    private def __next_laplace64 : Float64
      while true
        u = @prng.next_f64
        u >= 0.5 && return -Math.log(2.0 - u - u)
        u > 0.0 && return Math.log(u + u)
        # Reject u == 0.0
      end
    end
  end
end
