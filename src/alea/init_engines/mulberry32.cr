module Alea::InitEngines
  # `Mulberry32(N)` generator to initialize a `N` sized state for the pseudo-random number generators.
  # NOTE: `N` refers to the size in bits of the state divided by 32.
  #
  # The algorithm comes from https://gist.github.com/tommyettinger/46a874533244883189143505d203312c.
  #
  # ```
  # state = Alea::Mulberry32(4).init_state 93u32
  # state # => StaticArray[1079867279, 1912516084, 2459043021, 3508473169]
  # ```
  struct Mulberry32(N)
    # Written in 2017 by Tommy Ettinger (tommy.ettinger@gmail.com)
    #
    # To the extent possible under law, the author has dedicated all copyright
    # and related and neighboring rights to this software to the public domain
    # worldwide. This software is distributed without any warranty.
    #
    # See <http://creativecommons.org/publicdomain/zero/1.0/>.

    # Generate a state to be used by PRNGs as a `StaticArray(UInt32, N)`.
    #
    # **@parameters**:
    # * `seed`: initial seed; it must be an `UInt32`.
    def self.init_state(seed : UInt32)
      StaticArray(UInt32, N).new do
        tmp = (seed &+= 0x6d2b79f5u32)
        tmp = (tmp ^ (tmp >> 15)) &* (tmp | 1u32)
        tmp ^= tmp &+ (tmp ^ (tmp >> 7)) &* (tmp | 61u32)
        tmp ^ (tmp >> 14)
      end
    end
  end
end
