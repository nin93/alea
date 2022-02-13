# require "../../functions"
require "../../utils"
require "../random"

module Alea
  struct Random(G)
    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    #
    # **@parameters**:
    # * `lam`: separation parameter of the distribution;
    #   usually mentioned as **`λ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `lam` is negative or zero.
    def poisson(lam = 1.0)
      __poisson64 lam
    end

    # Run-time argument sanitizer for `#poisson`.
    private def __poisson64(lam : Number) : Int64
      if lam.class < Float
        Alea::Utils.sanity_check(lam, :lam, :poisson)
      end

      Alea::Utils.param_check(lam, :<=, 0.0, :lam, :poisson)

      __next_poisson64 lam.to_f64
    end

    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    # Unparsed version of `#poisson`.
    #
    # **@notes**:
    # * `lam` is `1.0`.
    def next_poisson : Int64
      poisson_mult 1.0
    end

    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    # Unparsed version of `#poisson`.
    #
    # **@parameters**:
    # * `lam`: separation parameter of the distribution;
    #   usually mentioned as **`λ`**.
    def next_poisson(lam : Float64) : Int64
      __next_poisson64 lam
    end

    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    # Unwrapped version of `#poisson`.
    private def __next_poisson64(lam : Float64) : Int64
      (lam >= 10.0) && return poisson_ptrs lam
      (lam == 0.0) && return 0i64
      poisson_mult lam
    end

    private def poisson_ptrs(lam : Float | Int)
      slam = Math.sqrt lam
      llam = Math.log lam
      b = 0.931 + 2.53 * slam
      a = -0.059 + 0.02483 * b
      inv = 1.1239 + 1.1328 / (b - 3.4)
      vr = 0.9277 - 3.6224 / (b - 2.0)
      while true
        u = @prng.next_f64 - 0.5
        v = @prng.next_f64
        us = 0.5 - u.abs
        k = Int64.new((2.0 * a / us + b) * u + lam + 0.43)
        ((us >= 0.07) && (v <= vr)) && return k
        ((k < 0) || ((us < 0.013) && (v > us))) && next
        log = Math.log(v) + Math.log(inv) - Math.log(a / (us * us) + b)
        gam = -(lam - k * llam + Math.lgamma(k + 1i64))
        (log <= gam) && return k
      end
    end

    private def poisson_mult(lam : Float | Int)
      lam = lam.to_f
      enlam = Math.exp(-lam)
      x = 0i64
      prod = 1.0
      while true
        u = @prng.next_f64
        prod *= u
        (enlam >= prod) && return x
        x += 1i64
      end
    end
  end
end
