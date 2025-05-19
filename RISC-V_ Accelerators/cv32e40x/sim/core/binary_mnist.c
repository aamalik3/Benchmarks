#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

//#include <float.h>
//#include <limits.h>

//#include "binary_mnist.h"
//#include "binary_mnist_data.h"


#define MAX(a,b) ((a) > (b) ? a : b)
#define MIN(a,b) ((a) < (b) ? a : b)
#define CEIL_POS(X) ((X-(int)(X)) > 0 ? (int)(X+1) : (int)(X))
#define MAX_FILTER_BYTES 12

//uint8_t volatile *train_data;
uint8_t volatile *final_guess;
uint8_t train_data[1960] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,240,0,255,255,0,31,255,224,1,255,192,0,15,236,0,0,124,0,0,1,224,0,0,30,0,0,0,252,0,0,7,224,0,0,63,0,0,1,240,0,0,7,128,0,3,248,0,0,255,0,0,63,224,0,15,252,0,3,255,0,0,255,192,0,15,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,240,0,0,63,0,0,7,252,0,1,255,192,0,31,252,0,3,255,192,0,127,206,0,15,192,224,1,252,14,0,30,0,224,1,192,14,0,60,0,224,3,192,62,0,56,7,192,3,128,240,0,56,30,0,3,255,224,0,63,248,0,3,254,0,0,31,192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,12,0,14,0,192,1,224,12,0,28,0,192,1,192,28,0,28,1,192,3,192,28,0,60,1,192,31,128,28,127,248,1,255,255,0,15,240,112,0,0,7,0,0,0,112,0,0,7,0,0,0,112,0,0,7,0,0,0,112,0,0,7,0,0,0,112,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,192,0,0,124,0,0,7,192,0,0,252,0,0,31,0,0,1,224,0,0,62,0,0,7,192,0,0,124,0,0,15,128,0,1,240,0,0,31,0,0,3,224,0,0,62,0,0,3,192,0,0,124,0,0,15,192,0,0,240,0,0,15,0,0,0,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,128,0,31,248,0,7,255,128,0,124,248,0,15,143,0,1,243,224,0,60,126,0,3,255,192,0,63,248,0,1,255,128,0,0,120,0,0,7,128,0,0,56,0,0,7,128,0,0,120,0,0,7,128,0,0,56,0,0,3,192,0,0,62,0,0,1,224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,0,0,7,240,0,1,255,128,0,127,248,0,7,247,128,0,126,120,0,7,135,128,0,0,120,0,0,127,128,0,63,240,0,15,255,128,1,251,252,0,63,127,248,7,239,191,128,127,240,120,7,254,0,0,127,192,0,7,224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,1,240,0,0,31,0,0,0,240,0,0,31,0,0,1,248,0,0,15,128,0,0,120,0,0,7,128,0,0,120,0,0,7,128,0,0,120,0,0,7,128,0,0,124,0,0,7,192,0,0,124,0,0,3,224,0,0,62,0,0,3,224,0,0,62,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,255,192,0,127,254,0,7,255,224,0,127,254,0,7,135,224,0,0,124,0,0,15,192,0,3,252,0,7,255,128,0,255,224,0,15,255,0,0,127,240,0,0,15,0,0,0,240,0,56,31,0,7,135,240,0,127,254,0,7,255,192,0,127,240,0,3,248,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,7,0,0,0,112,0,0,7,0,0,0,112,0,0,7,0,0,0,120,0,0,7,128,0,0,56,0,0,3,128,0,0,56,0,0,3,128,0,0,56,0,0,3,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,112,0,0,15,0,0,0,224,0,14,30,0,0,225,192,0,14,60,0,1,231,192,0,60,112,0,7,143,0,1,255,224,0,31,252,0,3,255,240,0,56,254,0,3,15,224,0,1,224,0,0,30,0,0,3,192,0,0,56,0,0,3,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,192,0,3,252,0,0,63,224,0,1,254,0,0,15,224,0,0,254,0,0,7,224,0,0,254,0,0,63,224,0,3,254,0,0,31,224,0,0,254,0,0,1,240,0,0,31,0,0,1,224,0,56,62,0,3,239,224,0,63,252,0,1,255,0,0,15,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,252,0,0,63,192,0,15,248,0,3,252,0,0,60,0,0,31,128,0,1,224,0,0,28,0,0,1,224,0,0,223,0,0,60,240,0,3,143,0,0,63,224,0,1,254,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,255,240,0,31,255,224,1,255,254,0,31,3,224,0,0,62,0,0,15,192,0,1,252,0,0,63,192,0,3,255,0,0,63,252,0,0,255,224,0,0,254,0,0,7,224,0,0,62,0,14,7,224,1,224,252,0,31,63,192,1,255,248,0,31,255,0,0,255,192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224,0,0,30,0,0,7,224,0,0,252,0,0,15,128,0,1,240,0,0,30,0,0,3,192,0,0,124,0,0,15,135,0,0,249,252,0,15,191,224,1,247,254,0,30,255,192,1,207,120,0,29,239,0,1,223,240,0,31,252,0,1,255,128,0,15,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,224,0,0,30,0,0,0,224,0,0,14,0,0,0,240,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,15,0,0,0,240,0,0,7,0,0,0,112,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,128,0,15,252,0,15,255,192,1,255,252,0,31,199,192,3,240,120,0,62,31,128,3,193,240,0,0,62,0,0,3,192,0,0,124,0,0,15,192,0,1,248,0,0,63,0,0,3,192,0,0,124,0,0,7,128,0,0,248,0,0,15,0,0,0,224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,252,0,0,127,192,0,7,158,0,0,224,224,0,14,15,0,0,192,240,0,0,15,0,0,0,112,0,0,15,0,0,0,243,192,0,63,252,0,255,255,128,63,255,0,3,253,224,0,56,124,0,3,143,128,0,63,240,0,1,252,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,224,0,1,254,0,1,255,224,0,31,252,0,3,247,192,0,60,248,0,3,255,0,0,63,224,0,1,254,0,0,31,192,0,3,240,0,0,63,0,0,15,240,0,0,255,0,0,31,240,0,1,223,0,0,31,224,0,1,252,0,0,31,192,0,1,240,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,1,240,0,0,60,0,0,7,128,0,0,240,0,0,14,0,0,1,192,0,0,28,0,0,1,128,0,0,56,192,0,3,190,0,0,55,240,0,7,99,0,0,118,48,0,7,3,0,0,112,48,0,7,7,0,0,112,240,0,3,254,0,0,31,192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,126,0,0,15,240,0,1,255,128,0,28,120,0,1,199,128,0,31,240,0,1,252,0,0,31,192,0,0,248,0,0,7,128,0,0,120,0,0,7,128,0,0,240,0,0,30,0,0,1,192,0,0,60,0,0,7,128,0,0,240,0,0,15,0,0,1,224,0,0,0,0,0};
float train_labels[20] = {5,0,4,1,9,2,1,3,1,4,3,5,3,6,1,7,2,8,6,9};

