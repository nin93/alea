require "../core/cerr"
require "./rnorm"
require "./rexp"

module Alea
  struct Random
    # Generate a *gamma-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `shape`: shape parameter of the distribution;
    #   usually mentioned as **`k`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`θ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if any of `shape` or `scale` is negative or zero.
    def gamma(shape, scale = 1.0)
      __gamma64 shape, scale
    end

    # Run-time argument sanitizer for `#gamma`.
    private def __gamma64(shape : Number, scale : Number) : Float64
      Alea.param_check(shape, :<=, 0.0, :shape, :gamma)
      Alea.param_check(scale, :<=, 0.0, :scale, :gamma)

      if shape.class < Float
        Alea.sanity_check(shape, :shape, :gamma)
      end

      if scale.class < Float
        Alea.sanity_check(scale, :scale, :gamma)
      end

      __next_gamma64(shape.to_f64) * scale.to_f64
    end

    # Generate a *gamma-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `shape`: shape parameter of the distribution;
    #   usually mentioned as **`k`**.
    #
    # **@note**:
    # * `scale` is `1.0`.
    def next_gamma(shape : Float64) : Float64
      __next_gamma64 shape
    end

    # Generate a *gamma-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `shape`: shape parameter of the distribution;
    #   usually mentioned as **`k`**.
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`θ`**.
    def next_gamma(shape : Float64, scale : Float64) : Float64
      __next_gamma64(shape) * scale
    end

    # Generate a *gamma-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `gamma`.
    private def __next_gamma64(shape : Float64) : Float64
      shape == 1.0 && return next_exp
      shape == 0.0 && return 0.0
      if shape < 1.0
        while true
          u = @prng.next_f64
          v = next_exp
          if u <= 1.0 - shape
            x = u ** (1.0 / shape)
            x <= v && return x
          else
            y = -Math.log((1.0 - u) / shape)
            x = (1.0 - shape + shape * y) ** (1.0 / shape)
            x <= v + y && return x
          end
        end
      else
        b = -0.3333333333333333_f64 + shape
        c = 1.0 / Math.sqrt(9.0 * b)
        while true
          while true
            x = next_normal
            v = 1.0 + c * x
            break unless v <= 0.0
          end
          v = v * v * v
          u = @prng.next_f64
          u < (1.0 - 0.0331_f64 * (x * x) * (x * x)) && return b * v
          Math.log(u) < 0.5 * x * x + b * (1.0 - v + Math.log(v)) && return b * v
        end
      end
    end
  end
end
