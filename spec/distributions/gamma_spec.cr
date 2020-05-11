require "../spec_helper"

describe Alea do
  context "Gamma" do
    describe Alea::Random do
      describe "#gamma" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.gamma 1_i{{bits.id}}
            SpecRng.gamma 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.gamma 1_u{{bits.id}}
            SpecRng.gamma 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.gamma 1.0_f32
          SpecRng.gamma 1.0_f64

          SpecRng.gamma 1.0_f32, 1.0_f32
          SpecRng.gamma 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if shape is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.gamma shape: 0.0
          end
        end

        it "raises ArgumentError if shape is negative" do
          expect_raises(ArgumentError) do
            SpecRng.gamma shape: -1.0
          end
        end

        it "raises ArgumentError if scale is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.gamma 1.0, scale: 0.0
          end
        end

        it "raises ArgumentError if scale is negative" do
          expect_raises(ArgumentError) do
            SpecRng.gamma 1.0, scale: -1.0
          end
        end
      end

      describe "#next_gamma" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_gamma 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_gamma 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_gamma 1.0_f32
          SpecRng.next_gamma 1.0_f64
        end

        it "generates gamma-distributed random values with fixed shape and scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_gamma shape: 3.0
            ans += ran
            ary << ran
          end

          # mean  is:   ks
          # stdev is:   sqrt( ks^2 )

          mean_r = 3.0
          stdev_r = 1.7320508075688772
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates gamma-distributed random values with fixed shape and fixed scale" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_gamma shape: 3.0, scale: 1.5
            ans += ran
            ary << ran
          end

          # mean  is:   ks
          # stdev is:   sqrt( ks^2 )

          mean_r = 4.5
          stdev_r = 2.598076211353316
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
