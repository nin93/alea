module Alea::CDF
  # Calculate the cumulative distribution function evaluated at `k`.
  #
  # **@parameters**:
  # * `k`: discrete-valued quantile of which estimate the cdf.
  # * `lam`: separation parameter of the distribution;
  #   usually mentioned as **`λ`**.
  #
  # **@exceptions**:
  # * `Alea::NaNError` if any of the arguments is `NaN`.
  # * `Alea::InfinityError` if any of the arguments is `Infinity`.
  # * `Alea::UndefinedError` if `lam` is negative or zero.
  def self.poisson(k : Int, lam : Float = 1.0) : Float64
    # No sanity check here: k is an Int
    Alea.sanity_check(lam, :lam, :poisson)
    Alea.param_check(lam, :<=, 0.0, :lam, :poisson)
    k < 0 && return 0.0
    Alea::Internal.inc_gamma_regular(k + 1, lam, :upper)
  end
end
