require "random/secure"

module Alea
  # `XSR` is a replacement for the default `Random::PCG32` stdlib prng that implements
  # the **xoshiro** algotithms for generating pseudo-random `UInt`s in 64-bits.
  # Performance is comparable, but quality of generated `Float`s is much better.
  abstract class XSR
    # Must return an uniformly-distributed `UInt64`.
    abstract def next_u : UInt64

    # Must return an uniformly-distributed `Float64` in [0, 1).
    abstract def next_f : Float64

    # Must perform a jump.
    abstract def jump : self

    # :nodoc:
    # http://prng.di.unimi.it/splitmix64.c
    # This is used as a state initializer.
    protected def init_state(state, storage, seed)
      storage.times do |i|
        state.value[i] = (seed &+ (i + 1) &* 0x9e3779b97f4a7c15)
        state.value[i] = (state.value[i] ^ (state.value[i] >> 30)) &* 0xbf58476d1ce4e5b9
        state.value[i] = (state.value[i] ^ (state.value[i] >> 27)) &* 0x94d049bb133111eb
        state.value[i] = state.value[i] ^ (state.value[i] >> 31)
      end
    end

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
  class XSR128 < XSR
    STATE_STORAGE = 2

    # The state of this PRNG.
    @state : StaticArray(UInt64, STATE_STORAGE)

    # Initializes the PRNG with initial state.
    def initialize(initstate : UInt64)
      @state = StaticArray[0u64, 0u64]
      init_state(pointerof(@state), STATE_STORAGE, initstate)
    end

    # Initializes the PRNG with initial state readed from system resorces.
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
  class XSR256 < XSR
    STATE_STORAGE = 4

    JUMP = StaticArray[
      0x180ec6d33cfd0aba_u64, 0xd5a61266f0c9392c_u64,
      0xa9582618e03fc9aa_u64, 0x39abdc4529b1661c_u64,
    ]

    # The state of this PRNG.
    @state : StaticArray(UInt64, STATE_STORAGE)

    # Initializes the PRNG with initial state.
    def initialize(initstate : UInt64)
      @state = StaticArray[0u64, 0u64, 0u64, 0u64]
      init_state(pointerof(@state), STATE_STORAGE, initstate)
    end

    # Initializes the PRNG with initial state readed from system resorces.
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
