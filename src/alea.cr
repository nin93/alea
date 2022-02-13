# `Alea` is a library for generating pseudo-random samples from most known probability distributions,
# written in pure Crystal.
#
# Algorithms in this library are heavily derived from [NumPy](https://github.com/numpy/numpy) and
# [Julia](https://github.com/JuliaLang/julia) lang. Disclaimer in LICENSE file.
module Alea
  VERSION = "0.3.0"
end

require "./alea/exceptions"
require "./alea/init_engines"
require "./alea/random"
require "./alea/tables"
require "./alea/cdf"
