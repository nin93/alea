# Alea

[![Build Status](https://travis-ci.org/nin93/alea.svg?branch=master)](https://travis-ci.org/nin93/alea)

Alea is a collection of utilities to work with most known probability distributions,
written in pure Crystal.

This project is in early development state and many distributions are still missing, as well as cumulative distribution functions, so this library is not production-ready yet.

Algorithms in this library are heavily derived from [NumPy](https://github.com/numpy/numpy) and [Julia lang](https://github.com/JuliaLang/julia). [LICENSE](https://github.com/nin93/alea/tree/master/LICENSE).

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

The algorithms in use for generating 64-bit uints and floats are from the **xoshiro** collection, designed by Sebastiano Vigna and David Blackman: really fast generators promising exquisite statistical properties as well.
Read more about this PRNGs at: http://prng.di.unimi.it/

By default the PRNG is `Alea::XSR128`, loaded with 128-bits of state and carrying a period of 2^128 - 1, but if more state is needed you can use `Alea::XSR256`, with corresponding state and period.

**NOTE**: *~20% speed loss when using the extended version*. [Benchmarks](https://github.com/nin93/alea/tree/master/benchmarks).

## Sampling

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

You can also implement your own custom PRNG by inheriting `Alea::XSR` and passing it to the constructor by its *class name*. Here is an example using the 256-bit state PRNG `Alea:XSR256`:
```crystal
random = Alea::Random.new(Alea::XSR256)
random.float # => 0.6533582874035311
random.prng  # => Alea::XSR256

# or seeded as well
random = Alea::Random.new(193, Alea::XSR256)
random.float # => 0.80750616724688
```

### Unsafe methods

Plain sampling methods (such as `#normal`, `#gamma`) performs checks over arguments passed to prevent bad data generation or inner exceptions.
In order to avoid them (checks might be slow) you must use their unsafe version by prepending `next_` to them:

```crystal
random = Alea::Random.new
random.normal(mean: 0, sigma: 0)      # raises ArgumentError: sigma is 0 or negative.
random.next_normal(mean: 0, sigma: 0) # this does not raise anything ever.
```

Timings are definitely comparable, though. See the [benchmarks](https://github.com/nin93/alea/tree/master/benchmarks) for direct comparisons between those methods.

### Supported Distributions

Current sampling methods are implemented for the following distributions:
  - Beta
  - Chi Square
  - Exponential
  - Gamma
  - Laplace
  - Lognormal
  - Normal
  - Uniform

## Cumulative Distribution Functions

Use the `Alea::CDF` module to calculate the Cumulative Distribution Function of a real-valued *X* evaluated at *x*. Arguments passed to cdf methods to shape the distributions are analogous to those used for sampling:

```crystal
Alea::CDF.normal(0.0)                        # => 0.5
Alea::CDF.normal(2.0, mean: 1.0, sigma: 0.5) # => 0.9772498680518208
```

### Supported Distributions

Current cdf methods are implemented for the following distributions:
  - Exponential
  - Laplace
  - Lognormal
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
