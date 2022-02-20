require "benchmark"
require "../src/alea"

# All these results come from an AMD Ryzen 9 4900HS (16) @ 1.400GHz.
# Builded with `--release` and `--no-debug` flags.

xsr128 = Alea::XSR128.new
xsr256 = Alea::XSR256.new
mt19937 = Alea::MT19937.new
pcg32 = ::Random.new

#  ::Random#next_u 334.34M (  2.99ns) (±19.78%)  0.0B/op   1.59× slower
#  XSR128#next_u32 378.91M (  2.64ns) (± 1.39%)  0.0B/op   1.40× slower
#  XSR256#next_u32 531.78M (  1.88ns) (± 2.29%)  0.0B/op        fastest
# MT19937#next_u32 359.89M (  2.78ns) (± 2.13%)  0.0B/op   1.48× slower
Benchmark.ips do |x|
  x.report "::Random#next_u" { pcg32.next_u }
  x.report "XSR128#next_u32" { xsr128.next_u32 }
  x.report "XSR256#next_u32" { xsr256.next_u32 }
  x.report "MT19937#next_u32" { mt19937.next_u32 }
end

#                        user     system      total        real
# ::Random#next_u    0.000005   0.000002   0.000007 (  0.000002)
# XSR128#next_u32    0.000001   0.000000   0.000001 (  0.000001)
# XSR256#next_u32    0.000001   0.000000   0.000001 (  0.000002)
# MT19937#next_u32   0.000002   0.000001   0.000003 (  0.000001)
Benchmark.bm do |x|
  x.report "::Random#next_u" { pcg32.next_u }
  x.report "XSR128#next_u32" { xsr128.next_u32 }
  x.report "XSR256#next_u32" { xsr256.next_u32 }
  x.report "MT19937#next_u32" { mt19937.next_u32 }
end

puts "======================================================="

# ::Random#rand(UInt64) 122.04M (  8.19ns) (± 5.53%)  0.0B/op   3.16× slower
#       XSR128#next_u64 386.01M (  2.59ns) (± 1.35%)  0.0B/op        fastest
#       XSR256#next_u64 376.79M (  2.65ns) (± 1.46%)  0.0B/op   1.02× slower
#      MT19937#next_u64 269.37M (  3.71ns) (± 3.32%)  0.0B/op   1.43× slower
Benchmark.ips do |x|
  x.report "::Random#rand(UInt64)" { pcg32.rand(UInt64) }
  x.report "XSR128#next_u64" { xsr128.next_u64 }
  x.report "XSR256#next_u64" { xsr256.next_u64 }
  x.report "MT19937#next_u64" { mt19937.next_u64 }
end

#                             user     system      total        real
# ::Random#rand(UInt64)   0.000011   0.000005   0.000016 (  0.000003)
# XSR128#next_u64         0.000002   0.000001   0.000003 (  0.000001)
# XSR256#next_u64         0.000001   0.000001   0.000002 (  0.000002)
# MT19937#next_u64        0.000001   0.000001   0.000002 (  0.000002)
Benchmark.bm do |x|
  x.report "::Random#rand(UInt64)" { pcg32.rand(UInt64) }
  x.report "XSR128#next_u64" { xsr128.next_u64 }
  x.report "XSR256#next_u64" { xsr256.next_u64 }
  x.report "MT19937#next_u64" { mt19937.next_u64 }
end

puts "======================================================="

# ::Random#rand(Float32) 381.89M (  2.62ns) (± 1.58%)  0.0B/op   1.39× slower
#        XSR128#next_f32 376.33M (  2.66ns) (± 2.49%)  0.0B/op   1.41× slower
#        XSR256#next_f32 531.47M (  1.88ns) (± 3.89%)  0.0B/op        fastest
#       MT19937#next_f32 335.82M (  2.98ns) (± 2.07%)  0.0B/op   1.58× slower
Benchmark.ips do |x|
  x.report "::Random#rand(Float32)" { pcg32.next_u.unsafe_shr(8) * 5.9604645e-08f32 }
  x.report "XSR128#next_f32" { xsr128.next_f32 }
  x.report "XSR256#next_f32" { xsr256.next_f32 }
  x.report "MT19937#next_f32" { mt19937.next_f32 }
end

#                              user     system      total        real
# ::Random#rand(Float32)   0.000008   0.000003   0.000011 (  0.000002)
# XSR128#next_f32          0.000002   0.000001   0.000003 (  0.000002)
# XSR256#next_f32          0.000001   0.000001   0.000002 (  0.000002)
# MT19937#next_f32         0.000001   0.000000   0.000001 (  0.000001)
Benchmark.bm do |x|
  x.report "::Random#rand(Float32)" { pcg32.next_u.unsafe_shr(8) * 5.9604645e-08f32 }
  x.report "XSR128#next_f32" { xsr128.next_f32 }
  x.report "XSR256#next_f32" { xsr256.next_f32 }
  x.report "MT19937#next_f32" { mt19937.next_f32 }
end

puts "======================================================="

# ::Random#next_float 389.93M (  2.56ns) (± 2.32%)  0.0B/op        fastest
#     XSR128#next_f64 387.27M (  2.58ns) (± 1.94%)  0.0B/op   1.01× slower
#     XSR256#next_f64 380.14M (  2.63ns) (± 1.76%)  0.0B/op   1.03× slower
#    MT19937#next_f64 270.19M (  3.70ns) (± 3.10%)  0.0B/op   1.44× slower
Benchmark.ips do |x|
  x.report "::Random#next_float" { pcg32.next_float }
  x.report "XSR128#next_f64" { xsr128.next_f64 }
  x.report "XSR256#next_f64" { xsr256.next_f64 }
  x.report "MT19937#next_f64" { mt19937.next_f64 }
end

#                           user     system      total        real
# ::Random#next_float   0.000006   0.000003   0.000009 (  0.000002)
# XSR128#next_f64       0.000002   0.000001   0.000003 (  0.000002)
# XSR256#next_f64       0.000001   0.000000   0.000001 (  0.000001)
# MT19937#next_f64      0.000001   0.000000   0.000001 (  0.000002)
Benchmark.bm do |x|
  x.report "::Random#next_float" { pcg32.next_float }
  x.report "XSR128#next_f64" { xsr128.next_f64 }
  x.report "XSR256#next_f64" { xsr256.next_f64 }
  x.report "MT19937#next_f64" { mt19937.next_f64 }
end
