// DO NOT EDIT -- generated by mk-ops.awk
#if ! defined (octave_mx_ops_h)
#define octave_mx_ops_h 1
#include "octave-config.h"
#include "mx-cdm-dm.h"
#include "mx-dm-cdm.h"
#include "mx-cs-dm.h"
#include "mx-cs-m.h"
#include "mx-cs-nda.h"
#include "mx-cdm-cm.h"
#include "mx-cdm-m.h"
#include "mx-cdm-s.h"
#include "mx-cm-cdm.h"
#include "mx-cm-dm.h"
#include "mx-cm-m.h"
#include "mx-cnda-nda.h"
#include "mx-cm-s.h"
#include "mx-cnda-s.h"
#include "mx-dm-cs.h"
#include "mx-dm-cm.h"
#include "mx-m-cs.h"
#include "mx-nda-cs.h"
#include "mx-m-cdm.h"
#include "mx-m-cm.h"
#include "mx-nda-cnda.h"
#include "mx-s-cdm.h"
#include "mx-s-cm.h"
#include "mx-s-cnda.h"
#include "mx-dm-m.h"
#include "mx-m-dm.h"
#include "mx-fcdm-fdm.h"
#include "mx-fdm-fcdm.h"
#include "mx-fcs-fdm.h"
#include "mx-fcs-fm.h"
#include "mx-fcs-fnda.h"
#include "mx-fcdm-fcm.h"
#include "mx-fcdm-fm.h"
#include "mx-fcdm-fs.h"
#include "mx-fcm-fcdm.h"
#include "mx-fcm-fdm.h"
#include "mx-fcm-fm.h"
#include "mx-fcnda-fnda.h"
#include "mx-fcm-fs.h"
#include "mx-fcnda-fs.h"
#include "mx-fdm-fcs.h"
#include "mx-fdm-fcm.h"
#include "mx-fm-fcs.h"
#include "mx-fnda-fcs.h"
#include "mx-fm-fcdm.h"
#include "mx-fm-fcm.h"
#include "mx-fnda-fcnda.h"
#include "mx-fs-fcdm.h"
#include "mx-fs-fcm.h"
#include "mx-fs-fcnda.h"
#include "mx-fdm-fm.h"
#include "mx-fm-fdm.h"
#include "mx-pm-m.h"
#include "mx-m-pm.h"
#include "mx-pm-cm.h"
#include "mx-cm-pm.h"
#include "mx-pm-fm.h"
#include "mx-fm-pm.h"
#include "mx-pm-fcm.h"
#include "mx-fcm-pm.h"
#include "mx-s-i8nda.h"
#include "mx-i8nda-s.h"
#include "mx-s-ui8nda.h"
#include "mx-ui8nda-s.h"
#include "mx-s-i16nda.h"
#include "mx-i16nda-s.h"
#include "mx-s-ui16nda.h"
#include "mx-ui16nda-s.h"
#include "mx-s-i32nda.h"
#include "mx-i32nda-s.h"
#include "mx-s-ui32nda.h"
#include "mx-ui32nda-s.h"
#include "mx-s-i64nda.h"
#include "mx-i64nda-s.h"
#include "mx-s-ui64nda.h"
#include "mx-ui64nda-s.h"
#include "mx-fs-i8nda.h"
#include "mx-i8nda-fs.h"
#include "mx-fs-ui8nda.h"
#include "mx-ui8nda-fs.h"
#include "mx-fs-i16nda.h"
#include "mx-i16nda-fs.h"
#include "mx-fs-ui16nda.h"
#include "mx-ui16nda-fs.h"
#include "mx-fs-i32nda.h"
#include "mx-i32nda-fs.h"
#include "mx-fs-ui32nda.h"
#include "mx-ui32nda-fs.h"
#include "mx-fs-i64nda.h"
#include "mx-i64nda-fs.h"
#include "mx-fs-ui64nda.h"
#include "mx-ui64nda-fs.h"
#include "mx-nda-i8.h"
#include "mx-i8-nda.h"
#include "mx-nda-ui8.h"
#include "mx-ui8-nda.h"
#include "mx-nda-i16.h"
#include "mx-i16-nda.h"
#include "mx-nda-ui16.h"
#include "mx-ui16-nda.h"
#include "mx-nda-i32.h"
#include "mx-i32-nda.h"
#include "mx-nda-ui32.h"
#include "mx-ui32-nda.h"
#include "mx-nda-i64.h"
#include "mx-i64-nda.h"
#include "mx-nda-ui64.h"
#include "mx-ui64-nda.h"
#include "mx-fnda-i8.h"
#include "mx-i8-fnda.h"
#include "mx-fnda-ui8.h"
#include "mx-ui8-fnda.h"
#include "mx-fnda-i16.h"
#include "mx-i16-fnda.h"
#include "mx-fnda-ui16.h"
#include "mx-ui16-fnda.h"
#include "mx-fnda-i32.h"
#include "mx-i32-fnda.h"
#include "mx-fnda-ui32.h"
#include "mx-ui32-fnda.h"
#include "mx-fnda-i64.h"
#include "mx-i64-fnda.h"
#include "mx-fnda-ui64.h"
#include "mx-ui64-fnda.h"
#include "mx-nda-i8nda.h"
#include "mx-i8nda-nda.h"
#include "mx-nda-ui8nda.h"
#include "mx-ui8nda-nda.h"
#include "mx-nda-i16nda.h"
#include "mx-i16nda-nda.h"
#include "mx-nda-ui16nda.h"
#include "mx-ui16nda-nda.h"
#include "mx-nda-i32nda.h"
#include "mx-i32nda-nda.h"
#include "mx-nda-ui32nda.h"
#include "mx-ui32nda-nda.h"
#include "mx-nda-i64nda.h"
#include "mx-i64nda-nda.h"
#include "mx-nda-ui64nda.h"
#include "mx-ui64nda-nda.h"
#include "mx-fnda-i8nda.h"
#include "mx-i8nda-fnda.h"
#include "mx-fnda-ui8nda.h"
#include "mx-ui8nda-fnda.h"
#include "mx-fnda-i16nda.h"
#include "mx-i16nda-fnda.h"
#include "mx-fnda-ui16nda.h"
#include "mx-ui16nda-fnda.h"
#include "mx-fnda-i32nda.h"
#include "mx-i32nda-fnda.h"
#include "mx-fnda-ui32nda.h"
#include "mx-ui32nda-fnda.h"
#include "mx-fnda-i64nda.h"
#include "mx-i64nda-fnda.h"
#include "mx-fnda-ui64nda.h"
#include "mx-ui64nda-fnda.h"
#include "mx-i8nda-ui8.h"
#include "mx-i8nda-i16.h"
#include "mx-i8nda-ui16.h"
#include "mx-i8nda-i32.h"
#include "mx-i8nda-ui32.h"
#include "mx-i8nda-i64.h"
#include "mx-i8nda-ui64.h"
#include "mx-i16nda-i8.h"
#include "mx-i16nda-ui8.h"
#include "mx-i16nda-ui16.h"
#include "mx-i16nda-i32.h"
#include "mx-i16nda-ui32.h"
#include "mx-i16nda-i64.h"
#include "mx-i16nda-ui64.h"
#include "mx-i32nda-i8.h"
#include "mx-i32nda-ui8.h"
#include "mx-i32nda-i16.h"
#include "mx-i32nda-ui16.h"
#include "mx-i32nda-ui32.h"
#include "mx-i32nda-i64.h"
#include "mx-i32nda-ui64.h"
#include "mx-i64nda-i8.h"
#include "mx-i64nda-ui8.h"
#include "mx-i64nda-i16.h"
#include "mx-i64nda-ui16.h"
#include "mx-i64nda-i32.h"
#include "mx-i64nda-ui32.h"
#include "mx-i64nda-ui64.h"
#include "mx-ui8nda-i8.h"
#include "mx-ui8nda-i16.h"
#include "mx-ui8nda-ui16.h"
#include "mx-ui8nda-i32.h"
#include "mx-ui8nda-ui32.h"
#include "mx-ui8nda-i64.h"
#include "mx-ui8nda-ui64.h"
#include "mx-ui16nda-i8.h"
#include "mx-ui16nda-ui8.h"
#include "mx-ui16nda-i16.h"
#include "mx-ui16nda-i32.h"
#include "mx-ui16nda-ui32.h"
#include "mx-ui16nda-i64.h"
#include "mx-ui16nda-ui64.h"
#include "mx-ui32nda-i8.h"
#include "mx-ui32nda-ui8.h"
#include "mx-ui32nda-i16.h"
#include "mx-ui32nda-ui16.h"
#include "mx-ui32nda-i32.h"
#include "mx-ui32nda-i64.h"
#include "mx-ui32nda-ui64.h"
#include "mx-ui64nda-i8.h"
#include "mx-ui64nda-ui8.h"
#include "mx-ui64nda-i16.h"
#include "mx-ui64nda-ui16.h"
#include "mx-ui64nda-i32.h"
#include "mx-ui64nda-ui32.h"
#include "mx-ui64nda-i64.h"
#include "mx-i8-ui8nda.h"
#include "mx-i8-i16nda.h"
#include "mx-i8-ui16nda.h"
#include "mx-i8-i32nda.h"
#include "mx-i8-ui32nda.h"
#include "mx-i8-i64nda.h"
#include "mx-i8-ui64nda.h"
#include "mx-i16-i8nda.h"
#include "mx-i16-ui8nda.h"
#include "mx-i16-ui16nda.h"
#include "mx-i16-i32nda.h"
#include "mx-i16-ui32nda.h"
#include "mx-i16-i64nda.h"
#include "mx-i16-ui64nda.h"
#include "mx-i32-i8nda.h"
#include "mx-i32-ui8nda.h"
#include "mx-i32-i16nda.h"
#include "mx-i32-ui16nda.h"
#include "mx-i32-ui32nda.h"
#include "mx-i32-i64nda.h"
#include "mx-i32-ui64nda.h"
#include "mx-i64-i8nda.h"
#include "mx-i64-ui8nda.h"
#include "mx-i64-i16nda.h"
#include "mx-i64-ui16nda.h"
#include "mx-i64-i32nda.h"
#include "mx-i64-ui32nda.h"
#include "mx-i64-ui64nda.h"
#include "mx-ui8-i8nda.h"
#include "mx-ui8-i16nda.h"
#include "mx-ui8-ui16nda.h"
#include "mx-ui8-i32nda.h"
#include "mx-ui8-ui32nda.h"
#include "mx-ui8-i64nda.h"
#include "mx-ui8-ui64nda.h"
#include "mx-ui16-i8nda.h"
#include "mx-ui16-ui8nda.h"
#include "mx-ui16-i16nda.h"
#include "mx-ui16-i32nda.h"
#include "mx-ui16-ui32nda.h"
#include "mx-ui16-i64nda.h"
#include "mx-ui16-ui64nda.h"
#include "mx-ui32-i8nda.h"
#include "mx-ui32-ui8nda.h"
#include "mx-ui32-i16nda.h"
#include "mx-ui32-ui16nda.h"
#include "mx-ui32-i32nda.h"
#include "mx-ui32-i64nda.h"
#include "mx-ui32-ui64nda.h"
#include "mx-ui64-i8nda.h"
#include "mx-ui64-ui8nda.h"
#include "mx-ui64-i16nda.h"
#include "mx-ui64-ui16nda.h"
#include "mx-ui64-i32nda.h"
#include "mx-ui64-ui32nda.h"
#include "mx-ui64-i64nda.h"
#include "mx-i8nda-ui8nda.h"
#include "mx-i8nda-i16nda.h"
#include "mx-i8nda-ui16nda.h"
#include "mx-i8nda-i32nda.h"
#include "mx-i8nda-ui32nda.h"
#include "mx-i8nda-i64nda.h"
#include "mx-i8nda-ui64nda.h"
#include "mx-i16nda-i8nda.h"
#include "mx-i16nda-ui8nda.h"
#include "mx-i16nda-ui16nda.h"
#include "mx-i16nda-i32nda.h"
#include "mx-i16nda-ui32nda.h"
#include "mx-i16nda-i64nda.h"
#include "mx-i16nda-ui64nda.h"
#include "mx-i32nda-i8nda.h"
#include "mx-i32nda-ui8nda.h"
#include "mx-i32nda-i16nda.h"
#include "mx-i32nda-ui16nda.h"
#include "mx-i32nda-ui32nda.h"
#include "mx-i32nda-i64nda.h"
#include "mx-i32nda-ui64nda.h"
#include "mx-i64nda-i8nda.h"
#include "mx-i64nda-ui8nda.h"
#include "mx-i64nda-i16nda.h"
#include "mx-i64nda-ui16nda.h"
#include "mx-i64nda-i32nda.h"
#include "mx-i64nda-ui32nda.h"
#include "mx-i64nda-ui64nda.h"
#include "mx-ui8nda-i8nda.h"
#include "mx-ui8nda-i16nda.h"
#include "mx-ui8nda-ui16nda.h"
#include "mx-ui8nda-i32nda.h"
#include "mx-ui8nda-ui32nda.h"
#include "mx-ui8nda-i64nda.h"
#include "mx-ui8nda-ui64nda.h"
#include "mx-ui16nda-i8nda.h"
#include "mx-ui16nda-ui8nda.h"
#include "mx-ui16nda-i16nda.h"
#include "mx-ui16nda-i32nda.h"
#include "mx-ui16nda-ui32nda.h"
#include "mx-ui16nda-i64nda.h"
#include "mx-ui16nda-ui64nda.h"
#include "mx-ui32nda-i8nda.h"
#include "mx-ui32nda-ui8nda.h"
#include "mx-ui32nda-i16nda.h"
#include "mx-ui32nda-ui16nda.h"
#include "mx-ui32nda-i32nda.h"
#include "mx-ui32nda-i64nda.h"
#include "mx-ui32nda-ui64nda.h"
#include "mx-ui64nda-i8nda.h"
#include "mx-ui64nda-ui8nda.h"
#include "mx-ui64nda-i16nda.h"
#include "mx-ui64nda-ui16nda.h"
#include "mx-ui64nda-i32nda.h"
#include "mx-ui64nda-ui32nda.h"
#include "mx-ui64nda-i64nda.h"
#endif
