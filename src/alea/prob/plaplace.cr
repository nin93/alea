module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given mean and scale of the distribution.
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
