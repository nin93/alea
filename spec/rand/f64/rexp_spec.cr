require "../../spec_helper"

describe Alea do
  context "Exponential" do
    describe Alea::Random do
      describe "#exp" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :exp,
          params: {scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :exp,
          params: {scale: 1.0},
          params_to_check: [:scale],
        )

        param_test(
          caller: SpecRng,
          method: :exp,
          params: {scale: 1.0},
          params_to_check: [:scale],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_exp" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        # mean  is:   k
        # stdev is:   k

        dist_test("generates exp-distributed random values with fixed scale 0.1 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 0.1},
          sample_type: Float64,
          real_mean: 0.1,
          real_stdev: 0.1,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 0.01 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 0.01},
          sample_type: Float64,
          real_mean: 0.01,
          real_stdev: 0.01,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 0.00001 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 0.00001},
          sample_type: Float64,
          real_mean: 0.00001,
          real_stdev: 0.00001,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 0.00000000001 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 0.00000000001},
          sample_type: Float64,
          real_mean: 0.00000000001,
          real_stdev: 0.00000000001,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 1.0 parameter",
          caller: SpecRng,
          method: :next_exp,
          sample_type: Float64,
          real_mean: 1.0,
          real_stdev: 1.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 3.0 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 3.0},
          sample_type: Float64,
          real_mean: 3.0,
          real_stdev: 3.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 10.0 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 10.0},
          sample_type: Float64,
          real_mean: 10.0,
          real_stdev: 10.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 100.0 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 100.0},
          sample_type: Float64,
          real_mean: 100.0,
          real_stdev: 100.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 1_000.0 parameter",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 1_000.0},
          sample_type: Float64,
          real_mean: 1_000.0,
          real_stdev: 1_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )

        dist_test("generates exp-distributed random values with fixed scale 10_000.0",
          caller: SpecRng,
          method: :next_exp,
          params: {scale: 10_000.0},
          sample_type: Float64,
          real_mean: 10_000.0,
          real_stdev: 10_000.0,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )
      end
    end
  end
end