module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given shape and scale of the distribution.
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
