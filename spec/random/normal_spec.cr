require "../spec_helper"

describe Alea do
  context "Normal" do
    describe Alea::Random do
      describe "#normal" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.normal 1_i{{bits.id}}
            SpecRng.normal 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.normal 1_u{{bits.id}}
            SpecRng.normal 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.normal 1.0_f32
          SpecRng.normal 1.0_f64

          SpecRng.normal 1.0_f32, 1.0_f32
          SpecRng.normal 1.0_f64, 1.0_f64
        end

        it "raises ArgumentError if sigma is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.normal sigma: 0.0
          end
        end

        it "raises ArgumentError if sigma is negative" do
          expect_raises(ArgumentError) do
            SpecRng.normal sigma: -1.0
          end
        end
      end

      describe "#next_normal" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_normal 1_i{{bits.id}}
            SpecRng.next_normal 1_i{{bits.id}}, 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized UInt as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_normal 1_u{{bits.id}}
            SpecRng.next_normal 1_u{{bits.id}}, 1_u{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_normal 1.0_f32
          SpecRng.next_normal 1.0_f64

          SpecRng.next_normal 1.0_f32, 1.0_f32
          SpecRng.next_normal 1.0_f64, 1.0_f64
        end

        it "generates normal-distributed random values with mean 0.0 and stdev 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_normal
            ans += ran
            ary << ran
          end

          mean_r = 0.0
          stdev_r = 1.0
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates normal-distributed random values with fixed mean and stdev 1.0" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_normal mean: 93.0
            ans += ran
            ary << ran
          end

          mean_r = 93.0
          stdev_r = 1.0
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates normal-distributed random values with fixed mean and fixed stdev" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_normal mean: 93.0, sigma: 9.3
            ans += ran
            ary << ran
          end

          mean_r = 93.0
          stdev_r = 9.3
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates normal-distributed random values with negative fixed mean and fixed stdev" do
          ary = Array(Float64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_normal mean: -93.0, sigma: 9.3
            ans += ran
            ary << ran
          end

          mean_r = -93.0
          stdev_r = 9.3
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
