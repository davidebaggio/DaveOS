org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

jmp short start
nop

bdb_oen:				db 'MSWIN4.1'
bdb_bytes_per_sector:	dw 512
bdb_sector_per_cluster:	db 1
bdb_reserved_sectors:	dw 1
bdb_fat_count:			db 2
bdb_dir_entries_count:	dw 0E0h
bdb_total_sectors:		dw 2880
bdb_media_descriptor:	db 0F0h
bdb_sectors_per_fat:	dw 9
bdb_sectors_per_track:	dw 12
bdb_heads:				dw 2
bdb_hidden_sectors:		dd 0
bdb_large_sector_count:	dd 0

ebr_drive_number:		db 0
						db 0
ebr_signature:			db 29h
ebr_volume_id:			db 12h, 34h, 56h, 78h
ebr_volume_label:		db 'DaveOS     '
ebr_system_id:			db 'FAT12   '



start:
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