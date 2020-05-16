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

    # Initializes the PRNG with initial state.
    def initialize(initstate : UInt64, prng : Alea::PRNG.class = DEFAULT)
      @prng = prng.new initstate
    end

    # Initializes the PRNG with initial state readed from system resorces.
    def initialize(prng : Alea::PRNG.class = DEFAULT)
      @prng = prng.new
    end

    # Returns the next generated `UInt64`.
    def next_u : UInt64
      @prng.next_u
    end

    # Returns the next generated `Float64`.
    def next_f : Float64
      @prng.next_f
    end

    # This equals to 2^(STATE_STORAGE * 32) calls to `#next_u` or `#next_f`.
    def jump : self
      @prng.jump
    end
  end
end