static const uint8_t bits[8] = {0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01};


/* layer types */
static void blinear_layer(const uint8_t* A, const uint8_t* F, uint8_t* C,
                          const float* Bias, const float* Gamma,
                          const float* Beta, const float* Mean,
                          const float* Std, const int m, const int n,
                          const int k);

static void bconv_layer(const uint8_t* A, const uint8_t* F, uint8_t* C,
                        const float* Bias, const float* Gamma, const float* Beta,
                        const float* Mean, const float* Std, const int m,
                        const int num_f, const int w, const int h, const int d,
                        const int kw, const int kh, const int sw, const int sh,
                        const int pw, const int ph, const int pl_w,
                        const int pl_h, const int pl_sw, const int pl_sh,
                        const int pl_pw, const int pl_ph);

/* layer helper functions */
static float batch_norm(float f, const float Gamma, const float Beta,
                        const float Mean, const float Std);

static void bconv(const uint8_t* A, const uint8_t* F, uint8_t* C,
                  const int c_start_idx, const int z, const float Bias,
                  const float Gamma, const float Beta, const float Mean,
                  const float Std, const int w, const int h, const int d,
                  const int kw, const int kh, const int sw, const int sh,
                  const int pw, const int ph, const int pl_w, const int pl_h,
                  const int pl_sw, const int pl_sh, const int pl_pw,
                  const int pl_ph);
static float fdot_3d(const float* A, const uint8_t* B, const int x, const int y,
                     const int w, const int h, const int d, const int kw,
                     const int kh);
static int bdot_3d(const uint8_t* A, const uint8_t* B, const int x, const int y,
                   const int z, const int w, const int h, const int d,
                   const int kw, const int kh);
static int bdot(const uint8_t* A, const uint8_t* B, const int N);

/* indexing functions */
static int idx_2d(const int i, const int j, const int rows);
static int idx_3d(const int i, const int j, const int k, const int rows,
                  const int cols);
static int idx_4d(const int i, const int j, const int k, const int l,
                  const int rows, const int cols, const int depth);
static int conv_idx(const int pl_i, const int x, const int kx, const int sx,
                    const int px);
static int convpool_size(const int x, const int kx, const int sx, const int px,
                         const int pl_x, const int pl_sx, const int pl_px);

/* Bit functions */
static uint8_t rotr1 (const uint8_t x);
static int popcnt8(const uint8_t v);
static int nthbitset_arr(const uint8_t* const arr, const int n);
static int bslice_2d(uint8_t* const dst, const uint8_t* const src, const int x,
                     const int y, const int w, const int h, const int kw,
                     const int kh);
static int bslice_2d_filter(uint8_t* const dst, const uint8_t* const src,
                            const int x, const int y, const int w, const int h,
                            const int kw, const int kh);
static int bslice_4d(uint8_t* const dst, const uint8_t* const src, const int x,
                     const int y, const int zi, const int zj, const int w,
                     const int h, const int d, const int kw, const int kh);


