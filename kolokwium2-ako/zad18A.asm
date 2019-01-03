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
	jz koniec

	cmp esi, edi
	ja zmniejsz_a

	sub edi, esi
	push edi
	push esi
	call _NWD
	add esp, 8	; zwalnianie pamieci zgodnie ze standardem C
	jmp koniec
zmniejsz_a:
	sub esi, edi
	push edi
	push esi
	call _NWD
	add esp, 8

koniec:
	mov eax, esi	; wyn=a
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_NWD ENDP
END