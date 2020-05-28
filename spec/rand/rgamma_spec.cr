require "../spec_helper"

describe Alea do
  context "Gamma" do
    describe Alea::Random do
      describe "#gamma" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :gamma,
          params: {shape: 1.0, scale: 1.0},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        sanity_test(
          caller: SpecRng,
          method: :gamma,
          params: {shape: 1.0, scale: 1.0},
          params_to_check: [:shape, :scale],
        )

        param_test(
          caller: SpecRng,
          method: :gamma,
          params: {shape: 1.0, scale: 1.0},
          params_to_check: [:shape, :scale],
          check_negatives: true,
          check_zeros: true,
        )
      end

      describe "#next_gamma" do
        arg_test("accepts any sized Int/UInt/Float as argument(s)",
          caller: SpecRng,
          method: :next_gamma,
          params: {shape: 0.1, scale: 0.1},
          return_type: Float64,
          types: [Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128,
                  Float32, Float64,
          ]
        )

        # mean  is:   ks
        # stdev is:   sqrt( ks^2 )

        dist_test("generates gamma-distributed random values with fixed shape 3.0 and scale 1.0 parameters",
          caller: SpecRng,
          method: :next_gamma,
          params: {shape: 3.0, scale: 1.0},
          sample_type: Float64,
          real_mean: 3.0,
          real_stdev: 1.7320508075688772,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )

        dist_test("generates gamma-distributed random values with fixed shape 3.0 and scale 1.5 parameters",
          caller: SpecRng,
          method: :next_gamma,
          params: {shape: 3.0, scale: 1.5},
          sample_type: Float64,
          real_mean: 4.5,
          real_stdev: 2.598076211353316,
          mean_tol: 0.005,
          stdev_tol: 0.005,
        )
      end
    end
  end
end
