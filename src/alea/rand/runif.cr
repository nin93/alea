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
      Alea.param_check(max, :<=, 0, :max, :uint)

      if max.class < Float
        Alea.sanity_check(max, :max, :uint)
      end

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
      Alea.param_check(min, :>=, max, :min, :uint)
      Alea.param_check(min, :<, 0, :min, :uint)

      if min.class < Float
        Alea.sanity_check(min, :min, :uint)
      end

      if max.class < Float
        Alea.sanity_check(max, :max, :uint)
      end

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

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, 1.0)`.
    #
    # **@references**: `#next_f64`.
    def float : Float64
      @prng.next_f64
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
    def float(max : Number) : Float64
      __float64 max
    end

    # Run-time argument sanitizer for `#float`.
    private def __float64(max : Number) : Float64
      if max.class < Float
        Alea.sanity_check(max, :max, :float)
      end

      Alea.param_check(max, :<=, 0, :max, :float)

      __next_float64 max.to_f64
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0, max)`.
    # Unparsed version for `#float`.
    #
    # **@parameters**:
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_float(max : Float64) : Float64
      __next_float64 max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in range `[0.0, max)`.
    # Unwrapped version for `#float`.
    private def __next_float64(max : Float64) : Float64
      # Float64, excluding mantissa, has 2^53 values
      max_prec = 1u64 << 53
      __next_uint64(max_prec) / max_prec.to_f64 * max
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def float(min : Number, max : Number) : Float64
      __float64 min, max
    end

    # Run-time argument sanitizer for `#float`.
    private def __float64(min : Number, max : Number) : Float64
      if min.class < Float
        Alea.sanity_check(min, :min, :float)
      end

      if max.class < Float
        Alea.sanity_check(max, :max, :float)
      end

      Alea.param_check(min, :>=, max, :min, :float)

      span = (max - min).to_f64
      __next_float64(span) + min.to_f64
    end

    # Generate a *uniform-distributed*, pseudo-random `Float64` in fixed range.
    # Unparsed version for `#float`.
    #
    # **@parameters**:
    # * `min`: left bound parameter of range of the distribution;
    #   usually mentioned as **`a`**.
    # * `max`: right bound parameter of range of the distribution;
    #   usually mentioned as **`b`**.
    def next_float(min : Float64, max : Float64) : Float64
      __next_float64(max - min) + min
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
    def float(range : Range(Number, Number)) : Float64
      __float64 range
    end

    # Run-time argument sanitizer for `#float`.
    private def __float64(range : Range(Number, Number)) : Float64
      min = range.begin
      max = range.end

      if min.class < Float
        Alea.sanity_check(min, :"range.begin", :float)
      end

      if max.class < Float
        Alea.sanity_check(max, :"range.end", :float)
      end

      span = (max - min).to_f64

      if range.excludes_end?
        unless min < max
          raise Alea::UndefinedError.new "Invalid value for `float': range = #{range}"
        end
        __next_float64(span) + min.to_f64
      else
        unless min <= max
          raise Alea::UndefinedError.new "Invalid value for `float': range = #{range}"
        end
        min.to_f64 + @prng.next_f64 * span
      end
    end
  end
end
