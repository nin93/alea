require "../random"

module Alea
  class Random
    # Generate a standard laplace-distributed random `Float64`
    # centred in 0.0 and scaled by 1.0.
    def next_laplace : Float64
      while true
        u = @prng.next_f
        u >= 0.5 && return -Math.log(2.0 - u - u)
        u > 0.0 && return Math.log(u + u)
      end
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a standard laplace-distributed random `Float64`
      # centred in 0.0 and scaled by 1.0.
      def next_laplace(mean : {{t1}}) : Float64
        while true
          u = @prng.next_f
          u >= 0.5 && return mean - Math.log(2.0 - u - u)
          u > 0.0 && return mean + Math.log(u + u)
        end
      end
    {% end %}

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # Generate a laplace-distributed random `Float64`
        # with given center and scale.
        def next_laplace(mean : {{t1}}, scale : {{t2}}) : Float64
          while true
            u = @prng.next_f
            u >= 0.5 && return mean - scale * Math.log(2.0 - u - u)
            u > 0.0 && return mean + scale * Math.log(u + u)
          end
        end
      {% end %}
    {% end %}
  end
end
