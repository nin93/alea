require "../../spec_helper"

describe Alea do
  context "Uniform" do
    describe Alea::Random do
      describe "#float" do
        arg_test("accepts any sized Float as argument(s)",
          caller: SpecRng,
          method: :float,
          params: {max: 1.0},
          return_type: Float64,
          types: [Float32, Float64]
        )

        sanity_test(
          caller: SpecRng,
          method: :float,
          params: {max: 1.0},
          params_to_check: [:max],
        )

        param_test(
          caller: SpecRng,
          method: :float,
          params: {max: 1.0},
          params_to_check: [:max],
          check_negatives: true,
          check_zeros: true,
        )

        it "accepts any sized Range as argument" do
          # TODO: uncomment when `float` accepts Int arguments
          # {% for bits in %i[8 16 32 64 128] %}
          #   SpecRng.float 1_i{{bits.id}}..1_i{{bits.id}}
          #   SpecRng.float 1_u{{bits.id}}..1_u{{bits.id}}
          # {% end %}

          {% for bits in %i[32 64] %}
            SpecRng.float 1.0_f{{bits.id}}..1.0_f{{bits.id}}
          {% end %}
        end

        it "raises Alea::NaNError if left bound is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float ((0.0 / 0.0)..0.0)
          end
        end

        it "raises Alea::InfinityError if left bound is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float ((1.0 / 0.0)..0.0)
          end
        end

        it "raises Alea::NaNError if right bound is NaN" do
          expect_raises(Alea::NaNError) do
            SpecRng.float (0.0..(0.0 / 0.0))
          end
        end

        it "raises Alea::InfinityError if right bound is Infinity" do
          expect_raises(Alea::InfinityError) do
            SpecRng.float (0.0..(1.0 / 0.0))
          end
        end

        it "raises Alea::UndefinedError if range is badly ordered" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float (1.0..0.0)
          end
        end

        it "raises Alea::UndefinedError if range is badly choosen" do
          expect_raises(Alea::UndefinedError) do
            SpecRng.float (1.0...1.0)
          end
        end

        it "returns an uniform-distributed in [0.0, 1.0) if max is 1.0" do
          SpecRng.float(1.0).should be < 1.0
        end

        it "returns an unique number if range only consists of it" do
          SpecRng.float(93.0..93.0).should eq(93.0)
        end

        it "returns 0.0 if max is range is 0.0..0.0" do
          SpecRng.float(0.0..0.0).should eq(0.0)
        end

        # mean  is:   (b + a) / 2
        # stdev is:   (b - a) / sqrt( 12 )

        dist_test("generates uniform-distributed random values with fixed max 9377.0 parameter",
          caller: SpecRng,
          method: :float,
          params: {max: 9377.0},
          sample_type: Float64,
          real_mean: 4688.5,
          real_stdev: 2706.9067370955604,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates uniform-distributed random values with fixed range 10...93 parameter",
          caller: SpecRng,
          method: :float,
          params: {range: 10.0...93.0},
          sample_type: Float64,
          real_mean: 51.5,
          real_stdev: 23.96003617136947,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates uniform-distributed random values with fixed range -10_000..93 parameter",
          caller: SpecRng,
          method: :float,
          params: {range: -10_000.0..93.0},
          sample_type: Float64,
          real_mean: -4953.0,
          real_stdev: 2913.8868086000416,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
