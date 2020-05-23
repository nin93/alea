require "../spec_helper"

describe Alea do
  context "Poisson" do
    describe Alea::CDF do
      describe "#poisson" do
        it "raises Alea::NaNError if degrees of freedom are NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.poisson(0, lam: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if degrees of freedom are Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.poisson(0, lam: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if freedom is equal to 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.poisson(0, lam: 0.0)
          end
        end

        it "raises Alea::UndefinedError if freedom is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.poisson(0, lam: -1.0)
          end
        end

        it "returns the cdf of -1.0 in Poiss(1)" do
          Alea::CDF.poisson(-1).should eq(0.0)
        end

        it "returns the cdf of 0 in Poiss(1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.36787944117144232159
          cv = Alea::CDF.poisson(0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2 in Poiss(1)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.91969860292860580398
          cv = Alea::CDF.poisson(2)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 1 in Poiss(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00049939922738733336
          cv = Alea::CDF.poisson(1, lam: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 2 in Poiss(10)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.00276939571551157594
          cv = Alea::CDF.poisson(2, lam: 10.0)
          cv.should be_close(wf, cv * tol)
        end

        it "returns the cdf of 214 in Poiss(100)" do
          # Percent err
          tol = 1.0e-14
          # From WolframAlpha
          wf = 0.220220646601698940243
          cv = Alea::CDF.poisson(7, lam: 10.0)
          cv.should be_close(wf, cv * tol)
        end
      end
    end
  end
end
