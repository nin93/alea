require "./prng"

module Alea
  # `Alea::XSR128`, pseudo-random number generator loaded with a state of 128 bits
  # and therefore a period of 2^128 -1. It is as fast as `Random::PCG32`.
  # If more period is needed, check out `Alea::XSR256`.
  class XSR128
    include Alea::PRNG(UInt32, UInt64)

    STATE_STORAGE_32 = 4
    STATE_STORAGE_64 = 2

    # The state this PRNG refers to when called for generating `UInt32`s.
    @state32 : StaticArray(UInt32, STATE_STORAGE_32)

    # The state this PRNG refers to when called for generating `UInt64`s.
    @state64 : StaticArray(UInt64, STATE_STORAGE_64)

    # The seed this PRNG received to initialize `@state32`.
    @seed32 : UInt32

    # The seed this PRNG received to initialize `@state64`.
    @seed64 : UInt64

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators.
    # * `seed64`: value as input to init. the state of 64-bit generators.
    #
    # **@references**:
    # * `Alea::Mulberry32(4)#init_state`.
    # * `Alea::SplitMix64(2)#init_state`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def initialize(@seed32 : UInt32, @seed64 : UInt64)
      @state32 = Alea::InitEngines::Mulberry32(STATE_STORAGE_32).init_state @seed32
      @state64 = Alea::InitEngines::SplitMix64(STATE_STORAGE_64).init_state @seed64
    end

    # Generate a uniform-distributed random `UInt32`.
    #
    # **@examples**:
    # ```
    # rng = Alea::XSR128.new
    # rng.next_u32 # => 1767702788
    # ```
    @[AlwaysInline]
    def next_u32 : UInt32
      rnd = rotate(@state32[0] &+ @state32[1], 7, size: 32) &+ @state32[0]
      xsr32_next_state
      rnd
    end

    # Generate a uniform-distributed random `UInt64`.
    #
    # **@examples**:
    # ```
    # rng = Alea::XSR128.new
    # rng.next_u64 # => 9136120204379184874
    # ```
    @[AlwaysInline]
    def next_u64 : UInt64
      tmp0 = @state64[0]
      tmp1 = @state64[1]
      rnd = rotate(tmp0 &+ tmp1, 17, size: 64) &+ tmp0
      xsr64_next_state
      rnd
    end

    JUMP_32B_64 = StaticArray[
      0x8764000b_u32, 0xf542d2d3_u32,
      0x6fa035c3_u32, 0x77f2db5b_u32,
    ]

    JUMP_32B_96 = StaticArray[
      0xb523952e_u32, 0x0b6f099f_u32,
      0xccf5a0ef_u32, 0x1c580662_u32,
    ]

    # Performs an advance over the 32-bit state.
    # This is the equivalent of `2^64` calls to `#next_u32`.
    #
    # **@parameters**:
    # * `long`: flag to advance the state by `2^96` calls.
    def jump_32(long : Bool = false) : self
      if long
        xsr32_advance_state JUMP_32B_96
      else
        xsr32_advance_state JUMP_32B_64
      end
      self
    end

    JUMP_64B_64 = StaticArray[
      0x2bd7a6a6e99c2ddc_u64,
      0x0992ccaf6a6fca05_u64,
    ]

    JUMP_64B_96 = StaticArray[
      0x360fd5f2cf8d5d99_u64,
      0x9c6e6877736c46e3_u64,
    ]

    # Performs an advance over the 64-bit state.
    # This is the equivalent of `2^64` calls to `#next_u64`.
    #
    # **@parameters**:
    # * `long`: flag to advance the state by `2^96` calls.
    def jump_64(long : Bool = false) : self
      if long
        xsr64_advance_state JUMP_64B_96
      else
        xsr64_advance_state JUMP_64B_64
      end
      self
    end

    @[AlwaysInline]
    protected def rotate(x, k, size)
      x.unsafe_shl(k) | x.unsafe_shr(size - k)
    end

    @[AlwaysInline]
    protected def xsr32_next_state
      tmp = @state32[1].unsafe_shl(9)
      @state32[2] ^= @state32[0]
      @state32[3] ^= @state32[1]
      @state32[1] ^= @state32[2]
      @state32[0] ^= @state32[3]
      @state32[2] ^= tmp
      @state32[3] = rotate(@state32[3], 11, size: 32)
    end

    @[AlwaysInline]
    protected def xsr64_next_state
      tmp0 = @state64[0]
      tmp1 = @state64[1]
      tmp1 ^= tmp0
      @state64[0] = rotate(tmp0, 49, size: 64) ^ tmp1 ^ tmp1.unsafe_shl(21)
      @state64[1] = rotate(tmp1, 28, size: 64)
    end

    protected def xsr32_advance_state(const)
      tmp = StaticArray(UInt32, STATE_STORAGE_32).new 0_u32
      STATE_STORAGE_32.times do |i|
        32.times do |j|
          if const[i] & 1_u32.unsafe_shl(j) != 0
            STATE_STORAGE_32.times { |k| tmp[k] ^= @state32[k] }
          end
          xsr32_next_state
        end
      end
      @state32 = tmp
    end

    protected def xsr64_advance_state(const)
      tmp = StaticArray(UInt64, STATE_STORAGE_64).new 0_u64
      STATE_STORAGE_64.times do |i|
        64.times do |j|
          if const[i] & 1_u64.unsafe_shl(j) != 0
            STATE_STORAGE_64.times { |k| tmp[k] ^= @state64[k] }
          end
          xsr64_next_state
        end
      end
      @state64 = tmp
    end
  end
end
