require "../spec_helper"

describe Alea do
  context "ChiSquare" do
    describe Alea::CDF do
      describe "#chi_square" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.chi_square(0.0 / 0.0, df: 1.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.chi_square(1.0 / 0.0, df: 1.0)
          end
        end

        it "raises Alea::NaNError if degrees of freedom are NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.chi_square(0.0, df: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if degrees of freedom are Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.chi_square(0.0, df: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if freedom is equal to 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.chi_square(0.0, df: 0.0)
          end
        end

        it "raises Alea::UndefinedError if freedom is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.chi_square(0.0, df: -1.0)
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
          cv = Alea::CDF.chi_square(0.5, df: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in X2(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00365984682734371234
          cv = Alea::CDF.chi_square(2.0, df: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214.0 in X2(100)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.99999999972060354684
          cv = Alea::CDF.chi_square(214.0, df: 100.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
