require "../core/czig"
require "../core/cerr"

module Alea
  struct Random
    # Generate a *exp-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `scale`: scale parameter of the distribution;
    #   usually mentioned as **`λ^-1`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `scale` is negative or zero.
    def exp(scale = 1.0)
      Alea.sanity_check(scale, :scale, :exp)
      Alea.param_check(scale, :<=, 0.0, :scale, :exp)
      next_exp scale
    end

    # :nodoc:
    # Unwrapped version of `exp`.
    # Generate a *exp-distributed*, pseudo-random `Float64`.
    def next_exp : Float64
      while true
        r = @prng.next_u64 >> 12
        idx = r & 0xff
        x = r * Core::Exp::W[idx]
        # this returns 98.9% of the time on 1st try
        r < Core::Exp::K[idx] && return x
        idx == 0 && return Core::Exp::R - Math.log(@prng.next_f64)
        # return from the triangular area
        (Core::Exp::F[idx - 1] - Core::Exp::F[idx]) * @prng.next_f64 + \
          Core::Exp::F[idx] < Math.exp(-x) && return x
      end
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `exp`.
      # Generate a *exp-distributed*, pseudo-random `Float64`.
      def next_exp(scale : {{t1}}) : Float64
        next_exp * scale
      end
    {% end %}
  end
end
