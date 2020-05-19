module Alea
  struct Random
    # Returns the next generated `UInt64`. See `#next_u`.
    def uint : UInt64
      @prng.next_u
    end

    # Generate a uniform-distributed `UInt64` in [0, max).
    # Raises ArgumentError if parameter is negative or zero.
    def uint(max : Int) : UInt64
      # No sanity check here: max is an Int
      Alea.param_check(max, :<=, 0, :max, :uint)
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
        raise Alea::UndefinedError.new "Invalid value for `uint': range = #{range}"
      end
      span = range.end - range.begin
      if range.excludes_end?
        if range.end == range.begin
          raise Alea::UndefinedError.new "Invalid value for `uint': range = #{range}"
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
      Alea.sanity_check(max, :max, :float)
      Alea.param_check(max, :<=, 0.0, :max, :float)
      @prng.next_f * max
    end

    # Generate a uniform-distributed `Float64` in a given range.
    def float(range : Range(Float, Float)) : Float64
      Alea.sanity_check(range.begin, :left_bound, :float)
      Alea.sanity_check(range.end, :right_bound, :float)
      unless range.begin <= range.end
        raise Alea::UndefinedError.new "Invalid value for `float': range = #{range}"
      end
      span = range.end - range.begin
      if range.excludes_end?
        if range.end == range.begin
          raise Alea::UndefinedError.new "Invalid value for `float': range = #{range}"
        end
      end
      @prng.next_f * span + range.begin
    end
  end
end