/* layers types */
static void blinear_layer(const uint8_t* A, const uint8_t* F, uint8_t* C,
                          const float* Bias, const float* Gamma,
                          const float* Beta, const float* Mean,
                          const float* Std, const int m, const int n,
                          const int k)
{
  uint8_t c_mask, res_sign;
  int i, j, ni, ci, c_shift, c_idx;
  const uint8_t *Ari;
  float res;

  c_shift = 7;
  c_mask = 1 << c_shift;
  c_idx = 0;
 
  /* Compute ceil in terms of 8-bits strides */
  ni = (n + 7) / 8;
  for (i = 0; i < m; ++i) {
    Ari = A + (i * ni);
    for (j = 0; j < k; ++j) {
      ci = j * ni;
      res = bdot(Ari, F + ci, n);
      res += Bias[j];
      res = batch_norm(res, Gamma[j], Beta[j], Mean[j], Std[j]);
      res_sign = res >= 0 ? 1 : 0;

      /* store result */
      C[c_idx] |= res_sign << c_shift;

      /* update c_idx */
      c_mask = rotr1(c_mask);
      c_idx += (c_mask & 0x80) >> 7;
      c_shift--;
      c_shift =  c_shift < 0 ? 7 : c_shift;
    }
    c_shift = 7;
    c_mask = 1 << c_shift;
    c_idx += 1;
  }
}

static void blinear_sm_layer(const uint8_t* A, const uint8_t* F, uint8_t* C,
                             const float* Bias, const float* Gamma,
                             const float* Beta, const float* Mean,
                             const float* Std, const int m, const int n,
                             const int k)
{
  int i, j, ni, ci,  max_idx;
  const uint8_t *Ari;
  float res, max_res;

  /* Compute ceil in terms of 8-bits strides */
  ni = (n + 7) / 8;
  for (i = 0; i < m; ++i) {
    max_res = -0.00000034028234663852885981170418348451692544;
    Ari = A + (i * ni);
    for (j = 0; j < k; ++j) {
      ci = j * ni;
      res = bdot(Ari, F + ci, n);
      res += Bias[j];
      res = batch_norm(res, Gamma[j], Beta[j], Mean[j], Std[j]);
	  //printf("res = %x, k = %d \n", res, j);
	  //printf("max_res = %x, k = %d \n", max_res, j);
      if (res > max_res) {
		//printf("cond is done, j = %d \n", j);
        max_idx = j;
        max_res = res;
      }
    }
    C[i] = max_idx;
  }
}

static void bconv_layer(const uint8_t* A, const uint8_t* F, uint8_t* C,
                        const float* Bias, const float* Gamma, const float* Beta,
                        const float* Mean, const float* Std, const int m,
                        const int num_f, const int w, const int h, const int d,
                        const int kw, const int kh, const int sw, const int sh,
                        const int pw, const int ph, const int pl_w,
                        const int pl_h, const int pl_sw, const int pl_sh,
                        const int pl_pw, const int pl_ph)
{
  int i, j, max_m, res_size, res_w, res_h, c_idx, f_idx, dcp_kwkh;


  c_idx = 0;
  res_w = convpool_size(w, kw, sw, pw, pl_w, pl_sw, pl_pw);
  res_h = convpool_size(h, kh, sh, ph, pl_h, pl_sh, pl_ph);
  res_size = res_w * res_h;
  max_m = CEIL_POS(res_size*m*num_f/8.0);
  dcp_kwkh = d*CEIL_POS(kw*kh/8.0);

  /* initialize result */
  for (i = 0; i < max_m; ++i) {
    C[i] = 0;
  }

  for (i = 0; i < m; ++i) {
    for (j = 0; j < num_f; ++j) {
      f_idx = j*dcp_kwkh;
      bconv(A, F + f_idx, C, c_idx, i, Bias[j], Gamma[j],
            Beta[j], Mean[j], Std[j], w, h, d, kw, kh, sw, sh, pw, ph,
            pl_w, pl_h, pl_sw, pl_sh, pl_pw, pl_ph);
      c_idx += res_size;
    }
  }
}

/* layer helper functions */
static float batch_norm(float f, const float Gamma, const float Beta,
                        const float Mean, const float Std)
{
  f -= Mean;
  f /= Std;
  f *= Gamma;
  f += Beta;
  return f;
}

static int bdot(const uint8_t* A, const uint8_t* B, const int N)
{
  int i, num_bytes, res;

  num_bytes = CEIL_POS(N/8.0);
  res = 0;
  for (i = 0; i < num_bytes; ++i) {
    res += popcnt8(~(A[i]^B[i]));
  }
  res = res*2 - N;
  return res;
}

