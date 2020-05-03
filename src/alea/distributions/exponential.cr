require "../random"
require "./ziggurat"

module Alea
  class Random
    # Generate a exp-distributed random `Float64` with given scale.
    # Scale parameter is lambda^-1.
    # Raises ArgumentError if parameter is negative or zero.
    def exponential(scale = 1.0)
      if scale <= 0.0
        raise ArgumentError.new "Expected scale parameter to be greater than 0.0."
      end

      next_exponential scale
    end

    # Generate a exp-distributed random `Float64` with scale 1.0.
    # Scale parameter is lambda^-1.
    def next_exponential : Float64
      while true
        r = @prng.next_u >> 12
        idx = r & 0xff
        x = r * Ziggurat::Exp::W[idx]
        # this returns 98.9% of the time on 1st try
        r < Ziggurat::Exp::K[idx] && return x
        idx == 0 && return Ziggurat::Exp::R - Math.log(@prng.next_f)
        # return from the triangular area
        (Ziggurat::Exp::F[idx - 1] - Ziggurat::Exp::F[idx]) * @prng.next_f + \
          Ziggurat::Exp::F[idx] < Math.exp(-x) && return x
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

  module CDF
    # Returns the probability of X being less or equal to x
    # with given scale of the distribution. Scale parameter is lambda^-1.
    def exponential(x : Float, scale : Float = 1.0) : Float64
      unless scale > 0.0
        raise ArgumentError.new "Expected scale to be positive."
      end
      x <= 0.0 && return 0.0
      1.0 - Math.exp(-x / scale)
    end
  end
end
