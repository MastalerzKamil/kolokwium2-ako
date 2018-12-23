.686
.model flat
public _kwadrat
.data
cztery	dw 4
.code

_kwadrat PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	push edx

	mov esi, [ebp+8]	; a
	cmp esi, 0
	jz zero
	cmp esi, 1
	jz jeden
	mov ebx, esi ; ebx to kopia a
	sub ebx, 2	; odejmij aby argumentem kfunkcji kwadsrat bylo a-1
	push ebx
	call _kwadrat
	add esp, 4
	mov edx, 0	; zeruj starsza czesc
	lea eax, [4*esi]
	add eax, ebx ; kwadrat(a-2) + 4*kwadrat(a)
	sub eax, 4 ; kwadrat(a-2) + 4*kwadrat(a) - 4
	jmp koniec
jeden:
	mov eax, 1
	jmp koniec
zero:
	mov eax, 0
koniec:
	pop edx
	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_kwadrat ENDP
END
