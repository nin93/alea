require "../spec_helper"

describe Alea do
  context "Beta" do
    describe Alea::Random do
      describe "#beta" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :beta,
          params: {a: 1.0, b: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :beta,
          params: {a: 1.0, b: 1.0},
          params_to_check: [:a, :b],
        )

        param_test(
          caller: SpecRng,
          method: :beta,
          params: {a: 1.0, b: 1.0},
          params_to_check: [:a, :b],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_beta" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :next_beta,
          params: {a: 1.0, b: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        # mean  is:   1.0 / (1.0 + (b / a))
        # stdev is:   sqrt( ab / ((a + b)^2 * (a + b + 1.0)) )

        dist_test("generates beta-distributed random values with fixed a 3.0 and b 5.0 parameters",
          caller: SpecRng,
          method: :next_beta,
          params: {a: 3.0, b: 5.0},
          sample_type: Float64,
          real_mean: 0.375,
          real_stdev: 0.1613743060919757,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )
      end
    end
  end
end
