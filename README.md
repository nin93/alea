# Alea

[![Build Status](https://travis-ci.org/nin93/alea.svg?branch=master)](https://travis-ci.org/nin93/alea)

Alea is a collection of utilities to work with most known probability distributions,
written in pure Crystal.

Features:
  * [PRNGs implementations](#PRNGs)
  * [Random sampling](#sampling)
  * [Cumulative Distribution Functions](#cumulative-distribution-functions)

This project is in early development state and many distributions are still missing, as well as cumulative distribution functions, so keep in mind that breaking changes may occur frequently.

Sampling algorithms in this library are heavily derived from [NumPy](https://github.com/numpy/numpy) and [Julia lang](https://github.com/JuliaLang/julia). [LICENSE](https://github.com/nin93/alea/tree/master/LICENSE).

## Why Crystal?
Crystal compiles to really fast native code without sacrificing any of the modern
programming languages standards providing a nice and clean interface.

## Installation

1. Add the dependency to your `shard.yml`:

  ```yaml
  dependencies:
    alea:
      github: nin93/alea
  ```

2. Run `shards install`

## Usage

```crystal
require "alea"
```

## PRNGs

The algorithms in use for generating 64-bit uints and floats are from the [xoshiro](http://prng.di.unimi.it/) (XOR/shift/rotate) collection, designed by Sebastiano Vigna and David Blackman: really fast generators promising exquisite statistical properties as well.

Currently implemented:
  - *xoroshiro128++* as engine for `#next_u` in `XSR128`
  - *xoroshiro128+* as engine for `#next_f` in `XSR128`
  - *xoshiro256++* as engine for `#next_u` in `XSR256`
  - *xoshiro256+* as engine for `#next_f` in `XSR256`

Digits stand for the storage of their state in bits.
Their period is thus `2^128 -1` for `XSR128` and `2^256 -1` for `XSR256`.

The `+` versions are slightly faster, but since they have a bias on the right-most bits, they are only used for generating random floats, which lose those bits while shifting to obtain the mantissa.

More informations are detailed in: http://prng.di.unimi.it/.

See the [benchmarks](https://github.com/nin93/alea/tree/master/benchmarks) for a comparison between these engines.

## Sampling
`Alea::Random` is the interface provided to perform sampling:
```crystal
random = Alea::Random.new
random.normal # => -0.36790519967553736
```
It also accepts an initial seed to reproduce the same seemingly random events across runs:
```crystal
seed = 9377u64
random = Alea::Random.new(seed)
random.exponential # => 2.8445710982736148
```
By default, the PRNG in use by `Alea::Random` is `XSR128`. You can, though, pass the desired engine as an argument to the constructor. Here is an example using `Alea::XSR256`:
```crystal
random = Alea::Random.new(Alea::XSR256)
random.float # => 0.6533582874035311
random.prng  # => Alea::XSR256

# or seeded as well
random = Alea::Random.new(193, Alea::XSR256)
random.float # => 0.80750616724688
```
All PRNGs in this library inherits from an abstract class `Alea::PRNG`; you are then allowed to build your own custom PRNG by inheriting the above parent class and passing it to `Alea::Random` just like in the previous example:

```crystal
class MyRandom < Alea::PRNG
  def next_u : UInt64
    # must be implemented
  end

  def next_f : Float64
    # must be implemented
  end

  def jump : self
    # must be implemented
  end

  ...
end

random = Alea::Random(MyRandom)
```

### Unsafe methods

Plain sampling methods (such as `#normal`, `#gamma`) performs checks over arguments passed to prevent bad data generation or inner exceptions.
In order to avoid them (checks might be slow) you must use their unsafe version by prepending `next_` to them:

```crystal
random = Alea::Random.new
random.normal(loc: 0, sigma: 0)      # raises Alea::UndefinedError: sigma is 0 or negative.
random.next_normal(loc: 0, sigma: 0) # these might raise internal exceptions.
```

Timings are definitely comparable, though. See the [benchmarks](https://github.com/nin93/alea/tree/master/benchmarks) for direct comparisons between those methods.

### Supported Distributions

Current sampling methods are implemented for the following distributions:
  - Beta
  - Chi-Square
  - Exponential
  - Gamma
  - Laplace
  - Log-Normal
  - Normal
  - Poisson
  - Uniform

## Cumulative Distribution Functions

`Alea::CDF` is the interface used to calculate the Cumulative Distribution Functions.
Given *X* ~ *D* and a fixed quantile *x*, CDFs are defined as the functions that associate *x* to the probability that the real-valued random *X* from the distribution *D* will take a value less or equal to *x*.

Arguments passed to `Alea::CDF` methods to shape the distributions are analogous to those used for sampling:

```crystal
Alea::CDF.normal(0.0)                        # => 0.5
Alea::CDF.normal(2.0, loc: 1.0, sigma: 0.5) # => 0.9772498680518208
Alea::CDF.chi_square(5.279, df: 5.0)    # => 0.6172121213841358
```

### Supported Distributions

Current CDFs estimations are implemented for the following distributions:
  - Chi-Squared
  - Exponential
  - Laplace
  - Log-Normal
  - Normal
  - Uniform

## Contributing

1. Fork it (<https://github.com/nin93/alea/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Elia Franzella](https://github.com/nin93) - creator and maintainer
