require "../internal/izigg"
require "../internal/ierr"

module Alea
  struct Random
    # Generate a *exp-distributed*, pseudo-random `Float64`.
    #
    # Parameters:
    # - **scale**: scale parameter of the distribution, also mentioned as *1/lambda*
    #
    # Raises:
    # - `Alea::NaNError` if any of the arguments is NaN
    # - `Alea::InfinityError` if any of the arguments is Infinity
    # - `Alea::UndefinedError` if **scale** is negative or zero
    def exponential(scale = 1.0)
      Alea.sanity_check(scale, :scale, :exponential)
      Alea.param_check(scale, :<=, 0.0, :scale, :exponential)
      next_exponential scale
    end

    # :nodoc:
    # Unwrapped version of `exponential`.
    # Generate a *exp-distributed*, pseudo-random `Float64`.
    def next_exponential : Float64
      while true
        r = @prng.next_u >> 12
        idx = r & 0xff
        x = r * Internal::Exp::W[idx]
        # this returns 98.9% of the time on 1st try
        r < Internal::Exp::K[idx] && return x
        idx == 0 && return Internal::Exp::R - Math.log(@prng.next_f)
        # return from the triangular area
        (Internal::Exp::F[idx - 1] - Internal::Exp::F[idx]) * @prng.next_f + \
          Internal::Exp::F[idx] < Math.exp(-x) && return x
      end
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `exponential`.
      # Generate a *exp-distributed*, pseudo-random `Float64`.
      def next_exponential(scale : {{t1}}) : Float64
        next_exponential * scale
      end
    {% end %}
  end
end
