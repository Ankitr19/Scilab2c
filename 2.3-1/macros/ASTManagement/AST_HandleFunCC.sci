// Copyright (C) 2017 - IIT Bombay - FOSSEE

// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author: Ukasha Noor
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in


function [FileInfo,SharedInfo] = AST_HandleFunCC(NCol,FileInfo,SharedInfo)

SCI2CNInArgCheck(argn(2),3,3)

// ------------------------------
// --- Check input arguments. ---
// ------------------------------

// -----------------------
// --- Initialization. ---
// -----------------------
nxtscifunname   = SharedInfo.NextSCIFunName;
nxtscifunnumber = SharedInfo.NextSCIFunNumber;
ReportFileName         = FileInfo.Funct(nxtscifunnumber).ReportFileName;

global SCI2CSTACK
global StackPosition;
global STACKDEDUG
// ---------------------------
// --- End Initialization. ---
// ---------------------------

// ------------------------------
// --- Read output parameters. --
// ------------------------------
LhsField = AST_PopASTStack();
NOutArg = 0;
OutputArgumentNames = [];
OutputArgumentScope = [];
while (LhsField ~= 'Lhs       :')
   NOutArg = NOutArg + 1;
   [OutputArgumentNames(NOutArg),OutputArgumentScope(NOutArg)] = AST_ExtractNameAndScope(LhsField);
   LhsField = AST_PopASTStack();
   if (LhsField == 'Expression:')
     error(9999, 'Found Expression: before Lhs');
   elseif (LhsField == 'Equal')
     error(9999, 'Found Equal before Lhs');
   end
end

// ------------------------------
// --- Read input parameters. ---
// ------------------------------


RhsField = AST_PopASTStack();
InputArgumentNames = [];
InputArgumentScope = [];
NInArg = 0;
InArg = [];
while (RhsField ~= 'Expression:')
   NInArg = NInArg + 1;
   if RhsField <> 'Operands:'
   [InputArgumentNames(NInArg),InputArgumentScope(NInArg)] = AST_ExtractNameAndScope(RhsField);
   end
   //InArg(NInArg) = RhsField;
   RhsField = AST_PopASTStack();
end
InputArgumentNames = SCI2Cflipud(InputArgumentNames);
InputArgumentScope = SCI2Cflipud(InputArgumentScope);


// -------------------------------------
// --- Generate the InArg structure. ---
// -------------------------------------
//#RNU_RES_E
for counterinputargs = 1:NInArg
   InArg(counterinputargs).Name=InputArgumentNames(counterinputargs);
   InArg(counterinputargs).Scope=InputArgumentScope(counterinputargs);
end

//#RNU_RES_B
// -------------------------------------
// --- Generate the InArg structure. ---
// -------------------------------------
//#RNU_RES_E
OutArg = [];
for counteroutputargs = 1:NOutArg
   OutArg(counteroutputargs).Name=OutputArgumentNames(counteroutputargs);
   OutArg(counteroutputargs).Scope=OutputArgumentScope(counteroutputargs);
end

// ------------------------
// --- Print Some Info. ---
// ------------------------

PrintStringInfo('N Input Arguments: '+string(NInArg),ReportFileName,'file','y','n');
PrintStringInfo('N Output Arguments: '+string(NOutArg),ReportFileName,'file','y');
   //#RNU_RES_E
   for counterinputargs = 1:NInArg
      //#RNU_RES_B
      PrintStringInfo('Input Argument Number '+string(counterinputargs)+': '+InArg(counterinputargs).Name,...
         ReportFileName,'file','y','n');
      PrintStringInfo('   Scope: '+InArg(counterinputargs).Scope,...
         ReportFileName,'file','y','n');
      //#RNU_RES_E
   end
   for counteroutputargs = 1:NOutArg
      //#RNU_RES_B
      PrintStringInfo('Output Argument Number '+string(counteroutputargs)+': '+OutArg(counteroutputargs).Name,...
         ReportFileName,'file','y','n');
      //PrintStringInfo('   Scope: '+ OutArg(counterinputargs).Scope,ReportFileName,'file','y','n');
      //#RNU_RES_E
   end

NOutArg_mod = NOutArg;

FunTypeAnnot = '';
FunSizeAnnot = '';
NLhsArg = 0;
LhsArg = [];
PrintStringInfo('...Equal not found.',ReportFileName,'file','y');

PrintStringInfo('***Analyzing Input Arguments***',ReportFileName,'file','y');
UpdatedInArg = InArg;
[InArg,SharedInfo] = ST_GetInArgInfo(InArg,NInArg,FileInfo,SharedInfo,'OpEqual');

NCol = NCol + 1;
NRow = NInArg/NCol;

com_type = 0;
for i = 1:NInArg
	if InArg(i).Type == 'z'
		com_type = 1;
	elseif InArg(i).Type == 'c'
		com_type = 2;
	end
end
	

if com_type == 0
	PrintStringInfo('   Generating Out Arg names.',ReportFileName,'file','y');
	OutArg(1).Type      = InArg(1).Type;
	OutArg(1).Size(1)   = string(NCol);
	OutArg(1).Size(2)   = string(NRow);
	OutArg(1).Dimension = 2;
	OutArg(1).Value     = InArg(1).Value;
	OutArg(1).FindLike  = InArg(1).FindLike;
elseif com_type == 1
	PrintStringInfo('   Generating Out Arg names.',ReportFileName,'file','y');
	OutArg(1).Type      = 'z';
	OutArg(1).Size(1)   = string(NCol);
	OutArg(1).Size(2)   = string(NRow);
	OutArg(1).Dimension = 2;
	OutArg(1).Value     = InArg(1).Value;
	OutArg(1).FindLike  = InArg(1).FindLike;
else
	PrintStringInfo('   Generating Out Arg names.',ReportFileName,'file','y');
	OutArg(1).Type      = 'c';
	OutArg(1).Size(1)   = string(NCol);
	OutArg(1).Size(2)   = string(NRow);
	OutArg(1).Dimension = 2;
	OutArg(1).Value     = InArg(1).Value;
	OutArg(1).FindLike  = InArg(1).FindLike;
end

//--- Check for output Argument in symbol table ---//
OutArg = ST_AnalyzeScope(OutArg,NOutArg,FileInfo,SharedInfo);

//--- Put the output Argument in symbol table ---//
ST_InsOutArg_Dup(InArg,NInArg,OutArg,NOutArg,com_type,FileInfo,SharedInfo,'all');


endfunction
