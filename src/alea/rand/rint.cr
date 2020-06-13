module Alea
  struct Random
    # Generate a *uniform-distributed*, pseudo-random `UInt64`.
    #
    # **@references**: `#next_u64`.
    def uint : UInt64
      @prng.next_u64
    end

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in range `[0, max)`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if `max` is negative or zero.
    def uint(max : Number) : UInt64
      __uint64 max
    end

    # Run-time argument sanitizer for `#uint`.
    private def __uint64(max : Number) : UInt64
      if max.class < Float
        Alea.sanity_check(max, :max, :uint)
      end

      Alea.param_check(max, :<=, 0, :max, :uint)

      __next_uint64 max.to_u64
    end

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in range `[0, max)`.
    # Unparsed version for `#uint`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_uint(max : UInt64) : UInt64
      __next_uint64 max
    end

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in range `[0, max)`.
    # Unwrapped version for `#uint`.
    private def __next_uint64(max : UInt64) : UInt64
      max == UInt64::MAX && return @prng.next_u64
      lim = UInt64::MAX - (UInt64::MAX % max)
      while true
        u = @prng.next_u64
        u < lim && return u % max
      end
    end

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in fixed range.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def uint(min : Number, max : Number) : UInt64
      __uint64 min, max
    end

    # Run-time argument sanitizer for `#uint`.
    private def __uint64(min : Number, max : Number) : UInt64
      if min.class < Float
        Alea.sanity_check(min, :min, :uint)
      end

      if max.class < Float
        Alea.sanity_check(max, :max, :uint)
      end

      Alea.param_check(min, :>=, max, :min, :uint)
      Alea.param_check(min, :<, 0, :min, :uint)

      span = (max - min).to_u64
      __next_uint64(span) + min.to_u64
    end

    # Generate a *uniform-distributed*, pseudo-random `UInt64` in fixed range.
    # Unparsed version for `#uint`.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_uint(min : UInt64, max : UInt64) : UInt64
      __next_uint64(max - min) + min
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
    def uint(range : Range(Number, Number)) : UInt64
      __uint64 range
    end

    # Run-time argument sanitizer for `#uint`.
    private def __uint64(range : Range(Number, Number)) : UInt64
      min = range.begin
      max = range.end

      if min.class < Float
        Alea.sanity_check(min, :"range.begin", :uint)
      end

      if max.class < Float
        Alea.sanity_check(max, :"range.end", :uint)
      end

      unless 0 <= min <= max
        raise Alea::UndefinedError.new "Invalid value for `uint': range = #{range}"
      end

      span = max.to_u64 - min.to_u64

      if range.excludes_end?
        if min == max
          raise Alea::UndefinedError.new "Invalid value for `uint': range = #{range}"
        end
      else
        if span == UInt64::MAX
          # The only 2 cases `span` is `UInt64::MAX` is when range is `0..UInt64::MAX`
          # or `0...UInt64::MAX`, so we prevent overflow in case of first scenario.
          return @prng.next_u64
        end
        span += 1
      end

      __next_uint64(span) + min.to_u64
    end
  end
end
