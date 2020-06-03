require "random/secure"
require "../../core/cgen"
require "./prng"

module Alea
  abstract class XSR < Alea::PRNG
    # :nodoc:
    @[AlwaysInline]
    protected def rotate(x, k, size)
      (x << k) | (x >> (size - k))
    end
  end

  # `Alea::XSR128` is the default pseudo-random number generator, with a state of 128 bits, and therefore
  # a period of 2^64 -1. It is as fast as `Random::PCG32`, but yielding a 64-bit unsigned integer.
  # If more state is needed, check `Alea::XSR256`.
  #
  # ```text
  #  - period:     2^128 -1
  #  - state type: UInt64
  # ```
  class XSR128 < Alea::XSR
    STATE_STORAGE_32 = 4
    STATE_STORAGE_64 = 2

    # The state this PRNG refers to when called for generating `UInt32`s.
    @state32 : StaticArray(UInt32, STATE_STORAGE_32)

    # The state this PRNG refers to when called for generating `UInt64`s.
    @state64 : StaticArray(UInt64, STATE_STORAGE_64)

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators.
    # * `seed64`: value as input to init. the state of 64-bit generators.
    #
    # **@references**:
    # * `Alea::Core::Mulberry32(4)#init_state`.
    # * `Alea::Core::SplitMix64(2)#init_state`.
    def initialize(seed32 : UInt32, seed64 : UInt64)
      @state32 = Alea::Core::Mulberry32(STATE_STORAGE_32).init_state seed32
      @state64 = Alea::Core::SplitMix64(STATE_STORAGE_64).init_state seed64
    end

    # Initializes the PRNG with initial seed.
    #
    # **@parameters**:
    # * `seed`: value as input to init. the state of both 32-bit and 64-bit generators.
    #
    # **@references**:
    # * `Alea::Core::Mulberry32(4)#init_state`.
    # * `Alea::Core::SplitMix64(2)#init_state`.
    #
    # **@exceptions**:
    # * `ArgumentError` if `seed` is negative.
    def initialize(seed : Int)
      if seed < 0
        raise ArgumentError.new "Invalid value for `XSR128.new`: seed = #{seed}"
      else
        @state32 = Alea::Core::Mulberry32(STATE_STORAGE_32).init_state seed.to_u32
        @state64 = Alea::Core::SplitMix64(STATE_STORAGE_64).init_state seed.to_u64
      end
    end

    # Initializes the PRNG with initial states.
    #
    # **@parameters**:
    # * `state32`: array of values for state of 32-bit generators.
    # * `state64`: array of values for state of 64-bit generators.
    def initialize(@state32 : StaticArray(UInt32, STATE_STORAGE_32),
                   @state64 : StaticArray(UInt64, STATE_STORAGE_64))
    end

    # Initializes the PRNG with initial seeds readed from system resources.
    def self.new
      # Cryptographically secure PRNG
      secure = ::Random::ISAAC.new
      seed32 = secure.next_u
      # Merge two 32-bit integers to obtain seed64
      lt32 = secure.next_u
      rt32 = secure.next_u
      seed64 = ((0u64 | lt32) << 32) | rt32
      new seed32, seed64
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

    # Generate a uniform-distributed random `Float32` in `[0, 1)`.
    #
    # **@examples**:
    # ```
    # rng = Alea::XSR128.new
    # rng.next_f32 # => 0.41157538
    # ```
    @[AlwaysInline]
    def next_f32 : Float32
      # 5.9604645e-8 is ldexp(1.0, -24.0).
      (next_u32 >> 8) * 5.9604645e-08f32
    end

    # Generate a uniform-distributed random `Float64` in `[0, 1)`.
    #
    # **@examples**:
    # ```
    # rng = Alea::XSR128.new
    # rng.next_f64 # => 0.12194680409000741
    # ```
    @[AlwaysInline]
    def next_f64 : Float64
      # 1.1102230246251565e-16 is ldexp(1.0, -53.0).
      (next_u64 >> 11) * 1.1102230246251565e-16f64
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
    protected def xsr32_next_state
      tmp = @state32[1] << 9
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
      @state64[0] = rotate(tmp0, 49, size: 64) ^ tmp1 ^ (tmp1 << 21)
      @state64[1] = rotate(tmp1, 28, size: 64)
    end

    protected def xsr32_advance_state(const)
      tmp = StaticArray(UInt32, STATE_STORAGE_32).new 0_u32
      STATE_STORAGE_32.times do |i|
        32.times do |j|
          if const[i] & (1_u32 << j) != 0
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
          if const[i] & (1_u64 << j) != 0
            STATE_STORAGE_64.times { |k| tmp[k] ^= @state64[k] }
          end
          xsr64_next_state
        end
      end
      @state64 = tmp
    end
  end

  # `Alea::XSR256` is the alternative PRNG loaded with 256 bits of state.
  # As a result of this, double steps are needed and therefore performance is affected.
  #
  # ```text
  #  - period:     2^256 -1
  #  - state type: UInt64
  # ```
  class XSR256 < Alea::XSR
    STATE_STORAGE = 4

    JUMP_128 = StaticArray[
      0x180ec6d33cfd0aba_u64, 0xd5a61266f0c9392c_u64,
      0xa9582618e03fc9aa_u64, 0x39abdc4529b1661c_u64,
    ]

    JUMP_192 = StaticArray[
      0x76e15d3efefdcbbf_u64, 0xc5004e441c522fb3_u64,
      0x77710069854ee241_u64, 0x39109bb02acbe635_u64,
    ]

    # The state of this PRNG.
    @state : StaticArray(UInt64, STATE_STORAGE)

    # Initializes the PRNG with initial seed.
    #
    # **@parameters**:
    # * `seed`: initial seed as input for generating the state of this PRNG.
    #
    # **@references**: `Alea::Core::SplitMix64(4)#init_state`.
    def initialize(seed : UInt64)
      @state = Alea::Core::SplitMix64(STATE_STORAGE).init_state(seed)
    end

    # Initializes the PRNG with initial state.
    #
    # **@parameters**:
    # * `state`: initial state of this PRNG.
    def initialize(@state : StaticArray(UInt64, STATE_STORAGE))
    end

    # Initializes the PRNG with initial seed readed from system resources.
    def self.new
      new ::Random::Secure.next_u.to_u64
    end

    # Generate a uniformly-distributed random `UInt64`.
    #
    # ```
    # rng = Alea::XSR256.new
    # rng.next_u # => 9136120204379184874
    # ```
    @[AlwaysInline]
    def next_u : UInt64
      rnd = rotate(@state[0] &+ @state[3], 23) &+ @state[0]
      xsr_new_state
      rnd
    end

    # Generate a uniformly-distributed random `Float64` in [0, 1).
    #
    # ```
    # rng = Alea::XSR256.new
    # rng.next_f # => 0.12194680409000741
    # ```
    @[AlwaysInline]
    def next_f : Float64
      rnd = @state[0] &+ @state[3]
      xsr_new_state
      # 1.1102230246251565e-16 is ldexp(1.0, -53.0).
      (rnd >> 11) * 1.1102230246251565e-16
    end

    # This is the equivalent of 2^128 calls to `#next_u`.
    def jump : self
      jumper JUMP_128
      self
    end

    # This is the equivalent of 2^192 calls to `#next_u`.
    def long_jump : self
      jumper JUMP_192
      self
    end

    private def jumper(const)
      tmp = StaticArray(UInt64, STATE_STORAGE).new 0u64
      STATE_STORAGE.times do |i|
        64.times do |j|
          if const[i] & (1u64 << j) != 0
            STATE_STORAGE.times { |i| tmp[i] ^= @state[i] }
          end
          next_u
        end
      end
      @state = tmp
    end

    # :nodoc:
    @[AlwaysInline]
    protected def xsr_new_state
      tmp = @state[1] << 17
      @state[2] ^= @state[0]
      @state[3] ^= @state[1]
      @state[1] ^= @state[2]
      @state[0] ^= @state[3]
      @state[2] ^= tmp
      @state[3] = rotate(@state[3], 45)
    end
  end
end
