
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

  ; [kepernyo letorles]
  ;mov ah, 0
  ;mov al, 3 
  ;int 10h
  ;optimalisabb verzioja
  mov ax, 3 ;0003h
  int 10h

  ;   [kurzor pozicio beallitas]
  ; 10h megszakítás
	; 02 funkció (ah-ba kell majd beállítani)
	; dh (x koordinata)
	; dl (y koordinata)
	; bh (melyik videopage- altalaban a 0-asat fogjuk venni)
  mov ah, 2
  mov bh, 0
  mov dh, 12; sor
  mov dl, 35; oszlop
  int 10h

  mov cx, 10
ciklus:
	MOV AH,2
  MOV DL,41h
  INT 21h

  loop ciklus


; ------------------------ [FELADAT] -------------------------

  
  mov di, offset ertek ; di regiszter megkapta az ertek cimet
  
  ; [kepernyo letorles]
  mov ax, 03
  int 10h

Bevitel:
  xor ax, ax
  
  ; karakter bekeres (ugye al kapja meg az ascii-t és ezert kell az ax kinullazasa)
  int 16h
  mov bx,ax

  ; kepernyo torles
  mov ax, 03
  int 10h

  mov ax,bx
  cmp al, 27 ; ha a bekert karakter egy [esc], akkor a ZERO flag 0 lesz es a jz utasitas teljesul (itt akkor kilep)
  jz Program_vege

  mov cx, 10
  mov ah, '0'

Vizsg:
  cmp al, ah
  jz Tarol
  inc ah
  loop Vizsg ; ez a ciklus vegig vizsgalgatja egy ciklus valtozo(ah) segitsegevel a szamokat 0-9 ig, hogy [al] azt tartalmazza-e

  ;ha a ciklus nem ugrik tovabb, akkor nem szam a megkapott ertek es kiir egy hibat

  ; kurzor poz
  mov ah, 02h
  mov bh, 0
  mov dh, 10
  int 10h

  ; szoveg kiiras
  mov dx, offset hiba
  mov ah, 09
  int 21h

  jmp Bevitel

Tarol:
  ; itt a di eredetileg egy cim, a '*****$' szoveg cime de [di] már a cím által mutatott értéket jelenti, azaz a szöveg elso karakteret, ami itt egy *
  ; al pedig a bekert karakterunk
  mov [di], al 
  ; inkrementaljuk a cimet, es igy mar a stringben a kovetkezo karakterre mutat
  inc di

  ;ezt a kovetkezo karaktert ideiglenesen helyettesitjuk egy $ jellel a kiiras miatt, hogy a * karakterek ne keruljenek a konzolra
  mov al, '$' 
  mov [di], al

  ; pozicionalas
  mov ah, 02h
  mov bh, 0
  mov dh, 5
  mov dl, 28
  int 10h

  ; szoveg kiiras
  mov dx, offset ertek
  mov ah, 09
  int 21h

  mov ax, offset ertek
  add ax, 4
  cmp ax, di
  jnz Bevitel

  ;pozicionalas
  mov ah, 02h
  mov bh, 0
  mov dh, 7
  int 10h
  
  ;szoveg kiiras 
  mov dx, offset uzenet
  mov ah, 09h
  int 21h

Program_vege:
	mov ax, 4c00h
	int 21h

hiba db 'Nem megengedett karakter!$' 
ertek db '*****$' 
uzenet db 'Vege abevitelnek$'

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

