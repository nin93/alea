module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `scale`: scale parameter of the distribution;
  #   usually mentioned as **`λ^-1`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `scale` is negative or zero.
  def self.exp(x : Float, scale : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :exp)
    Alea.sanity_check(scale, :scale, :exp)
    Alea.param_check(scale, :<=, 0.0, :scale, :exp)
    x <= 0.0 && return 0.0
    1.0 - Math.exp(-x / scale)
  end
end
