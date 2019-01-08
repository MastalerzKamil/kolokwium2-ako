.686
.model flat
extern _GetSystemInfo@4 : PROC
extern _malloc : PROC
extern _free : PROC
public _liczba_procesorow

.data
.code
_liczba_procesorow PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	push dword PTR 40
	call _malloc
	add esp, 4

	mov esi, eax
	push esi
	call _GetSystemInfo@4	; zapisz danez GetSysemInfo do przydzielonego miejsca przez malloc

	mov eax, dword PTR [esi+24]	; dwNumberProcessors

	pop edi
	pop esi
	pop ebx
	; add esp, 40
	pop ebp
	ret
_liczba_procesorow ENDP
END