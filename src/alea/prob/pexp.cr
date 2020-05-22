module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given scale of the distribution. Scale parameter is lambda^-1.
  def self.exp(x : Float, scale : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :exp)
    Alea.sanity_check(scale, :scale, :exp)
    Alea.param_check(scale, :<=, 0.0, :scale, :exp)
    x <= 0.0 && return 0.0
    1.0 - Math.exp(-x / scale)
  end
end
