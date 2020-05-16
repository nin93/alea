module Alea::Internal
  # log-gamma function to support some of these distributions.
  # The algorithm comes (with some modifications) from SPECFUN
  # by Shanjie Zhang and Jianming Jin and their book "Computation
  # of Special Functions", 1996, John Wiley & Sons, Inc.
  # https://github.com/numpy/numpy/blob/master/numpy/random/src/distributions/distributions.c#L344
  def self.loggamma(x)
    (x == 1.0 || x == 2.0) && return 0.0

    a = StaticArray[
      1.796443723688307e-01, -2.955065359477124e-02, 6.410256410256410e-03,
      -1.917526917526918e-03, 8.417508417508418e-04, -5.952380952380952e-04,
      7.936507936507937e-04, -2.777777777777778e-03, 8.333333333333333e-02,
    ]

    n = x < 7.0 ? (7.0 - x).to_i64! : 0i64
    x0 = n + x
    x2 = (1.0 / x0) * (1.0 / x0)
    xl = 1.8378770664093453
    a0 = -1.39243221690590e+00
    gl0 = a0
    9.times do |i|
      gl0 = gl0 * x2 + a[i]
    end
    logg = gl0 / x0 + 0.5 * xl + (x0 - 0.5) * Math.log(x0) - x0
    if x < 7.0
      n.times do
        x0 -= 1.0
        logg -= Math.log(x0)
      end
    end
    logg
  end
end
