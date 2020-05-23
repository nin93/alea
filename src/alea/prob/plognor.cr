module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the underlying normal distribution;
  #   usually mentioned as **`μ`**.
  # * `sigma`: scale parameter, or standard deviation of the underlying normal distribution;
  #   usually mentioned as **`σ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `sigma` is negative or zero.
  def self.lognormal(x : Float, loc : Float = 0.0, sigma : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :lognormal)
    Alea.sanity_check(loc, :loc, :lognormal)
    Alea.sanity_check(sigma, :sigma, :lognormal)
    Alea.param_check(sigma, :<=, 0.0, :sigma, :lognormal)
    x <= 0.0 && return 0.0
    0.5 + 0.5 * (Math.erf((Math.log(x) - loc) / (sigma * 1.4142135623730951)))
  end
end
