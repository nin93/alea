require "./rgamma"

module Alea
  struct Random
    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    #
    # Parameters:
    # - **freedom**: degrees of freedom parameter of the distribution
    #
    # Raises:
    # - `Alea::NaNError` if any of the arguments is NaN
    # - `Alea::InfinityError` if any of the arguments is Infinity
    # - `Alea::UndefinedError` if **freedom** is negative or zero
    def chi_square(freedom)
      Alea.sanity_check(freedom, :freedom, :chi_square)
      Alea.param_check(freedom, :<=, 0.0, :freedom, :chi_square)
      next_chi_square freedom
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `chi_square`.
      # Generate a *chi-square-distributed*, pseudo-random `Float64`.
      def next_chi_square(freedom : {{t1}}) : Float64
        next_gamma(freedom / 2.0) * 2.0
      end
    {% end %}
  end
end
