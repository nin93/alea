module Alea
  # `PRNG` is a replacement for the default `Random::PCG32` stdlib prng that implements
  # the **xoshiro** algotithms to generate pseudo-random `UInt`s in 64-bits.
  # Performance is comparable, but quality of generated `Float`s is much better.
  # Inherit this and implement `#next_u`, `#next_f` and `#jump` to build you own generator.
  abstract class PRNG
    # Must return an uniform-distributed `UInt32`.
    abstract def next_u32 : UInt32

    # Must return an uniform-distributed `UInt64`.
    abstract def next_u64 : UInt64

    # Generate a uniform-distributed random `Float32` in `[0, 1)`.
    @[AlwaysInline]
    def next_f32 : Float32
      # 5.9604645e-8 is ldexp(1.0, -24.0).
      (next_u32 >> 8) * 5.9604645e-08f32
    end

    # Generate a uniform-distributed random `Float64` in `[0, 1)`.
    @[AlwaysInline]
    def next_f64 : Float64
      # 1.1102230246251565e-16 is ldexp(1.0, -53.0).
      (next_u64 >> 11) * 1.1102230246251565e-16f64
    end
  end
end
