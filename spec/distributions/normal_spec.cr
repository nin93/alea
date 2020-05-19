require "../spec_helper"

describe Alea do
  context "Normal" do
    describe Alea::Random do
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

        it "raises Alea::NaNError if mean is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.normal mean: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if mean is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.normal mean: 1.0 / 0.0
          end
        end

        it "raises Alea::NaNError if sigma NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.normal 1.0, sigma: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if sigma Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.normal 1.0, sigma: 1.0 / 0.0
          end
        end

        it "raises Alea::UndefinedError if sigma is 0.0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.normal sigma: 0.0
          end
        end

        it "raises Alea::UndefinedError if sigma is negative" do
          expect_raises(Alea::UndefinedError) do
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

    describe Alea::CDF do
      describe "#normal" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.normal(0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.normal(1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if mean is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.normal(0.0, mean: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if mean is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.normal(0.0, mean: 1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if stdev is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.normal(0.0, sigma: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if stdev is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.normal(0.0, sigma: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if stdev is equal to 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.normal(0.0, sigma: 0.0)
          end
        end

        it "raises Alea::UndefinedError if stdev is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.normal(0.0, sigma: -1.0)
          end
        end

        it "returns the cdf of 0.0 in N(0, 1)" do
          Alea::CDF.normal(0.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in N(2, 1)" do
          Alea::CDF.normal(2.0, mean: 2.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in N(0, 0.5)" do
          Alea::CDF.normal(2.0, sigma: 0.5).should eq(0.9999683287581669)
        end

        it "returns the cdf of 2.0 in N(1, 0.5)" do
          Alea::CDF.normal(2.0, mean: 1.0, sigma: 0.5).should eq(0.9772498680518208)
        end

        it "returns the cdf of -2.0 in N(-2, 1)" do
          Alea::CDF.normal(-2.0, mean: -2.0).should eq(0.5)
        end

        it "returns the cdf of -2.0 in N(0, 0.5)" do
          Alea::CDF.normal(-2.0, sigma: 0.5).should eq(3.167124183311998e-5)
        end

        it "returns the cdf of -2.0 in N(1, 0.5)" do
          Alea::CDF.normal(-2.0, mean: 1.0, sigma: 0.5).should eq(9.865876449133282e-10)
        end
      end
    end
  end
end
