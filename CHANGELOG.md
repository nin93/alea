# Alea changelog

## [0.2.2]
### Added
- **Uniform distribution** support.
- New methods that take an upper limit or a range as optional arguments:
  - `Alea::Random#uint : UInt64`
  - `Alea::Random#float : Float64`

## [0.2.1]
### Added
  - **Laplace distribution** support.
  - **Safe methods**: now each sampling method has an alias for secure argument checks.
    The alias are obtained by omitting `next_` from the regular ones.

## [0.2.0]
### Changed
  - Deprecated C bindings due to the slowness of the calls to the static library.
  - Deprecated `Random::PCG32` as the main PRNG of `Alea::Random`, now powered by the `Alea::XSR128` engine by default.
  - `Alea::Random` no longer inherits the PRNG, instead it is passed to the constructor. This increases modularity and opens the doors to customizations.

### Added
  - `Alea::XSR` abstract class, inherit this to build your own PRNG to pass to `Alea::Random`.
  - `Alea::XSR128` class, PRNG loaded with a state of 128 bits.
  - `Alea::XSR256` class, PRNG loaded with a state of 256 bits.

## [0.1.1]
### Added
  - C implementations of the **xoshiro** algorithms collection for `UInt64` and `Float64` sampling.

## [0.1.0]
  - Initial release.
  - Supported distributions:
    - Normal
    - Exponential
    - Lognormal
    - Beta
    - Gamma
    - Chi Square
