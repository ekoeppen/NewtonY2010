;
;
;	RExStrmHead.s
;	From address 0x01E00000
;
;	Author		Jonathan Kipling Knight
;	Created		12/26/2000
;	Modified	12/27/2000
;
;

	INCLUDE stream.a

	AREA RExStrmHead, CODE
	ENTRY
start	; create Newton Streamed Object Format header
	DCB kNSOFversion		; NSOF version
	DCB kBinaryObjectOp		; binary streamed object
	NSOFSize 0x2000			; size of binary
	NSOFSymbol ("code")		; class of binary

	END