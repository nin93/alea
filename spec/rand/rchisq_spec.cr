require "../spec_helper"

describe Alea do
  context "ChiSquare" do
    describe Alea::Random do
      describe "#chisq" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :chisq,
          params: {df: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :chisq,
          params: {df: 1.0},
          params_to_check: [:df],
        )

        param_test(
          caller: SpecRng,
          method: :chisq,
          params: {df: 1.0},
          params_to_check: [:df],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_chisq" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :next_chisq,
          params: {df: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        # mean  is:   k
        # stdev is:   sqrt( 2k )

        dist_test("generates chi^2-distributed random values with fixed df 3.0",
          caller: SpecRng,
          method: :next_chisq,
          params: {df: 3.0},
          sample_type: Float64,
          real_mean: 3.0,
          real_stdev: 2.449489742783178,
          mean_tol: 0.005,
          stdev_tol: 0.01,
        )
      end
    end
  end
end