static int bdot_3d(const uint8_t* A, const uint8_t* B, const int x, const int y,
                    const int z, const int w, const int h, const int d,
                    const int kw, const int kh)
{
  /* Handles up to 10x10 filters */
  uint8_t A_slice[MAX_FILTER_BYTES] = {0};
  uint8_t B_slice[MAX_FILTER_BYTES] = {0};
  const uint8_t *B_idx;
  int i, comp_n, res, N, B_bytes, bx, by, bw, bh, w_x, h_y;

  N = kw*kh;
  B_bytes = CEIL_POS(kw*kh/8.0);
  res = 0;
  w_x = w - x;
  h_y = h - y;
  for (i = 0; i < d; ++i) {
    B_idx = B + B_bytes*i;
    comp_n = bslice_4d(A_slice, A, x, y, z, i, w, h, d, kw, kh);
    //no padding
    if (comp_n == N) {
      res += bdot(A_slice, B_idx, N);
    }
    //padding
    else {
      bx = -MIN(0, x);
      by = -MIN(0, y);
      bw = MIN(kw, w_x);
      bh = MIN(kh, h_y);
      bslice_2d_filter(B_slice, B_idx, bx, by, kw, kh, bw, bh);
      res += bdot(A_slice, B_slice, comp_n);
    }
  }

  return res;
}



static void bconv(const uint8_t* A, const uint8_t* F, uint8_t* C,
                  const int c_start_idx, const int z, const float Bias,
                  const float Gamma, const float Beta, const float Mean,
                  const float Std, const int w, const int h, const int d,
                  const int kw, const int kh, const int sw, const int sh,
                  const int pw, const int ph, const int pl_w, const int pl_h,
                  const int pl_sw, const int pl_sh, const int pl_pw,
                  const int pl_ph)
{
  uint8_t c_mask, res_sign;
  int pl_i, pl_j, i, j, i_in, j_in, pl_i_max, pl_j_max, c_shift, c_idx, pl_w2_1, pl_hpw_1;
  float res, max_res;

  c_shift = 7 - (c_start_idx % 8);
  c_mask = 1 << c_shift;
  c_idx = c_start_idx / 8;
  pl_i_max = (w - kw + 2*pw)/sw + (2*pl_pw) + 1;
  pl_j_max = (h - kh + 2*ph)/sh + (2*pl_ph) + 1;
  pl_w2_1 = pl_w + pl_pw - 1;
  pl_hpw_1 = pl_h + pl_pw - 1;
  for (pl_i = -pl_pw; pl_i + pl_w2_1 < pl_i_max; pl_i += pl_sw) {
  for (pl_j = -pl_ph; pl_j + pl_hpw_1 < pl_j_max; pl_j += pl_sh) {
    max_res = res = -0.00000034028234663852885981170418348451692544;
	
    int pl_i_pl_w = pl_i + pl_w;
    for (i_in = pl_i; i_in < pl_i_pl_w; ++i_in) {
    i = conv_idx(i_in, w, kw, sw, pw);
    int pl_j_pl_h = pl_j + pl_h;
    for (j_in = pl_j; j_in < pl_j_pl_h; ++j_in) {
      j = conv_idx(j_in, h, kh, sh, ph);
      if (i >= -pw && j >= -ph) {
        res = bdot_3d(A, F, i, j, z, w, h, d, kw, kh);
        max_res = MAX(res, max_res);
      }
    }
    }
    max_res += Bias;
    max_res = batch_norm(max_res, Gamma, Beta, Mean, Std);
    res_sign = max_res >= 0 ? 1 : 0;

    /* store result */
    C[c_idx] |= res_sign << c_shift;

    /* update c_idx */
    c_mask = rotr1(c_mask);
    c_idx += (c_mask & 0x80) >> 7;
    c_shift--;
    c_shift =  c_shift < 0 ? 7 : c_shift;
  }
  }
}

static float fdot_3d(const float* A, const uint8_t* B, const int x, const int y,
                     const int w, const int h, const int d, const int kw,
                     const int kh)
{
  uint8_t  bitset;
  int i, j, k, b_idx, A_bytes, x_kw, y_kh;
  float a, res;
  const float *A_slice;

  A_bytes = w*h;
  res = 0;
  b_idx = 0;
  x_kw = x + kw;
  y_kh = y + kh;
  for (i = 0; i < d; ++i) {
    A_slice = A + A_bytes*i;
    for (j = x; j < x_kw; ++j) {
      for (k = y; k < y_kh; ++k) {
        /* handles padding */
        if (j < 0 || j > h-1 || k < 0 || k > w-1) {
          a = 0.0;
        }
        else {
          a = A_slice[idx_2d(j, k, w)];
        }

        bitset = nthbitset_arr(B, b_idx);
        res += bitset ? a : -a;
        b_idx++;
      }
    }
  }

  return res;
}

/* index functions */
static int idx_2d(const int i, const int j, const int rows)
{
  return i * rows + j;
}

static int idx_3d(const int i, const int j, const int k, const int rows,
                  const int cols)
{
  return i * rows * cols + j * cols + k;
}

static int idx_4d(const int i, const int j, const int k, const int l,
                  const int rows, const int cols, const int depth)
{
  return i * rows * cols * depth + j * cols * depth + k * depth + l;
}

static int conv_idx(const int pl_i, const int x, const int kx, const int sx,
                    const int px)
{
  int conv_sz = (x - kx + 2*px)/sx;
  return (pl_i < 0 || pl_i > conv_sz) ? -2147483647 : pl_i * sx - px;
}

