; float plus_jeden(float a);
; funkcja zwi�ksza o 1 warto�� argumentu
; i mo�e by� stosowana tylko dla argument�w dodatnich;
; argument a nie jest warto�ci� specjaln�

.686
.model flat

public _plus_jeden_float

.code

_plus_jeden_float PROC
	push	ebp
	mov		ebp, esp
	push	ebx
	mov		eax, [ebp+8]		; argument funkcji
	mov		ebx, eax			; kopia argumentu
	rol		ebx, 9				; wpisanie wyk�adnika do BL

; przypadek szczeg�lny: gdy wyk�adnik > 150, dodanie 1 nie zmienia
; warto�ci liczby � w tym przypadku argument funkcji odczytany ze
; stosu [ebp+8] stanowi wynik (w dalszej cz�ci zawarto�� EAX zostanie
; skopiowana na wierzcho�ek stosu koprocesora)
	cmp		bl, 150
	ja		koniec ; skok, gdy wyk�adnik > 150

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; wyodr�bnienie bit�w i przywr�cenie niejawnego bitu mantysy
	and		eax, 7FFFFFH
	or		eax, 800000H

; liczba 1
	mov		edx, 1

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; sprawdzenie czy umowna kropka znajduje si� w�r�d bit�w mantysy
	cmp		bl, 127
	jae		jedynka_w_lewo		; skok gdy wyk�adnik >= 127

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; przypadek, gdy wyk�adnik < 127
; je�li wyk�adnik jest mniejszy lub r�wny 126, to ca�a liczba
; zmiennoprzecinkowa jest na pewno mniejsza od 1 - zatem wynik dodawania
; b�dzie liczb� zawarty w przedziale <1, 2) - b�dzie to wi�c liczba
; znormalizowana
; w omawianym przypadku umowna kropka znajduje si� na lewo od bit�w
; mantysy w celu wykonania dodawania trzeba przesun�� mantys� w prawo
; tak by umowna kropka znalaz�a si� mi�dzy bitami 23 i 22
; do uzyskanej w ten spos�b warto�ci nale�y doda� mantys� liczby 1
; (w tej liczbie umowna kropka znajduje si� tak�e mi�dzy bitami 23 i 22)
; liczba przesuni�� mantysy w prawo wynosi (127 - wykladnik)
; je�li warto�� tej r�nicy jest wi�ksza lub r�wna 25, to w wyniku
; przesuni�cia w prawo wszystkie bity mantysy zostan�
; usuni�te - wynik ko�cowy b�dzie = 1
	cmp		bl, 102
	ja		przesun_w_prawo		; skok, gdy wyk�adnik > 102
	mov		eax, 3F800000H		; liczba 1 w formacie float
	jmp		koniec

przesun_w_prawo:
	mov		cl, 127
	sub		cl, bl
	shr		eax, cl			; przesuni�cie mantysy w prawo tak, by umowna
							; kropka znalaz�a si� mi�dzy bitami 23 i 22
							; uwaga tylko 5 ostatnich bit�w CL okre�la
							; liczb� przesuni��
	mov		bl, 127			; aktualny wyk�adnik (zob. opis wy�ej)

	adc		eax, 0			; zaokr�glenie
; w tym przypadku dodawanie 1 do bitu o wadze 2^0 jest zb�dne,
; poniewa� bit nie ten wyst�puje w postaci jawnej
; add eax, 00800000: ; dodanie 1 na bicie mantysy o wadze 2^0
	jmp		dalej

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; przesuni�cie w lewo "1" w EDX

jedynka_w_lewo:
	mov		cl, 150
	sub		cl, bl
	shl		edx, cl
	add		eax, edx		; dodanie liczby 1 do mantysy

	; sprawdzenie, czy w wyniku dodawania mantysa < 2
	bt		eax, 24
	jnc		dalej		; skok, gdy mantysa < 2 (war. normalizacji spe�niony)
	shr		eax, 1		; normalizacja mantysy
	adc		eax, 0		; zaokr�glenie
	add		bl, 1		; korekcja wyk�adnika

; -----------------------------------------
; odtworzenie postaci zmiennoprzecinkowej liczby

dalej:
	and		eax, 7FFFFFH	; pozostaj� tylko bity mantysy o wagach u�amkowych
	and		ebx, 0FFH
	ror		ebx, 9			; przesuni�cie wyk�adnika na bity 30 - 23
	or		eax, ebx ; z�o�enie mantysy i wyk�adnika

koniec:
	push	eax
	fld		dword PTR [esp]		; wpisanie wyniku na wierzcho�ek
								; stosu koprocesora
	add		esp, 4				; usuni�cie obliczonej warto�ci ze stosu
	
	pop		ebx
	pop		ebp
	ret
_plus_jeden_float ENDP

END