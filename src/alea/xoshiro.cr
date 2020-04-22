require "random/secure"
require "./lib/libxoshiro"

# `Xoshiro` is a replacement of the default `Random` stdlib module that implements
# the **xoshiro256++** algotithms for generating pseudo-random `UInt` in both 32 and 64 bits
#
# Due to some current limitatinos of LLVM for this kind of technical work, implementations
# of the actual algotithms are done in C and compiled with GCC (Ubuntu 7.5.0-3ubuntu1~18.04),
# then binded into Crystal and wrapped by this module.
module Alea::Xoshiro
  # Returns an instance of `Alea::Xoshiro::XSR64`
  #
  # ```
  # rng = Alea::Xoshiro.new
  # rng => Alea::Xoshiro::XSR64
  # ```
  def self.new
    XSR64.new(::Random::Secure.next_u.to_u64)
  end

  # Returns an instance of `Alea::Xoshiro::XSR64` with given initial state
  #
  # ```
  # rng = Alea::Xoshiro.new 9377
  # rng.next_u32 # =>
  # ```
  def self.new(initsate)
    XSR64.new(initsate.to_u64)
  end

  # TODO:
  # Generate a uniformly-distributed random `UInt32`
  #
  # ```
  # rng = Alea::Xoshiro.new
  # rng.next_u32 # =>
  # ```
  def next_u32 : UInt32
    LibXoshiro.next_u32
  end

  # Generate a uniformly-distributed random `UInt64`
  #
  # ```
  # rng = Alea::Xoshiro.new
  # rng.next_u64 # => 9136120204379184874
  # ```
  def next_u64 : UInt64
    LibXoshiro.next_u64
  end

  # TODO:
  # Generate a uniformly-distributed random `Float32` in [0, 1] (inclusive)
  #
  # ```
  # rng = Alea::Xoshiro.new
  # rng.next_f32 # =>
  # ```
  def next_f32 : Float32
    LibXoshiro.next_f32
  end

  # TODO: discover why performs worse than #rand
  # Generate a uniformly-distributed random `Float64` in [0, 1] (inclusive)
  #
  # ```
  # rng = Alea::Xoshiro.new
  # rng.next_f64 # => 0.12194680409000741
  # ```
  def next_f64 : Float64
    LibXoshiro.next_f64
  end

  # The actual PRNG in use for generating uniformly-distributed values to support the library
  # distributions. It uses **xoshiro256++** rock-solid algorithms to perform sampling
  class XSR64
    include Xoshiro

    # Instanciate the PRNG with initial state
    def initialize(initstate : UInt64)
      LibXoshiro.init(initstate)
    end

    # Instanciate the PRNG with pseudo-random initial state readed from system resorces
    def self.new
      new ::Random::Secure.next_u.to_u64
    end
  end
end
