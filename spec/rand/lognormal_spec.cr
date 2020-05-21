require "../spec_helper"

describe Alea do
  context "Lognormal" do
    describe Alea::Random do
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

        it "raises Alea::NaNError if mean is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.lognormal mean: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if mean is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.lognormal mean: 1.0 / 0.0
          end
        end

        it "raises Alea::NaNError if sigma NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.lognormal 1.0, sigma: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if sigma Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.lognormal 1.0, sigma: 1.0 / 0.0
          end
        end

        it "raises Alea::UndefinedError if sigma is 0.0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.lognormal sigma: 0.0
          end
        end

        it "raises Alea::UndefinedError if sigma is negative" do
          expect_raises(Alea::UndefinedError) do
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
          stdev.should be_close(stdev_r, 0.007 * stdev_r)
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
          stdev.should be_close(stdev_r, 0.007 * stdev_r)
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
          stdev.should be_close(stdev_r, 0.007 * stdev_r)
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
          stdev.should be_close(stdev_r, 0.007 * stdev_r)
        end
      end
    end

    describe Alea::CDF do
      describe "#lognormal" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.lognormal(0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.lognormal(1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if mean is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.lognormal(0.0, mean: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if mean is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.lognormal(0.0, mean: 1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if stdev is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.lognormal(0.0, sigma: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if stdev is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.lognormal(0.0, sigma: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if stdev is equal to 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.lognormal(0.0, sigma: 0.0)
          end
        end

        it "raises Alea::UndefinedError if stdev is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.lognormal(0.0, sigma: -1.0)
          end
        end

        it "returns the cdf of 0.0 in LogN(0, 1)" do
          Alea::CDF.lognormal(0.0).should eq(0.0)
        end

        it "returns the cdf of 1.0 in LogN(0, 1)" do
          Alea::CDF.lognormal(1.0).should eq(0.5)
        end

        it "returns the cdf of -1.0 in LogN(0, 1)" do
          Alea::CDF.lognormal(-1.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in LogN(2, 1)" do
          Alea::CDF.lognormal(2.0, mean: 2.0).should eq(0.09563135117897992)
        end

        it "returns the cdf of 2.0 in LogN(0, 0.5)" do
          Alea::CDF.lognormal(2.0, sigma: 0.5).should eq(0.9171714809983015)
        end

        it "returns the cdf of 2.0 in LogN(1, 0.5)" do
          Alea::CDF.lognormal(2.0, mean: 1.0, sigma: 0.5).should eq(0.26970493073490953)
        end
      end
    end
  end
end
