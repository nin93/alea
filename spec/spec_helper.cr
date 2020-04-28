require "spec"
require "../src/alea"

# default pseudo-random number generator for specs
SpecRng   = Alea::Random.new 9377
SpecNdata = 5_000_000

def stdev(ary, mean, n)
  ans = 0.0
  ary.each do |e|
    ans += (e - mean) ** 2
  end
  Math.sqrt(ans / (n - 1))
end
