require "../spec_helper"

describe Alea do
  context "Laplace" do
    describe Alea::Random do
      describe "#laplace" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :laplace,
          params: {loc: 1.0, scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :laplace,
          params: {loc: 1.0, scale: 1.0},
          params_to_check: [:loc, :scale],
        )

        param_test(
          caller: SpecRng,
          method: :laplace,
          params: {loc: 1.0, scale: 1.0},
          params_to_check: [:scale],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_laplace" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :next_laplace,
          params: {loc: 1.0, scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        # mean  is:   m
        # stdev is:   k * sqrt( 2 )

        dist_test("generates laplace-distributed random values with fixed loc 0.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_laplace,
          sample_type: Float64,
          real_mean: 0.0,
          real_stdev: 1.4142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 3.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_laplace,
          params: {loc: 3.0},
          sample_type: Float64,
          real_mean: 3.0,
          real_stdev: 1.4142135623730951,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates laplace-distributed random values with fixed loc 3.0 and scale 1.5 parameters",
          caller: SpecRng,
          method: :next_laplace,
          params: {loc: 3.0, scale: 1.5},
          sample_type: Float64,
          real_mean: 3.0,
          real_stdev: 2.121320343559643,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
