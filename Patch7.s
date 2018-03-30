;
;
;	Patch7.s
;	From address 0x01DA0000
;

	INCLUDE project.a
	INCLUDE bytecode.a
	INCLUDE package.a
	INCLUDE page.a
	
	GBLA reORG	; to produce a false ORG in branches
	
	AREA Patch7, CODE, REL
	ORG	BaseAddrPatch7

;
; Definitions
;
	
SecondsBase 			EQU 0x0D0A9D00 ; January 1st 2008, 12:00AM in minutes since 1904; shifted left twice (NewtonScript Integer)
SecondsBaseInSeconds 	EQU 0xC39F3300 ; January 1st 2008, 12:00AM in seconds since 1904
OriginalSecondsBase 	EQU 0x0B292600 ; January 1st 1993, 12:00AM in minutes since 1904
ResetTime 				EQU 0xC39FDBC0 ; January 1st 2008, 12:00PM in seconds since 1904

; 
; Jumptable patch 0x01ac0000
; 

reORG	SETA	{PC} - 0x01ac0000
L01DA0000
	DCD     0xeaa05505, 0xeaa05b06, 0xea975c23, 0xea975c12
	DCD     0xea9759d6, 0xea975bed, 0xea975a4a, 0xea975a88
	DCD     0xea975c34, 0xea975b6f, 0xea975c14, 0xea975bc5
	DCD     0xea975b95, 0xea9759fe, 0xea975b78, 0xea975b46
	DCD     0xea975b51, 0xea975b4a, 0xea975ba5, 0xea975a0c
	DCD     0xea975bca, 0xea975bb3, 0xea975b04, 0xea975aa8
	DCD     0xea975ad4, 0xea975bbe, 0xea9b8100, 0xea975c2c
	B		FDateFromSeconds
	DCD		0xea9cfa26, 0xea9cf945, 0xea9726c1

reORG	SETA	{PC} - 0x01ac1080
L01DA0080
;    DCD     0xea9b65c9, 0xea97561c, 0xea97245f, 0xea9cee10
    DCD     0xea9b65c9, 0xea97561c
	B		FSetTimeInSeconds
	DCD		0xea9cee10

    DCD     0xea99a0fb, 0xea9cf547, 0xea97260f, 0xea9cf6bb
    DCD     0xea9da4c2, 0xea9da455, 0xea99e464, 0xeaa12d81
    DCD     0xea975c23, 0xea97488b, 0xea97535b, 0xeaa05d31
    DCD     0xeaa05d31, 0xea975bcf, 0xeaa057a5, 0xea975fdb
    DCD     0xea99e730, 0xea974c07, 0xea99e358, 0xea99d7c2
    DCD     0xeaa05404, 0xea98e313, 0xea98e26c, 0xea9768c6
    DCD     0xea9b6639, 0xea974bc4, 0xea974bbe, 0xea9759ab
;
; Patch Entry
;

PatchEntry
	MOV 	r12, sp
	STMDB 	sp!, {r11-r12, lr-pc}
	SUB		r11, r12, #4
	BL		InitScriptGlobals
	BL		AdjustTime
	BL		PatchTimeFunctions		
	LDMDB 	r11, {r11, sp, pc}

;
; Register replacements for TimeInSecondsToTime and
; TimeToTimeInSeconds functions
;

PatchTimeFunctions
	MOV 	r12, sp
	STMDB 	sp!, {r11-r12, lr-pc}
	SUB		r11, r12, #4

	MOV		r0, #0
	LDR		r1, TimeInSecondsToTimeSYM
	LDR		r2, TimeInSecondsToTimeFn
	BL		FDefGlobalFn

	MOV		r0, #0
	LDR		r1, TimeToTimeInSecondsSYM
	LDR		r2, TimeToTimeInSecondsFn
	BL		FDefGlobalFn

	LDMDB 	r11, {r11, sp, pc}
	
	REFVAR	TimeInSecondsToTimeSYM, 0x003b88d0 + 1
	REFVAR	TimeInSecondsToTimeFn, TimeInSecondsToTimeNew + 1
