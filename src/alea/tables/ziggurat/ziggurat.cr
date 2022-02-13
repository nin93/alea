module Alea::Tables
  # The ziggurat tables for generating normal and exponential
  # distributed variables with better statistical properties
  #
  # These constants are transcribed from:
  # * Julia at: https://github.com/JuliaLang/julia/blob/master/stdlib/Random/src/normal.jl
  #   Copyright (c) 2009-2019: Jeff Bezanson, Stefan Karpinski, Viral B. Shah, and other contributors:
  #   https://github.com/JuliaLang/julia/contributors
  # * Numpy at: https://github.com/numpy/numpy/blob/master/numpy/random/src/distributions/ziggurat_constants.h
  #   Copyright (c) 2005-2017, NumPy Developers. All rights reserved.
  module Ziggurat
  end
end

require "./exponential"
require "./normal"
