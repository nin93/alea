require "./ziggurat"
require "./xoshiro"

module Alea
  # `Alea::Random` provides the base interface for distribution sampling, using the **xoshiro256++**
  # pseudo random number generator. Most of the implementations are from *numpy*.
  #
  # ```
  # seed = 9377
  # rgn = Alea::Random.new(seed)
  # rgn # => Alea::Random
  # ```
  class Random < Xoshiro::XSR64
    # Generate a normally-distributed random `Float64`
    # with mean 0.0 and standard deviation 1.0
    #
    # ```
    # rng = Alea::Random.new
    # rng.next_normal # => -0.36790519967553736
    # ```
    def next_normal : Float64
      while true
        r = next_u64 >> 12
        rabs = Int64.new(r >> 1)
        idx = rabs & 0xff
        x = (r & 0x1 == 1 ? -rabs : rabs) * Ziggurat::Normal::W[idx]
        if rabs < Ziggurat::Normal::K[idx]
          # this returns 99.3% of the time on 1st try
          return x
        end
        if idx == 0
          while true
            xx = -Ziggurat::Normal::RINV * Math.log(rand)
            yy = -Math.log(rand)
            if yy + yy > xx * xx
              return (rabs >> 8) & 0x1 == 1 ? -Ziggurat::Normal::R - xx : Ziggurat::Normal::R + xx
            end
          end
        else
          if (Ziggurat::Normal::F[idx - 1] - Ziggurat::Normal::F[idx]) * rand + \
               Ziggurat::Normal::F[idx] < Math.exp(-0.5 * x * x)
            # return from the triangular area
            return x
          end
        end
      end
    end

    # Generate a lognormally-distributed random `Float64`
    # with underlying standard normal distribution
    #
    # ```
    # rng = Alea::Random.new
    # rng.next_lognormal # => -0.36790519967553736
    # ```
    def next_lognormal : Float64
      Math.exp(next_normal)
    end

    # Generate a standard exp-distributed random `Float64` with sigma 1.0
    #
    # ```
    # rng = Alea::Random.new
    # rng.next_exponential # => 0.07119782748354186
    # ```
    def next_exponential : Float64
      while true
        r = next_u64 >> 12
        idx = r & 0xff
        x = r * Ziggurat::Exp::W[idx]
        if r < Ziggurat::Exp::K[idx]
          # this returns 98.9% of the time on 1st try
          return x
        end
        if idx == 0
          return Ziggurat::Exp::R - Math.log(rand)
        end
        if (Ziggurat::Exp::F[idx - 1] - Ziggurat::Exp::F[idx]) * rand + \
             Ziggurat::Exp::F[idx] < Math.exp(-x)
          # return from the triangular area
          return x
        end
      end
    end

    {% for type in [
                     "Int8".id, "Int16".id,
                     "Int32".id, "Int64".id,
                     "Int128".id, "UInt8".id,
                     "UInt16".id, "UInt32".id,
                     "UInt64".id, "UInt128".id,
                     "Float32".id, "Float64".id,
                   ] %}
      # Generate a normally-distributed random `Float64`
      # with given mean and standard deviation 1.0
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_normal 10 # => 9.38761513979513230
      # ```
      def next_normal(mean : {{type}}) : Float64
        next_normal + mean
      end

      # Generate a normally-distributed random `Float64`
      # with given mean and standard deviation
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_normal(9, 3) # => 7.722170952103513
      # ```
      def next_normal(mean : {{type}}, sigma : {{type}}) : Float64
        next_normal * sigma + mean
      end

      # Generate a lognormally-distributed random `Float64`
      # with given mean of the underlying normal distribution
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_lognormal 23 # => 23064336689.760487
      # ```
      def next_lognormal(mean : {{type}}) : Float64
        Math.exp(next_normal + mean)
      end

      # Generate a lognormally-distributed random `Float64` with given
      # mean and standard deviation of the underlying normal distribution
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_lognormal(2.0, 0.5) # => 9.206759439680813
      # ```
      def next_lognormal(mean : {{type}}, sigma : {{type}}) : Float64
        Math.exp(next_normal * sigma + mean)
      end

      # Generate a exp-distributed random `Float64` with given standard deviation
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_exponential 3.2 # => 8.07507379961553
      # ```
      def next_exponential(sigma : {{type}}) : Float64
        next_exponential * sigma
      end

      # Generate a beta-distributed random `Float64` in range [0, 1)
      # Named arguments are mandatory to prevent ambiguity
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_beta(a: 0.5, b: 0.5) # => 0.9807570320273012
      # ```
      def next_beta(*, a : {{type}}, b : {{type}}) : Float64
        if alfa <= 1.0 && beta <= 1.0
          while true
            u = rand
            v = rand
            x = u ** (1.0 / alfa)
            y = v ** (1.0 / beta)
            if (x + y) <= 1.0
              if (x + y) > 0.0
                return x / (x + y)
              else
                logx = Math.log(u) / alfa
                logy = Math.log(v) / beta
                logm = logx > logy ? logx : logy
                logx -= logm
                logy -= logm
                expx = Math.exp(logx)
                expy = Math.exp(logy)
                return Math.exp(logx - Math.log(expx + expy))
              end
            end
          end
        else
          ga = next_gamma(alfa)
          gb = next_gamma(beta)
          ga / (ga + gb)
        end
      end

      # Generate a gamma-distributed random `Float64` with given shape
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_gamma 2.5 # => 2.852113536270907
      # ```
      def next_gamma(shape : {{type}}) : Float64
        return next_exponential if shape == 1.0
        return 0.0 if shape == 0.0
        if shape < 1.0
          while true
            u = rand
            v = next_exponential
            if u <= 1.0 - shape
              x = u ** (1.0 / shape)
              return x if x <= v
            else
              y = -Math.log((1.0 - u) / shape)
              x = (1.0 - shape + shape * y) ** (1.0 / shape)
              return x if x <= v + y
            end
          end
        else
          b = shape - 0.3333333333333333_f64
          c = 1.0 / Math.sqrt(9.0 * b)
          while true
            while true
              x = next_normal
              v = 1.0 + c * x
              break unless v <= 0.0
            end
            v = v * v * v
            u = rand
            if u < (1.0 - 0.0331_f64 * (x * x) * (x * x))
              return b * v
            end
            if Math.log(u) < 0.5 * x * x + b * (1.0 - v + Math.log(v))
              return b * v
            end
          end
        end
      end

      # Generate a gamma-distributed random `Float64`
      # with given shape and scale
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_gamma(2.5, 10.0) # => 2.852113536270907
      # ```
      def next_gamma(shape : {{type}}, scale : {{type}}) : Float64
        next_gamma(shape) * scale
      end

      # Generate a chi^2-distributed random `Float64`
      # with given degrees of freedom
      #
      # ```
      # rng = Alea::Random.new
      # rng.next_chi_square 100 # => 92.59632908638439
      # ```
      def next_chi_square(freedom : {{type}}) : Float64
        next_gamma(freedom / 2.0) * 2.0
      end
    {% end %}
  end
end
