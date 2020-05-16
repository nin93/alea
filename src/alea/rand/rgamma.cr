require "./rnorm"
require "./rexp"

module Alea
  struct Random
    # Generate a gamma-distributed random `Float64`
    # with given shape and scale.
    # Raises ArgumentError if parameters are negative or zero.
    def gamma(shape, scale = 1.0)
      if shape <= 0.0 || scale <= 0.0
        raise ArgumentError.new "Expected shape and scale parameters to be greater than 0.0."
      end

      next_gamma shape, scale
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a gamma-distributed random `Float64` with given shape.
      def next_gamma(shape : {{t1}}) : Float64
        shape == 1.0 && return next_exponential
        shape == 0.0 && return 0.0
        if shape < 1.0
          while true
            u = @prng.next_f
            v = next_exponential
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
            u = @prng.next_f
            u < (1.0 - 0.0331_f64 * (x * x) * (x * x)) && return b * v
            Math.log(u) < 0.5 * x * x + b * (1.0 - v + Math.log(v)) && return b * v
          end
        end
      end
    {% end %}

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # Generate a gamma-distributed random `Float64`
        # with given shape and scale.
        def next_gamma(shape : {{t1}}, scale : {{t2}}) : Float64
          next_gamma(shape) * scale
        end
      {% end %}
    {% end %}
  end
end
