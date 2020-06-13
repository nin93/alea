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
      __chisq64 df
    end

    # Run-time argument sanitizer for `#chisq`.
    private def __chisq64(df : Number) : Float64
      if df.class < Float
        Alea.sanity_check(df, :df, :chisq)
      end

      Alea.param_check(df, :<=, 0.0, :df, :chisq)

      __next_chisq64 df.to_i32
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    # Unparsed version of `chisq`.
    #
    # **@parameters**:
    # * `df`: degrees of freedom of the distribution;
    #   usually mentioned as **`k`**.
    def next_chisq(df : Int32) : Float64
      __next_chisq64 df
    end

    # Generate a *chi-square-distributed*, pseudo-random `Float64`.
    # Unwrapped version of `chisq`.
    private def __next_chisq64(df : Int32) : Float64
      next_gamma(df / 2.0) * 2.0
    end
  end
end
