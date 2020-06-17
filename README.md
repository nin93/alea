# Alea

[![Build Status](https://img.shields.io/travis/nin93/alea/master?style=flat-square)](https://travis-ci.org/nin93/alea)
[![Crystal](https://img.shields.io/badge/crystal-v0.34.0-24292e?style=flat-square&logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+PHN2ZyAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgICB4bWxuczpjYz0iaHR0cDovL2NyZWF0aXZlY29tbW9ucy5vcmcvbnMjIiAgIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyIgICB4bWxuczpzdmc9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiAgIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgICBoZWlnaHQ9IjY0LjAiICAgd2lkdGg9IjY0LjAiICAgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgICB2aWV3Qm94PSIwIDAgNjkuMDQxMTAxIDY4LjgwMDc4MyIgICB5PSIwcHgiICAgeD0iMHB4IiAgIGlkPSJMYXllcl8xIiAgIHZlcnNpb249IjEuMSI+PG1ldGFkYXRhICAgaWQ9Im1ldGFkYXRhMTUiPjxyZGY6UkRGPjxjYzpXb3JrICAgICAgIHJkZjphYm91dD0iIj48ZGM6Zm9ybWF0PmltYWdlL3N2Zyt4bWw8L2RjOmZvcm1hdD48ZGM6dHlwZSAgICAgICAgIHJkZjpyZXNvdXJjZT0iaHR0cDovL3B1cmwub3JnL2RjL2RjbWl0eXBlL1N0aWxsSW1hZ2UiIC8+PGRjOnRpdGxlPjwvZGM6dGl0bGU+PC9jYzpXb3JrPjwvcmRmOlJERj48L21ldGFkYXRhPjxkZWZzICAgaWQ9ImRlZnMxMyI+PC9kZWZzPjxzdHlsZSAgIGlkPSJzdHlsZTIiICAgdHlwZT0idGV4dC9jc3MiPi5zdDB7ZmlsbDpub25lO308L3N0eWxlPjxnICAgc3R5bGU9ImRpc3BsYXk6aW5saW5lIiAgIGlkPSJsYXllcjMiPjxwYXRoICAgICB0cmFuc2Zvcm09InJvdGF0ZSgtMC41MzY5MjE2LC0xMjYuNTM4MzQsMjExLjU1Njc0KSIgICAgIGQ9Ik0gMjkuODg4NjMsNTEuNjE5OTU0IDYuNjgxNzQ3MiwyNy44NTEyODUgMzguODY5NDYsMTkuNjM3ODcgWiIgICAgIGlkPSJwYXRoMTE0NyIgICAgIHN0eWxlPSJkaXNwbGF5OmlubGluZTtmaWxsOiNmZmZmZmY7ZmlsbC1vcGFjaXR5OjEiIC8+PC9nPjxyZWN0ICAgY2xhc3M9InN0MCIgICB3aWR0aD0iMzQwLjM5OTk5IiAgIGhlaWdodD0iMTM3LjciICAgaWQ9InJlY3Q2IiAgIHg9Ii0xMjIuMDEzODUiICAgeT0iLTMyLjQyMzkxMiIgICBzdHlsZT0iZmlsbDpub25lIiAvPjxnICAgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTEyMi4zMTQxNiwtMzIuMzYxNzE2KSIgICBzdHlsZT0iZGlzcGxheTppbmxpbmUiICAgaWQ9ImxheWVyMiI+PHBhdGggICAgIHN0eWxlPSJzdHJva2Utd2lkdGg6MC44NTk2NDU5NiIgICAgIGlkPSJwYXRoMTAxNiIgICAgIGQ9Im0gMTQ5LjE4OTkzLDM3LjEzNzMzMyBjIC0wLjA4NjUsMCAtMC4yNTgxNywwLjAwMTggLTAuMzQ0MTgsMC4wODczIGwgLTIxLjQ5MTA4LDIxLjQwMzg0OCBjIC0wLjA4NjUsMC4wODU5OSAtMC4wODYxLDAuMTcyMjY2IC0wLjA4NjEsMC4zNDQxOTIgbCA3LjgyMjQzLDI5LjIyNzk2IGMgMCwwLjA4NTk3IDAuMDg1MiwwLjE3MjYwNCAwLjI1NjksMC4yNTg1NzMgbCAyOS4zMTUyOCw3LjgyMjQ1IGMgMC4wODY0LDAgMC4yNTY1MywzLjY2ZS00IDAuMzQyNSwtMC4wODYxNCBsIDIxLjQ5MTI0LC0yMS40MDU0NiBjIDAuMDg2MiwtMC4xNzE5MzIgMC4xNzMxOCwtMC4yNTgyMjggMC4wODc3LC0wLjM0NDIwMSBsIC03LjgyNDIzLC0yOS4yMjc5MTMgYyAwLC0wLjA4NjAyIC0wLjA4NDcsLTAuMTcwOTIyIC0wLjI1Njg3LC0wLjI1Njg4OSB6IG0gOC41OTY0NywxNC4xODQxNTMgYyAwLDAuMDg1OTkgMC4wODU5LDAuMDg2OTQgMC4wODU5LDAuMTcyOTQgbCAtNy43MzY3OSwyOC43MTI1MDQgYyAwLDAuMDg2IC0wLjA4NzIsMC4wODYgLTAuMTcyOTUsMCBMIDEyOC45ODg0Myw1OS4yMzEyMzggYyAtMC4wODYxLC0wLjA4NjAxIDAsLTAuMDg2OTUgMCwtMC4xNzI5MzUgeiIgLz48L2c+PHJlY3QgICBzdHlsZT0iZmlsbDpub25lIiAgIHk9Ii0zMi40MjM5MTIiICAgeD0iLTEyMi4wMTM4NSIgICBpZD0icmVjdDEwMTAiICAgaGVpZ2h0PSIxMzcuNyIgICB3aWR0aD0iMzQwLjM5OTk5IiAgIGNsYXNzPSJzdDAiIC8+PC9zdmc+)](https://github.com/crystal-lang/crystal)
[![Shard](https://img.shields.io/badge/shard-v0.2.3-orange?style=flat-square)](https://crystalshards.org/shards/github/nin93/alea)
[![Docs](https://img.shields.io/badge/docs-GitHub_pages-blueviolet.svg?style=flat-square)](https://nin93.github.io/alea/)
[![License](https://img.shields.io/badge/license-MIT-informational.svg?style=flat-square)](https://github.com/nin93/alea/blob/master/LICENSE.md)

Alea is a collection of utilities to work with most known probability distributions,
written in pure Crystal.

Features:
* [PRNGs implementations](#prngs)
* [Random sampling (single/double precision)](#sampling)
* [Cumulative Distribution Functions (single/double precision)](#cumulative-distribution-functions)

> **Note**: This project is in development state and many distributions are
  still missing, as well as cumulative distribution functions, so keep in mind that
  breaking changes may occur frequently.

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

The algorithms in use for generating unsigned integers are from the
[xoshiro](http://prng.di.unimi.it/) (XOR/shift/rotate) collection, designed by
Sebastiano Vigna and David Blackman: really fast generators promising exquisite
statistical properties as well.

Currently implemented engines:
+ `XSR128` backed by *xoroshiro128++* (32/64 bit)
+ `XSR256` backed by *xoshiro256++* (32/64 bit)

The digits in the class name stand for the storage of their state in bits.
Their period is thus `2^128 -1` for `XSR128` and `2^256 -1` for `XSR256`.

Floats are obtained by `ldexp` (load exponent) operations upon generated unsigned integers.

More informations are detailed in: http://prng.di.unimi.it/.

All PRNGs in this library inherit from `PRNG`. You are allowed to build your own custom
PRNG by inheriting the above parent class and defining `#next_u32` and `#next_u64`,
since all methods rely upon them to perform sampling:
```crystal
class MyGenerator < Alea::PRNG
  @state32 : StaticArray(UInt32)
  @state64 : StaticArray(UInt64)

  # must be implemented
  def next_u32 : UInt32
    # extract 32-bit integer
    # update @state32
  end

  # must be implemented
  def next_u64 : UInt64
    # extract 64-bit integer
    # update @state64
  end
end
```
The above example is a rapresentation of how PRNGs are implemented and should be
built in order to be wrapped correctly by `Random` and generate properly.

It is worth noting that in these implementations `#next_u32` and `#next_u64`
depend on different states and thus they are independent from each other,
as well as `#next_f32` and `#next_f64` or `#next_i32` and `#next_i64`.
It is still fine, though, if both `#next_u32` and `#next_u64` rely on the same
state, if you want. I choose not to, as it makes state advancements unpredictable.

## Sampling
`Random` is the interface provided to perform sampling:
```crystal
random = Alea::Random.new
random.normal # => -0.36790519967553736 : Float64
```
It also accepts an initial seed to reproduce the same seemingly random events across runs:
```crystal
seed = 9377u64
random = Alea::Random.new(seed)
random.exp # => 0.10203669577353723 : Float64
```
By default, the PRNG in use by `Random` is `XSR128`. You can, though, pass the desired
engine as an argument to the constructor. Here is an example using `XSR256`:
```crystal
random = Alea::Random.new(Alea::XSR256)
random.float # => 0.6533582874035311 : Float64
random.prng  # => Alea::XSR256

# or seeded as well
random = Alea::Random.new(193, Alea::XSR256)
random.float # => 0.4507930323670787 : Float64
```
Custom PRNGs can be used as well, assuming `#next_u32` and `#next_u64` generate uniformly
distributed unsigned integers:

```crystal
# Using class from the example above
random = Alea::Random.new(MyGenerator)
random.uint 3...93            # => 73 : UInt64
random.float32 -12.2...35.453 # => 34.033405 : Float32
```

### Unsafe methods

Plain sampling methods (such as `#normal`, `#gamma`) performs checks over arguments
passed to prevent bad data generation or inner exceptions.
In order to avoid them (checks might be slow) you must use their unsafe version by
prepending `next_` to them:

```crystal
random = Alea::Random.new
random.normal(loc: 0, sigma: 0)      # raises Alea::UndefinedError: sigma is 0 or negative.
random.next_normal(loc: 0, sigma: 0) # these might raise internal exceptions.
```

Timings are definitely comparable, though. See the
[benchmarks](https://github.com/nin93/alea/tree/master/benchmarks)
for direct comparisons between those methods.

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

`CDF` is the interface used to calculate the Cumulative Distribution Functions.
Given *X* ~ *D* and a fixed quantile *x*, CDFs are defined as the functions that
associate *x* to the probability that the real-valued random *X* from the
distribution *D* will take a value less or equal to *x*.

Arguments passed to `CDF` methods to shape the distributions are analogous to
those used for sampling:

```crystal
Alea::CDF.normal(0.0)                       # => 0.5 : Float64
Alea::CDF.normal(2.0, loc: 1.0, sigma: 0.5) # => 0.9772498680518208 : Float64
Alea::CDF.chisq(5.279, df: 5.0)             # => 0.6172121213841358 : Float64
Alea::CDF.chisq32(5.279, df: 5.0)           # => 0.61721206 : Float32
```

### Supported Distributions

Current CDFs estimations are implemented for the following distributions:
  - Chi-Square
  - Exponential
  - Gamma
  - Laplace
  - Log-Normal
  - Normal
  - Poisson
  - Uniform

## References
Fully listed in [LICENSE.md](https://github.com/nin93/alea/tree/master/LICENSE.md):
* [Crystal](https://github.com/crystal-lang/crystal) `Random` module for uniform sampling
* [NumPy](https://github.com/numpy/numpy) `random` module for pseudo-random sampling methods
* [JuliaLang](https://github.com/JuliaLang/julia) `random` module for ziggurat methods
* [IncGammaBeta.jl](https://github.com/jkovacic/IncGammaBeta.jl) for incomplete gamma functions

## Contributing

1. Fork it (<https://github.com/nin93/alea/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Elia Franzella](https://github.com/nin93) - creator and maintainer
