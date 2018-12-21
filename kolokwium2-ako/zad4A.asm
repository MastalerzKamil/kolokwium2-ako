.686
.model flat
public _szukaj_elem_min

.data
rozmiar	dd 0
.code
_szukaj_elem_min PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	push ecx

	mov esi, [ebp+8]	; tablica
	mov ecx, [ebp+12]	; n

	mov rozmiar, ecx
	mov ecx, 0
	lea eax, [esi+4*ecx]	; pierwszy element najmniejszy
iteruj:
	push ecx ; zapamietaj iterator z zewnetrznej petli
porownuj:
	inc ecx
	adc ecx, 0
	cmp ecx, rozmiar	; koniec petli wewnetrznej
	jz po_porownaniu
	mov ebx, [esi+4*ecx]
	cmp [eax], ebx
	jbe porownuj	; eax >= 0 wiec wieksze
	lea eax, [esi+4*ecx]
	jmp porownuj
po_porownaniu:
	pop ecx	; przwrocenie iteratora z petli zewnetrznej
	inc ecx
	cmp ecx, rozmiar
	jnz iteruj
	pop ecx
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_szukaj_elem_min ENDP
END