#include <stdint.h>
#include <stdio.h>
#include "xoshiro.h"

uint32_t state32[4];
uint64_t state64[4];

/* This is an modification of SplitMix64, originally written in 2015
 * by Sebastiano Vigna (vigna@acm.org).
 * Proposed as a fix-incremented version of Java 8's SplittableRandom generator
 * See http://dx.doi.org/10.1145/2714064.2660195 and
 * http://docs.oracle.com/javase/8/docs/api/java/util/SplittableRandom.html
 *
 * To the extent possible under law, the author has dedicated all copyright
 * and related and neighboring rights to this software to the public domain
 * worldwide. This software is distributed without any warranty.
 *
 * See <http://creativecommons.org/publicdomain/zero/1.0/>.
 *
 * It is a very fast generator passing BigCrush, and it can be useful if
 * for some reason you absolutely want 64 bits of state.
 *
 * Needed to fill up the initial state to prevent generator breaking down. */
void xoshiro_splitmix_init64(uint64_t initstate) {
  uint8_t i;

  for(i = 0; i < 4; i++) {
    state64[i] = (initstate += 0x9e3779b97f4a7c15);
    state64[i] = (state64[i] ^ (state64[i] >> 30)) * 0xbf58476d1ce4e5b9;
    state64[i] = (state64[i] ^ (state64[i] >> 27)) * 0x94d049bb133111eb;
	  state64[i] =  state64[i] ^ (state64[i] >> 31);
  }
}

static inline uint64_t rotl64(const uint64_t x, int k) {
  return (x << k) | (x >> (64 - k));
}

uint64_t xoshiro_next_u64(void) {
  const uint64_t r = rotl64(state64[0] + state64[3], 23) + state64[0];
  const uint64_t t = state64[1] << 17;

  state64[2] ^= state64[0];
	state64[3] ^= state64[1];
	state64[1] ^= state64[2];
	state64[0] ^= state64[3];
	state64[2] ^= t;

	state64[3] = rotl64(state64[3], 45);

  return r;
}
