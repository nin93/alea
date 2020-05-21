require "../spec_helper"

describe Alea do
  context "Uniform" do
    describe Alea::Random do
      describe "#uint" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.uint 1_i{{bits.id}}
            SpecRng.uint 1_i{{bits.id}}..1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.uint 1_u{{bits.id}}
            SpecRng.uint 1_u{{bits.id}}..1_u{{bits.id}}
          {% end %}
        end

        it "raises Alea::UndefinedError if max is 0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint max: 0
          end
        end

        it "raises Alea::UndefinedError if max is negative" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint max: -1
          end
        end

        it "raises Alea::UndefinedError if range is negative" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint (-1..0)
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint (1..0)
          end
        end

        it "raises Alea::UndefinedError if range is badly choosen" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.uint (1...1)
          end
        end

        it "returns 0 if max is 1" do
          SpecRng.uint(1).should eq(0)
        end

        it "returns an unique number if range only consists of it" do
          SpecRng.uint(93..93).should eq(93)
        end

        it "returns 0 if max is range is 0..0" do
          SpecRng.uint(0..0).should eq(0)
        end

        it "returns uniformly-distributed random values with fixed limit" do
          ary = Array(UInt64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.uint 9377
            ans += ran
            ary << ran
          end

          # mean  is:   a / 2
          # stdev is:   a / sqrt( 12 )

          mean_r = 4688.5
          stdev_r = 2706.9067370955604
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "returns uniformly-distributed random values with fixed range inclusive" do
          ary = Array(UInt64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.uint 10..93
            ans += ran
            ary << ran
          end

          # mean  is:   (b + a) / 2
          # stdev is:   (b - a) / sqrt( 12 )

          mean_r = 51.5
          stdev_r = 24.248711305964285
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "returns uniformly-distributed random values with fixed range exclusive" do
          ary = Array(UInt64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.uint 10...93
            ans += ran
            ary << ran
          end

          # mean  is:   (b + a) / 2
          # stdev is:   (b - a) / sqrt( 12 )

          mean_r = 51.0
          stdev_r = 23.96003617136947
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end
      end

      describe "#float" do
        it "accepts any sized Float as argument(s)" do
          {% for bits in %i[32 64] %}
            SpecRng.float 1.0_f{{bits.id}}
            SpecRng.float 1.0_f{{bits.id}}..1.0_f{{bits.id}}
          {% end %}
        end

        it "raises Alea::NaNError if max is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float max: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if max is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float max: 1.0 / 0.0
          end
        end

        it "raises Alea::UndefinedError if max is 0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float max: 0.0
          end
        end

        it "raises Alea::UndefinedError if max is negative" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float max: -1.0
          end
        end

        it "raises Alea::NaNError if left bound is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float ((0.0 / 0.0)..0.0)
          end
        end

        it "raises Alea::InfinityError if left bound is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float ((1.0 / 0.0)..0.0)
          end
        end

        it "raises Alea::NaNError if right bound is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float (0.0..(0.0 / 0.0))
          end
        end

        it "raises Alea::InfinityError if right bound is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float (0.0..(1.0 / 0.0))
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float (1.0..0.0)
          end
        end

        it "raises Alea::UndefinedError if range is badly choosen" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float (1.0...1.0)
          end
        end

        it "returns an uniform-distributed in [0.0, 1.0) if max is 1.0" do
          SpecRng.float(1.0).should be < 1.0
        end

        it "returns an unique number if range only consists of it" do
          SpecRng.float(93.0..93.0).should eq(93.0)
        end

        it "returns 0.0 if max is range is 0.0..0.0" do
          SpecRng.float(0.0..0.0).should eq(0.0)
        end

        it "returns uniformly-distributed random values with fixed limit" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.float 9377.0
            ans += ran
            ary << ran
          end

          # mean  is:   a / 2
          # stdev is:   a / sqrt( 12 )

          mean_r = 4688.5
          stdev_r = 2706.9067370955604
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "returns uniformly-distributed random values with fixed range inclusive" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.float -10_000.0..93.0
            ans += ran
            ary << ran
          end

          # mean  is:   (b + a) / 2
          # stdev is:   (b - a) / sqrt( 12 )

          mean_r = -4953.0
          stdev_r = 2913.8868086000416
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "returns uniformly-distributed random values with fixed range exclusive" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.float 10.0...93.0
            ans += ran
            ary << ran
          end

          # mean  is:   (b + a) / 2
          # stdev is:   (b - a) / sqrt( 12 )

          mean_r = 51.5
          stdev_r = 23.96003617136947
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end
      end
    end

    describe Alea::CDF do
      describe "#uniform" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.uniform(0.0 / 0.0, min: 0.0, max: 1.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.uniform(1.0 / 0.0, min: 0.0, max: 1.0)
          end
        end

        it "raises Alea::NaNError if min is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.uniform(0.0, min: 0.0 / 0.0, max: 0.0)
          end
        end

        it "raises Alea::InfinityError if min is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.uniform(0.0, min: 1.0 / 0.0, max: 0.0)
          end
        end

        it "raises Alea::NaNError if max is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.uniform(0.0, min: 0.0, max: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if max is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.uniform(0.0, min: 0.0, max: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if min is equal to max" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.uniform(0.0, min: 0.0, max: 0.0)
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.uniform(0.0, min: 0.0, max: -1.0)
          end
        end

        it "returns the cdf of -1.0 in U(0, 100)" do
          Alea::CDF.uniform(-1.0, min: 0.0, max: 100.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in U(0, 100)" do
          Alea::CDF.uniform(0.0, min: 0.0, max: 100.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in U(0, 100)" do
          Alea::CDF.uniform(50.0, min: 0.0, max: 100.0).should eq(0.5)
        end

        it "returns the cdf of 100.0 in U(0, 100)" do
          Alea::CDF.uniform(100.0, min: 0.0, max: 100.0).should eq(1.0)
        end

        it "returns the cdf of 101.0 in U(0, 100)" do
          Alea::CDF.uniform(101.0, min: 0.0, max: 100.0).should eq(1.0)
        end
      end
    end
  end
end
