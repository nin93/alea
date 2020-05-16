module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given mean and scale of the distribution.
  def self.laplace(x : Float, mean : Float = 0.0, scale : Float = 1.0) : Float64
    unless scale > 0.0
      raise ArgumentError.new "Expected scale to be positive."
    end
    a = (x - mean) / scale
    x < mean && return 0.5 * Math.exp(a)
    1.0 - 0.5 * Math.exp(-a)
  end
end
