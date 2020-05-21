module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given mean and standard deviation of the distribution.
  def self.normal(x : Float, loc : Float = 0.0, sigma : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :normal)
    Alea.sanity_check(loc, :loc, :normal)
    Alea.sanity_check(sigma, :sigma, :normal)
    Alea.param_check(sigma, :<=, 0.0, :sigma, :normal)
    0.5 * (1.0 + Math.erf((x - loc) / (sigma * 1.4142135623730951)))
  end
end
