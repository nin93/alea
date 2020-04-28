require "./spec_helper"

describe Alea do
  describe Alea::Random do
    context "Normal" do
      describe "#normal" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.normal 1_i{{bits.id}}
            SpecRng.normal 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.normal 1_u{{bits.id}}
            SpecRng.normal 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.normal 1.0_f32
          SpecRng.normal 1.0_f64

          SpecRng.normal 1.0_f32, 1.0_f32
          SpecRng.normal 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if sigma is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.normal sigma: 0.0
          end
        end

        it "raises ArgumentError if sigma is negative" do
          expect_raises(ArgumentError) do
            SpecRng.normal sigma: -1.0
          end
        end
      end

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
    end

    context "Lognormal" do
      describe "#lognormal" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.lognormal 1_i{{bits.id}}
            SpecRng.lognormal 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.lognormal 1_u{{bits.id}}
            SpecRng.lognormal 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.lognormal 1.0_f32
          SpecRng.lognormal 1.0_f64

          SpecRng.lognormal 1.0_f32, 1.0_f32
          SpecRng.lognormal 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if sigma is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.lognormal sigma: 0.0
          end
        end

        it "raises ArgumentError if sigma is negative" do
          expect_raises(ArgumentError) do
            SpecRng.lognormal sigma: -1.0
          end
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
    end

    context "Exponential" do
      describe "#exponential" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.exponential 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.exponential 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.exponential 1.0_f32
          SpecRng.exponential 1.0_f64
        end

        it "raises ArgumentError if scale is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.exponential scale: 0.0
          end
        end

        it "raises ArgumentError if scale is negative" do
          expect_raises(ArgumentError) do
            SpecRng.exponential scale: -1.0
          end
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
    end

    context "Gamma" do
      describe "#gamma" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.gamma 1_i{{bits.id}}
            SpecRng.gamma 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.gamma 1_u{{bits.id}}
            SpecRng.gamma 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.gamma 1.0_f32
          SpecRng.gamma 1.0_f64

          SpecRng.gamma 1.0_f32, 1.0_f32
          SpecRng.gamma 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if shape is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.gamma shape: 0.0
          end
        end

        it "raises ArgumentError if shape is negative" do
          expect_raises(ArgumentError) do
            SpecRng.gamma shape: -1.0
          end
        end

        it "raises ArgumentError if scale is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.gamma 1.0, scale: 0.0
          end
        end

        it "raises ArgumentError if scale is negative" do
          expect_raises(ArgumentError) do
            SpecRng.gamma 1.0, scale: -1.0
          end
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
    end

    context "Beta" do
      describe "#beta" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.beta a: 1_i{{bits.id}}, b: 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.beta a: 1_u{{bits.id}}, b: 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.beta a: 1.0_f32, b: 1.0_f32
          SpecRng.beta a: 1.0_f64, b: 1.0_f64
        end

        it "raises ArgumentError if a is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: 0.0, b: 1.0
          end
        end

        it "raises ArgumentError if a is negative" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: -1.0, b: 1.0
          end
        end

        it "raises ArgumentError if b is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: 1.0, b: 0.0
          end
        end

        it "raises ArgumentError if b is negative" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: 1.0, b: -1.0
          end
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
      end
    end

    context "Laplace" do
      describe "#laplace" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.laplace 1_i{{bits.id}}
            SpecRng.laplace 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.laplace 1_u{{bits.id}}
            SpecRng.laplace 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.laplace 1.0_f32
          SpecRng.laplace 1.0_f64

          SpecRng.laplace 1.0_f32, 1.0_f32
          SpecRng.laplace 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if scale is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.laplace 1.0, scale: 0.0
          end
        end

        it "raises ArgumentError if scale is negative" do
          expect_raises(ArgumentError) do
            SpecRng.laplace 1.0, scale: -1.0
          end
        end
      end

      describe "#next_laplace" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_laplace 1_i{{bits.id}}
            SpecRng.next_laplace 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_laplace 1_u{{bits.id}}
            SpecRng.next_laplace 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_laplace 1.0_f32
          SpecRng.next_laplace 1.0_f64

          SpecRng.next_laplace 1.0_f32, 1.0_f32
          SpecRng.next_laplace 1.0_f64, 1.0_f64
        end

        it "generates laplace-distributed random values with mean 0.0 and scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_laplace
            ans += ran
            ary << ran
          end

          # mean  is:   m
          # stdev is:   k * sqrt( 2 )

          mean_r = 0.0
          stdev_r = 1.4142135623730951
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates laplace-distributed random values with fixed mean and scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_laplace mean: 3.0
            ans += ran
            ary << ran
          end

          # mean  is:   m
          # stdev is:   k * sqrt( 2 )

          mean_r = 3.0
          stdev_r = 1.4142135623730951
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates laplace-distributed random values with fixed shape and fixed scale" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_laplace mean: 3.0, scale: 1.5
            ans += ran
            ary << ran
          end

          # mean  is:   m
          # stdev is:   k * sqrt( 2 )

          mean_r = 3.0
          stdev_r = 2.121320343559643
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end
      end
    end

    context "ChiSquare" do
      describe "#chi_square" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.chi_square 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.chi_square 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.chi_square 1.0_f32
          SpecRng.chi_square 1.0_f64
        end

        it "raises ArgumentError if degrees of freedom are 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.chi_square freedom: 0.0
          end
        end

        it "raises ArgumentError if degrees of freedom are negative" do
          expect_raises(ArgumentError) do
            SpecRng.chi_square freedom: -1.0
          end
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
end
