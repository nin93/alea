require "./rgamma"

module Alea
  struct Random
    # Generate a *beta-distributed*, pseudo-random `Float64` in range `[0, 1)`.
    #
    # **@note**: named arguments are mandatory to prevent ambiguity.
    #
    # **@parameters**:
    # * `a`: shape parameter of the distribution;
    #   usually mentioned as **`α`**.
    # * `b`: shape parameter of the distribution;
    #   usually mentioned as **`β`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if any of `a` or `b` is negative or zero.
    def beta(*, a, b)
      Alea.sanity_check(a, :a, :beta)
      Alea.sanity_check(b, :b, :beta)
      Alea.param_check(a, :<=, 0.0, :a, :beta)
      Alea.param_check(b, :<=, 0.0, :b, :beta)
      next_beta a: a, b: b
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # :nodoc:
        # Unwrapped version of `beta`.
        # Generate a *beta-distributed*, pseudo-random `Float64` in range [0, 1).
        # Named arguments are mandatory to prevent ambiguity.
        def next_beta(*, a : {{t1}}, b : {{t2}}) : Float64
          if a <= 1.0 && b <= 1.0
            while true
              u = @prng.next_f64
              v = @prng.next_f64
              x = u ** (1.0 / a)
              y = v ** (1.0 / b)
              if (x + y) <= 1.0
                (x + y) > 0.0 && return x / (x + y)
                logx = Math.log(u) / a
                logy = Math.log(v) / b
                logm = logx > logy ? logx : logy
                logx -= logm
                logy -= logm
                expx = Math.exp(logx)
                expy = Math.exp(logy)
                return Math.exp(logx - Math.log(expx + expy))
              end
            end
          else
            ga = next_gamma(a)
            gb = next_gamma(b)
            ga / (ga + gb)
          end
        end
      {% end %}
    {% end %}
  end
end
