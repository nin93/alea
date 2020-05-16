module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given scale of the distribution. Scale parameter is lambda^-1.
  def self.exponential(x : Float, scale : Float = 1.0) : Float64
    unless scale > 0.0
      raise ArgumentError.new "Expected scale to be positive."
    end
    x <= 0.0 && return 0.0
    1.0 - Math.exp(-x / scale)
  end
end
