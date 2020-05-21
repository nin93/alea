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
            SpecRng.chi_square df: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if degrees of freedom are Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.chi_square df: 1.0 / 0.0
          end
        end

        it "raises Alea::UndefinedError if degrees of freedom are 0.0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.chi_square df: 0.0
          end
        end

        it "raises Alea::UndefinedError if degrees of freedom are negative" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.chi_square df: -1.0
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
            ran = SpecRng.next_chi_square df: 3.0
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
  end
end
