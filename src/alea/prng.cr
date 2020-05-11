module Alea
  # `PRNG` is a replacement for the default `Random::PCG32` stdlib prng that implements
  # the **xoshiro** algotithms to generate pseudo-random `UInt`s in 64-bits.
  # Performance is comparable, but quality of generated `Float`s is much better.
  # Inherit this and implement `#next_u`, `#next_f` and `#jump` to build you own generator.
  abstract class PRNG
    # Must return an uniform-distributed `UInt64`.
    abstract def next_u : UInt64

    # Must return an uniform-distributed `Float64` in [0, 1).
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
end
