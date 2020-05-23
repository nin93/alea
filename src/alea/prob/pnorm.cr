module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the distribution;
  #   usually mentioned as **`μ`**.
  # * `sigma`: scale parameter, or standard deviation of the distribution;
  #   usually mentioned as **`σ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `sigma` is negative or zero.
  def self.normal(x : Float, loc : Float = 0.0, sigma : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :normal)
    Alea.sanity_check(loc, :loc, :normal)
    Alea.sanity_check(sigma, :sigma, :normal)
    Alea.param_check(sigma, :<=, 0.0, :sigma, :normal)
    0.5 * (1.0 + Math.erf((x - loc) / (sigma * 1.4142135623730951)))
  end
end
