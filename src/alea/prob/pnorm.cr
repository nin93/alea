module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given mean and standard deviation of the distribution.
  def self.normal(x : Float, mean : Float = 0.0, sigma : Float = 1.0) : Float64
    unless sigma > 0.0
      raise ArgumentError.new "Expected sigma to be positive."
    end
    0.5 * (1.0 + Math.erf((x - mean) / (sigma * 1.4142135623730951)))
  end
end
