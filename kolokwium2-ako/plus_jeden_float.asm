; float plus_jeden(float a);
; funkcja zwiêksza o 1 wartoœæ argumentu
; i mo¿e byæ stosowana tylko dla argumentów dodatnich;
; argument a nie jest wartoœci¹ specjaln¹

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
	rol		ebx, 9				; wpisanie wyk³adnika do BL

; przypadek szczególny: gdy wyk³adnik > 150, dodanie 1 nie zmienia
; wartoœci liczby – w tym przypadku argument funkcji odczytany ze
; stosu [ebp+8] stanowi wynik (w dalszej czêœci zawartoœæ EAX zostanie
; skopiowana na wierzcho³ek stosu koprocesora)
	cmp		bl, 150
	ja		koniec ; skok, gdy wyk³adnik > 150

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; wyodrêbnienie bitów i przywrócenie niejawnego bitu mantysy
	and		eax, 7FFFFFH
	or		eax, 800000H

; liczba 1
	mov		edx, 1

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; sprawdzenie czy umowna kropka znajduje siê wœród bitów mantysy
	cmp		bl, 127
	jae		jedynka_w_lewo		; skok gdy wyk³adnik >= 127

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; przypadek, gdy wyk³adnik < 127
; jeœli wyk³adnik jest mniejszy lub równy 126, to ca³a liczba
; zmiennoprzecinkowa jest na pewno mniejsza od 1 - zatem wynik dodawania
; bêdzie liczb¹ zawarty w przedziale <1, 2) - bêdzie to wiêc liczba
; znormalizowana
; w omawianym przypadku umowna kropka znajduje siê na lewo od bitów
; mantysy w celu wykonania dodawania trzeba przesun¹æ mantysê w prawo
; tak by umowna kropka znalaz³a siê miêdzy bitami 23 i 22
; do uzyskanej w ten sposób wartoœci nale¿y dodaæ mantysê liczby 1
; (w tej liczbie umowna kropka znajduje siê tak¿e miêdzy bitami 23 i 22)
; liczba przesuniêæ mantysy w prawo wynosi (127 - wykladnik)
; jeœli wartoœæ tej ró¿nicy jest wiêksza lub równa 25, to w wyniku
; przesuniêcia w prawo wszystkie bity mantysy zostan¹
; usuniête - wynik koñcowy bêdzie = 1
	cmp		bl, 102
	ja		przesun_w_prawo		; skok, gdy wyk³adnik > 102
	mov		eax, 3F800000H		; liczba 1 w formacie float
	jmp		koniec

przesun_w_prawo:
	mov		cl, 127
	sub		cl, bl
	shr		eax, cl			; przesuniêcie mantysy w prawo tak, by umowna
							; kropka znalaz³a siê miêdzy bitami 23 i 22
							; uwaga tylko 5 ostatnich bitów CL okreœla
							; liczbê przesuniêæ
	mov		bl, 127			; aktualny wyk³adnik (zob. opis wy¿ej)

	adc		eax, 0			; zaokr¹glenie
; w tym przypadku dodawanie 1 do bitu o wadze 2^0 jest zbêdne,
; poniewa¿ bit nie ten wystêpuje w postaci jawnej
; add eax, 00800000: ; dodanie 1 na bicie mantysy o wadze 2^0
	jmp		dalej

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
; przesuniêcie w lewo "1" w EDX

jedynka_w_lewo:
	mov		cl, 150
	sub		cl, bl
	shl		edx, cl
	add		eax, edx		; dodanie liczby 1 do mantysy

	; sprawdzenie, czy w wyniku dodawania mantysa < 2
	bt		eax, 24
	jnc		dalej		; skok, gdy mantysa < 2 (war. normalizacji spe³niony)
	shr		eax, 1		; normalizacja mantysy
	adc		eax, 0		; zaokr¹glenie
	add		bl, 1		; korekcja wyk³adnika

; -----------------------------------------
; odtworzenie postaci zmiennoprzecinkowej liczby

dalej:
	and		eax, 7FFFFFH	; pozostaj¹ tylko bity mantysy o wagach u³amkowych
	and		ebx, 0FFH
	ror		ebx, 9			; przesuniêcie wyk³adnika na bity 30 - 23
	or		eax, ebx ; z³o¿enie mantysy i wyk³adnika

koniec:
	push	eax
	fld		dword PTR [esp]		; wpisanie wyniku na wierzcho³ek
								; stosu koprocesora
	add		esp, 4				; usuniêcie obliczonej wartoœci ze stosu
	
	pop		ebx
	pop		ebp
	ret
_plus_jeden_float ENDP

END