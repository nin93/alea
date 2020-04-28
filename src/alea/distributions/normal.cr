require "../random"
require "./ziggurat"

module Alea
  class Random
    # Generate a normal-distributed random `Float64`
    # with mean 0.0 and standard deviation 1.0.
    def next_normal : Float64
      while true
        r = @prng.next_u >> 12
        rabs = Int64.new(r >> 1)
        idx = rabs & 0xff
        x = (r & 0x1 == 1 ? -rabs : rabs) * Ziggurat::Normal::W[idx]
        # this returns 99.3% of the time on 1st try
        rabs < Ziggurat::Normal::K[idx] && return x
        if idx == 0
          while true
            xx = -Ziggurat::Normal::RINV * Math.log(@prng.next_f)
            yy = -Math.log(@prng.next_f)
            (yy + yy > xx * xx) && return (rabs >> 8) & 0x1 == 1 ? -Ziggurat::Normal::R - xx : Ziggurat::Normal::R + xx
          end
        else
          # return from the triangular area
          (Ziggurat::Normal::F[idx - 1] - Ziggurat::Normal::F[idx]) * @prng.next_f + \
            Ziggurat::Normal::F[idx] < Math.exp(-0.5 * x * x) && return x
        end
      end
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a normal-distributed random `Float64`
      # with given mean and standard deviation 1.0.
      def next_normal(mean : {{t1}}) : Float64
        next_normal + mean
      end
    {% end %}

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # Generate a normal-distributed random `Float64`
        # with given mean and standard deviation.
        def next_normal(mean : {{t1}}, sigma : {{t2}}) : Float64
          next_normal * sigma + mean
        end
      {% end %}
    {% end %}
  end
end
