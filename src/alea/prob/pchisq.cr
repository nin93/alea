module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `df`: degrees of freedom of the distribution;
  #   usually mentioned as **`k`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `df` is negative or zero.
  def self.chisq(x : Float, df : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :chisq)
    Alea.sanity_check(df, :df, :chisq)
    Alea.param_check(df, :<=, 0.0, :df, :chisq)
    x <= 0.0 && return 0.0
    Alea::Internal.incg_regular_lower(df * 0.5, x * 0.5)
  end
end
