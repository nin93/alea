require "./ziggurat"
require "./xsr"

module Alea
  # `Alea::Random` provides the interface for distribution sampling, using the
  # **xoshiro** pseudo random number generators written by Sebastiano Vigna and David Blackman.
  #
  # ```
  # seed = 9377
  # random = Alea::Random.new(seed)
  # random # => Alea::Random
  # ```
  #
  # The default generator is `Alea::XSR128`, faster than `Alea::XSR256`, but less capable state.
  # To use the 256-bits version call the constructor like this:
  #
  # ```
  # seed = 12345
  # random = Alea::Random.new(seed, Alea::XSR256)
  # random.prng # => Alea::XSR256
  # ```
  #
  # You can build your own custom PRNG by inheriting `Alea::XSR` and implementing `#next_u`,
  # `#next_f` and `#jump`, as they are needed by every other call (except for `#jump`);
  # then create a new instance of `Alea::Random` passing you class by its name like above.
  #
  # The following implementations are taken from **numpy**.
  class Random
    DEFAULT = Alea::XSR128

    # The PRNG in use by this class.
    getter prng : Alea::XSR

    # Initializes the PRNG with initial state.
    def initialize(initstate : UInt64, prng : Alea::XSR.class = DEFAULT)
      @prng = prng.new initstate
    end

    # Initializes the PRNG with initial state readed from system resorces.
    def initialize(prng : Alea::XSR.class = DEFAULT)
      @prng = prng.new
    end

    # Returns the next generated `UInt64`.
    def next_u : UInt64
      @prng.next_u
    end

    # Returns the next generated `Float64`.
    def next_f : Float64
      @prng.next_f
    end

    # This equals to 2^(STATE_STORAGE * 32) calls to `#next_u` or `#next_f`.
    def jump : self
      @prng.jump
    end

    # Generate a exp-distributed random `Float64` with scale 1.0.
    # Scale parameter is lambda^-1
    def next_exponential : Float64
      while true
        r = @prng.next_u >> 12
        idx = r & 0xff
        x = r * Ziggurat::Exp::W[idx]
        # this returns 98.9% of the time on 1st try
        r < Ziggurat::Exp::K[idx] && return x
        idx == 0 && return Ziggurat::Exp::R - Math.log(@prng.next_f)
        # return from the triangular area
        (Ziggurat::Exp::F[idx - 1] - Ziggurat::Exp::F[idx]) * @prng.next_f + \
          Ziggurat::Exp::F[idx] < Math.exp(-x) && return x
      end
    end

    # Generate a standard laplace-distributed random `Float64`
    # centred in 0.0 and scaled by 1.0.
    def next_laplace : Float64
      while true
        u = @prng.next_f
        u >= 0.5 && return -Math.log(2.0 - u - u)
        u > 0.0 && return Math.log(u + u)
      end
    end

    # Generate a lognormal-distributed random `Float64`
    # with underlying standard normal distribution.
    def next_lognormal : Float64
      Math.exp(next_normal)
    end

    # Generate a normal-distributed random `Float64`
    # with mean 0.0 and standard deviation 1.0.
    def next_normal : Float64
      while true
        r = @prng.next_u >> 12
        rabs = Int64.new(r >> 1)
        idx = rabs & 0xff
        x = (r & 0x1 == 1 ? -rabs : rabs) * Ziggurat::Normal::W[idx]
        # this returns 99.3% of the time on 1st try
        rabs < Ziggurat::Normal::K[idx] && return x
        if idx == 0
          while true
            xx = -Ziggurat::Normal::RINV * Math.log(@prng.next_f)
            yy = -Math.log(@prng.next_f)
            (yy + yy > xx * xx) && return (rabs >> 8) & 0x1 == 1 ? -Ziggurat::Normal::R - xx : Ziggurat::Normal::R + xx
          end
        else
          # return from the triangular area
          (Ziggurat::Normal::F[idx - 1] - Ziggurat::Normal::F[idx]) * @prng.next_f + \
            Ziggurat::Normal::F[idx] < Math.exp(-0.5 * x * x) && return x
        end
      end
    end

    # This are written to allow any combination of
    # argument types and avoid tedious manual casting.
    {% for t1 in ["Int".id, "Float".id] %}
      # Generate a chi^2-distributed random `Float64`
      # with given degrees of freedom.
      def next_chi_square(freedom : {{t1}}) : Float64
        next_gamma(freedom / 2.0) * 2.0
      end

      # Generate a exp-distributed random `Float64` with given scale.
      # Scale parameter is lambda^-1
      def next_exponential(scale : {{t1}}) : Float64
        next_exponential * scale
      end

      # Generate a gamma-distributed random `Float64` with given shape.
      def next_gamma(shape : {{t1}}) : Float64
        shape == 1.0 && return next_exponential
        shape == 0.0 && return 0.0
        if shape < 1.0
          while true
            u = @prng.next_f
            v = next_exponential
            if u <= 1.0 - shape
              x = u ** (1.0 / shape)
              x <= v && return x
            else
              y = -Math.log((1.0 - u) / shape)
              x = (1.0 - shape + shape * y) ** (1.0 / shape)
              x <= v + y && return x
            end
          end
        else
          b = -0.3333333333333333_f64 + shape
          c = 1.0 / Math.sqrt(9.0 * b)
          while true
            while true
              x = next_normal
              v = 1.0 + c * x
              break unless v <= 0.0
            end
            v = v * v * v
            u = @prng.next_f
            u < (1.0 - 0.0331_f64 * (x * x) * (x * x)) && return b * v
            Math.log(u) < 0.5 * x * x + b * (1.0 - v + Math.log(v)) && return b * v
          end
        end
      end

      # Generate a standard laplace-distributed random `Float64`
      # centred in 0.0 and scaled by 1.0.
      def next_laplace(mean : {{t1}}) : Float64
        while true
          u = @prng.next_f
          u >= 0.5 && return mean - Math.log(2.0 - u - u)
          u > 0.0 && return mean + Math.log(u + u)
        end
      end

      # Generate a lognormal-distributed random `Float64`
      # with given mean of the underlying normal distribution.
      def next_lognormal(mean : {{t1}}) : Float64
        Math.exp(next_normal + mean)
      end

      # Generate a normal-distributed random `Float64`
      # with given mean and standard deviation 1.0.
      def next_normal(mean : {{t1}}) : Float64
        next_normal + mean
      end
    {% end %}

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

        # Generate a gamma-distributed random `Float64`
        # with given shape and scale.
        def next_gamma(shape : {{t1}}, scale : {{t2}}) : Float64
          next_gamma(shape) * scale
        end

        # Generate a laplace-distributed random `Float64`
        # with given center and scale.
        def next_laplace(mean : {{t1}}, scale : {{t2}}) : Float64
          while true
            u = @prng.next_f
            u >= 0.5 && return mean - scale * Math.log(2.0 - u - u)
            u > 0.0 && return mean + scale * Math.log(u + u)
          end
        end

        # Generate a lognormal-distributed random `Float64` with given
        # mean and standard deviation of the underlying normal distribution.
        def next_lognormal(mean : {{t1}}, sigma : {{t2}}) : Float64
          Math.exp(next_normal * sigma + mean)
        end

        # Generate a normal-distributed random `Float64`
        # with given mean and standard deviation.
        def next_normal(mean : {{t1}}, sigma : {{t2}}) : Float64
          next_normal * sigma + mean
        end
      {% end %}
    {% end %}
  end
end
