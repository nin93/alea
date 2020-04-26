require "./spec_helper"

def stdev(ary, mean, n)
  ans = 0.0
  ary.each do |e|
    ans += (e - mean) ** 2
  end
  Math.sqrt(ans / (n - 1))
end

describe Alea do
  describe Alea::XSR128 do
    pending "returns a new instance from module" do
      Alea::Xoshiro.new.should be_a(Alea::XSR128)
      Alea::Xoshiro.new(12345).should be_a(Alea::XSR128)
    end

    it "returns a new instance from class" do
      Alea::XSR128.new.should be_a(Alea::XSR128)
      Alea::XSR128.new(12345).should be_a(Alea::XSR128)
    end

    it "generates sames numbers from same initial state concurrently" do
      rng1 = Alea::XSR128.new 93
      rng2 = Alea::XSR128.new 93

      1_000_000.times do
        rng1.next_u.should eq(rng2.next_u)
      end
    end

    it "generates different numbers from different initial state" do
      rng1 = Alea::XSR128.new 93
      rng2 = Alea::XSR128.new 193

      1_000_000.times do
        rng1.next_u.should_not eq(rng2.next_u)
      end
    end

    describe "#next_u" do
      it "returns a UInt64" do
        rng = Alea::XSR128.new
        rnd = rng.next_u
        rnd.should be_a(UInt64)
      end

      it "returns a UInt64 with given initial state" do
        rng = Alea::XSR128.new 9377
        rnd = rng.next_u
        rnd.should be_a(UInt64)
      end

      it "returns uniformly-distributed random values" do
        ary = Array(UInt64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_u
          ans += ran
          ary << ran
        end

        mean = ans / SpecNdata
        mean.should be_close(9223372036854775807.5, 1.5e16)
        stdev = stdev(ary, mean, SpecNdata)
        stdev.should be_close(5.325116328314172e+18, 0.5e18)
      end
    end

    describe "#next_f" do
      it "generates a Float64" do
        rng = Alea::XSR128.new
        rnd = rng.next_f
        rnd.should be_a(Float64)
      end

      it "generates a Float64 with given initial state" do
        rng = Alea::XSR128.new 9377
        rnd = rng.next_f
        rnd.should be_a(Float64)
      end

      it "generates uniformly-distributed random values" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_f
          ans += ran
          ary << ran
        end

        mean = ans / SpecNdata
        mean.should be_close(0.5, 0.01)
        stdev = stdev(ary, mean, SpecNdata)
        stdev.should be_close(0.2886751345948129, 0.005)
      end
    end
  end

  describe Alea::Random do
    describe "#next_normal" do
      it "accepts any sized Int as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_normal 1_i{{bits.id}}
          SpecRng.next_normal 1_i{{bits.id}}, 1_i{{bits.id}}
        {% end %}
      end

      it "accepts any sized UInt as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_normal 1_u{{bits.id}}
          SpecRng.next_normal 1_u{{bits.id}}, 1_u{{bits.id}}
        {% end %}
      end

      it "accepts any sized Float as argument(s)" do
        SpecRng.next_normal 1.0_f32
        SpecRng.next_normal 1.0_f64

        SpecRng.next_normal 1.0_f32, 1.0_f32
        SpecRng.next_normal 1.0_f64, 1.0_f64
      end

      it "generates normal-distributed random values with mean 0.0 and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_normal
          ans += ran
          ary << ran
        end

        mean_r = 0.0
        stdev_r = 1.0
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates normal-distributed random values with fixed mean and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_normal mean: 93.0
          ans += ran
          ary << ran
        end

        mean_r = 93.0
        stdev_r = 1.0
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates normal-distributed random values with fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_normal mean: 93.0, sigma: 9.3
          ans += ran
          ary << ran
        end

        mean_r = 93.0
        stdev_r = 9.3
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates normal-distributed random values with negative fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_normal mean: -93.0, sigma: 9.3
          ans += ran
          ary << ran
        end

        mean_r = -93.0
        stdev_r = 9.3
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end
    end

    describe "#next_lognormal" do
      it "accepts any sized Int as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_lognormal 1_i{{bits.id}}
          SpecRng.next_lognormal 1_i{{bits.id}}, 1_i{{bits.id}}
        {% end %}
      end

      it "accepts any sized UInt as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_lognormal 1_u{{bits.id}}
          SpecRng.next_lognormal 1_u{{bits.id}}, 1_u{{bits.id}}
        {% end %}
      end

      it "accepts any sized Float as argument(s)" do
        SpecRng.next_lognormal 1.0_f32
        SpecRng.next_lognormal 1.0_f64

        SpecRng.next_lognormal 1.0_f32, 1.0_f32
        SpecRng.next_lognormal 1.0_f64, 1.0_f64
      end

      it "generates lognormal-distributed random values with underlying normal with mean 0.0 and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_lognormal
          ans += ran
          ary << ran
        end

        # mean  is:   exp( m + s^2 / 2 )
        # stdev is:   sqrt( exp(2m + s^2) * (exp(s^2) - 1) )

        mean_r = 1.6487212707001282
        stdev_r = 2.1611974158950877
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates lognormal-distributed random values with underlying normal with fixed mean and stdev 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_lognormal mean: 3.0
          ans += ran
          ary << ran
        end

        # mean  is:   exp( m + s^2 / 2 )
        # stdev is:   sqrt( exp(2m + s^2) * (exp(s^2) - 1) )

        mean_r = 33.11545195869231
        stdev_r = 43.40881049525856
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates lognormal-distributed random values with underlying normal with fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_lognormal mean: 3.0, sigma: 0.5
          ans += ran
          ary << ran
        end

        # mean  is:   exp( m + s^2 / 2 )
        # stdev is:   sqrt( exp(2m + s^2) * (exp(s^2) - 1) )

        mean_r = 22.75989509352673
        stdev_r = 12.129666457739873
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates lognormal-distributed random values with underlying normal with negative fixed mean and fixed stdev" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_lognormal mean: -3.0, sigma: 0.5
          ans += ran
          ary << ran
        end

        # mean  is:   exp( m + s^2 / 2 )
        # stdev is:   sqrt( exp(2m + s^2) * (exp(s^2) - 1) )

        mean_r = 0.05641613950377735
        stdev_r = 0.03006643713435963
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end
    end

    describe "#next_exponential" do
      it "accepts any sized Int as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_exponential 1_i{{bits.id}}
        {% end %}
      end

      it "accepts any sized UInt as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_exponential 1_u{{bits.id}}
        {% end %}
      end

      it "accepts any sized Float as argument(s)" do
        SpecRng.next_exponential 1.0_f32
        SpecRng.next_exponential 1.0_f64
      end

      it "generates exp-distributed random values with scale 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_exponential
          ans += ran
          ary << ran
        end

        # mean  is:   k
        # stdev is:   k

        mean_r = 1.0
        stdev_r = 1.0
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates exp-distributed random values with fixed scale" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_exponential scale: 3.0
          ans += ran
          ary << ran
        end

        # mean  is:   k
        # stdev is:   k

        mean_r = 3.0
        stdev_r = 3.0
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end
    end

    describe "#next_gamma" do
      it "accepts any sized Int as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_gamma 1_i{{bits.id}}
        {% end %}
      end

      it "accepts any sized UInt as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_gamma 1_u{{bits.id}}
        {% end %}
      end

      it "accepts any sized Float as argument(s)" do
        SpecRng.next_gamma 1.0_f32
        SpecRng.next_gamma 1.0_f64
      end

      it "generates gamma-distributed random values with fixed shape and scale 1.0" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_gamma shape: 3.0
          ans += ran
          ary << ran
        end

        # mean  is:   ks
        # stdev is:   sqrt( ks^2 )

        mean_r = 3.0
        stdev_r = 1.7320508075688772
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates gamma-distributed random values with fixed shape and fixed scale" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_gamma shape: 3.0, scale: 1.5
          ans += ran
          ary << ran
        end

        # mean  is:   ks
        # stdev is:   sqrt( ks^2 )

        mean_r = 4.5
        stdev_r = 2.598076211353316
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end
    end

    describe "#next_beta" do
      it "accepts any sized Int as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_beta a: 1_i{{bits.id}}, b: 1_i{{bits.id}}
        {% end %}
      end

      it "accepts any sized UInt as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_beta a: 1_u{{bits.id}}, b: 1_u{{bits.id}}
        {% end %}
      end

      it "accepts any sized Float as argument(s)" do
        SpecRng.next_beta a: 1.0_f32, b: 1.0_f32
        SpecRng.next_beta a: 1.0_f64, b: 1.0_f64
      end

      it "generates beta-distributed random values with fixed a and b parameters" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_beta a: 3.0, b: 5.0
          ans += ran
          ary << ran
        end

        # mean  is:   1.0 / (1.0 + (b / a))
        # stdev is:   sqrt( ab / ((a + b)^2 * (a + b + 1.0)) )

        mean_r = 0.375
        stdev_r = 0.1613743060919757
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end

      it "generates beta-distributed random values with fixed shape and fixed scale" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_beta a: 3.0, b: 1.5
          ans += ran
          ary << ran
        end

        # mean  is:   1.0 / (1.0 + (b / a))
        # stdev is:   sqrt( ab / ((a + b)^2 * (a + b + 1.0)) )

        mean_r = 0.6666666666666666
        stdev_r = 0.20100756305184242
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end
    end

    describe "#next_chi_square" do
      it "accepts any sized Int as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_chi_square 1_i{{bits.id}}
        {% end %}
      end

      it "accepts any sized UInt as argument(s)" do
        {% for bits in %i[8 16 32 64 128] %}
          SpecRng.next_chi_square 1_u{{bits.id}}
        {% end %}
      end

      it "accepts any sized Float as argument(s)" do
        SpecRng.next_chi_square 1.0_f32
        SpecRng.next_chi_square 1.0_f64
      end

      it "generates chi^2-distributed random values with fixed degrees of freedom" do
        ary = Array(Float64).new
        ans = 0.0

        SpecNdata.times do
          ran = SpecRng.next_chi_square freedom: 3.0
          ans += ran
          ary << ran
        end

        # mean  is:   k
        # stdev is:   sqrt( 2k )

        mean_r = 3.0
        stdev_r = 2.449489742783178
        tol = 0.005

        mean = ans / SpecNdata
        stdev = stdev(ary, mean, SpecNdata)
        mean.should be_close(mean_r, tol * stdev_r)
        stdev.should be_close(stdev_r, tol * stdev_r)
      end
    end
  end
end
