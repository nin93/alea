require "../random"

module Alea
  struct Random
    # Generate a poisson-distributed random `Int64` with given lambda parameter.
    # Raises ArgumentError if lambda parameter is negative or zero.
    def poisson(lam = 1.0)
      unless lam > 0.0
        raise ArgumentError.new "Expected lambda to be greater than 0.0"
      end

      next_poisson lam
    end

    # Generate a standard poisson-distributed random `Int64` with lambda 1.0.
    def next_poisson : Int64
      poisson_mult 1.0
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a poisson-distributed random `Int64`
      # with given lambda parameter.
      def next_poisson(lam : {{t1}}) : Int64
        (lam >= 10.0) && return poisson_ptrs lam
        (lam == 0.0) && return 0i64
        poisson_mult lam
      end
    {% end %}
  end
end
