// Copyright (C) 2016 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function img = CV_LoadImage(filename,loadtype)
// function to load an image object from given filename
//
// Calling Sequence
//     CV_LoadImage(filename,loadtype)
//
// Parameters
//     filename: name of file to be opened
//     loadtype: desired load method
//
// Description
//	This function can be used for loading a previously stored image
//	
//	loadtype can take the following values:
//	<itemizedlist>
//	<listitem><para> less than 0 -> image is loaded as is (with alpha channel)</para></listitem>
//	<listitem><para> 0 -> image is loaded as greyscale</para></listitem>
//	<listitem><para> greater than 0 -> 3 channel color image is loaded</para></listitem>
//	</itemizedlist>
//
// This is curretly dummy function. It provides no functionality but is required 
// for providing support for generating C code for OpenCV
//
// Examples
//	CV_LoadImage('~/test.jpg',0)
// See also
//     CV_CreateImage
//
// Authors
//     Siddhesh Wani
//

img = 0;

endfunction
