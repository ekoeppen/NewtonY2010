;
;
;	ROMStrmHead.s
;
;	Author		Jonathan Kipling Knight
;	Created		12/26/2000
;	Modified	12/26/2000
;
;

	INCLUDE stream.a

	AREA ROMStrmHead, CODE
	ENTRY
start	; create Newton Streamed Object Format header
	DCB kNSOFversion		; NSOF version
	DCB kBinaryObjectOp		; binary streamed object
	NSOFSize 0xA000			; size of binary
	NSOFSymbol ("code")		; class of binary

	END