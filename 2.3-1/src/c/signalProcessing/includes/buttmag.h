/* Copyright (C) 2017 - IIT Bombay - FOSSEE

 This file must be used under the terms of the CeCILL.
 This source file is licensed as described in the file COPYING, which
 you should have received as part of this distribution.  The terms
 are also available at
 http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 Author: Ankit Raj
 Organization: FOSSEE, IIT Bombay
 Email: toolbox@scilab.in
 */

#ifndef __BUTTMAG_H__
#define __BUTTMAG_H__
#include "types.h"

#ifdef __cplusplus
extern "C" {
#endif

void dbuttmags(double order, double omegac, double* sample, int size,double* out);
void u8buttmags(int order, int omegac, double* sample, int size,double* out);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* __BUTTMAG_H__ */

