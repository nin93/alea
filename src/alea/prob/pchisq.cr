module Alea::CDF
  # Returns the probability of X being less or equal to x
  # with given degrees of freedom of the distribution.
  def self.chisq(x : Float, df : Float = 1.0) : Float64
    Alea.sanity_check(x, :x, :chisq)
    Alea.sanity_check(df, :df, :chisq)
    Alea.param_check(df, :<=, 0.0, :df, :chisq)
    x <= 0.0 && return 0.0
    Alea::Internal.incg_regular_lower(df * 0.5, x * 0.5)
  end
end
