module Alea
  # `Alea::PRNG` is the class all PRNGs iherit from. Use this class to build your own engine as described
  # in the [example](https://github.com/nin93/alea/blob/master/custom_prng.cr) provided in the documentation.
  abstract class PRNG
    # Must initialize states from seeds.
    abstract def initialize(seed32, seed64)

    # Must return an uniform-distributed `UInt32`.
    abstract def next_u32 : UInt32

    # Must return an uniform-distributed `UInt64`.
    abstract def next_u64 : UInt64

    # Returns the type of values stored in 32-bit state. This is needed by `Alea::Random`
    # to detect the type of states and provide properly typed seeds to underlying PRNGs.
    # This should be overridden by PRNGs which need a type in state different from `UInt32`.
    def self.type_32
      UInt32
    end

    # Returns the type of values stored in 64-bit state. This is needed by `Alea::Random`
    # to detect the type of states and provide properly typed seeds to underlying PRNGs.
    # This should be overridden by PRNGs which need a type in state different from `UInt64`.
    def self.type_64
      UInt64
    end

    # Returns an instamce of this PRNG with initial seeds readed from system resources.
    def self.secure
      # Cryptographically secure PRNG
      secure = ::Random::ISAAC.new
      seed32 = secure.rand self.type_32
      seed64 = secure.rand self.type_64
      self.new seed32, seed64
    end

    # Generate a uniform-distributed random `Int32` in range `Int32::MIN..Int32::MAX`.
    @[AlwaysInline]
    def next_i32 : Int32
      next_u32.to_i32!
    end

    # Generate a uniform-distributed random `Int64` in range `Int64::MIN..Int64::MAX`.
    @[AlwaysInline]
    def next_i64 : Int64
      next_u64.to_i64!
    end

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
