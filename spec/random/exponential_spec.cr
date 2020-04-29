require "../spec_helper"

describe Alea do
  describe Alea::Random do
    context "Exponential" do
      describe "#exponential" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.exponential 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.exponential 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.exponential 1.0_f32
          SpecRng.exponential 1.0_f64
        end

        it "raises ArgumentError if scale is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.exponential scale: 0.0
          end
        end

        it "raises ArgumentError if scale is negative" do
          expect_raises(ArgumentError) do
            SpecRng.exponential scale: -1.0
          end
        end
      end

      describe "#next_exponential" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_exponential 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_exponential 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_exponential 1.0_f32
          SpecRng.next_exponential 1.0_f64
        end

        it "generates exp-distributed random values with scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_exponential
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
            ran = SpecRng.next_exponential scale: 3.0
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
