# Alea

[![Build Status](https://travis-ci.org/nin93/alea.svg?branch=master)](https://travis-ci.org/nin93/alea)

`Alea` is a library for generating pseudo-random samples from most known probability distributions,
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

## Usage

```crystal
require "alea"
```

The PRNG in use for generating 64-bit unsigned ints is **xoshiro256++**, designed by David Blackman and Sebastiano Vigna: way better than Crystal default [Random::PCG32](https://crystal-lang.org/api/0.34.0/Random/PCG32.html) in terms of efficiency (6.3x times faster than `rand(UInt64)`) and quality of variables as well.


Read more about this PRNG at: http://prng.di.unimi.it/

Example of use:
```crystal
rng = Alea::Random.new
rng.next_normal # => -0.36790519967553736
```
It also accepts an initial seed:
```crystal
seed = 9377
rng = Alea::Random.new(seed)
rng.next_exponential # => 0.07119782748354186
```

## Development

Library is in development, current sampling methods are implemented for:
  - Normal
  - Exponential
  - Lognormal
  - Chi Square
  - Gamma
  - Beta

## Contributing

1. Fork it (<https://github.com/nin93/alea/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Elia Franzella](https://github.com/nin93) - creator and maintainer
