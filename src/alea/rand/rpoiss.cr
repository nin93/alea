require "../internal/ipoiss"

module Alea
  struct Random
    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    #
    # **@parameters**:
    # * `lam`: separation parameter of the distribution;
    #   usually mentioned as **`λ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `lam` is negative or zero.
    def poisson(lam = 1.0)
      Alea.sanity_check(lam, :lam, :poisson)
      Alea.param_check(lam, :<=, 0.0, :lam, :poisson)
      next_poisson lam
    end

    # :nodoc:
    # Unwrapped version of `poisson`.
    # Generate a *poisson-distributed*, pseudo-random `Int64`.
    def next_poisson : Int64
      Alea::Core.poisson_mult 1.0, @prng
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `poisson`.
      # Generate a *poisson-distributed*, pseudo-random `Int64`.
      def next_poisson(lam : {{t1}}) : Int64
        (lam >= 10.0) && return Alea::Core.poisson_ptrs lam, @prng
        (lam == 0.0) && return 0i64
        Alea::Core.poisson_mult lam, @prng
      end
    {% end %}
  end
end
