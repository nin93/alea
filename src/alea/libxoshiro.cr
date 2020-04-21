@[Link(ldflags: "#{__DIR__}/lib/libxoshiro.a")]
lib LibXoshiro
  fun init = xoshiro_splitmix_init64(init : UInt64) : Void
  # TODO:
  # fun next_u32 = xoshiro_next_u32 : UInt32
  fun next_u64 = xoshiro_next_u64 : UInt64
  # TODO:
  # fun next_f32 = xoshiro_next_f32 : Float32
  fun next_f64 = xoshiro_next_f64 : Float64
end
