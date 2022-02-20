require "./prng"

module Alea
  # `Alea::XSR256`, pseudo-random number generator loaded with 256 bits of state
  # and therefore a period of 2^256 -1. It is slower (2x) than `Alea::XSR128`.
  # If more period is needed, check out `Alea::MT19937`.
  class XSR256
    include Alea::PRNG(UInt64, UInt64)

    STATE_STORAGE_64 = 4

    # The state this PRNG refers to when called for generating `UInt32`s.
    @state32 : StaticArray(UInt64, STATE_STORAGE_64)

    # The state this PRNG refers to when called for generating `UInt64`s.
    @state64 : StaticArray(UInt64, STATE_STORAGE_64)

    # The seed this PRNG received to initialize `@state32`.
    @seed32 : UInt64

    # The seed this PRNG received to initialize `@state64`.
    @seed64 : UInt64

    # Pending pseudo-random value discarded from partial generation to be reused.
    @pending : UInt32 | Nil

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators.
    # * `seed64`: value as input to init. the state of 64-bit generators.
    #
    # **@note**: both 32-bit and 64-bit states are internally processed
    #   as arrays of `UInt64`, and so is the type of seeds.
    #
    # **@references**:
    # * `Alea::SplitMix64(4)#init_state`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def initialize(@seed32 : UInt64, @seed64 : UInt64)
      @state32 = Alea::InitEngines::SplitMix64(STATE_STORAGE_64).init_state @seed32
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
      if @pending
        # Previously stored value
        rnd = @pending.as UInt32
        xsr32_next_state
        @pending = nil
      else
        # Unpack `UInt64` into two `UInt32`
        tmp = rotate(@state32[0] &+ @state32[3], 23, size: 64) &+ @state32[0]
        # Store value for next call
        @pending = 0u32 | tmp.unsafe_shr(32)
        rnd = 0u32 | tmp
      end
      rnd
    end

    # Generate a uniform-distributed random `UInt64`.
    #
    # **@examples**:
    # ```
    # rng = Alea::XSR256.new
    # rng.next_u # => 9136120204379184874
    # ```
    @[AlwaysInline]
    def next_u64 : UInt64
      rnd = rotate(@state64[0] &+ @state64[3], 23, size: 64) &+ @state64[0]
      xsr64_next_state
      rnd
    end

    JUMP_64B_128 = StaticArray[
      0x180ec6d33cfd0aba_u64, 0xd5a61266f0c9392c_u64,
      0xa9582618e03fc9aa_u64, 0x39abdc4529b1661c_u64,
    ]

    JUMP_64B_192 = StaticArray[
      0x76e15d3efefdcbbf_u64, 0xc5004e441c522fb3_u64,
      0x77710069854ee241_u64, 0x39109bb02acbe635_u64,
    ]

    # Performs an advance over the 32-bit state.
    # This is the equivalent of `2^128` calls to `#next_u32`.
    #
    # **@parameters**:
    # * `long`: flag to advance the state by `2^192` calls.
    def jump_32(long : Bool = false) : self
      if long
        xsr32_advance_state JUMP_64B_192
      else
        xsr32_advance_state JUMP_64B_128
      end
      self
    end

    # Performs an advance over the 32-bit state.
    # This is the equivalent of `2^128` calls to `#next_u32`.
    #
    # **@parameters**:
    # * `long`: flag to advance the state by `2^192` calls.
    def jump_64(long : Bool = false) : self
      if long
        xsr64_advance_state JUMP_64B_192
      else
        xsr64_advance_state JUMP_64B_128
      end
      self
    end

    @[AlwaysInline]
    protected def rotate(x, k, size)
      x.unsafe_shl(k) | x.unsafe_shr(size - k)
    end

    protected def xsr32_advance_state(const)
      tmp = StaticArray(UInt64, STATE_STORAGE_64).new 0_u64
      STATE_STORAGE_64.times do |i|
        64.times do |j|
          if const[i] & 1_u64.unsafe_shl(j) != 0
            STATE_STORAGE_64.times { |k| tmp[k] ^= @state32[k] }
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

    @[AlwaysInline]
    protected def xsr32_next_state
      tmp = @state32[1].unsafe_shl(17)
      @state32[2] ^= @state32[0]
      @state32[3] ^= @state32[1]
      @state32[1] ^= @state32[2]
      @state32[0] ^= @state32[3]
      @state32[2] ^= tmp
      @state32[3] = rotate(@state32[3], 45, size: 64)
    end

    @[AlwaysInline]
    protected def xsr64_next_state
      tmp = @state64[1].unsafe_shl(17)
      @state64[2] ^= @state64[0]
      @state64[3] ^= @state64[1]
      @state64[1] ^= @state64[2]
      @state64[0] ^= @state64[3]
      @state64[2] ^= tmp
      @state64[3] = rotate(@state64[3], 45, size: 64)
    end
  end
end
