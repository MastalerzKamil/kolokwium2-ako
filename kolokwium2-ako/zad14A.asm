.686
.model flat
;public _main
extern _ExitProcess@4 : PROC

.data
test_float			dd 12.25
mantysa				dd 0
double_wykladnik	dw 0
znak				dw 0
liczba_double		dw 4 dup (?)
.code
; _main PROC
	mov esi, offset test_float
	mov edi, offset liczba_double
	mov edx, [esi]
	bt edx, 31
	jnc dodatnia
	mov znak, 8000h	; ustaw bit znaku jako ujemny (najstarszy bit jako 1)
dodatnia:
	mov eax, [esi]
	shl eax, 1 ; wymazanie znaku z edi
	shr eax, 24 ; wymazanie mantysy z edi
	sub eax, 127	; wyciagniecie przesuniecia
	add eax, 1023	; stworz wykladnik double
	mov double_wykladnik, ax
; tworzenie mantysy i zapisanie mantysy
	mov [edi], word ptr 0	; castowanie do double powoduje dodanie zer na najmlodszych 2 najmlodszych bajtach
	mov eax, [esi]
	shl eax, 9	; wymazanie wykladnika i znaku z zrodlowej liczby
	;shr eax, 9	; cofam aby odpowiednio mantyse do pamieci zapisac
	mov dword PTR mantysa, eax
	shl eax, 4	; przesun o 4 bity w lewo w celu nie zapisania bitow ktore beda w slowie z wykladnikiem
	mov [edi+2], eax	; zapisz mantyse ktora sie nie zmienia
	mov edx, dword PTR mantysa
	shr edx, 28	; pozbycie sie zapisanych juz bitow w mantysie
	mov ax,  double_wykladnik
	shl ax, 4	; zrobienie miejsca na posostalosci z mantysy
	or ax, dx	; polaczenie wykladnika i posotalosci mantysy
	mov [edi+6], ax
	push 0
	call _ExitProcess@4
;_main ENDP
END