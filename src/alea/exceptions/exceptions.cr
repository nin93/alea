module Alea
  # Exception raised when distribution conditions are not met.
  class UndefinedError < Exception; end

  # Exception raised when `NaN` is passed as argument.
  class NaNError < Exception; end

  # Exception raised when `Infinity` is passed as argument.
  class InfinityError < Exception; end

  # Exception raised when algorithm has not converged within a fixed limit of iterations.
  class DivergencenceError < Exception; end
end
