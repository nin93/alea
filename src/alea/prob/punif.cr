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
  def self.uniform(x, min, max) : Float64
    __uniform64 x, min, max
  end

  # Run-time argument sanitizer for `#uniform`.
  private def self.__uniform64(x : Number, min : Number, max : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :uniform)
    end

    if min.class < Float
      Alea.sanity_check(min, :min, :uniform)
    end

    if max.class < Float
      Alea.sanity_check(max, :max, :uniform)
    end

    Alea.param_check(min, :>=, max, :min, :uniform)

    __cdf_uniform64 x.to_f64, min.to_f64, max.to_f64
  end

  # Unwrapped version of `#uniform`.
  private def self.__cdf_uniform64(x : Float64, min : Float64, max : Float64) : Float64
    x <= min && return 0.0
    x >= max && return 1.0
    (x - min) / (max - min)
  end
end
