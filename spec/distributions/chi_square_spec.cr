require "../spec_helper"

describe Alea do
  context "ChiSquare" do
    describe Alea::Random do
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

        it "raises Alea::NaNError if degrees of freedom are NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.chi_square freedom: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if degrees of freedom are Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.chi_square freedom: 1.0 / 0.0
          end
        end

        it "raises Alea::UndefinedError if degrees of freedom are 0.0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.chi_square freedom: 0.0
          end
        end

        it "raises Alea::UndefinedError if degrees of freedom are negative" do
          expect_raises(Alea::UndefinedError) do
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

    describe Alea::CDF do
      describe "#chi_square" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.chi_square(0.0 / 0.0, freedom: 1.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.chi_square(1.0 / 0.0, freedom: 1.0)
          end
        end

        it "raises Alea::NaNError if degrees of freedom are NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.chi_square(0.0, freedom: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if degrees of freedom are Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.chi_square(0.0, freedom: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if freedom is equal to 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.chi_square(0.0, freedom: 0.0)
          end
        end

        it "raises Alea::UndefinedError if freedom is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.chi_square(0.0, freedom: -1.0)
          end
        end

        it "returns the cdf of -1.0 in X2(1)" do
          Alea::CDF.chi_square(-1.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in X2(1)" do
          Alea::CDF.chi_square(0.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in X2(1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.842700792949714869341
          cv = Alea::CDF.chi_square(2.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in X2(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 6.6117105610342475e-06
          cv = Alea::CDF.chi_square(0.5, freedom: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in X2(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00365984682734371234
          cv = Alea::CDF.chi_square(2.0, freedom: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214.0 in X2(100)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.99999999972060354684
          cv = Alea::CDF.chi_square(214.0, freedom: 100.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