static int convpool_size(const int x, const int kx, const int sx, const int px,
                         const int pl_x, const int pl_sx, const int pl_px)
{
  return ((x - kx + 2*px)/sx - pl_x + (2*pl_px) + 1)/pl_sx + 1;
}

/* Bit functions */
static uint8_t rotr1 (const uint8_t x)
{
  return (x >> 1) | (x << 7);
}

static int nthbitset_arr(const uint8_t* const arr, const int n)
{
  return arr[n/8] & bits[n%8] ? 1 : 0;
}

static int popcnt8(const uint8_t v) {
  uint8_t c;
  c = v - ((v >> 1) & 0x55);
  c = ((c >> 2) & 0x33) + (c & 0x33);
  return ((c >> 4) + c) & 0x0F;
}

static int bslice_2d(uint8_t* const dst, const uint8_t* const src, const int x,
                     const int y, const int w, const int h, const int kw,
                     const int kh)
{
  int i, j, n, idx, shift, bytes, x_kw, y_kh;
  uint8_t mask, bitset;

  /* initiaize dst */
  bytes = CEIL_POS(kw*kh/8.0);
  for (i = 0; i < bytes; ++i) {
    dst[i] = 0;
  }

  idx = 0;
  shift = 7;
  n = 0;
  x_kw = x + kw;
  y_kh = y + kh;
  for (i = x; i < x_kw; ++i) {
    for (j = y; j < y_kh; ++j) {
      /* Padding out of bounds */
      if (i < 0 || i > h-1 || j < 0 || j > w-1) {
        continue;
      }

      bitset = nthbitset_arr(src, idx_2d(i, j, w));
      dst[idx/8] |= bitset << shift;

      mask = rotr1(mask);
      idx++;
      shift--;
      shift = shift < 0 ? 7 : shift;
      n++;
    }
  }

  return n;
}

static int bslice_2d_filter(uint8_t* const dst, const uint8_t* const src,
                            const int x, const int y, const int w, const int h,
                            const int kw, const int kh)
{
  int i, j, n, idx, shift, bytes, bitset, x_kw, y_kh;
  uint8_t mask;

  /* initiaize dst */
  bytes = CEIL_POS(kw*kh/8.0);
  for (i = 0; i < bytes; ++i) {
    dst[i] = 0xFF;
  }

  idx = 0;
  shift = 7;
  n = 0;
  x_kw = x + kw;
  y_kh = y + kh;
  for (i = x; i < x_kw; ++i) {
    for (j = y; j < y_kh; ++j) {
      /* Padding out of bounds */
      if (i < 0 || i > h-1 || j < 0 || j > w-1) {
        continue;
      }

      bitset = nthbitset_arr(src, idx_2d(i, j, w));
      dst[idx/8] &= ~((!bitset) << shift);

      mask = rotr1(mask);
      idx++;
      shift--;
      shift = shift < 0 ? 7 : shift;
      n++;
    }
  }

  return n;
}

/* 4d slice function on binary matrix (bit packed) */
static int bslice_4d(uint8_t* const dst, const uint8_t* const src, const int x,
                     const int y, const int zi, const int zj, const int w,
                     const int h, const int d, const int kw, const int kh)
{
  int i, j, n, idx, shift, bytes, bitset, x_kw, y_kh;
  uint8_t mask;

  /* initialize dest */
  bytes = CEIL_POS(kw*kh/8.0);
  for (i = 0; i < bytes; ++i) {
    dst[i] = 0;
  }

  idx = 0;
  shift = 7;
  n = 0;
  x_kw = x + kw;
  y_kh = y + kh;
  for (i = x; i < x_kw; ++i) {
    for (j = y; j < y_kh; ++j) {
      if (i < 0 || i > h-1 || j < 0 || j > w-1) {
        continue;
      }

      bitset = nthbitset_arr(src, idx_4d(zi, zj, i, j, d, w, h));
      dst[idx/8] |= bitset << shift;
      mask = rotr1(mask);
      idx++;
      shift--;
      shift = shift < 0 ? 7 : shift;
      n++;
    }
  }

  return n;
}






float l_b_conv_pool_bn_bst0_bconv_b[10] = {-0.0019964674,-0.0014448628,0.035571262,0.0011312434,0.00052776962,-0.0024792235,0.0030493855,-0.0082627721,0.009665288,-0.0015612287};
uint8_t l_b_conv_pool_bn_bst0_bconv_W[20] = {248,127,228,127,228,127,110,255,189,255,158,255,183,127,19,255,91,127,101,255};
float l_b_conv_pool_bn_bst0_bn_beta[10] = {-0.44869453,-0.36304367,-0.72027928,-0.52004105,0.0420793,-0.070259444,-0.28672469,-0.34335798,-0.24082467,-0.51694465};
float l_b_conv_pool_bn_bst0_bn_gamma[10] = {1.0057141,0.91785663,0.90325022,0.90230775,0.81065816,0.93027312,0.8877396,0.86638236,0.7668674,1.078504};
float l_b_conv_pool_bn_bst0_bn_mean[10] = {2.0757804,2.3014512,2.7197518,1.3350036,0.91946429,1.0179693,0.78374344,2.964381,1.6609945,1.7927171};
float l_b_conv_pool_bn_bst0_bn_std[10] = {3.2608018,2.7385249,2.1224995,3.3819435,4.5014768,3.7332389,2.9808712,2.2145314,2.6149683,3.2134039};
void l_b_conv_pool_bn_bst0(uint8_t* input, uint8_t* output){
  bconv_layer(input, l_b_conv_pool_bn_bst0_bconv_W, output, l_b_conv_pool_bn_bst0_bconv_b, l_b_conv_pool_bn_bst0_bn_gamma, l_b_conv_pool_bn_bst0_bn_beta, l_b_conv_pool_bn_bst0_bn_mean, l_b_conv_pool_bn_bst0_bn_std, 1, 10, 28, 28, 1, 3, 3, 2, 2, 0, 0, 3, 3, 2, 2, 0, 0);
}

