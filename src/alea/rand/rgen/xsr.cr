require "random/secure"
require "../../core/cgen"
require "./prng"

module Alea
  abstract class XSR < Alea::PRNG
    # :nodoc:
    @[AlwaysInline]
    protected def rotate(x, k)
      (x << k) | (x >> (64 - k))
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
    STATE_STORAGE = 2

    # The state of this PRNG.
    @state : StaticArray(UInt64, STATE_STORAGE)

    # Initializes the PRNG with initial seed.
    #
    # **@parameters**:
    # * `seed`: initial seed as input for generating the state of this PRNG.
    #
    # **@references**: `Alea::Core::SplitMix64(2)#init_state`.
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
    # rng = Alea::XSR128.new
    # rng.next_u # => 9136120204379184874
    # ```
    @[AlwaysInline]
    def next_u : UInt64
      tp0 = @state[0]
      tp1 = @state[1]
      rnd = rotate(tp0 &+ tp1, 17) &+ tp0
      tp1 ^= tp0
      @state[0] = rotate(tp0, 49) ^ tp1 ^ (tp1 << 21)
      @state[1] = rotate(tp1, 28)
      rnd
    end

    # Generate a uniformly-distributed random `Float64` in [0, 1).
    #
    # ```
    # rng = Alea::XSR128.new
    # rng.next_f # => 0.12194680409000741
    # ```
    @[AlwaysInline]
    def next_f : Float64
      # 1.1102230246251565e-16 is ldexp(1.0, -53.0).
      (next_u >> 11) * 1.1102230246251565e-16
    end

    # TODO:
    def jump : self
      raise NotImplementedError.new
      self
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

    JUMP = StaticArray[
      0x180ec6d33cfd0aba_u64, 0xd5a61266f0c9392c_u64,
      0xa9582618e03fc9aa_u64, 0x39abdc4529b1661c_u64,
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

    # TODO:
    def jump : self
      raise NotImplementedError.new
      self
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
