org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

	mov ah, 0x0e
	mov bx, OSNAME

labelName:
	mov al, [bx]
	cmp al, 0
	je endName
	int 0x10
	inc bx
	jmp labelName
endName:

jmp $

OSNAME:
	db "DaveOS", ENDL, 0

times 510 - ($ - $$) db 0
dw 0xaa55