float l_b_linear_bn_softmax1_bl_b[10] = {-0.0030055868,-0.0011136349,-0.00034322278,0.0024574662,-0.00028333769,-0.0010476325,0.0024891661,-0.00016313365,-0.018592985,0.0032423565};
uint8_t l_b_linear_bn_softmax1_bl_W[450] = {98,3,128,79,224,36,56,24,94,89,65,130,3,146,36,111,53,216,250,126,179,43,19,207,196,146,185,33,118,121,236,203,131,192,67,7,98,118,57,60,37,46,207,61,245,0,12,161,37,160,32,75,24,96,34,2,34,129,10,208,32,82,19,188,75,41,32,59,197,2,152,115,167,68,129,21,37,192,164,28,167,128,5,49,85,176,128,180,18,106,113,238,177,255,31,60,240,59,243,244,239,1,15,126,63,153,222,32,239,225,53,159,55,127,3,201,211,56,240,116,253,155,18,211,240,195,91,104,140,20,18,59,29,78,113,35,204,204,219,226,60,172,205,254,59,130,30,243,0,38,50,137,248,230,10,142,203,199,176,190,238,253,163,59,167,143,206,236,242,191,56,255,40,243,202,100,36,56,169,244,2,16,111,248,88,17,2,189,129,63,0,59,236,113,247,95,78,46,125,61,178,80,30,235,235,176,3,102,18,146,82,15,208,50,116,115,255,135,203,129,208,223,89,97,15,8,115,252,193,248,199,183,196,31,192,119,254,107,137,9,65,9,197,78,119,124,201,214,231,83,78,219,1,2,5,13,114,79,30,127,12,100,147,32,66,246,113,192,9,227,188,113,3,124,235,247,146,124,222,134,48,102,99,235,236,53,246,192,20,140,119,88,233,200,149,98,168,126,7,71,62,0,40,124,96,32,118,143,222,159,15,128,213,182,192,255,63,242,76,3,241,113,36,160,71,159,35,136,3,32,146,103,25,1,228,162,27,144,63,90,33,53,38,173,51,51,36,31,195,120,48,3,56,243,61,194,50,28,103,120,240,124,199,34,250,12,237,243,15,140,102,75,25,195,53,157,134,143,63,219,197,160,227,223,61,226,15,141,251,206,104,115,175,19,56,134,57,243,206,112,115,127,127,142,127,230,227,29,114,52,94,51,222,129,10,240,152,96,28,8,251,73,28,129,252,184,48,28,15,29,230,97,192,239,255,199,211,191,116,138,59,0,238,226,14,217,152,207,243,103};
float l_b_linear_bn_softmax1_bn_beta[10] = {-0.12386253,-0.13802822,0.083668754,0.084427208,0.0110215,0.0053780014,-0.10728264,0.03886269,0.10919367,0.03057849};
float l_b_linear_bn_softmax1_bn_gamma[10] = {1.9055973,1.8344553,1.8852386,1.8764985,1.8410195,1.7907674,1.8511354,1.8892865,1.7601967,1.7847425};
float l_b_linear_bn_softmax1_bn_mean[10] = {32.604347,3.7339218,-15.641062,0.30107751,-6.0577564,13.673304,15.538383,7.6556573,46.733898,28.500366};
float l_b_linear_bn_softmax1_bn_std[10] = {28.082285,29.841702,30.142958,26.488661,25.52788,25.87661,27.551304,30.894911,23.24127,28.76712};
void l_b_linear_bn_softmax1(uint8_t* input, uint8_t* output){
  blinear_sm_layer(input, l_b_linear_bn_softmax1_bl_W, output, l_b_linear_bn_softmax1_bl_b, l_b_linear_bn_softmax1_bn_gamma, l_b_linear_bn_softmax1_bn_beta, l_b_linear_bn_softmax1_bn_mean, l_b_linear_bn_softmax1_bn_std, 1, 360, 10); 
}


uint8_t temp1[104] = {0};
uint8_t temp2[104] = {0};
void ebnn_compute(uint8_t *input, uint8_t *output){
  l_b_conv_pool_bn_bst0(input, temp1);
  l_b_linear_bn_softmax1(temp1, output);
}

