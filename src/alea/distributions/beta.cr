require "../random"
require "./gamma"

module Alea
  class Random
    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # Generate a beta-distributed random `Float64` in range [0, 1).
        # Named arguments are mandatory to prevent ambiguity.
        def next_beta(*, a : {{t1}}, b : {{t2}}) : Float64
          if a <= 1.0 && b <= 1.0
            while true
              u = @prng.next_f
              v = @prng.next_f
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
