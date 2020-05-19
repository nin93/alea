require "../internal/izigg"
require "../internal/ierr"

module Alea
  struct Random
    # Generate a exp-distributed random `Float64` with given scale.
    # Scale parameter is lambda^-1.
    # Raises ArgumentError if parameter is negative or zero.
    def exponential(scale = 1.0)
      Alea.sanity_check(scale, :scale, :exponential)
      Alea.param_check(scale, :<=, 0.0, :scale, :exponential)
      next_exponential scale
    end

    # Generate a exp-distributed random `Float64` with scale 1.0.
    # Scale parameter is lambda^-1.
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
      # Generate a exp-distributed random `Float64` with given scale.
      # Scale parameter is lambda^-1.
      def next_exponential(scale : {{t1}}) : Float64
        next_exponential * scale
      end
    {% end %}
  end
end
