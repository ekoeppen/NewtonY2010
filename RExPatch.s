;
;
;	RExPatch.s
;	From address 0x01E00000
;
;	Author		Jonathan Kipling Knight
;	Created		12/17/2000
;	Modified	1/9/2001
;
;

	INCLUDE project.a
	INCLUDE package.a
	INCLUDE page.a
	INCLUDE Bytecode.a

	AREA RExPatch, CODE, ABS
	ORG	BaseAddrRExPatch
	ENTRY
L01E00000
	B	0x007A5690	; branch from ScreenBuffer at 0x007A5618
	B	0x007A5698	; branch from ScreenBuffer at 0x007A5624,0x007A5680
	B	0x007A569C	; branch from ScreenBuffer at 0x007A5628,0x007A5684
	B	0x007A56A0	; branch from ScreenBuffer at 0x007A5688
	B	0x007A56CC	; branch from ScreenBuffer at 0x007A568C
	B	0x007A5878
	B	0x007A5BFC
	B	0x007A5E48
	B	0x007A587C
	B	0x007A5880
	B	0x007A5A04
	B	0x007A5EA4
	B	0x007A5A84
	B	new7A5ADC	; patch from 0x007A5ADC
	B	0x007A5BF4
	B	0x007A5EA0
	B	0x007A5A7C
	B	0x007A5A80
	FILL 14,0xE6000410

fnMap	; exact copy of function map in Patch4 at L01A8C680
	ObjectHeader (fnMapEnd-{PC}), kArrayObject
	IntegerRef	0		; class of array
	NILRef				; NIL
	PointerRef 0x003C31CC		; 'class
	PointerRef 0x00535F6C		; 'instructions
	PointerRef 0x00629434		; 'literals
	PointerRef 0x00629450		; 'argFrame
	PointerRef 0x0041957C		; 'numArgs
fnMapEnd
	FILL 23,0xDEADC0DE

L01E00100
;	ORG	0x01EE2100
	PointerRef 0x00748458	; @8256
	PointerRef 0x0074862C	; @8257
	PointerRef 0x00748960	; @8258
	PointerRef 0x0074A984	; @8259
	PointerRef 0x0074C4A0	; @8260
	PointerRef 0x0074CEBC	; @8261
	PointerRef 0x0074F388	; @8262
	PointerRef 0x007512E0	; @8263
	PointerRef 0x00751CE8	; @8264
	PointerRef 0x00752548	; @8265
	PointerRef 0x007529C4	; @8266
	PointerRef 0x007538A0	; @8267
	PointerRef 0x00754990	; @8268
	PointerRef new8269	; patch of @8269 from 0x00754CB1
	PointerRef 0x00756978	; @8270
	PointerRef 0x00756C04	; @8271
	PointerRef 0x0075798C	; @8272
	PointerRef 0x00757F74	; @8273
	PointerRef 0x00758568	; @8274
	PointerRef 0x00759AC4	; @8275
	PointerRef 0x0075FBC8	; @8276
	PointerRef 0x00760F78	; @8277
	PointerRef 0x0075CB88	; @8278
	PointerRef 0x00761BAC	; @8279
	PointerRef 0x00761C38	; @8280
	PointerRef 0x00761CB0	; @8281
	PointerRef 0x00761D1C	; @8282
	PointerRef 0x00761D4C	; @8283
	PointerRef 0x00761E00	; @8284
	PointerRef 0x00761FDC	; @8285
	PointerRef 0x007621B8	; @8286
	PointerRef 0x00762394	; @8287

new7A5ADC
	CMP	R1,#0
	BNE	0x007A5ADC
	MOV	R12,sp
	STMFD	sp!,{R4-R6,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	STR	R2,[R4,#48]
	SUB	sp,sp,#4
	MOV	R6,#0
	ADR	R0,D0
	BL	0x01BC5280
	BL	0x01BC214C
	STR	R0,[sp]
	MOV	R0,sp
	BL	0x01A96B04
	BL	0x01BC214C
	MOV	R5,R0
	LDR	R0,[sp]
	BL	0x01BC31BC
	LDR	R0,[R5]
	TEQ	R0,#2
	BEQ	L1
	TST	R0,#3
	MOVEQ	R0,R0,ASR #2
	BEQ	L2
	BL	0x01BBEF08
L2	MOV	R6,R0
L1	ADD	R4,R4,#44
	LDMED	R4!,{R0,R1}
	ADD	R0,R0,R1
	ADD	R0,R0,R6
	ADD	R0,R0,#102
	MOV	R1,#0x20000000
	STR	R0,[R1]
	MOV	R0,R5
	BL	0x01BC31BC
	LDMEA	R11,{R4-R6,R11,sp,PC}
D0	DCB	"UniC"
	%	4

new8269
	ObjectHeader (map-{PC}), kFrameObject
	PointerRef map
	PointerRef 0x00754CB0	; old @8269
	PointerRef fn
map					; [4: NIL, '_proto, 'StartConnected ]
	ObjectHeader (fn-{PC}), kArrayObject
	IntegerRef	4
	NILRef
	PointerRef 0x007A8C98	; '_proto
	PointerRef 0x00754DF4	; 'StartConnected
fn
;	FnObject fnBytecode, fnLiterals, 0, 0	; this will refer to same map but in ROMPatch
	ObjectHeader 0x20, kFrameObject	; func()
	PointerRef fnMap				                ; 	if autodock and syncOptions = 'all then
	ImmediateRef 0xC				                ;		syncOptions = 'allWithSoups;
	PointerRef fnBytecode				            ;	inherited:StartConnected();
	PointerRef fnLiterals				            ; end
	NILRef
	IntegerRef 0
fnBytecode
	ObjectHeader (codeEnd-{PC}), kBinaryObject
	PointerRef 0x007A7D7C	; 'instructions
codeStart
	FindVar 0
	BranchIfFalse 10  ;(L5 - codeStart)
	FindVar 1
	Push 2
	PrimitiveFn equalsFn
	Branch 11 ;(L4 - codeStart)
L5	PushNIL
L4	BranchIfFalse 16 ;(L3 - codeStart)
	Push 3
	FindSetVar 1
L3	Push 4
	Resend 0
	Return
codeEnd
	BinaryFiller 0xBA
fnLiterals
	ObjectHeader (litsEnd-{PC}), kArrayObject
	PointerRef 0x007A7D9C	; 'literals
	PointerRef 0x00754ECC	; 'autodock
	PointerRef 0x00754E34	; 'syncOptions
	PointerRef 0x007559A0	; 'all
	PointerRef 0x00759884	; 'allWithSoups
	PointerRef 0x00754DF4	; 'StartConnected
litsEnd
	FILL 854,0xDEADC0DE

	END
