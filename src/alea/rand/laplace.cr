require "../random"

module Alea
  struct Random
    # Generate a laplace-distributed random `Float64`
    # with given center and scale.
    # Raises ArgumentError if scale parameter is negative or zero.
    def laplace(mean = 0.0, scale = 1.0)
      if scale <= 0.0
        raise ArgumentError.new "Expected scale parameter to be greater than 0.0."
      end

      next_laplace mean, scale
    end

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
          u >= 0.5 && return -(Math.log(2.0 - u - u) - mean)
          u > 0.0 && return Math.log(u + u) + mean
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
            u >= 0.5 && return -(Math.log(2.0 - u - u) * scale - mean)
            u > 0.0 && return Math.log(u + u) * scale + mean
          end
        end
      {% end %}
    {% end %}
  end
end
