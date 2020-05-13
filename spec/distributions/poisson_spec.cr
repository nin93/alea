require "../spec_helper"

describe Alea do
  context "Poisson" do
    describe Alea::Random do
      describe "#poisson" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.poisson 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.poisson 1.0_f32
          SpecRng.poisson 1.0_f64
        end

        it "raises ArgumentError if lambda is 0.0" do
          expect_raises(ArgumentError) do
            SpecRng.poisson lam: 0.0
          end
        end

        it "raises ArgumentError if lambda is negative" do
          expect_raises(ArgumentError) do
            SpecRng.poisson lam: -1.0
          end
        end
      end

      describe "#next_poisson" do
        it "accepts any sized Int as argument(s)" do
          {% for bits in %i[8 16 32 64 128] %}
            SpecRng.next_poisson 1_i{{bits.id}}
          {% end %}
        end

        it "accepts any sized Float as argument(s)" do
          SpecRng.next_poisson 1.0_f32
          SpecRng.next_poisson 1.0_f64
        end

        it "generates poisson-distributed random values with lambda 1.0" do
          ary = Array(Int64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_poisson
            ans += ran
            ary << ran
          end

          # mean  is:   l
          # stdev is:   sqrt( l )

          mean_r = 1.0
          stdev_r = 1.0
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates poisson-distributed random values with fixed lambda below 7.0" do
          ary = Array(Int64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_poisson lam: 3.0
            ans += ran
            ary << ran
          end

          # mean  is:   l
          # stdev is:   sqrt( l )

          mean_r = 3.0
          stdev_r = 1.7320508075688772
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates poisson-distributed random values with fixed lambda = 10.0" do
          ary = Array(Int64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_poisson lam: 10.0
            ans += ran
            ary << ran
          end

          # mean  is:   l
          # stdev is:   sqrt( l )

          mean_r = 10.0
          stdev_r = 3.1622776601683795
          tol = 0.005

          mean = ans / SpecNdata
          stdev = stdev(ary, mean, SpecNdata)
          mean.should be_close(mean_r, tol * stdev_r)
          stdev.should be_close(stdev_r, tol * stdev_r)
        end

        it "generates poisson-distributed random values with fixed lambda above 10.0" do
          ary = Array(Int64).new
          ans = 0.0

          SpecNdata.times do
            ran = SpecRng.next_poisson lam: 937793773973.0
            ans += ran
            ary << ran
          end

          # mean  is:   l
          # stdev is:   sqrt( l )

          mean_r = 937793773973.0
          stdev_r = 968397.5288965787
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
