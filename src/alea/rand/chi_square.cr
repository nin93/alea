require "../random"
require "./gamma"

module Alea
  struct Random
    # Generate a chi^2-distributed random `Float64` with given degrees of freedom.
    # Raises ArgumentError if parameter is negative or zero.
    def chi_square(freedom)
      if freedom <= 0.0
        raise ArgumentError.new "Expected freedom parameter to be greater than 0.0."
      end

      next_chi_square freedom
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a chi^2-distributed random `Float64`
      # with given degrees of freedom.
      def next_chi_square(freedom : {{t1}}) : Float64
        next_gamma(freedom / 2.0) * 2.0
      end
    {% end %}
  end
end
