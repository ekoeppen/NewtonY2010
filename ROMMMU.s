;
;
;	ROMMMU.s
;	From address 0x01D80000
;	From the MP2100 ROM 717260
;
;	Author		Jonathan Kipling Knight
;	Created		12/17/2000
;	Modified	12/23/2000 Match Exactly with 717260 (Kip)
;
;

	INCLUDE page.a
	
	AREA ROMMMU, CODE

; patches of 0x2000
	DontLoadPages 22	; 0x01A00000 - 0x01A15000
	LoadPage 2			; 0x01A16000
	DontLoadPages 9		; 0x01A17000 - 0x01A1F000

; patches of 0x3000
	DontLoadPages 11	; 0x01A20000 - 0x01A2A000
	LoadPage 2			; 0x01A2B000
	LoadPage 3			; 0x01A2C000
	DontLoadPages 1		; 0x01A2D000
	LoadPage 2			; 0x01A2E000
	LoadPage 3			; 0x01A2F000
	DontLoadPages 16	; 0x01A30000 - 0x01A3F000

; patches of 0x4000
	DontLoadPages 2		; 0x01A40000 - 0x01A41000
	LoadPage 3			; 0x01A42000
	DontLoadPages 3		; 0x01A43000 - 0x01A45000
	LoadPage 2			; 0x01A46000
	DontLoadPages 14	; 0x01A47000 - 0x01A54000
	LoadPage 2			; 0x01A55000
	DontLoadPages 1		; 0x01A56000
	LoadPage 2			; 0x01A57000
	DontLoadPages 8		; 0x01A58000 - 0x01A5F000

; patches of 0x5000
	DontLoadPages 1		; 0x01A60000
	LoadPage 3			; 0x01A61000
	DontLoadPages 3		; 0x01A62000 - 0x01A64000
	LoadPage 2			; 0x01A65000
; Change start for InitCirrusHW
;	DontLoadPages 6		; 0x01A66000 - 0x01A6B000
	DontLoadPages 4		; 0x01A66000 - 0x01A69000
	LoadPage 8		    ; 0x01A6A000
; Change end	
	DontLoadPages 1		; 0x01A6B000
	LoadPage 4			; 0x01A6C000
	DontLoadPages 12	; 0x01A6E000 - 0x01A78000
	LoadPage 3			; 0x01A79000
	LoadPage 3			; 0x01A7A000
	DontLoadPages 5		; 0x01A7B000 - 0x01A7F000

; patches of 0x6000
	DontLoadPages 12	; 0x01A80000 - 0x01A8B000
	LoadPage 5			; 0x01A8C000

; Change start for InitScriptGlobals
;	DontLoadPages 15	; 0x01A8D000 - 0x01A9B000
	DontLoadPages 12	; 0x01A8D000 - 0x01A98000
	LoadPage 8			; 0x01A99000
	DontLoadPages 2		; 0x01A9A000 - 0x01A9B000
; Change end

	LoadPage 2			; 0x01A9C000
	DontLoadPages 3		; 0x01A9D000 - 0x01A9F000

; patches of 0x7000
	DontLoadPages 5		; 0x01AA0000 - 0x01AA4000
	LoadPage 3			; 0x01AA5000
	DontLoadPages 4		; 0x01AA6000 - 0x01AA9000
	LoadPage 2			; 0x01AAA000
	DontLoadPages 18	; 0x01AAB000 - 0x01ABC000
	LoadPage 2			; 0x01ABD000
	DontLoadPages 2		; 0x01ABE000 - 0x01ABF000

; patches of 0x8000

; Change start for FDateFromSeconds and FSetTimeInSeconds
;	DontLoadPages 14	; 0x01AC0000 - 0x01ACD000
	LoadPage 8			; 0x01AC0000
	LoadPage 8			; 0x01AC1000
	DontLoadPages 12	; 0x01AC2000 - 0x01ACD000
; Change end

	LoadPage 3			; 0x01ACE000
	DontLoadPages 1		; 0x01ACF000
	LoadPage 3			; 0x01AD0000

; Change start for FSetSysAlarm and FTimeInSeconds
;	DontLoadPages 14	; 0x01AD1000 - 0x01ADE000
	DontLoadPages 9		; 0x01AD1000 - 0x01AD9000
	LoadPage 8			; 0x01ADA000
	LoadPage 8			; 0x01ADB000
	DontLoadPages 3		; 0x01ADC000 - 0x01ADE000
; Change end

	LoadPage 2			; 0x01ADF000

; patches of 0x9000
	LoadPage 3			; 0x01AE0000
	LoadPage 4			; 0x01AE1000
	LoadPage 4			; 0x01AE2000
	DontLoadPages 11	; 0x01AE3000 - 0x01AED000
	LoadPage 4			; 0x01AEE000
	DontLoadPages 17	; 0x01AEF000 - 0x01AFF000

; patches of 0xA000
	DontLoadPages 3		; 0x01B00000 - 0x01B02000
	LoadPage 2			; 0x01B03000
	LoadPage 3			; 0x01B04000
	DontLoadPages 14	; 0x01B05000 - 0x01B12000
	LoadPage 2			; 0x01B13000
	DontLoadPages 1		; 0x01B14000
	LoadPage 3			; 0x01B15000
	LoadPage 3			; 0x01B16000
	DontLoadPages 9		; 0x01B17000 - 0x01B1F000

