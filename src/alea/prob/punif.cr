module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `x`.
  #
  # **@parameters**:
  # * `x`: real-valued quantile of which estimate the cdf.
  # * `min`: left bound parameter of range of the distribution;
  #   usually mentioned as **`a`**.
  # * `max`: right bound parameter of range of the distribution;
  #   usually mentioned as **`b`**.
  #
  # **@notes**:
  # * *range* is `[min, max)`.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments bound is `NaN`.
  # * `Alea::InfinityError` if any of the arguments bound is `Infinity`.
  # * `Alea::UndefinedError` if `max` is less than `min`.
  def self.uniform(x : Float, min : Float, max : Float) : Float64
    Alea.sanity_check(x, :x, :uniform)
    Alea.sanity_check(min, :min, :uniform)
    Alea.sanity_check(max, :max, :uniform)
    unless min < max
      raise Alea::UndefinedError.new "Invalid value for `uniform': range = #{min}...#{max}"
    end
    x <= min && return 0.0
    x >= max && return 1.0
    (x - min) / (max - min)
  end
end
