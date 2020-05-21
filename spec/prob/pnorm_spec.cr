require "../spec_helper"

describe Alea do
  context "Normal" do
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
