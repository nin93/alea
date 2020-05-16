require "../random"
require "./normal"

module Alea
  struct Random
    # Generate a lognormal-distributed random `Float64` with given
    # mean and standard deviation of the underlying normal distribution.
    # Raises ArgumentError if sigma parameter is negative or zero.
    def lognormal(mean = 0.0, sigma = 1.0)
      if sigma <= 0.0
        raise ArgumentError.new "Expected standard deviation to be greater than 0.0."
      end

      next_lognormal mean, sigma
    end

    # Generate a lognormal-distributed random `Float64`
    # with underlying standard normal distribution.
    def next_lognormal : Float64
      Math.exp(next_normal)
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a lognormal-distributed random `Float64`
      # with given mean of the underlying normal distribution.
      def next_lognormal(mean : {{t1}}) : Float64
        Math.exp(next_normal + mean)
      end
    {% end %}

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # Generate a lognormal-distributed random `Float64` with given
        # mean and standard deviation of the underlying normal distribution.
        def next_lognormal(mean : {{t1}}, sigma : {{t2}}) : Float64
          Math.exp(next_normal * sigma + mean)
        end
      {% end %}
    {% end %}
  end
end
