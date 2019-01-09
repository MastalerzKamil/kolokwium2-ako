.686
.model flat
public _ASCII_na_UTF16
extern _malloc : PROC
.data
n	dd	0
.code
_ASCII_na_UTF16 PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]	; znaki
	mov ecx, [ebp+12]	; n

	mov eax, ecx
	mov edx, 0
	mov ebx, 2	; aby zaalokowac 2*ecx bajtow
	mul bx	; wynik DX:AX
	shl dx, 16
	or eax, edx	; zlaczenie po mnozeniu do eax
	mov ecx, eax
	push ecx
	call _malloc
	add esp, 4	; zwolnienie pamieci
	mov edi, eax	; zaalokowanie pamieci do edi
	mov ecx, [ebp+12]
	mov n, ecx
	mov ecx, 0
kopiuj:
	mov bl, [esi+ecx]
	mov bh, 0	; w ASCII UTF-16  starszy bajt=0
	mov[edi+2*ecx], bx
	inc ecx
	cmp ecx, n
	jnz kopiuj
	mov [edi+2*ecx], word ptr 0
	mov eax, edi

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_ASCII_na_UTF16 ENDP
END