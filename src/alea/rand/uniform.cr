require "../random"

module Alea
  class Random
    # Returns the next generated `UInt64`. See `#next_u`.
    def uint : UInt64
      @prng.next_u
    end

    # Generate a uniform-distributed `UInt64` in [0, max).
    # Raises ArgumentError if parameter is negative or zero.
    def uint(max : Int) : UInt64
      unless max > 0
        raise ArgumentError.new "Invalid limit for uint: #{max}"
      end
      max == UInt64::MAX && return @prng.next_u
      lim = UInt64::MAX - (UInt64::MAX % max)
      while true
        u = @prng.next_u
        u < lim && return u % max
      end
    end

    # Generate a uniform-distributed `UInt64` in a given range.
    # Raises ArgumentError if range parameter is not a subset of N+.
    def uint(range : Range(Int, Int)) : UInt64
      unless 0 <= range.begin <= range.end
        raise ArgumentError.new "Invalid range for uint: #{range}"
      end
      span = range.end - range.begin
      if range.excludes_end?
        if range.end == range.begin
          raise ArgumentError.new "Invalid range for uint: #{range}"
        end
      else
        span += 1
      end
      uint(span) + range.begin
    end

    # Returns the next generated `Float64`. See `#next_f`.
    def float : Float64
      @prng.next_f
    end

    # Generate a uniform-distributed `Float64` in [0.0, max).
    # Raises ArgumentError if parameter is negative or zero.
    def float(max : Float) : Float64
      unless max > 0
        raise ArgumentError.new "Invalid limit for float: #{max}"
      end
      @prng.next_f * max
    end

    # Generate a uniform-distributed `Float64` in a given range.
    def float(range : Range(Float, Float)) : Float64
      unless range.begin <= range.end
        raise ArgumentError.new "Invalid range for float: #{range}"
      end
      span = range.end - range.begin
      if range.excludes_end?
        if range.end == range.begin
          raise ArgumentError.new "Invalid range for float: #{range}"
        end
      end
      @prng.next_f * span + range.begin
    end
  end

  module CDF
    # Returns the probability of X being less or equal to x
    # with given scale of the distribution.
    def uniform(x : Float, min : Float, max : Float) : Float64
      unless min < max
        raise ArgumentError.new "Invalid range for uniform: #{min}...#{max}"
      end
      x <= min && return 0.0
      x >= max && return 1.0
      (x - min) / (max - min)
    end
  end
end