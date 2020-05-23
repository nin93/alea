module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `shape`: shape parameter of the distribution;
  #   usually mentioned as **`k`**.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`θ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if any of `shape` or `scale` is negative or zero.
  def self.gamma(x : Float, shape : Float, scale : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :gamma)
    Alea.sanity_check(shape, :shape, :gamma)
    Alea.sanity_check(scale, :scale, :gamma)
    Alea.param_check(shape, :<=, 0.0, :shape, :gamma)
    Alea.param_check(scale, :<=, 0.0, :scale, :gamma)
    x <= 0.0 && return 0.0
    Alea::Internal.incg_regular_lower(shape, x / scale)
  end
end
