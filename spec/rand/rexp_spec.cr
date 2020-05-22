require "../spec_helper"

describe Alea do
  context "Exponential" do
    describe Alea::Random do
      describe "#exp" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.exp 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.exp 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.exp 1.0_f32
          SpecRng.exp 1.0_f64
        end

        it "raises Alea::NaNError if a is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.exp scale: 0.0 / 0.0
          end
        end

        it "raises Alea::InfinityError if a is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.exp scale: 1.0 / 0.0
          end
        end

        it "raises Alea::UndefinedError if scale is 0.0" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.exp scale: 0.0
          end
        end

        it "raises Alea::UndefinedError if scale is negative" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.exp scale: -1.0
          end
        end
      end

      describe "#next_exp" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_exp 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_exp 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_exp 1.0_f32
          SpecRng.next_exp 1.0_f64
        end

        it "generates exp-distributed random values with scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_exp
            ans += ran
            ary << ran
          end

          # mean  is:   k
          # stdev is:   k

          mean_r = 1.0
          stdev_r = 1.0
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates exp-distributed random values with fixed scale" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_exp scale: 3.0
            ans += ran
            ary << ran
          end

          # mean  is:   k
          # stdev is:   k

          mean_r = 3.0
          stdev_r = 3.0
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