TimeInSecondsToTimeNew	
	DCD		0x000020C3
	DCD		0x00000000
	DCD		0x0064D2DD
	DCD		0x00000032
	DCD		0x00420775
	DCD		NewSecondsBaseLiterals + 1
	DCD		0x00000002
	DCD		0x00000004

	REFVAR	TimeToTimeInSecondsSYM, 0x003b894c + 1
	REFVAR	TimeToTimeInSecondsFn, TimeToTimeInSecondsNew + 1
TimeToTimeInSecondsNew	
	DCD		0x000020C3
	DCD		0x00000000
	DCD		0x0064D2B9
	DCD		0x00000032
	DCD		0x00420725
	DCD		NewSecondsBaseLiterals + 1
	DCD		0x00000002
	DCD		0x00000008

NewSecondsBaseLiterals
	DCD		0x000010C1
	DCD		0x00000000
	DCD		0x00629435
	DCD		SecondsBase

;
; Replacement Time, SetTimeInSeconds and TimeInSeconds functions
;

FTime ; 0x01bf2900
	MOV 	r12, sp
	STMDB 	sp!, {r11-r12, lr-pc}
	SUB 	r11, r12, #&00000004
;	BL		AdjustTime
	BL 		RealClock
	MOV 	r0, r0, lsl #2
	LDMDB 	r11, {r11, sp, pc}
	
	
FTimeInSeconds ; 0x01adbd88
	MOV 	r12, sp
	STMDB 	sp!, {r11-r12, lr-pc}
	SUB 	r11, r12, #&00000004
;	BL		AdjustTime
	BL 		RealClockSeconds
	ADD     r0, r0, #&cd00  ; substract the seconds base in suitable chunks
	SUB     r0, r0, #&3a00000
	ADD     r0, r0, #&40000000
	MOV 	r0, r0, lsl #2
	LDMDB 	r11, {r11, sp, pc}
	
FSetTimeInSeconds ; 0x01ac1088
	MOV 	r12, sp
	STMDB 	sp!, {r11-r12, lr-pc}
	SUB 	r11, r12, #&00000004
	LDR		r0, [r1]
	LDR		r0, [r0]
	TST		r0, #&00000003
	MOVEQ	r0, r0, asr #2
	BEQ		ParamOk0
	BL		_RINTError
ParamOk0
	SUB     r0, r0, #&cd00 ; add the seconds base
	ADD     r0, r0, #&3a00000
	ADD     r0, r0, #&c0000000
	BL		SetRealClockSeconds
	MOV		r0, #&00000002
	LDMDB 	r11, {r11, sp, pc}
	
FDateFromSeconds ; 0x01ac0070
	MOV 	r12, sp
	STMDB 	sp!, {r4, r11-r12, lr-pc}
	SUB 	r11, r12, #&00000004
	MOV		r4, r1
	SUB		sp, sp, #&00000028
	MOV		r0, sp
	BL		TDate__TDate
	LDR		r0, [r4]
	LDR		r0, [r0]
	TST		r0, #&00000003
	MOVEQ	r0, r0, asr #2
	BEQ		ParamOk1
	BL		_RINTError
