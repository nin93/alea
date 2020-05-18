module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given degrees of freedom of the distribution.
  def self.chi_square(x : Float, freedom : Float = 1.0) : Float64
    unless freedom > 0.0
      raise ArgumentError.new "Expected degrees of freedom to be positive"
    end
    x <= 0.0 && return 0.0
    Alea::Internal.incg_regular_lower(freedom * 0.5, x * 0.5)
  end
end
