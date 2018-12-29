.686
.model flat
public _pole_kola

.data
.code
_pole_kola PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp + 8]
	finit
	fldpi
	fld dword PTR [esi]
	fmul st(0), st(0)
	fmulp st(1), st(0)
	fst dword PTR [esi]
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_pole_kola ENDP
END