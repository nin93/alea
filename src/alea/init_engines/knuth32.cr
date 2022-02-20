module Alea::InitEngines
  # Knuth32(N)` generator to initialize a `N` sized state for the pseudo-random number generators.
  # NOTE: `N` refers to the size in bits of the state divided by 32.
  #
  # The algorithm comes from https://github.com/numpy/numpy/blob/master/numpy/random/src/mt19937/mt19937.c.
  #
  # ```
  # state = Alea::Knuth32(4).init_state 93u32
  # state # => StaticArray[93, 1052567986, 1433826620, 220522004]
  # ```
  struct Knuth32(N)
    # Generate a state to be used by PRNGs as a `StaticArray(UInt32, N)`.
    #
    # **@parameters**:
    # * `seed`: initial seed; it must be an `UInt32`.
    def self.init_state(seed : UInt32)
      seed &= 0xffffffffu32
      StaticArray(UInt32, N).new do |i|
        tmp = seed
        seed = (1812433253u32 &* (seed ^ seed.unsafe_shr 30) &+ i &+ 1)
        seed &= 0xffffffffu32
        tmp
      end
    end
  end
end
