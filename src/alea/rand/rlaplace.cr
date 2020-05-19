require "../internal/ierr"

module Alea
  struct Random
    # Generate a *laplace-distributed*, pseudo-random `Float64`.
    #
    # Parameters:
    # - **mean**: centrality parameter, or mean of the distribution
    # - **scale**: scale parameter of the distribution
    #
    # Raises:
    # - `Alea::NaNError` if any of the arguments is NaN
    # - `Alea::InfinityError` if any of the arguments is Infinity
    # - `Alea::UndefinedError` if **scale** is negative or zero
    def laplace(mean = 0.0, scale = 1.0)
      Alea.sanity_check(mean, :mean, :laplace)
      Alea.sanity_check(scale, :scale, :laplace)
      Alea.param_check(scale, :<=, 0.0, :scale, :laplace)
      next_laplace mean, scale
    end

    # :nodoc:
    # Unwrapped version of `laplace`.
    # Generate a *laplace-distributed*, pseudo-random `Float64`.
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
      # :nodoc:
      # Unwrapped version of `laplace`.
      # Generate a *laplace-distributed*, pseudo-random `Float64`.
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
        # :nodoc:
        # Unwrapped version of `laplace`.
        # Generate a *laplace-distributed*, pseudo-random `Float64`.
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
