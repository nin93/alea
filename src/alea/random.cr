require "random/pcg32"
require "./ziggurat"

module Alea
  # `Alea::Random` provides the base interface for distribution sampling, using the `Random::PCG32` Crystal
  # pseudo random number generator. Most of the implementations are from *numpy*.
  #
  # ```
  # seed = 9377
  # rgn = Alea::Random.new(seed)
  # rgn # => Alea::Random
  # ```
  class Random < ::Random::PCG32
    # Generate a standard exp-distributed random `Float64` with sigma 1.0
    def next_exponential : Float64
      while true
        r = rand(UInt64) >> 12
        idx = r & 0xff
        x = r * Ziggurat::Exp::W[idx]
        if r < Ziggurat::Exp::K[idx]
          # this returns 98.9% of the time on 1st try
          return x
        end
        if idx == 0
          return Ziggurat::Exp::R - Math.log(next_float)
        end
        if (Ziggurat::Exp::F[idx - 1] - Ziggurat::Exp::F[idx]) * next_float + \
             Ziggurat::Exp::F[idx] < Math.exp(-x)
          # return from the triangular area
          return x
        end
      end
    end

    # Generate a nomally-distributed random `Float64`
    # with mean 0.0 and standard deviation 1.0
    def next_normal : Float64
      while true
        r = rand(UInt64) >> 12
        rabs = Int64.new(r >> 1)
        idx = rabs & 0xff
        x = (r & 0x1 == 1 ? -rabs : rabs) * Ziggurat::Normal::W[idx]
        if rabs < Ziggurat::Normal::K[idx]
          # this returns 99.3% of the time on 1st try
          return x
        end
        if idx == 0
          while true
            xx = -Ziggurat::Normal::RINV * Math.log(next_float)
            yy = -Math.log(next_float)
            if yy + yy > xx * xx
              return (rabs >> 8) & 0x1 == 1 ? -Ziggurat::Normal::R - xx : Ziggurat::Normal::R + xx
            end
          end
        else
          if (Ziggurat::Normal::F[idx - 1] - Ziggurat::Normal::F[idx]) * next_float + \
               Ziggurat::Normal::F[idx] < Math.exp(-0.5 * x * x)
            # return from the triangular area
            return x
          end
        end
      end
    end

    {% for type in [
                     "Int8".id, "Int16".id,
                     "Int32".id, "Int64".id,
                     "Int128".id, "Float32".id,
                     "Float64".id,
                   ] %}
      # Generate a random nomally-distributed random `Float64` with given mean
      def next_normal(mean : {{type}}) : Float64
        next_normal + mean
      end

      # Generate a random nomally-distributed random `Float64`
      # with given mean and standard deviation
      def next_normal(mean : {{type}}, sigma : {{type}}) : Float64
        next_normal * sigma + mean
      end

      # Generate a random lognomally-distributed random `Float64`
      # with given mean of the underlying normal distribution
      def next_lognormal(mean : {{type}}) : Float64
        Math.exp(next_normal mean)
      end

      # Generate a random lognomally-distributed random `Float64` with given
      # mean and standard deviation of the underlying normal distribution
      def next_lognormal(mean : {{type}}, sigma : {{type}}) : Float64
        Math.exp(next_normal mean, sigma)
      end

      # Generate a random exp-distributed random `Float64` with given standard deviation
      def next_exponential(sigma : {{type}}) : Float64
        next_exponential * sigma
      end

      # Generate a random beta-distributed random `Float64`
      def next_beta(alfa : {{type}}, beta : {{type}}) : Float64
        if alfa <= 1.0 && beta <= 1.0
          while true
            u = next_float
            v = next_float
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

      # Generate a random gamma-distributed random `Float64` with given shape
      def next_gamma(shape : {{type}}) : Float64
        return next_exponential if shape == 1.0
        return 0.0 if shape == 0.0

        if shape < 1.0
          while true
            u = next_float
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
            u = next_float
            if u < (1.0 - 0.0331_f64 * (x * x) * (x * x))
              return b * v
            end
            if Math.log(u) < 0.5 * x * x + b * (1.0 - v + Math.log(v))
              return b * v
            end
          end
        end
      end

      # Generate a random gamma-distributed random `Float64`
      # with given shape and scale
      def next_gamma(shape : {{type}}, scale : {{type}}) : Float64
        next_gamma(shape) * scale
      end

      # Generate a random chi^2-distributed random `Float64`
      # with given degrees of freedom
      def next_chi_square(freedom : {{type}}) : Float64
        next_gamma(freedom / 2.0) * 2.0
      end

      # Generate a random chi^2-distributed random `Float64`
      # with given degrees of freedom and sigma
      def next_chi_square(freedom : {{type}}, sigma)
        next_gamma(freedom / 2.0) * 2.0 * sigma
      end
    {% end %}
  end
end
