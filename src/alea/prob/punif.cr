module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given scale of the distribution.
  def self.uniform(x : Float, min : Float, max : Float) : Float64
    unless min < max
      raise ArgumentError.new "Invalid range for uniform: #{min}...#{max}"
    end
    x <= min && return 0.0
    x >= max && return 1.0
    (x - min) / (max - min)
  end
end
