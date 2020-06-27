require "./src/alea"

# This is an example of custom PRNG.
# B
class CustomEngine < Alea::PRNG
  # Define both your 32 and 64 bits seeds variables.
  @seed32 : UInt64
  @seed64 : UInt64
  
  # Define your state variables in both 32 and 64 bits.
  # NOTE: seeds must match up the type of corrisponding state.
  @state32 : StaticArray(UInt64, 4)
  @state64 : StaticArray(UInt64, 4)

  def initialize(@seed32 : UInt64, @seed64 : UInt64)
    # It is recommended to use `Alea::Core::SplitMix64` and `Alea::Core::Mulberry32`
    # to initialize 64 and 32 state bits, respectively; use `self.init_state` to 
    # obtain the generated state. If you want to use them as initializers, 
    # remember that they actually return `StaticArray` of unsigned integers.
    
    # Here @state32, although is meant to generate 32-bit unsigned
    # integers, stores 64-bit unsigned integers internally.
    # 4 is the number of integers stored: this means that this state is
    # loaded with 256 bits.
    @state32 = Alea::Core::SplitMix64(4).init_state @seed32
    
    # Same applies to @state64
    @state64 = Alea::Core::SplitMix64(4).init_state @seed64
  end

  # Implement the engine that generates 32-bit unisigned integers
  def next_u32 : UInt32
    # ...
  end

  # Implement the engine that generates 64-bit unisigned integers
  def next_u64 : UInt64
    # ...
  end

  # In order for `Alea::Random` to wrap properly your generator, 
  # it should know what type your seeds (and thus states) are.
  # This is achieved by asking defined class method for them:
  # `self.type_32` and `self.type_64`.
  # They are already defined in `PRNG`, but since our @state32 does not match 
  # the standard value of `PRNG.type_32` (`UInt32`), we need to override it.
  def self.type_32
    UInt64
  end
end

# Cryptographically secure PRNG seeded with system resources.
secure = CustomEngine.secure

# PRNG seeded by value.
seeded = CustomEngine.new 12345, 54321

# Now we are able to bind your generator to `Alea::Random` and
# make proper calls to constructors:
Alea::Random.new CustomEngine

# (Or from an already initialized instance of a PRNG):
Alea::Random.new prng: CustomEngine.new(12345, 54321)

