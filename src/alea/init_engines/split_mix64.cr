module Alea::InitEngines
  # `SplitMix64(N)` generator to initialize a `N` sized state for the pseudo-random number generators.
  # NOTE: `N` refers to the size in bits of the state divided by 64.
  #
  # The algorithm comes from http://prng.di.unimi.it/splitmix64.c.
  #
  # ```
  # state = Alea::SplitMix64(2).init_state 93u64
  # state # => StaticArray[17266415801915045436, 2250649230797539417]
  # ```
  struct SplitMix64(N)
    # Written in 2015 by Sebastiano Vigna (vigna@acm.org)
    #
    # To the extent possible under law, the author has dedicated all copyright
    # and related and neighboring rights to this software to the public domain
    # worldwide. This software is distributed without any warranty.
    #
    # See <http://creativecommons.org/publicdomain/zero/1.0/>.

    # Generate a state to be used by PRNGs as a `StaticArray(UInt64, N)`.
    #
    # **@parameters**:
    # * `seed`: initial seed; it must be an `UInt64`.
    def self.init_state(seed : UInt64)
      StaticArray(UInt64, N).new do
        tmp = (seed &+= 0x9e3779b97f4a7c15)
        tmp = (tmp ^ tmp.unsafe_shr 30) &* 0xbf58476d1ce4e5b9
        tmp = (tmp ^ tmp.unsafe_shr 27) &* 0x94d049bb133111eb
        tmp ^ tmp.unsafe_shr 31
      end
    end
  end
end
