require "./spec_helper"

def stdev(ary, mean, n)
  ans = 0.0
  ary.each do |e|
    ans += (e - mean) ** 2
  end
  Math.sqrt(ans / (n - 1))
end

describe Alea do
  describe Alea::Xoshiro::XSR64 do
    it "builds a new instance from module" do
      SpecRng.should be_a(Alea::Xoshiro::XSR64)
    end

    describe "#next_u64" do
      it "generates a UInt64" do
        rng = Alea::Xoshiro.new
        rnd = rng.next_u64
        rnd.should be_a(UInt64)
      end

      it "generates a UInt64 with given initial state" do
        rng = Alea::Xoshiro.new 9377
        rnd = rng.next_u64
        rnd.should be_a(UInt64)
      end

      it "generates uniformly-distributed random values" do
        ary = Array(UInt64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_u64
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(9223372036854775807.5, 1.5e16)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(5.325116328314172e+18, 0.5e18)
      end
    end

    describe "#next_f64" do
      it "generates a Float64" do
        rng = Alea::Xoshiro.new
        rnd = rng.next_f64
        rnd.should be_a(Float64)
      end

      it "generates a Float64 with given initial state" do
        rng = Alea::Xoshiro.new 9377
        rnd = rng.next_f64
        rnd.should be_a(Float64)
      end

      it "generates uniformly-distributed random values" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_f64
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(0.5, 0.01)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(0.2886751345948129, 0.005)
      end
    end
  end

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

      it "accepts any sized UInt" do
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

      it "generates normal-distributed random values with mean 0.0 and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_normal
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(0.0, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(1.0, 0.05)
      end

      it "generates normal-distributed random values with fixed mean and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_normal mean: 93.0
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(93.0, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(1.0, 0.05)
      end

      it "generates normal-distributed random values with fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_normal mean: 93.0, sigma: 9.3
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(93.0, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(9.3, 0.05)
      end

      it "generates normal-distributed random values with negative fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_normal mean: -93.0, sigma: 9.3
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(-93.0, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(9.3, 0.05)
      end
    end

    describe "#next_lognormal" do
      it "accepts any sized Int" do
        SpecRng.next_lognormal 1_i8
        SpecRng.next_lognormal 1_i16
        SpecRng.next_lognormal 1_i32
        SpecRng.next_lognormal 1_i64
        SpecRng.next_lognormal 1_i128

        SpecRng.next_lognormal 1_i8, 1_i8
        SpecRng.next_lognormal 1_i16, 1_i16
        SpecRng.next_lognormal 1_i32, 1_i32
        SpecRng.next_lognormal 1_i64, 1_i64
        SpecRng.next_lognormal 1_i128, 1_i128
      end

      it "accepts any sized UInt" do
        SpecRng.next_lognormal 1_u8
        SpecRng.next_lognormal 1_u16
        SpecRng.next_lognormal 1_u32
        SpecRng.next_lognormal 1_u64
        SpecRng.next_lognormal 1_u128

        SpecRng.next_lognormal 1_u8, 1_u8
        SpecRng.next_lognormal 1_u16, 1_u16
        SpecRng.next_lognormal 1_u32, 1_u32
        SpecRng.next_lognormal 1_u64, 1_u64
        SpecRng.next_lognormal 1_u128, 1_u128
      end

      it "accepts any sized Float" do
        SpecRng.next_lognormal 1.0_f32
        SpecRng.next_lognormal 1.0_f64

        SpecRng.next_lognormal 1.0_f32, 1.0_f32
        SpecRng.next_lognormal 1.0_f64, 1.0_f64
      end

      it "generates lognormal-distributed random values with underlying normal with mean 0.0 and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_lognormal
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(1.6487212707001282, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(2.1611974158950877, 0.05)
      end

      it "generates lognormal-distributed random values underlying normal with fixed mean and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_lognormal mean: 3.0
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(33.11545195869231, 0.5)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(43.40881049525856, 1.0)
      end

      it "generates lognormal-distributed random values underlying normal with fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_lognormal mean: 3.0, sigma: 0.5
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(22.75989509352673, 0.5)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(12.129666457739873, 0.5)
      end

      it "generates lognormal-distributed random values underlying normal with negative fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_lognormal mean: -3.0, sigma: 0.5
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(0.05641613950377735, 0.005)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(0.03006643713435963, 0.005)
      end
    end

    describe "#next_exponential" do
      it "accepts any sized Int" do
        SpecRng.next_exponential 1_i8
        SpecRng.next_exponential 1_i16
        SpecRng.next_exponential 1_i32
        SpecRng.next_exponential 1_i64
        SpecRng.next_exponential 1_i128
      end

      it "accepts any sized UInt" do
        SpecRng.next_exponential 1_u8
        SpecRng.next_exponential 1_u16
        SpecRng.next_exponential 1_u32
        SpecRng.next_exponential 1_u64
        SpecRng.next_exponential 1_u128
      end

      it "accepts any sized Float" do
        SpecRng.next_exponential 1.0_f32
        SpecRng.next_exponential 1.0_f64
      end

      it "generates exp-distributed random values with stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_exponential
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(1.0, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(1.0, 0.05)
      end

      it "generates exp-distributed random values with fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        300_000.times do
          ran = SpecRng.next_exponential scale: 3.0
          ans += ran
          ary << ran
        end

        mean = ans / 300_000
        mean.should be_close(3.0, 0.05)
        stdev = stdev(ary, mean, 300_000)
        stdev.should be_close(3.0, 0.05)
      end
    end
  end
end
