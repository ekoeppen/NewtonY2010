;
;
;	Patch6.s
;	From address 0x01C11000
;	From the MP2100 ROM 717260
;
;	Author		Jonathan Kipling Knight
;	Created		12/17/2000
;	Modified	12/23/2000 Match exactly to 717260 (Kip)
;
;

	INCLUDE project.a
	INCLUDE package.a
	INCLUDE bytecode.a
	INCLUDE page.a


	AREA Patch6, CODE, ABS
	ORG	BaseAddrPatch6

L01C11000
	MOV	R12,sp
	STMFD	sp!,{R4-R7,R11,R12,LR,PC}
	SUB	R11,R12,#4
	SUB	sp,sp,#4
	MOV	R0,#2
	BL	0x01BC214C
	STR	R0,[sp]
	MOV	R0,sp
	BL	0x001F6360
	BL	0x01BC214C
	MOV	R4,R0
	LDR	R0,[sp]
	BL	0x01BC31BC
	LDR	R0,[R4]
	TEQ	R0,#2
	LDRNE	R7,D0
	LDRNE	R0,[R7]
	TEQNE	R0,#0
	LDRNE	R0,[R0,#64]
	TEQNE	R0,#0
	BEQ	L2
	MOV	R5,#0
	LDR	R6,D1
L1	LDR	R2,[R6,R5,LSL #2]
	LDR	R0,[R7]
	LDR	R0,[R0,#64]
	MOV	R3,#0
	MOV	R1,#0
	BL	0x01A010E0
	ADD	R5,R5,#1
	CMP	R5,#7
	BLT	L1
L2	LDR	R5,[R4]
	MOV	R0,R4
	BL	0x01BC31BC
	MOV	R0,R5
	LDMEA	R11,{R4-R7,R11,sp,PC}
D0	DCD	0x0C101B20
D1	DCD	D21

L01C1109C
	MOV	R12,sp
	STMFD	sp!,{R4-R8,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	MOV	R5,R1
	ANDS	R7,R2,#255
	BNE	L3
	MOV	R6,#0
	LDR	R8,D1
L4	LDR	R0,[R8,R6,LSL #2]
	MOV	R1,R4
	BL	0x01BB5AA8
	TEQ	R0,#0
	MOVEQ	R7,#1
	BEQ	L3
	ADD	R6,R6,#1
	CMP	R6,#7
	BLT	L4
L3	MOV	R2,R7
	MOV	R1,R5
	MOV	R0,R4
	LDMEA	R11,{R4-R8,R11,sp,LR}
	B	0x001F4BCC

D22	DCB	"cr",0,0
D23	DCB	"dr",0,0
D24	DCB	"ln",0,0
D25	DCB	"mt",0,0
D26	DCB	"pl",0,0
D27	DCB	"st",0,0
D28	DCB	"ct",0,0
D21	DCD	D22
	DCD	D23
	DCD	D24
	DCD	D25
	DCD	D26
	DCD	D27
	DCD	D28

L01C11130
	MOV	R12,sp
	STMFD	sp!,{R0,R1,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R1,#0
	BL	0x01A48414
L5	LDMEA	R11,{R0,R1,R11,sp,LR}

L01C11148
	B	0x01BE10B4

L01C1114C
	MOV	R12,sp
	STMFD	sp!,{R0,R1,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R1,#0
	BL	0x01B8739C
	B	L5

L01C11164
	MOV	R12,sp
	STMFD	sp!,{R0,R1,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R1,#0
	BL	0x01B88418
	B	L5

L01C1117C
	LDR	R12,D3

L01C11180
	CMP	R12,R1
	LDREQ	R1,D4
	BEQ	L6
	LDR	R12,D5
	CMP	R12,R1
	LDREQ	R1,D6
	BEQ	L6
	LDR	R12,D7
	CMP	R12,R1
	LDREQ	R1,D8
	BEQ	L6
	LDR	R12,D9
	CMP	R12,R1
	LDREQ	R1,D10
	BNE	0x002AC018
L6	MOV	R12,sp
	STMFD	sp!,{R4-R7,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	MOV	R6,R2
	MOV	R5,R3
	MOV	R7,R1
	BL	0x01BE2140
	CMP	R0,#0
	BNE	L7
	LDR	R0,D2
	LDR	R0,[R0]
	MOV	R2,#0
	MOV	R1,#233
	SUB	R1,R1,#0x00002800
	BL	0x01BE319C
L7	MOV	R3,R5
	MOV	R2,R6
	MOV	R1,R7
	LDMEA	R11,{R4-R7,R11,sp,LR}
	B	0x01C02114
D2	DCD	0x00371318
D3	DCD	0x002CF354
D4	DCD	L01C11130
D5	DCD	0x01A4C62C
D6	DCD	L01C11148
D7	DCD	0x01B9EF28
D8	DCD	L01C1114C
D9	DCD	0x01B9CE5C
D10	DCD	L01C11164

L01C11234
	MOV	R12,sp
	STMFD	sp!,{R4,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	LDR	R1,[R0,#148]
	LDR	R2,[R0,#144]
	LDR	R0,[R0,#152]
	CMP	R1,#0
	BLT	L8
	CMP	R1,#0x00280000
	BGT	L8
	CMP	R0,#0
	BLT	L8
	CMP	R0,#0x00280000
	BLE	L9
L8	MOV	R0,#0
	STR	R0,[R4,#48]
	MOV	R0,R4
	MOV	R1,#60
	LDMEA	R11,{R4,R11,sp,LR}
	B	0x01AEE778
L9	CMP	R2,#0x00068000
	BGT	0x0005925C
	B	0x00059230

L01C11294
	MOV	R12,sp
	STMFD	sp!,{R4-R7,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	LDR	R5,[R0,#152]
	ADD	R7,R0,#144
	LDMFD	R7,{R6,R7}
	BL	0x01BD4A20
	CMP	R5,R7
	SUBLE	R7,R7,R5
	SUBGT	R7,R5,R7
	MOV	R1,#1
	CMP	R5,#0x003C0000
	BGT	0x00059314
	CMP	R7,#0x000F0000
	BGE	0x00059314
	LDR	R2,[R4,#52]
	CMP	R2,R0
	BLS	0x00059314
	LDR	R0,[R4,#56]
	SUB	R0,R7,R0
	CMP	R0,#0x00010000
	BGE	0x00059314
	CMP	R6,#0x00040000
	BLT	0x000592F0
	CMP	R6,#0x00068000
	BGT	0x000592F0

L01C11300
	B	0x000592E4

L01C11304
	LDR	R12,D11
	CMP	R12,LR
	BNE	0x001941B0
	CMP	R5,#1
	BEQ	0x001941B0
	CMP	R5,#9
	BGE	0x001941B0
	LDR	R12,D12
	MOV	R0,#0
	STR	R0,[R12]
	LDR	R0,[R11,#4]
	LDR	R12,[R0,#16]
	TST	R12,#0x08000000
	BNE	L11
	MOV	R1,#1
	MOV	R0,R1,LSL R5
	BL	0x01BE2140
	MOVS	R4,R0
	BNE	L10
	LDR	R0,[sp,#60]
	BL	0x01BE10B4
	LDMEA	R11,{R4-R11,sp,PC}
	
L10	LDR	R12,D12
	STR	R4,[R12]
	MOV	R0,#1
	MOV	R1,R0,LSL R5
	MOV	R0,#0
	MOV	R12,R4
L12	STRB	R0,[R12],#1
	ADD	R0,R0,#1
	CMP	R0,R1
	BLT	L12
L11	B	0x00158E80
D11	DCD	0x00158DC0
D12	DCD	0x0C1064E4

L01C11390
	STMFD	sp!,{LR}
	BL	0x0015896C
	LDR	R12,D12
	LDR	R0,[R12]
	CMP	R0,#0
	BEQ	L13
	BL	0x01BE10B4
	LDR	R12,D12
	MOV	R0,#0
	STR	R0,[R12]
L13	LDMFD	sp!,{PC}
L14	MOV	R12,sp
	STMFD	sp!,{R4-R6,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	SUB	sp,sp,#8
	MOV	R0,#2
	BL	0x01BC214C
	STR	R0,[sp]
	MOV	R1,sp
	MOV	R0,R4
	BL	0x01AB7BF0
	BL	0x01BC214C
	STR	R0,[sp,#4]
	LDR	R0,[sp]
	BL	0x01BC31BC
	MOV	R0,R4
	BL	0x01AC10FC
	MOV	R6,R0
	MOV	R0,R4
	BL	0x01ABBDA4
	ADD	R2,sp,#4
	LDR	R1,D13
	MOV	R0,R4
	BL	0x01AAA554
	BL	0x01BC214C
	MOV	R5,R0
	TEQ	R6,#0
	MOVNE	R0,R4
	BLNE	0x01ABBDDC
	B	0x0009298C
D13	DCD	0x006829D8

L01C11438
	MOV	R12,sp
	STMFD	sp!,{R4,R11,R12,LR,PC}
	SUB	R11,R12,#4
	LDR	R1,[R0,#68]
	LDR	R12,D14
	TEQ	R1,R12
	MOVNE	R1,#0
	MOVEQ	R1,#1
	ANDS	R4,R1,#255
	BLNE	L14
	MOV	R0,R4
	LDMEA	R11,{R4,R11,sp,PC}
D14	DCB	"dslp"

L01C1146C
	MOV	R12,sp
	STMFD	sp!,{R4-R8,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	MOV	R5,R1
	MOV	R1,R0
	LDR	R6,D15
	LDR	R0,[R6]
	BL	0x01A8E77C
	MOV	R7,R0
	MOV	R1,R4
	LDR	R0,[R6]
	BL	0x01A8F7CC
	MOV	R6,R0
	LDR	R0,[R5]
	LDR	R0,[R0]
	TST	R0,#3
	MOVEQ	R0,R0,ASR #2
	BEQ	L15
	BL	0x01BC211C
L15	MOV	R8,#26
	TEQ	R0,#0
	BEQ	L16
	LDR	R0,[R5]
	LDR	R0,[R0]
	TST	R0,#3
	MOVEQ	R0,R0,ASR #2
	BEQ	L17
	BL	0x01BC211C
L17	ADD	R6,R0,R6
	CMP	R6,R7
	BHI	L18
	CMP	R6,#1
	BCS	L16
L18	MOV	R0,#30
	BL	0x01AA52F8
	B	L19
D15	DCD	0x0C1010D0

L16
	MOV	R1,R6
	MOV	R0,R4
	BL	0x01ACB5F8
L19	MOV	R0,R8
	LDMEA	R11,{R4-R8,R11,sp,PC}

L01C11518
	ObjectHeader (L01C115C0-{PC}), kBinaryObject
	PointerRef 0x00535F6C
	DCD	0x7C22C700
	DCD	0x11A70008
	DCD	0x5F00507F
	DCD	0x000824C2
	DCD	0xA7000727
	DCD	0x043F7F00
	DCD	0x07916F00
	DCD	0x2427001A
	DCD	0xA65F004C
	DCD	0x7F000718
	DCD	0xC46F0033
	DCD	0x27001AA5
	DCD	0x5F004C19
	DCD	0x287F0007
	DCD	0x91A70009
	DCD	0x7F00096F
	DCD	0x004C7F00
	DCD	0x091A3800
	DCD	0x27001AA6
	DCD	0x7F000805
	DCD	0x7F000806
	DCD	0x6F000B22
	DCD	0x22A70008
	DCD	0x007EC56F
	DCD	0x00817D6F
	DCD	0x00791B27
	DCD	0x001A1C2A
	DCD	0xC56F0076
	DCD	0x1D7B221E
	DCD	0x2B005F00
	DCD	0x811F0007
	DCD	0x7B221E2B
	DCD	0x00770008
	DCD	0x1F000991
	DCD	0x77000A7B
	DCD	0x1F000B1F
	DCD	0x000C8A1F
	DCD	0x000C8A1F
	DCD	0x000D2A02

L01C115C0
	ObjectHeader (L01C115D4-{PC}), kFrameObject
	PointerRef L01C115D4
	PointerRef 0x0064734C
	PointerRef L01C115EC

L01C115D4
	ObjectHeader (L01C115EC-{PC}), kArrayObject
	IntegerRef 4
	NILRef
	PointerRef 0x003BB31C
	PointerRef 0x003C28F0

L01C115EC
	FnObject L01C11518, L01C1160C, 5, 2

L01C1160C
	ObjectHeader (L01C11650-{PC}), kArrayObject
	PointerRef 0x00629434
	PointerRef 0x00496FB4
	PointerRef 0x003B420C
	PointerRef 0x00418F04
	PointerRef 0x003BC664
	PointerRef 0x003B0A80
	PointerRef 0x00497004
	PointerRef 0x003B1994
	PointerRef 0x0056A930
	PointerRef 0x003B0080
	PointerRef 0x003B18A0
	PointerRef 0x003C63D0
	PointerRef 0x0056A95C
	PointerRef 0x003B0038
	PointerRef 0x003B0EE4

L01C11650
	MOV	R12,sp
	STMFD	sp!,{R0-R3}
	STMFD	sp!,{R4-R12,LR,PC}
	SUB	R11,R12,#20
	MOV	R4,R0
	MOV	R5,R3
	LDR	R0,[R11,#20]
	AND	R0,R0,#255
	STR	R0,[sp,#-16]!
	LDR	R0,[R3,#8]
	LDR	R7,D20
	MOV	R10,#0

L01C11680
	TEQ	R0,#53
	BNE	L20
	LDR	R0,[R5,#16]
	LDR	R1,[R7,R0,LSL #2]
	LDR	R1,[R1,#48]
	TEQ	R1,#0
	BNE	L20
	MOV	R3,#0
	STMFD	sp!,{R3}
	MOV	R3,R0
	MOV	R1,R5
	MOV	R0,R4
	MOV	R2,#2
	BL	0x01B38C04
	ADD	sp,sp,#4
	MOV	R0,R10
	B	0x00053780
D20	DCD	0x0C105FE4
	
L20	MOV	R8,#0
	SUB	sp,sp,#28
	ADD	R1,R4,#0x0000020C
	ADD	R1,R1,#0x00001800
	MOV	R7,R1
	B	0x00052E48
	
	MOV	R12,sp
	STMFD	sp!,{R4,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R1
	LDR	R0,[R1,#260]
	TEQ	R0,#100
	LDMNEEA	R11,{R4,R11,sp,PC}
	SUB	sp,sp,#8
	LDR	R0,D16
	MOV	R1,R0
	LDR	R0,[R0,#36]
	LDR	R1,[R1,#32]
	LDR	R0,[R0]
	ADD	R0,R1,R0
	ADD	R0,R0,#2
	MOV	R2,#6
	MOV	R1,sp
	BL	0x01BDEF54
	LDR	R0,[sp]
	LDR	R12,D17
	TEQ	R0,R12
	BNE	L21
	LDRB	R0,[sp,#5]
	TEQ	R0,#20
	MOVEQ	R0,#0x00000234
	ADDEQ	R0,R0,#0x00001000
	BEQ	L22
	LDRB	R0,[sp,#5]
	TEQ	R0,#21
	BNE	L21
	MOV	R0,#0
L22	STR	R0,[R4,#264]!
L21	LDMEA	R11,{R4,R11,sp,PC}
D16	DCD	0x0C107D88
D17	DCB	"dPro"

L01C1176C
	MOV	R12,sp
	STMFD	sp!,{R4,R5,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R4,R0
	MOV	R5,#0
	LDR	R0,[R0]
	TEQ	R0,#0
	BEQ	L23
	MOV	R0,R4
	BL	0x01BAC60C
	MOV	R0,#1
	STRB	R0,[R4,#12]
L25	LDR	R0,[R4]
	TEQ	R0,#0
	BEQ	L24
	LDR	R1,[R4]
	LDR	R0,[R1,#12]
	CMP	R0,#4
	BHI	L24
	MOV	R0,R4
	MOV	R2,#0
	BL	0x01BAC674
	LDR	R1,[R0]
	MOV	LR,PC
	ADD	PC,R1,#4
	LDR	R0,[R4]
	TEQ	R0,#0
	BNE	L25
L24	MOV	R0,#0
	STRB	R0,[R4,#12]
	LDR	R0,[R4]
	TEQ	R0,#0
	LDRNE	R5,[R0,#12]!
L23	MOV	R0,R5
	LDMEA	R11,{R4,R5,R11,sp,PC}

L01C117F8
	MOV	R12,sp
	STMFD	sp!,{R4,R5,R11,R12,LR,PC}
	SUB	R11,R12,#4
	MOV	R5,R0
	BL	0x01A452FC
	MOV	R4,R0
	MOV	R0,R5
	MOV	R1,#0
	BL	0x01A46300
	TEQ	R4,#0
	LDMEQEA	R11,{R4,R5,R11,sp,PC}
	LDR	R0,[R4,#124]
	BL	0x01B139F4
	TEQ	R0,#0
	LDREQ	R1,[R5,#4]!
	LDREQ	R0,[R4,#124]!
	LDMEQEA	R11,{R4,R5,R11,sp,LR}
	BEQ	0x01B0B5DC
	LDR	R0,[R4,#148]
	TEQ	R0,#0
	BEQ	L26
	LDR	R1,[R5,#4]
	BL	0x01A494A8
	TEQ	R0,#0
	LDRNE	R0,[R4,#148]
	LDRNE	R1,[R5,#4]
	BLNE	0x01A48464
L26	LDR	R1,[R5,#4]
	LDR	R0,[R4,#124]!
	BL	0x01B0B5DC
	MOV	R0,R5
	LDMEA	R11,{R4,R5,R11,sp,LR}
	B	0x01A610A0

L01C1187C
	ObjectHeader 0x14, kFrameObject
	PointerRef L01C11890
	PointerRef 0x006454B8
	PointerRef L01C118A8

L01C11890
	ObjectHeader 0x18, kArrayObject
	IntegerRef 4
	NILRef
	PointerRef 0x003BB31C
	PointerRef 0x003C2728

L01C118A8
	FnObject L01C118C8, L01C118E8, 0, 0

L01C118C8
	ObjectHeader 0x20, kBinaryObject
	PointerRef 0x00535F6C
	DCD	0x706F000B
	DCD	0x701929C5
	DCD	0x5F000C22
	DCD	0x6F001122
	DCD	0xA81A4802

L01C118E8
	ObjectHeader 0x18, kArrayObject
	PointerRef 0x00629434
	PointerRef 0x0049C968
	PointerRef 0x003B2C48
	PointerRef 0x003C2728

L01C11900
	ObjectHeader 0x14, kFrameObject
	PointerRef 0x01C11914
	PointerRef 0x00646770
	PointerRef 0x01C1192C

L01C11914
	ObjectHeader 0x18, kArrayObject
	IntegerRef 4
	NILRef
	PointerRef 0x003BB31C
	PointerRef 0x003C2750

L01C1192C
	FnObject L01C1194C, L01C11968, 0, 0
L01C1194C
	ObjectHeader (fnEnd-{PC}), kBinaryObject
	PointerRef 0x00535F6C
	DCD	0x70C70018
	DCD	0x19C66F00
	DCB	0x0B,0x22,0xAA,0x1B
	DCB	0x50
	Return
fnEnd
	BinaryFiller 0xBA

L01C11968
	ObjectHeader (L01C11984-{PC}), kArrayObject
	PointerRef 0x00629434
	PointerRef 0x0045DF94
	PointerRef 0x003BBC44
	PointerRef 0x0045ECEC
	PointerRef 0x003C2750

L01C11984
	LDR	R12,D18
	CMP	R12,LR
	BNE	0x0003F614
	BL	0x0003F614
	LDR	R5,[sp,#140]
	LDR	R0,[R5,#16]
	AND	R0,R0,#255
	TEQ	R0,#1
	BNE	L27
	STR	R9,[sp,#-108]!
	ADD	R0,sp,#8
	BL	0x01BB2974
	TEQ	R0,#0
	BNE	L28
	MOV	R0,sp
	BL	0x01BE007C
	LDR	R0,[R5,#16]
	ORR	R0,R0,#0x01000000
	STR	R0,[R5,#16]
	B	L29
L28	LDR	R0,[sp,#96]
	LDR	R1,D19
	LDR	R1,[R1]
	BL	0x01BE3194
	TEQ	R0,#0
	MOVEQ	R0,sp
	BLEQ	0x01BE2154
	MOV	R0,sp
L29	BL	0x01BE10B8
	ADD	sp,sp,#108
L27	B	0x0003EDC8

L01C11A00
D18	DCD	0x0003EDB0
D19	DCD	0x003712B4

	FILL 382,0xDEADC0DE
	END
