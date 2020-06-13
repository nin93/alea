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
  def self.normal(x, loc = 0.0, sigma = 1.0) : Float64
    __normal64 x, loc, sigma
  end

  # Run-time argument sanitizer for `#normal`.
  private def self.__normal64(x : Number, loc : Number, sigma : Number) : Float64
    if x.class < Float
      Alea.sanity_check(x, :x, :normal)
    end

    if loc.class < Float
      Alea.sanity_check(loc, :loc, :normal)
    end

    if sigma.class < Float
      Alea.sanity_check(sigma, :sigma, :normal)
    end

    Alea.param_check(sigma, :<=, 0.0, :sigma, :normal)

    __cdf_normal64 x.to_f64, loc.to_f64, sigma.to_f64
  end

  # Unwrapped version of `#normal`.
  private def self.__cdf_normal64(x : Float64, loc : Float64, sigma : Float64) : Float64
    0.5 * (1.0 + Math.erf((x - loc) / (sigma * 1.4142135623730951)))
  end
end
