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
  end
end
