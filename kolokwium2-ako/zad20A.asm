.686
.model flat
extern _GetSystemInfo@4 : PROC
public _liczba_procesorow

.data
.code
_liczba_procesorow PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, [ebp+8]
	push esi
	call _GetSystemInfo@4
	mov eax, [esi+32]

	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_liczba_procesorow ENDP
END