require "./rgamma"

module Alea
  struct Random
    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    #
    # Parameters:
    # - **df**: degrees of freedom parameter of the distribution
    #
    # Raises:
    # - `Alea::NaNError` if any of the arguments is NaN
    # - `Alea::InfinityError` if any of the arguments is Infinity
    # - `Alea::UndefinedError` if **df** is negative or zero
    def chi_square(df)
      Alea.sanity_check(df, :df, :chi_square)
      Alea.param_check(df, :<=, 0.0, :df, :chi_square)
      next_chi_square df
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `chi_square`.
      # Generate a *chi-square-distributed*, pseudo-random `Float64`.
      def next_chi_square(df : {{t1}}) : Float64
        next_gamma(df / 2.0) * 2.0
      end
    {% end %}
  end
end
