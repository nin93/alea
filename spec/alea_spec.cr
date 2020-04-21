require "./spec_helper"

def stdev(ary, mean, n)
  ans = 0.0
  ary.each do |e|
    ans += (e - mean) ** 2
  end
  Math.sqrt(ans / (n-1))
end

describe Alea do
  describe Random do
    describe "#next_normal" do
      it "accepts any sized Int" do
        SpecRng.next_normal 1_i8
        SpecRng.next_normal 1_i16
        SpecRng.next_normal 1_i32
        SpecRng.next_normal 1_i64
        SpecRng.next_normal 1_i128

        SpecRng.next_normal 1_i8, 1_i8
        SpecRng.next_normal 1_i16, 1_i16
        SpecRng.next_normal 1_i32, 1_i32
        SpecRng.next_normal 1_i64, 1_i64
        SpecRng.next_normal 1_i128, 1_i128
      end

      pending "accepts any sized UInt" do
        SpecRng.next_normal 1_u8
        SpecRng.next_normal 1_u16
        SpecRng.next_normal 1_u32
        SpecRng.next_normal 1_u64
        SpecRng.next_normal 1_u128

        SpecRng.next_normal 1_u8, 1_u8
        SpecRng.next_normal 1_u16, 1_u16
        SpecRng.next_normal 1_u32, 1_u32
        SpecRng.next_normal 1_u64, 1_u64
        SpecRng.next_normal 1_u128, 1_u128
      end

      it "accepts any sized Float" do
        SpecRng.next_normal 1.0_f32
        SpecRng.next_normal 1.0_f64

        SpecRng.next_normal 1.0_f32, 1.0_f32
        SpecRng.next_normal 1.0_f64, 1.0_f64
      end

      it "generates normal-distributed random values with mean 0.0 and sigma 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        200_000.times do
          norm = SpecRng.next_normal
          ans += norm
          ary << norm
        end

        mean = ans / 200_000
        mean.should be_close(0.0, 0.05)
        stdev = stdev(ary, mean, 200_000)
        stdev.should be_close(1.0, 0.05)
      end

      it "generates normal-distributed random values with fixed mean and sigma 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        200_000.times do
          norm = SpecRng.next_normal mean: 93.0
          ans += norm
          ary << norm
        end

        mean = ans / 200_000
        mean.should be_close(93.0, 0.05)
        stdev = stdev(ary, mean, 200_000)
        stdev.should be_close(1.0, 0.05)
      end

      it "generates normal-distributed random values with fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        200_000.times do
          norm = SpecRng.next_normal mean: 93.0, sigma: 9.3
          ans += norm
          ary << norm
        end

        mean = ans / 200_000
        mean.should be_close(93.0, 0.05)
        stdev = stdev(ary, mean, 200_000)
        stdev.should be_close(9.3, 0.05)
      end

      it "generates normal-distributed random values with negative fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        200_000.times do
          norm = SpecRng.next_normal mean: -93.0, sigma: -9.3
          ans += norm
          ary << norm
        end

        mean = ans / 200_000
        mean.should be_close(-93.0, 0.05)
        stdev = stdev(ary, mean, 200_000)
        stdev.should be_close(9.3, 0.05)
      end
    end
  end
end
