require "../spec_helper"

describe Alea do
  context "Beta" do
    describe Alea::Random do
      describe "#beta" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.beta a: 1_i{{bits.id}}, b: 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.beta a: 1_u{{bits.id}}, b: 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.beta a: 1.0_f32, b: 1.0_f32
          SpecRng.beta a: 1.0_f64, b: 1.0_f64
        end

        it "raises ArgumentError if a is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: 0.0, b: 1.0
          end
        end

        it "raises ArgumentError if a is negative" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: -1.0, b: 1.0
          end
        end

        it "raises ArgumentError if b is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: 1.0, b: 0.0
          end
        end

        it "raises ArgumentError if b is negative" do
          expect_raises(ArgumentError) do
            SpecRng.beta a: 1.0, b: -1.0
          end
        end
      end

      describe "#next_beta" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_beta a: 1_i{{bits.id}}, b: 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_beta a: 1_u{{bits.id}}, b: 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_beta a: 1.0_f32, b: 1.0_f32
          SpecRng.next_beta a: 1.0_f64, b: 1.0_f64
        end

        it "generates beta-distributed random values with fixed a and b parameters" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_beta a: 3.0, b: 5.0
            ans += ran
            ary << ran
          end

          # mean  is:   1.0 / (1.0 + (b / a))
          # stdev is:   sqrt( ab / ((a + b)^2 * (a + b + 1.0)) )

          mean_r = 0.375
          stdev_r = 0.1613743060919757
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
