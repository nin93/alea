module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given scale of the distribution.
  def self.uniform(x : Float, min : Float, max : Float) : Float64
    Alea.sanity_check(x, :x, :uniform)
    Alea.sanity_check(min, :min, :uniform)
    Alea.sanity_check(max, :max, :uniform)
    unless min < max
      raise Alea::UndefinedError.new "Invalid value for `uniform': range = #{min}...#{max}"
    end
    x <= min && return 0.0
    x >= max && return 1.0
    (x - min) / (max - min)
  end
end
