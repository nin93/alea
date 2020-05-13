require "../random"
require "./normal"
require "./exponential"

module Alea
  class Random
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

    # log-gamma function to support some of these distributions.
    # The algorithm comes (with some modifications) from SPECFUN
    # by Shanjie Zhang and Jianming Jin and their book "Computation
    # of Special Functions", 1996, John Wiley & Sons, Inc.
    # https://github.com/numpy/numpy/blob/master/numpy/random/src/distributions/distributions.c#L344
    protected def loggamma(x)
      (x == 1.0 || x == 2.0) && return 0.0

      a = StaticArray[
        1.796443723688307e-01, -2.955065359477124e-02, 6.410256410256410e-03,
        -1.917526917526918e-03, 8.417508417508418e-04, -5.952380952380952e-04,
        7.936507936507937e-04, -2.777777777777778e-03, 8.333333333333333e-02,
      ]

      n = x < 7.0 ? (7.0 - x).to_i64! : 0i64
      x0 = n + x
      x2 = (1.0 / x0) * (1.0 / x0)
      xl = 1.8378770664093453
      a0 = -1.39243221690590e+00
      gl0 = a0
      9.times do |i|
        gl0 = gl0 * x2 + a[i]
      end
      logg = gl0 / x0 + 0.5 * xl + (x0 - 0.5) * Math.log(x0) - x0
      if x < 7.0
        n.times do
          x0 -= 1.0
          logg -= Math.log(x0)
        end
      end
      logg
    end
  end
end
