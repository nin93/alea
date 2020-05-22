require "../spec_helper"

describe Alea do
  context "Gamma" do
    describe Alea::CDF do
      describe "#gamma" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.gamma(0.0 / 0.0, shape: 1.0, scale: 1.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.gamma(1.0 / 0.0, shape: 1.0, scale: 1.0)
          end
        end

        it "raises Alea::NaNError if shape is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.gamma(0.0, shape: 0.0 / 0.0, scale: 1.0)
          end
        end

        it "raises Alea::InfinityError if shape is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.gamma(0.0, shape: 1.0 / 0.0, scale: 1.0)
          end
        end

        it "raises Alea::NaNError if scale is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.gamma(0.0, shape: 1.0, scale: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if scale is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.gamma(0.0, shape: 1.0, scale: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if shape is 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.gamma(0.0, shape: 0.0, scale: 1.0)
          end
        end

        it "raises Alea::UndefinedError if shape is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.gamma(0.0, shape: -1.0, scale: 1.0)
          end
        end

        it "raises Alea::UndefinedError if scale is 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.gamma(0.0, shape: 1.0, scale: 0.0)
          end
        end

        it "raises Alea::UndefinedError if scale is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.gamma(0.0, shape: 1.0, scale: -1.0)
          end
        end

        it "returns the cdf of -1.0 in G(1, 1)" do
          Alea::CDF.gamma(-1.0, shape: 1.0, scale: 1.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in G(1, 1)" do
          Alea::CDF.gamma(0.0, shape: 1.0, scale: 1.0).should eq(0.0)
        end

        it "returns the cdf of 2.0 in G(1, 1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.86466471676338730810
          cv = Alea::CDF.gamma(2.0, shape: 1.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 0.5 in G(10, 1)" do
          # Percent err
          tol = 1.0e-13
          # From WolframAlpha
          wf = 1.7096700293489033e-10
          cv = Alea::CDF.gamma(0.5, shape: 10.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2.0 in G(10, 1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00004649807501726380
          cv = Alea::CDF.gamma(2.0, shape: 10.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214.0 in G(100, 1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.9999999999999999988291
          cv = Alea::CDF.gamma(214.0, shape: 100.0, scale: 1.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
