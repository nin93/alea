module Alea
  struct Random
    # Generate a *uniform-distributed*, pseudo-random `UInt64`.
    #
    # **@references**: `#next_u`.
    def uint : UInt64
      @prng.next_u
    end

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in range `[0, max)`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if `max` is negative or zero.
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

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in fixed range.
    #
    # **@parameters**:
    # * `range`: range parameter, inclusive or exclusive, of the distribution:
    # * `range.begin`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `range.end`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # # **@notes**:
    # * *inclusive* means `[range.begin, range.end]`.
    # * *exclusive* means `[range.begin, range.end)`.
    # * see `Range` from Crystal stdlib.
    #
    # **@examples**:
    # ```
    # range_in = 10..9377
    # range_in # Range(Int32, Int32), end-inclusive
    #
    # range_ex = 10...9377
    # range_ex # Range(Int32, Int32), end-exclusive
    #
    # random = Alea::Random.new
    # random.uint(range_in) # => 2640
    # random.uint(range_ex) # => 527
    # ```
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if `range.end` is less than `range.begin`.
    # * `Alea::UndefinedError` if `range` is not end-inclusive but bounds are the same.
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

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, 1.0)`.
    #
    # **@references**: `#next_f`.
    def float : Float64
      @prng.next_f
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, max)`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `max` is negative or zero.
    def float(max : Float) : Float64
      Alea.sanity_check(max, :max, :float)
      Alea.param_check(max, :<=, 0.0, :max, :float)
      @prng.next_f * max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    #
    # **@parameters**:
    # * `range`: range parameter, inclusive or exclusive, of the distribution:
    # * `range.begin`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `range.end`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@notes**:
    # * *inclusive* means `[range.begin, range.end]`.
    # * *exclusive* means `[range.begin, range.end)`.
    # * see `Range` from Crystal stdlib.
    #
    # **@examples**:
    # ```
    # range_in = 10.0..9377.0
    # range_in # Range(Float64, Float64), end-inclusive
    #
    # range_ex = 10.0...9377.0
    # range_ex # Range(Float64, Float64), end-exclusive
    #
    # random = Alea::Random.new
    # random.float(range_in) # => 9113.861259040154
    # random.float(range_ex) # => 7701.2778313581175
    # ```
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments bound is `NaN`.
    # * `Alea::InfinityError` if any of the arguments bound is `Infinity`.
    # * `Alea::UndefinedError` if `range.end` is less than `range.begin`.
    # * `Alea::UndefinedError` if `range` is not end-inclusive but bounds are the same.
    def float(range : Range(Float, Float)) : Float64
      Alea.sanity_check(range.begin, :"range.begin", :float)
      Alea.sanity_check(range.end, :"range.end", :float)
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
