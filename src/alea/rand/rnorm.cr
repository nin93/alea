require "../core/czig"
require "../core/cerr"

module Alea
  struct Random
    # Generate a *normal-distributed*, pseudo-random `Float64`.
    #
    # **@parameters**:
    # * `loc`: centrality parameter, or mean of the distribution;
    #   usually mentioned as **`μ`**.
    # * `sigma`: scale parameter, or standard deviation of the distribution;
    #   usually mentioned as **`σ`**.
    #
    # **@exceptions**:
    # * `Alea::NaNError` if any of the arguments is `NaN`.
    # * `Alea::InfinityError` if any of the arguments is `Infinity`.
    # * `Alea::UndefinedError` if `sigma` is negative or zero.
    def normal(loc = 0.0, sigma = 1.0)
      Alea.sanity_check(loc, :loc, :normal)
      Alea.sanity_check(sigma, :sigma, :normal)
      Alea.param_check(sigma, :<=, 0.0, :sigma, :normal)
      next_normal loc, sigma
    end

    # :nodoc:
    # Unwrapped version of `normal`.
    # Generate a *normal-distributed*, pseudo-random `Float64`.
    def next_normal : Float64
      while true
        r = @prng.next_u >> 12
        rabs = Int64.new(r >> 1)
        idx = rabs & 0xff
        x = (r & 0x1 == 1 ? -rabs : rabs) * Core::Normal::W[idx]
        # this returns 99.3% of the time on 1st try
        rabs < Core::Normal::K[idx] && return x
        if idx == 0
          while true
            xx = -Core::Normal::RINV * Math.log(@prng.next_f)
            yy = -Math.log(@prng.next_f)
            (yy + yy > xx * xx) && return (rabs >> 8) & 0x1 == 1 ? -Core::Normal::R - xx : Core::Normal::R + xx
          end
        else
          # return from the triangular area
          (Core::Normal::F[idx - 1] - Core::Normal::F[idx]) * @prng.next_f + \
            Core::Normal::F[idx] < Math.exp(-0.5 * x * x) && return x
        end
      end
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # :nodoc:
      # Unwrapped version of `normal`.
      # Generate a *normal-distributed*, pseudo-random `Float64`.
      def next_normal(loc : {{t1}}) : Float64
        next_normal + loc
      end
    {% end %}

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      {% for t2 in ["Int".id, "Float".id] %}
        # :nodoc:
        # Unwrapped version of `normal`.
        # Generate a *normal-distributed*, pseudo-random `Float64`.
        def next_normal(loc : {{t1}}, sigma : {{t2}}) : Float64
          next_normal * sigma + loc
        end
      {% end %}
    {% end %}
  end
end
