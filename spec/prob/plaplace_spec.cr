require "../spec_helper"

describe Alea do
  context "Laplace" do
    describe Alea::CDF do
      describe "#laplace" do
        it "raises Alea::NaNError if x is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.laplace(0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if x is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.laplace(1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if mean is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.laplace(1.0, mean: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if mean is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.laplace(1.0, mean: 1.0 / 0.0)
          end
        end

        it "raises Alea::NaNError if scale is NaN" do
          expect_raises(Alea::NaNError) do
            Alea::CDF.laplace(1.0, scale: 0.0 / 0.0)
          end
        end

        it "raises Alea::InfinityError if scale is Infinity" do
          expect_raises(Alea::InfinityError) do
            Alea::CDF.laplace(1.0, scale: 1.0 / 0.0)
          end
        end

        it "raises Alea::UndefinedError if scale is equal to 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.laplace(0.0, scale: 0.0)
          end
        end

        it "raises Alea::UndefinedError if scale is less than 0.0" do
          expect_raises Alea::UndefinedError do
            Alea::CDF.laplace(0.0, scale: -1.0)
          end
        end

        it "returns the cdf of 0.0 in Laplace(0, 1)" do
          Alea::CDF.laplace(0.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in Laplace(2, 1)" do
          Alea::CDF.laplace(2.0, mean: 2.0).should eq(0.5)
        end

        it "returns the cdf of 2.0 in Laplace(0, 0.5)" do
          Alea::CDF.laplace(2.0, scale: 0.5).should eq(0.9908421805556329)
        end

        it "returns the cdf of 2.0 in Laplace(1, 0.5)" do
          Alea::CDF.laplace(2.0, mean: 1.0, scale: 0.5).should eq(0.9323323583816936)
        end

        it "returns the cdf of -2.0 in Laplace(-2, 1)" do
          Alea::CDF.laplace(-2.0, mean: -2.0).should eq(0.5)
        end

        it "returns the cdf of -2.0 in Laplace(0, 0.5)" do
          Alea::CDF.laplace(-2.0, scale: 0.5).should eq(0.00915781944436709)
        end

        it "returns the cdf of -2.0 in Laplace(1, 0.5)" do
          Alea::CDF.laplace(-2.0, mean: 1.0, scale: 0.5).should eq(0.0012393760883331792)
        end
      end
    end
  end
end
