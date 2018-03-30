;
;
;	RExMMU.s
;	From address 0x01E00000
;
;	Author		Jonathan Kipling Knight
;	Created		12/17/2000
;	Modified	12/17/2000
;
;

	INCLUDE package.a
	INCLUDE page.a

	AREA RExMMU, CODE
	ENTRY
	
MMUTable
	LoadPage 1			; 0x01E00000
	DontLoadPages 225	; 0x01E01000 - 0x01EE1000
	LoadPage 1			; 0x01EE2000
	DontLoadPages 797	; 0x01EE3000 - 0x021FF000

	END