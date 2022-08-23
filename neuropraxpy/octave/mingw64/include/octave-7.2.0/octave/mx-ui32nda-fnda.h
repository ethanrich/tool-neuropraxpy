// DO NOT EDIT -- generated by mk-ops.awk
#if ! defined (octave_mx_ui32nda_fnda_h)
#define octave_mx_ui32nda_fnda_h 1
#include "octave-config.h"
#include "uint32NDArray.h"
#include "fNDArray.h"
  extern OCTAVE_API uint32NDArray operator + (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API uint32NDArray operator - (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API uint32NDArray product (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API uint32NDArray quotient (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_lt (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_le (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_ge (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_gt (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_eq (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_ne (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_and (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_or (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_not_and (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_not_or (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_and_not (const uint32NDArray&, const FloatNDArray&);
  extern OCTAVE_API boolNDArray mx_el_or_not (const uint32NDArray&, const FloatNDArray&);
#endif