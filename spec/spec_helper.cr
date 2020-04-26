require "spec"
require "../src/alea"

# default pseudo-random number generator for specs
SpecRng   = Alea::Random.new 9377
SpecNdata = 5_000_000
