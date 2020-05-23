require "./rgamma"

module Alea
  struct Random
    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`k`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `df` is negative or zero.
    def chisq(df)
      Alea.sanity_check(df, :df, :chisq)
      Alea.param_check(df, :<=, 0.0, :df, :chisq)
      next_chisq df
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `chisq`.
      # Generate a *chi-square-distributed*, pseudo-random `Float64`.
      def next_chisq(df : {{t1}}) : Float64
        next_gamma(df / 2.0) * 2.0
      end
    {% end %}
  end
end
