require "../spec_helper"

describe Alea do
  context "Uniform" do
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
