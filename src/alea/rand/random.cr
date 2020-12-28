require "./rgen/prng"
require "./*"

module Alea
  # `Alea::Random` provides the interface for pseudo-random generations and distribution sampling.
  #
  # ```
  # seed = 9377
  # random = Alea::Random(Alea::XSR128).new(seed)
  # random.float # => 0.08153691876972058
  # ```
  #
  # The default generator is `Alea::XSR128`. To use any other PRNG in this library call the constructor
  # passing its class name. Here is an example using `Alea::XSR256`, loaded with 256 bits of state:
  #
  # NOTE: due to https://github.com/crystal-lang/crystal/issues/4678 , you still need
  # to explicitly pass the generator as the generic type even if it defaults to `Alea::Random::XSR128`.
  #
  # ```
  # seed = 12345
  # random = Alea::Random.new(seed, Alea::XSR256)
  # random.prng # => Alea::XSR256
  #
  # # Works with an instance as well:
  # xsr = Alea::XSR256.new 9377, 2353
  # random = Alea::Random.new xsr
  # random.prng # => Alea::XSR256
  # ```
  #
  # `Alea::Random` can accept a custom PRNG as well: check `Alea::PRNG` and the
  # [example](https://github.com/nin93/alea/blob/master/custom_prng.cr)
  # provided to build your own.
  #
  # The following implementations are taken from **numpy**.
  struct Random(G)
    DEFAULT = Alea::XSR128

    # The PRNG in use by this struct.
    getter prng : G

    # Initializes the PRNG with initial instance.
    #
    # NOTE: due to https://github.com/crystal-lang/crystal/issues/4678 , you still need
    # to explicitly pass the generator as the generic type even if it defaults to `Alea::Random::DEFAULT`.
    #
    # **@parameters**:
    # * `prng`: the PRNG instance itself.
    def initialize(@prng : G = Alea::XSR128.new)
    end

    # Initializes the PRNG with initial seeds.
    #
    # NOTE: due to https://github.com/crystal-lang/crystal/issues/4678 , you still need
    # to explicitly pass the generator as the generic type even if it defaults to `Alea::Random::DEFAULT`.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators of `prng`.
    # * `seed64`: value as input to init. the state of 64-bit generators of `prng`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def self.new(seed32 : Int, seed64 : Int)
      Alea.param_check(seed32, :<, 0, :seed32, :"Random.new")
      Alea.param_check(seed64, :<, 0, :seed64, :"Random.new")
      new G.new(seed32, seed64)
    end

    # Initializes the PRNG with initial seed.
    #
    # NOTE: due to https://github.com/crystal-lang/crystal/issues/4678 , you still need
    # to explicitly pass the generator as the generic type even if it defaults to `Alea::Random::DEFAULT`.
    #
    # **@parameters**:
    # * `seed`: initial seed as input for generating the state of `prng`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if `seed` is negative.
    def self.new(seed : Int)
      Alea.param_check(seed, :<, 0, :seed, :"Random.new")
      new G.new(seed, seed)
    end

    # Initializes the PRNG with initial state readed from system resources.
    def self.new
      new G.secure
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
