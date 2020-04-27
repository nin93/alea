# Alea

[![Build Status](https://travis-ci.org/nin93/alea.svg?branch=master)](https://travis-ci.org/nin93/alea)

Alea is a library for generating pseudo-random samples from most known probability distributions,
written in pure Crystal.

Algorithms in this library are heavily derived from [NumPy](https://github.com/numpy/numpy) and [Julia](https://github.com/JuliaLang/julia) lang. Disclaimer in LICENSE file.

## Why Crystal?
Crystal compiles to really fast native code without sacrificing any of the modern
programming languages standards providing a nice and clean interface.

**Cons**: poor library support, that's why this implementation aims be an enrichment to the community, so help is appreciated.

## Installation

1. Add the dependency to your `shard.yml`:

  ```yaml
  dependencies:
    alea:
      github: nin93/alea
  ```

2. Run `shards install`

## PRNGs

The algorithms in use for generating 64-bit uints and floats are from the **xoshiro** collection, designed by Sebastiano Vigna and David Blackman: really fast generators promising exquisite statistical properties as well.
Read more about this PRNGs at: http://prng.di.unimi.it/

By default the PRNG is `Alea::XSR128`, loaded with 128-bits of state and carrying a period of 2^128 - 1, but if more state is needed you can use `Alea::XSR256`, with corresponding state and period.
**NOTE**: *~20% speed loss when using the extended version*. [Benchmarks](https://github.com/nin93/alea/tree/master/benchmarks).


## Usage

```crystal
require "alea"

alea = Alea::Random.new
alea.next_normal # => -0.36790519967553736
```
It also accepts an initial seed to reproduce the same seemingly random events across runs:
```crystal
seed = 9377u64
alea = Alea::Random.new(seed)
alea.next_exponential # => 2.8445710982736148
```

You can also implement your own custom PRNG by inheriting `Alea::XSR` and passing it to the constructor by its class name.
Here is an example using the 256-bit state PRNG `Alea:XSR256`:
```crystal
alea = Alea::Random.new(Alea::XSR256)
alea.next_f # => 0.6533582874035311
alea.prng   # => Alea::XSR256

# or seeded as well
seed = 193u64
alea = Alea::Random.new(seed, Alea::XSR256)
alea.next_f # => 0.80750616724688
```

## Development state

Library is in development, current sampling methods are implemented for:
  - Beta
  - Chi Square
  - Exponential
  - Gamma
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
