require "../spec_helper"

describe Alea do
  context "Exponential" do
    describe Alea::CDF do
      describe "#exponential" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.exponential(0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.exponential(1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if scale is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.exponential(1.0, scale: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if scale is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.exponential(1.0, scale: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if scale is 0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.exponential(0.0, scale: 0.0)
          end
        end

        it "raises Alea::UndefinedError if scale is negative" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.exponential(0.0, scale: -1.0)
          end
        end

        it "returns the cdf of -1.0 in Exp(1.0)" do
          Alea::CDF.exponential(-1.0).should eq(0.0)
        end

        it "returns the cdf of 0.0 in Exp(1.0)" do
          Alea::CDF.exponential(0.0).should eq(0.0)
        end

        it "returns the cdf of 1.0 in Exp(1.0)" do
          Alea::CDF.exponential(1.0).should eq(0.6321205588285577)
        end

        it "returns the cdf of 2.0 in Exp(1.0)" do
          Alea::CDF.exponential(2.0).should eq(0.8646647167633873)
        end

        it "returns the cdf of 1.0 in Exp(0.5)" do
          Alea::CDF.exponential(1.0, scale: 0.5).should eq(0.8646647167633873)
        end

        it "returns the cdf of 2.0 in Exp(0.5)" do
          Alea::CDF.exponential(2.0, scale: 0.5).should eq(0.9816843611112658)
        end
      end
    end
  end
end
