require "../random"

module Alea
  class Random
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

    # :nodoc:
    protected def poisson_ptrs(lam)
      slam = Math.sqrt lam
      llam = Math.log lam
      b = 0.931 + 2.53 * slam
      a = -0.059 + 0.02483 * b
      inv = 1.1239 + 1.1328 / (b - 3.4)
      vr = 0.9277 - 3.6224 / (b - 2.0)
      while true
        u = @prng.next_f - 0.5
        v = @prng.next_f
        us = 0.5 - u.abs
        k = Int64.new((2.0 * a / us + b) * u + lam + 0.43)
        ((us >= 0.07) && (v <= vr)) && return k
        ((k < 0) || ((us < 0.013) && (v > us))) && next
        log = Math.log(v) + Math.log(inv) - Math.log(a / (us * us) + b)
        gam = -lam + k * llam - loggamma(k + 1i64)
        (log <= gam) && return k
      end
    end

    # :nodoc:
    protected def poisson_mult(lam)
      enlam = Math.exp(-lam)
      x = 0i64
      prod = 1.0
      while true
        u = @prng.next_f
        prod *= u
        (enlam >= prod) && return x
        x += 1i64
      end
    end
  end
end
