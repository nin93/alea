require "../spec_helper"

describe Alea do
  describe Alea::Random do
    context "Laplace" do
      describe "#laplace" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.laplace 1_i{{bits.id}}
            SpecRng.laplace 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.laplace 1_u{{bits.id}}
            SpecRng.laplace 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.laplace 1.0_f32
          SpecRng.laplace 1.0_f64

          SpecRng.laplace 1.0_f32, 1.0_f32
          SpecRng.laplace 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if scale is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.laplace 1.0, scale: 0.0
          end
        end

        it "raises ArgumentError if scale is negative" do
          expect_raises(ArgumentError) do
            SpecRng.laplace 1.0, scale: -1.0
          end
        end
      end

      describe "#next_laplace" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_laplace 1_i{{bits.id}}
            SpecRng.next_laplace 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_laplace 1_u{{bits.id}}
            SpecRng.next_laplace 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_laplace 1.0_f32
          SpecRng.next_laplace 1.0_f64

          SpecRng.next_laplace 1.0_f32, 1.0_f32
          SpecRng.next_laplace 1.0_f64, 1.0_f64
        end

        it "generates laplace-distributed random values with mean 0.0 and scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_laplace
            ans += ran
            ary << ran
          end

          # mean  is:   m
          # stdev is:   k * sqrt( 2 )

          mean_r = 0.0
          stdev_r = 1.4142135623730951
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates laplace-distributed random values with fixed mean and scale 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_laplace mean: 3.0
            ans += ran
            ary << ran
          end

          # mean  is:   m
          # stdev is:   k * sqrt( 2 )

          mean_r = 3.0
          stdev_r = 1.4142135623730951
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates laplace-distributed random values with fixed shape and fixed scale" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_laplace mean: 3.0, scale: 1.5
            ans += ran
            ary << ran
          end

          # mean  is:   m
          # stdev is:   k * sqrt( 2 )

          mean_r = 3.0
          stdev_r = 2.121320343559643
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