ParamOk1
	SUB     r1, r0, #&cd00 ; add the seconds base
	ADD     r1, r1, #&3a00000
	ADD     r1, r1, #&c0000000
	MOV		r0, sp
	BL		TDate__InitWithSeconds
	MOV		r0, sp
	BL		ToObject__TDate
	MOV		r4, r0
	LDR		r0, [sp, #&00000024]
	BL		DisposeRefHandle
	LDR		r0, [sp, #&00000020]
	BL		DisposeRefHandle
	LDR		r0, [sp, #&0000001c]
	BL		DisposeRefHandle
	MOV		r0, r4
	LDMDB 	r11, {r4, r11, sp, pc}
	
	
;
; Time adjustment to January 1st 2008, 12:00PM
;

AdjustTime
	MOV     r1, #&81000
	ADD     r1, r1, #&f100000
	LDR     r0, [r1,#0]
	LDR     r2, [pc, #DefaultTime-.-8]
	CMP     r0, r2
	STRCC   r2, [r1,#0]
	MOVCC	r0, r2
	MOV     pc, lr
DefaultTime
	DCD     ResetTime

;
; FSetSysAlarm fix (raw dump, should be disassembled)
;

FSetSysAlarm
    DCD     0xe1a0c00d, 0xe92dd8f0, 0xe24cb004, 0xe1a04001
    DCD     0xe1a06002, 0xe1a05003, 0xe59f7178, 0xe5970074

;	DCD     0xeb630642
	BL		TURealTimeAlarm__ClearAlarm

	DCD		0xe5940000, 0xe5900000, 0xe3300002
    DCD     0x0a000056, 0xe24dd048, 0xe1a0000d, 0xe3a029e1
    DCD     0xe59f1154

;	DCD		0xeb62f9e4
	BL		TTime__TTime

	DCD		0xe28d1040, 0xe89d5000
    DCD     0xe8815000, 0xe5940000, 0xe5900000, 0xe3100003
    DCD     0x01a00140, 0x0a000000

;	DCD		0xeb62cc70
	BL		_RINTError

	DCD		0xe1a01000
    DCD     0xe28d0008, 0xe3a029e1
	
;	DCD		0xeb62f9d7
	BL		TTime__TTime
	
	DCD		0xe28d0038
    DCD     0xe28d1008, 0xe8915000, 0xe8805000
	
;	DCD		0xeb5e1efd
	BL		GMTOffset
	
    DCD     0xe1a04000
	
;	DCD		0xebfd1965
	BL		DaylightSavingsOffset
	
	DCD		0xe0841000, 0xe28d0010
    DCD     0xe3a029e1
	
;	DCD		0xeb62f9cc
	BL		TTime__TTime
	
	DCD		0xe28d1030, 0xe28d0010
    DCD     0xe8905000, 0xe8815000, 0xe24dd008, 0xe28d1040
    DCD     0xe8915000, 0xe88d5000, 0xe1a0100d, 0xe28d0048
	
;	DCD     0xeb634830
	BL		CompAdd
	
	DCD		0xe28d0028, 0xe8bd5000, 0xe8805000
    DCD     0xe24dd008, 0xe28d0028, 0xe8905000, 0xe88d5000
    DCD     0xe1a0100d, 0xe28d0038
	
;	DCD		0xeb63482c
	BL		CompSub
	
	DCD		0xe28d0020
    DCD     0xe8bd5000, 0xe8805000, 0xe28d0028, 0xe28d1018
    DCD     0xe8915000, 0xe8805000, 0xe5970004, 0xe2801020
    DCD     0xe59f0078, 0xe5810000, 0xe59f0074, 0xe5810004
    DCD     0xe59f0070, 0xe5810008, 0xe59d002c, 0xe581000c
    DCD     0xe5962000, 0xe5922000, 0xe5910014, 0xe5802000
    DCD     0xe5952000, 0xe5922000, 0xe5910010, 0xe3a03001
    DCD     0xe5802000, 0xe3a0201c, 0xe92d000e
	
;	DCD		0xeb63125d
	BL		GetGlobals
	
    DCD     0xe5900070, 0xe5903000, 0xe5970000, 0xe28d1034
    DCD     0xe5902000, 0xe5b70074
	
;	DCD		0xeb632f38
	BL		TURealTimeAlarm__SetAlarm
	
	DCD		0xe28dd054
    DCD     0xe3a00002, 0xe91ba8f0, 0x0c1054a8

;	DCD		0xa7693a00
	DCD		SecondsBaseInSeconds

    DCD     0x6e657774, 0x69646c65, 0x616c726d
	
;
; Table of ROM functions so that they can be called by the patched functions
; 

L01DA0480
	JUMPTABLE RealClock 			, 0x002555f4
	JUMPTABLE RealClockSeconds		, 0x00255578
	JUMPTABLE FDefGlobalFn			, 0x002b7334
	JUMPTABLE _RINTError			, 0x0031cf3c
	JUMPTABLE SetRealClockSeconds	, 0x002555b8
	JUMPTABLE FDateFromSecondsOld	, 0x0008a868
	JUMPTABLE TDate__TDate			, 0x00089ad0
	JUMPTABLE TDate__InitWithSeconds, 0x0008e72c
	JUMPTABLE DisposeRefHandle		, 0x0031d2b0
	JUMPTABLE ToObject__TDate		, 0x0008a64c
	JUMPTABLE InitScriptGlobals		, 0x001f1828
	JUMPTABLE TURealTimeAlarm__ClearAlarm	, 0x1bd081c
	JUMPTABLE TTime__TTime			, 0x01bcd6c8
	JUMPTABLE GMTOffset				, 0x01a96b74
	JUMPTABLE DaylightSavingsOffset	, 0x0025551c

L01DA0500
reORG	SETA	{PC} - 0x01A6A500
	DCD 0xea99c3a5, 0xea99c3ba, 0xea99c3c2, 0xea99c3f4
	DCD 0xea99c407, 0xea99f1bc, 0xea99f1c3, 0xea99f1c5
	B InitCirrusHWPatch
	DCD 0xeaa46aad, 0xeaa46934, 0xea99f94c
	DCD 0xea99f95f, 0xea99f9e5, 0xea99f9f8, 0xea99fa1a
	DCD 0xea99fa4e, 0xea99fa72, 0xea99f95d, 0xea99f964
	DCD 0xea99f975, 0xea99f989, 0xea99f9b2, 0xea99f9d0
	DCD 0xea9db504, 0xea9db663, 0xea9db087, 0xea9db128
	DCD 0xea9db139, 0xea9db15d, 0xea9db16f, 0xea9db177

;
; Continuation of our own jumptable
; 

L01DA0580
	JUMPTABLE CompAdd				, 0x01be1084
	JUMPTABLE CompSub				, 0x01be109c
	JUMPTABLE GetGlobals			, 0x01bd39d4
	JUMPTABLE TURealTimeAlarm__SetAlarm	, 0x01bdad5c
	JUMPTABLE InitCirrusHW			, 0x000e6c44
	JUMPTABLE DisableAllInterrupts  , 0x01bd18ac
	JUMPTABLE BootOSContinued		, 0x000188E4

; Patch around AdjustRealTimeClock
; The patch consists in skipping the call to AdjustRealTimeClock.
; AdjustRealTimeClock function is called from BootOS like this:
; 000188D0 ldr      r0, 0x00019518
; 000188D4 mov      lr, pc
; 000188D8 ldr      pc, [r0]        <-- this is InitCirrusHW
; 000188DC bl       0x01BD18AC      <-- this is DisableAllInterrupts
; 000188E0 bl       0x000452FC      <-- this is AdjustRealTimeClock
; ...
; So instead, we patch InitCirrusHW with a new function which calls the original InitCirrusHW
; then we bl to DisableAllInterrupts and finally we jump to back to 000188E4 in BootOS,
; effectively skipping the call to AdjustRealTimeClock
InitCirrusHWPatch
    BL		InitCirrusHW
    BL      DisableAllInterrupts
    B 		BootOSContinued
	FILL 15, {PC}

L01DA0600
	FILL 32, {PC}

L01DA0680
	FILL 32, {PC}

L01DA0700
	FILL 32, {PC}

L01DA0780
	FILL 32, {PC}

L01DA0800
	FILL 32, {PC}

L01DA0880
	FILL 32, {PC}

reORG	SETA	{PC} - 0x01bf2900
L01DA0900
	B		FTime
	DCD		0xea982b4e, 0xea9b1b3e, 0xea9b1b89
	DCD     0xea9b1bd4, 0xea9b1cdc, 0xea9b1c56, 0xea9b1d5e
	DCD     0xea9989f4, 0xea9e80c8, 0xea9b861f, 0xea9c065b
	DCD     0xea9c065f, 0xea9c0663, 0xea9c0669, 0xea9c066d
	DCD     0xea9c0671, 0xea9b8510, 0xea9b84e2, 0xea9b853c
	DCD     0xea9e87e3, 0xea9d7886, 0xea9b09ff, 0xea9b0e8e
	DCD     0xea9b16cf, 0xea9b1a43, 0xea9b1811, 0xea9b0b00
	DCD     0xea9b0ee4, 0xea9b1344, 0xea9b1379, 0xea9b1307

L01DA0980
	FILL 32, {PC}

L01DA0A00
	FILL 32, {PC}

L01DA0A80
	FILL 32, {PC}

L01DA0B00
	FILL 32, {PC}

L01DA0B80
	FILL 32, {PC}

L01DA0C00
	FILL 32, {PC}

reORG	SETA	{PC} - 0x01a99c80
L01DA0C80
	DCD		0xea9aae1d, 0xea9ab0b7, 0xea974156, 0xea9aab09
	DCD 	0xea9aaaf8, 0xea9c62a0, 0xea9aab8e, 0xea9ac205
	DCD 	0xea9ac1aa, 0xeaa1c925, 0xea9773d0, 0xea9a905e
	DCD		0xea9d4c0e, 0xea9b8ac1, 0xea9b8b09, 0xea9b8a32
	DCD 	0xea9ab3f8, 0xea99476b, 0xea9a934c, 0xea99c5d5
	DCD 	0xea9ab3de, 0xea9b9f7b, 0xea9a9251, 0xea9743be
	B		PatchEntry
	DCD		0xea9d3f4b, 0xea966a04, 0xea9ab38d
	DCD 	0xea9acc8a, 0xea9a9784, 0xea99c617, 0xea9aaf72

L01DA0D00
reORG	SETA	{PC} - 0x01adad00
;    DCD     0xea9c9aa7, 0xeaa0d078, 0xea96be2d, 0xea9c462f
    DCD     0xea9c9aa7
	B		FSetSysAlarm
	DCD		0xea96be2d, 0xea9c462f
    DCD     0xea9945e7, 0xea96bd16, 0xea96bca0, 0xea9c3e18
    DCD     0xea9dea08, 0xea9c449b, 0xea9c8903, 0xea9c88e9
    DCD     0xea9c8a2e, 0xea9c307c, 0xea9c9fcc, 0xea9c9fd1
    DCD     0xea9c553a, 0xea9c88d7, 0xea9c3d87, 0xea9c412e
    DCD     0xea9c87bc, 0xea96bf0b, 0xea9c8fac, 0xea96bbc4
    DCD     0xea9b16bf, 0xea9b16b4, 0xea9591f5, 0xea9c83e5
    DCD     0xea9c82ce, 0xea9c407e, 0xea9c40cd, 0xea9c9ff0

reORG	SETA	{PC} - 0x01adbd80
L01DA0D80
	DCD     0xea96b7b5, 0xea9c4e3c
	B		FTimeInSeconds
	DCD		0xea96b92d
;	DCD     0xea96b7b5, 0xea9c4e3c, 0xea96b775, 0xea96b92d
	DCD     0xea9c43bc, 0xea9c39b2, 0xea96ba15, 0xea9c3af8
	DCD     0xea9c3a3a, 0xea9c3d3a, 0xea96b9cb, 0xea9705e4
	DCD     0xeaa2a6ad, 0xea9e111e, 0xea971434, 0xea9e13b5
	DCD     0xea98cbc3, 0xea9a358c, 0xea9990a6, 0xea9e3394
	DCD     0xea95614d, 0xeaa0bdf6, 0xea9e188a, 0xea9e17e4
	DCD     0xea9599f3, 0xea9a755b, 0xea9e1884, 0xea9aade5
	DCD     0xea98155a, 0xea9e1500, 0xea9e26c3, 0xea9aae0e
	
L01DA0E00
	FILL 32, {PC}

L01DA0E80
	FILL 32, {PC}

L01DA0F00
	FILL 32, {PC}

L01DA0F80
	DCD		0x81DA0F80
	FILL	31, {PC}

	END