; patches of 0xB000
	DontLoadPages 8		; 0x01B20000 - 0x01B27000
	LoadPage 2			; 0x01B28000
	DontLoadPages 13	; 0x01B29000 - 0x01B35000
	LoadPage 4			; 0x01B36000
	DontLoadPages 4		; 0x01B37000 - 0x01B3A000
	LoadPage 2			; 0x01B3B000
	DontLoadPages 4		; 0x01B3C000 - 0x01B3F000

; patches of 0xC000
	LoadPage 4			; 0x01B40000
	DontLoadPages 2		; 0x01B41000 - 0x01B42000
	LoadPage 3			; 0x01B43000
	DontLoadPages 2		; 0x01B44000 - 0x01B45000
	LoadPage 3			; 0x01B46000
	DontLoadPages 2		; 0x01B47000 - 0x01B48000
	LoadPage 3			; 0x01B49000
	LoadPage 3			; 0x01B4A000
	DontLoadPages 5		; 0x01B4B000 - 0x01B4F000
	LoadPage 4			; 0x01B50000
	LoadPage 2			; 0x01B51000
	DontLoadPages 3		; 0x01B52000 - 0x01B54000
	LoadPage 4			; 0x01B55000
	DontLoadPages 2		; 0x01B56000 - 0x01B57000
	LoadPage 2			; 0x01B58000
	LoadPage 4			; 0x01B59000
	DontLoadPages 6		; 0x01B5A000 - 0x01B5F000

; patches of 0xD000
	DontLoadPages 32	; 0x01B60000 - 0x01B7F000

; patches of 0xE000
	DontLoadPages 14	; 0x01B80000 - 0x01B8D000
	LoadPage 5			; 0x01B8E000
	DontLoadPages 2		; 0x01B8F000 - 0x01B90000
	LoadPage 3			; 0x01B91000
	DontLoadPages 14	; 0x01B92000 - 0x01B9F000

; patches of 0xF000
	DontLoadPages 12	; 0x01BA0000 - 0x01BAB000
	LoadPage 6			; 0x01BAC000
	DontLoadPages 5		; 0x01BAD000 - 0x01BB1000
	LoadPage 2			; 0x01BB2000
	DontLoadPages 13	; 0x01BB3000 - 0x01BBF000

; patches of 0x10000
	DontLoadPages 4		; 0x01BC0000 - 0x01BC3000
	LoadPage 4			; 0x01BC4000
	DontLoadPages 14	; 0x01BC5000 - 0x01BD2000
	LoadPage 3			; 0x01BD3000
	DontLoadPages 7		; 0x01BD4000 - 0x01BDA000
	LoadPage 3			; 0x01BDB000
	DontLoadPages 2		; 0x01BDC000 - 0x01BDD000
	LoadPage 2			; 0x01BDE000
	DontLoadPages 1		; 0x01BDF000

; patches of 0x11000
	DontLoadPages 15	; 0x01BE0000 - 0x01BEE000
	LoadPage 4			; 0x01BEF000
; Change start for FTime
	DontLoadPages 16	; 0x01BF0000 - 0x01BFF000
;	DontLoadPages 2		; 0x01BF0000 - 0x01BF1000
;	LoadPage 8			; 0x01BF2000
;	DontLoadPages 13	; 0x01BF3000 - 0x01BFF000
; Change end

; patches of 0x12000
	DontLoadPages 8		; 0x01C00000 - 0x01BFF000
	LoadPage 3			; 0x01BEF000
	DontLoadPages 6		; 0x01BF0000 - 0x01BFF000
	LoadPage 5			; 0x01BEF000
	LoadPage 5			; 0x01BEF000
	LoadPage 7			; 0x01BEF000
	DontLoadPages 14	; 0x01BF0000 - 0x01C1F000

; patches of nothing
	DontLoadPages 352	; 0x01C20000 - 0x01D7F000
	
; patches of Magic Pointer Table 0 (0x3AF000)
	LoadPage 2			; 0x01D80000
	LoadPage 2			; 0x01D81000
	LoadPage 2			; 0x01D82000
	DontLoadPages 1		; 0x01D83000
	LoadPage 2			; 0x01D84000
	DontLoadPages 4		; 0x01D85000 - 0x01D88000
	LoadPage 2			; 0x01D89000
	DontLoadPages 2		; 0x01D8A000 - 0x01D8B000
	LoadPage 2			; 0x01D8C000
	DontLoadPages 2		; 0x01D8D000 - 0x01D8E000
	LoadPage 2			; 0x01D8F000
	LoadPage 2			; 0x01D90000
	DontLoadPages 8		; 0x01D91000 - 0x01D98000
	LoadPage 2			; 0x01D99000
	LoadPage 2			; 0x01D9A000
	DontLoadPages 5		; 0x01D9B000 - 0x01D9F000

; map in patch pages at 0x01DA00000
	LoadPage 8			; 0x01DA0000

	DontLoadPages 1119	; 0x01DA8000 - 0x021FF000

; original code

; patches of nothing
;	DontLoadPages 1120	; 0x01DA0000 - 0x021FF000

	END