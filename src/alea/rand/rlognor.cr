require "../internal/ierr"
require "./rnorm"

module Alea
  struct Random
    # Generate a *lognormal-distributed*, pseudo-random `Float64`.
    #
    # Parameters:
    # - **mean**: centrality parameter, or mean of the underlying normal distribution
    # - **sigma**: scale parameter, or standard deviation of the underlying normal distribution
    #
    # Raises:
    # - `Alea::NaNError` if any of the arguments is NaN
    # - `Alea::InfinityError` if any of the arguments is Infinity
    # - `Alea::UndefinedError` if **sigma** is negative or zero
    def lognormal(mean = 0.0, sigma = 1.0)
      Alea.sanity_check(mean, :mean, :lognormal)
      Alea.sanity_check(sigma, :sigma, :lognormal)
      Alea.param_check(sigma, :<=, 0.0, :sigma, :lognormal)
      next_lognormal mean, sigma
    end

    # :nodoc:
    # Unwrapped version of `lognormal`.
    # Generate a *lognormal-distributed*, pseudo-random `Float64`.
    def next_lognormal : Float64
      Math.exp(next_normal)
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `lognormal`.
      # Generate a *lognormal-distributed*, pseudo-random `Float64`.
      def next_lognormal(mean : {{t1}}) : Float64
        Math.exp(next_normal + mean)
      end
    {% end %}

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # :nodoc:
        # Unwrapped version of `lognormal`.
        # Generate a *lognormal-distributed*, pseudo-random `Float64`.
        def next_lognormal(mean : {{t1}}, sigma : {{t2}}) : Float64
          Math.exp(next_normal * sigma + mean)
        end
      {% end %}
    {% end %}
  end
end
