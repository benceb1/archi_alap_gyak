
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	mov ah, 02h
  mov dl, '0'
  int 21h
  ;mov dl, 30h
  ;int 21h
  ;mov dl, 48
  ;int 21h
  ;mov dl, 00110000b
  ;int 21h

  ;string kiiras:

  mov ah, 09h
  mov dx, offset szoveg ; offset annyit jelent, hogy nem az erteket adja at a valtozonak, hanem a cimet
  int 21h

  ;osszeadas eredmeny kiiras
  ;elrakjuk a szamot al-be
  mov al, 2
  ;hozzaadnunk 3at
  add al,3
  ;beallitjuk a karakterkiiras funkciot
  mov ah, 02h
  ;beallitjuk a parametert a kiirasnak
  mov dl,al
  ;meg hozzaadnunk 30h-t mert az ascii tablaban 30h-tol kezdodnek a szamok
  add dl, 30h
  ;execute
  int 21h


  ;kivonunk belole 2-t
  sub dl, 4
  int 21h

  ;ha dl egyenlo egy-el, akkor irjuk ki, hogy egyenlő, ellenkező esetben azt, hogy nem egyenlő
  cmp dl, 31h ;31h = 1
  je egyenlo ;oda ugrik és onnan megy is tovabb lefele

  ; ebben az esetben nem ugrottunk az egyenlohoz
  mov ah, 09h
  mov dx, offset cmp_fail
  int 21h
  jmp folytatas

egyenlo:
  mov ah, 09h
  mov dx, offset cmp_success
  int 21h


folytatas:
  ; OR
  mov ah, 00110000b
   or ah, 00110110b
  
  PUSH AX ;push-nál csak egész regisztert tudunk elrakni (16-bitet)
  mov ah, 2
  POP DX
  mov dl, dh
  int 21h


  ; AND - azaz bitenkenti es muvelet, csak akkor lesz egy, ah mind a 2 helyen 1 pl:
  mov dl, 00110111b
  and dl, 11111100b

;eredmeny:00110100 lesz

; maszkolas: az and paranccsal ki tudunk nullázni, és az or paranccsal egybe tudunk állítani


; BITENKENTI LEPTETO ES ROTALO UTASITASOK

;SHL ESETÉN (SHIFT LEFT)
; 00000001 (1)
; 00000010 (2)

;MASIK PELDA
;10000000 (128)
;00000000 (0)

; a léptetés mindig a számrendszer alapjával valo szorzás vagy osztás (balra szorzás, jobbra osztás)

; ROTALAS (ami az egyikoldalt kimegy, az a tuloldalt visszajon)
; ROL
; 10000000
; 00000001

; ROR
; 00000001
; 10000000

; pelda
mov bl, 1
mov ah, 2
mov dl, bl
add dl, 48
int 21h

;parancs, mit akarunk leptetni, mennyivel
shl bl, 1
mov dl, bl
add dl, 48
int 21h

shl bl, 1
mov dl, bl
add dl, 48
int 21h

Program_Vege:
	mov ax, 4c00h
	int 21h

;db = define byte
;byte - onként tároljuk el benne a string karaktereit
szoveg db "ablak $"
;szam  dw 13 ;16 biten tarolja
;szam2 dd 27 ;32 biten tarolja
;ha gy szam 2 byteos akkor db helyett dw kell
;variaciok: dd es dt(10byte)
cmp_success db "egyenlo $"
cmp_fail db "nem egyenlo $"

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

