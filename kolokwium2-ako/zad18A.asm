.686
.model flat
public _NWD

.data
.code
_NWD PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp+8]	; a
	mov edi, [ebp+12]	; b

	cmp esi, edi
	jz rowne

	cmp esi, edi
	ja wieksze_a

	sub edi, esi
	push edi
	push esi
	call _NWD
	add esp, 8	; zwalnianie pamieci zgodnie ze standardem C
	jmp koniec
wieksze_a:
	sub esi, edi
	push edi
	push esi
	call _NWD
	add esp, 8
	jmp koniec
rowne:
	mov eax, esi	; wyn=a
koniec:
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_NWD ENDP
END