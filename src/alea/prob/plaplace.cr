module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `loc`: centrality parameter, or mean of the distribution;
  #   usually mentioned as **`μ`**.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`b`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `scale` is negative or zero.
  def self.laplace(x : Float, loc : Float = 0.0, scale : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :laplace)
    Alea.sanity_check(loc, :loc, :laplace)
    Alea.sanity_check(scale, :scale, :laplace)
    Alea.param_check(scale, :<=, 0.0, :scale, :laplace)
    a = (x - loc) / scale
    x < loc && return 0.5 * Math.exp(a)
    1.0 - 0.5 * Math.exp(-a)
  end
end
