require "./rgen/prng"
require "./*"

module Alea
  # `Alea::Random` provides the interface for distribution sampling, using the
  # **xoshiro** pseudo random number generators written by Sebastiano Vigna and David Blackman.
  #
  # ```
  # seed = 9377
  # random = Alea::Random.new(seed)
  # random # => Alea::Random
  # ```
  #
  # The default generator is `Alea::XSR128`, faster than `Alea::XSR256`, but less capable state.
  # To use the 256-bits version call the constructor like this:
  #
  # ```
  # seed = 12345
  # random = Alea::Random.new(seed, Alea::XSR256)
  # random.prng # => Alea::XSR256
  # ```
  #
  # You can build your own custom PRNG by inheriting `Alea::PRNG` and implementing `#next_u`,
  # `#next_f` and `#jump`, as they are needed by every other call (except for `#jump`);
  # then create a new instance of `Alea::Random` passing you class by its name like above.
  #
  # The following implementations are taken from **numpy**.
  struct Random
    DEFAULT = Alea::XSR128

    # The PRNG in use by this struct.
    getter prng : Alea::PRNG

    # Initializes the PRNG with initial instance.
    #
    # **@parameters**:
    # * `prng`: the PRNG instance itself.
    def initialize(@prng : Alea::PRNG)
    end

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators of `prng`.
    # * `seed64`: value as input to init. the state of 64-bit generators of `prng`.
    # * `prng`: the PRNG in use by this instance.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def self.new(seed32 : Int, seed64 : Int, prng : Alea::PRNG.class = DEFAULT)
      Alea.param_check(seed32, :<, 0, :seed32, :"Random.new")
      Alea.param_check(seed64, :<, 0, :seed64, :"Random.new")
      # Cast seeds to type needed by underlying PRNG.
      s32 = prng.type_32.new seed32
      s64 = prng.type_64.new seed64
      new prng.new(s32, s64)
    end

    # Initializes the PRNG with initial seed.
    #
    # **@parameters**:
    # * `seed`: initial seed as input for generating the state of `prng`.
    # * `prng`: the PRNG in use by this instance.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if `seed` is negative.
    def self.new(seed : Int, prng : Alea::PRNG.class = DEFAULT)
      Alea.param_check(seed, :<, 0, :seed, :"Random.new")
      # Cast seeds to type needed by underlying PRNG.
      s32 = prng.type_32.new seed
      s64 = prng.type_64.new seed
      new prng.new(s32, s64)
    end

    # Initializes the PRNG with initial state readed from system resources.
    #
    # **@parameters**:
    # * `prng`: the PRNG in use by this instance.
    def self.new(prng : Alea::PRNG.class = DEFAULT)
      new prng.secure
    end

    # Returns the next generated `UInt32`.
    def next_u32 : UInt32
      @prng.next_u32
    end

    # Returns the next generated `UInt64`.
    def next_u64 : UInt64
      @prng.next_u64
    end

    # Returns the next generated `Float32`.
    def next_f32 : Float32
      @prng.next_f32
    end

    # Returns the next generated `Float64`.
    def next_f64 : Float64
      @prng.next_f64
    end
  end
end