int main()
{
	
//  train_data = (uint8_t *)malloc(sizeof(uint8_t)*98);
  final_guess = (uint8_t *)malloc(sizeof(uint8_t)*1); 

	/*for(int i =0; i < 98; i++){
		train_data[i]=0;	
	}*/
/*
   train_data[0] = 0; 
   train_data[1] = 0; 
   train_data[2] = 0; 
   train_data[3] = 0;
   train_data[4] = 0;
   train_data[5] = 0;
   train_data[6] = 0;
   train_data[7] = 0;
   train_data[8] = 0;
   train_data[9] = 0;
  train_data[10] = 0;
  train_data[11] = 0;
  train_data[12] = 0;
  train_data[13] = 0;
  train_data[14] = 0;
  train_data[15] = 0;
  train_data[16] = 0;
  train_data[17] = 0;
  train_data[18] = 0;
  train_data[19] = 0;
  train_data[20] = 224;
  train_data[21] = 12;
  train_data[22] = 0;
  train_data[23] = 14;
  train_data[24] = 0;
  train_data[25] = 192;
  train_data[26] = 1;
  train_data[27] = 224;
  train_data[28] = 12;
  train_data[29] = 0;
  train_data[30] = 28;
  train_data[31] = 0;
  train_data[32] = 192;
  train_data[33] = 1;
  train_data[34] = 192;
  train_data[35] = 28;
  train_data[36] = 0;
  train_data[37] = 28;
  train_data[38] = 1;
  train_data[39] = 192;
  train_data[40] = 3;
  train_data[41] = 192;
  train_data[42] = 28;
  train_data[43] = 0;
  train_data[44] = 60;
  train_data[45] = 1;
  train_data[46] = 192;
  train_data[47] = 31;
  train_data[48] = 128;
  train_data[49] = 28;
  train_data[50] = 127;
  train_data[51] = 248;
  train_data[52] = 1;
  train_data[53] = 255;
  train_data[54] = 255;
  train_data[55] = 0;
  train_data[56] = 15;
  train_data[57] = 240;
  train_data[58] = 112;
  train_data[59] = 0;
  train_data[60] = 0;
  train_data[61] = 7;
  train_data[62] = 0;
  train_data[63] = 0;
  train_data[64] = 0;
  train_data[65] = 112;
  train_data[66] = 0;
  train_data[67] = 0;
  train_data[68] = 7;
  train_data[69] = 0;
  train_data[70] = 0;
  train_data[71] = 0;
  train_data[72] = 112;
  train_data[73] = 0;
  train_data[74] = 0;
  train_data[75] = 7;
  train_data[76] = 0;
  train_data[77] = 0;
  train_data[78] = 0;
  train_data[79] = 112;
  train_data[80] = 0;
  train_data[81] = 0;
  train_data[82] = 7;
  train_data[83] = 0;
  train_data[84] = 0;
  train_data[85] = 0;
  train_data[86] = 112;
  train_data[87] = 0;
  train_data[88] = 0;
  train_data[89] = 0;
  train_data[90] = 0;
  train_data[91] = 0;
  train_data[92] = 0;
  train_data[93] = 0;
  train_data[94] = 0;
  train_data[95] = 0;
  train_data[96] = 0; 
  train_data[97] = 0;  
  

*/

/*
  train_data[0] = 0; 
  train_data[1] = 0; 
  train_data[2] = 0; 
  train_data[3] = 0;
  train_data[4] = 0;
  train_data[5] = 0;
  train_data[6] = 0;
  train_data[7] = 0;
  train_data[8] = 0;
  train_data[9] = 0;
  train_data[10] = 0;
  train_data[11] = 0;
  train_data[12] = 0;
  train_data[13] = 0;
  train_data[14] = 0;
  train_data[15] = 1;
  train_data[16] = 240;
  train_data[17] = 0;
  train_data[18] = 0;
  train_data[19] = 63;
  train_data[20] = 0;
  train_data[21] = 0;
  train_data[22] = 7;
  train_data[23] = 252;
  train_data[24] = 0;
  train_data[25] = 1;
  train_data[26] = 255;
  train_data[27] = 192;
  train_data[28] = 0;
  train_data[29] = 31;
  train_data[30] = 252;
  train_data[31] = 0;
  train_data[32] = 3;
  train_data[33] = 255;
  train_data[34] = 192;
  train_data[35] = 0;
  train_data[36] = 127;
  train_data[37] = 206;
  train_data[38] = 0;
  train_data[39] = 15;
  train_data[40] = 192;
  train_data[41] = 224;
  train_data[42] = 1;
  train_data[43] = 252;
  train_data[44] = 14;
  train_data[45] = 0;
  train_data[46] = 30;
  train_data[47] = 0;
  train_data[48] = 224;
  train_data[49] = 1;
  train_data[50] = 192;
  train_data[51] = 14;
  train_data[52] = 0;
  train_data[53] = 60;
  train_data[54] = 0;
  train_data[55] = 224;
  train_data[56] = 3;
  train_data[57] = 192;
  train_data[58] = 62;
  train_data[59] = 0;
  train_data[60] = 56;
  train_data[61] = 7;
  train_data[62] = 192;
  train_data[63] = 3;
  train_data[64] = 128;
  train_data[65] = 240;
  train_data[66] = 0;
  train_data[67] = 56;
  train_data[68] = 30;
  train_data[69] = 0;
  train_data[70] = 3;
  train_data[71] = 255;
  train_data[72] = 224;
  train_data[73] = 0;
  train_data[74] = 63;
  train_data[75] = 248;
  train_data[76] = 0;
  train_data[77] = 3;
  train_data[78] = 254;
  train_data[79] = 0;
  train_data[80] = 0;
  train_data[81] = 31;
  train_data[82] = 192;
  train_data[83] = 0;
  train_data[84] = 0;
  train_data[85] = 0;
  train_data[86] = 0;
  train_data[87] = 0;
  train_data[88] = 0;
  train_data[89] = 0;
  train_data[90] = 0;
  train_data[91] = 0;
  train_data[92] = 0;
  train_data[93] = 0;
  train_data[94] = 0;
  train_data[95] = 0;
  train_data[96] = 0; 
  train_data[97] = 0;  
  */
   /*
  train_data[0] =  0; 
  train_data[1] =  0; 
  train_data[2] =  0; 
  train_data[3] =  0; 
  train_data[4] =  0;
  train_data[5] =  0;
  train_data[6] =  0;
  train_data[7] =  0;
  train_data[8] =  0;
  train_data[9] =  0;
  train_data[10] = 0;
  train_data[11] = 0;
  train_data[12] = 0;
  train_data[13] = 0;
  train_data[14] = 0;
  train_data[15] = 0;
  train_data[16] = 0;
  train_data[17] = 0;
  train_data[18] = 0;
  train_data[19] = 255;
  train_data[20] = 240;
  train_data[21] = 0;
  train_data[22] = 255;
  train_data[23] = 255;
  train_data[24] = 0;
  train_data[25] = 31;
  train_data[26] = 255;
  train_data[27] = 224;
  train_data[28] = 1;
  train_data[29] = 255;
  train_data[30] = 192;
  train_data[31] = 0;
  train_data[32] = 15;
  train_data[33] = 236;
  train_data[34] = 0;
  train_data[35] = 0;
  train_data[36] = 124;
  train_data[37] = 0;
  train_data[38] = 0;
  train_data[39] = 1;
  train_data[40] = 224;
  train_data[41] = 0;
  train_data[42] = 0;
  train_data[43] = 30;
  train_data[44] = 0;
  train_data[45] = 0;
  train_data[46] = 0;
  train_data[47] = 252;
  train_data[48] = 0;
  train_data[49] = 0;
  train_data[50] = 7;
  train_data[51] = 224;
  train_data[52] = 0;
  train_data[53] = 0;
  train_data[54] = 63;
  train_data[55] = 0;
  train_data[56] = 0;
  train_data[57] = 1;
  train_data[58] = 240;
  train_data[59] = 0;
  train_data[60] = 0;
  train_data[61] = 7;
  train_data[62] = 128;
  train_data[63] = 0;
  train_data[64] = 3;
  train_data[65] = 248;
  train_data[66] = 0;
  train_data[67] = 0;
  train_data[68] = 255;
  train_data[69] = 0;
  train_data[70] = 0;
  train_data[71] = 63;
  train_data[72] = 224;
  train_data[73] = 0;
  train_data[74] = 15;
  train_data[75] = 252;
  train_data[76] = 0;
  train_data[77] = 3;
  train_data[78] = 255;
  train_data[79] = 0;
  train_data[80] = 0;
  train_data[82] = 255;
  train_data[83] = 192;
  train_data[84] = 0;
  train_data[85] = 15;
  train_data[86] = 240;
  train_data[87] = 0;
  train_data[88] = 0;
  train_data[89] = 0;
  train_data[90] = 0;
  train_data[91] = 0;
  train_data[92] = 0;
  train_data[93] = 0;
  train_data[94] = 0;
  train_data[95] = 0;
  train_data[96] = 0;
  train_data[97] = 0;
  
  */
  for(int j = 0; j < 1; ++j) {
     int index = 1*CEIL_POS((28*28)/8)*j; //Each element packed, since binary
     //ebnn_compute(&train_data, final_guess); //fpga
     ebnn_compute(&train_data[index], final_guess); //c code version
     uint8_t temp0 = 0xAA;
     uint8_t temp1 = 0xBB;
     uint8_t temp2 = 0xCC;
     //result [0] =  0xFFF0F0;
     uint32_t result = temp0<<24 | temp1<<16 |  temp2<<8 | final_guess[0];
	 int fail =  (int)train_labels[j] != final_guess[0];
     printf("actual: %d %s predicted: %d \n", (int)train_labels[j], (fail ? "<>" : "=="), final_guess[0]);
	 printf("result = %x \n", result);
  }
   
 // return 0;
}
