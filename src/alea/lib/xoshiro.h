#ifndef XOSHIRO_H
#define XOSHIRO_H
#include <stdint.h>

void xoshiro_splitmix_init64(uint64_t state);

uint32_t xoshiro_next_u32(void); // TODO
uint64_t xoshiro_next_u64(void);

float xoshiro_next_f32(void); // TODO
double xoshiro_next_f64(void);

extern uint32_t state32[4]; // TODO
extern uint64_t state64[4];

#endif
