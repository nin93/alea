module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given loc and standard deviation of the underlying normal distribution.
  def self.lognormal(x : Float, loc : Float = 0.0, sigma : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :lognormal)
    Alea.sanity_check(loc, :loc, :lognormal)
    Alea.sanity_check(sigma, :sigma, :lognormal)
    Alea.param_check(sigma, :<=, 0.0, :sigma, :lognormal)
    x <= 0.0 && return 0.0
    0.5 + 0.5 * (Math.erf((Math.log(x) - loc) / (sigma * 1.4142135623730951)))
  end
end
