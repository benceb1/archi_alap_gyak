
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

	; biosz megszakitasok (interrupt set bios services) (10h - viedo services) (16h - keyboard IO)
  

  ; cel: kepernyo letorlese
  ; nem trivialis megoldas: 10-es megszakitasban a 0-ás funkcioban, ha atvaltunk egy uj videomodba, akkor letorli a kepernyot
  ; al - be 3-at kell tenni, mert a 3-as videomodot szeretnenk beallitani

  mov ah, 0
  mov al, 3 ; al kapja meg a 3-as kepernyomodot
  int 10h

  ; karakter bekeres (16h megszakitas (keyboard io))
  ; 0-as funkcio -> read keyboard input (ezt a kodot majd az ah-ba kell betenni)
  ; a funkcio var, es ha kap egy billentyuleutest, azt az #### al-be #### tolti be egy ascii kodkent, addig varakozik, amig nem kap
read_character:
  mov ah, 0
  int 16h

  ; osszehasonlitas (kilep vagy folytatja)
  cmp al, 27 ; 27 az esc kodja, azaz csak akkor megy tovabb, ha a leutott billentyu az esc
  je ciklus_vege ; ha esc akkor kilep

  ; ### utolag hozzaadott, a szam szamlalohoz ugrik, ha a bekert karakter egy szam
  cmp al, '0' ; osszehasonlitja a 0 karakter ascii sorszamaval
  jl read_character
  cmp al, '9'
  jng szam

  cmp al, 'A' ; 
  jl read_character
  cmp al, 'Z'
  jng nagy


  ; (utolag mellekelt tartalom ebben a kis blokkban a kommentes sor)
  ; cel az, hogy minden kisbetunel inkrementaljon
  ; ebben az esetben tartomanyt kell vizsgalni (ascii sorszamok tartomanyat)
  ; - beolvasas utan -> osszehasonlitunk es ha a megadott karakter sorszama kisebb mint a tartomany elso elemenek sorszama
  ; akkor ugrik az elejere
  ; aztan megnezzuk, hogy a megadott karakter sorszama nagyobb-e, mint a tartomany utolso elemenek a sorszama
  ; ha igaz, akkor abban az esetben is ugrunk az elejere

  ; o volt az 'a' betu vizsgalata
  ;cmp al, 'a'

  ;de most az a-z kozotti betuk kellenek
  cmp al, 'a'
  ;ha kisebb akkor ugorjunk az elejere mert a tartomanyon kivul vagyunk
  jl read_character
  cmp al, 'z'
  jg read_character ; és akkor ugorjon az elejére, ha nagyobb

  ;jmp novel ;ez a jump mar nem is fog kelleni, mert ugy is az a cimkeresz kovetkezik

  ; nagy betu esete is
  ;cmp al, 'A'
  ;je novel


  ; meg kell szamulnunk, hogy hanyszor nyomtunk le 'a' betut, ami lehet 'a' es 'A' is.
  ; ebben az esetben mindenkeppen kell egy szamlalo

novel:
  mov si, offset szamlalo2 ; szamlalo cimet betoltjuk az si regiszterbe
  mov bl, [si] ; bl megkapja az si regiszter altal mutatott 8 bites erteket (ami a 0 eseteben a 48??)
  inc bl ;inkrementaljuk igy lesz 49 ami mar az 1-nek felel meg
  mov [si], bl ; a vegeredmenyt visszairjuk a memoriateruletre
  jmp read_character


szam:
  mov si, offset szamlalo ; szamlalo cimet betoltjuk az si regiszterbe
  mov bl, [si] ; bl megkapja az si regiszter altal mutatott 8 bites erteket (ami a 0 eseteben a 48??)
  inc bl ;inkrementaljuk igy lesz 49 ami mar az 1-nek felel meg
  mov [si], bl ; a vegeredmenyt visszairjuk a memoriateruletre
  jmp read_character

nagy:
  mov si, offset szamlalo1 ; szamlalo cimet betoltjuk az si regiszterbe
  mov bl, [si] ; bl megkapja az si regiszter altal mutatott 8 bites erteket (ami a 0 eseteben a 48??)
  inc bl ;inkrementaljuk igy lesz 49 ami mar az 1-nek felel meg
  mov [si], bl ; a vegeredmenyt visszairjuk a memoriateruletre
  jmp read_character


ciklus_vege:
; kurzor pozícionálás 
	; 10h megszakítás
	; 02 funkció (ah-ba kell majd beállítani)
	; dh (x koordinata)
	; dl (y koordinata)
	; bh (melyik videopage- altalaban a 0-asat fogjuk venni)
  mov ah, 2
  mov bh, 0
  mov dh, 12; sor
  mov dl, 31; oszlop
  int 10h

  mov ah, 9
  mov dx, offset szoveg
  int 21h

  mov ah, 2
  mov bh, 0
  mov dh, 13; sor
  mov dl, 31; oszlop
  int 10h

  mov ah, 9
  mov dx, offset szoveg1
  int 21h

  mov ah, 2
  mov bh, 0
  mov dh, 14; sor
  mov dl, 31; oszlop
  int 10h

  mov ah, 9
  mov dx, offset szoveg2
  int 21h

end_of_program:
	mov ax, 4c00h
	int 21h

szoveg db "a lenyomott szamok szama: "
szamlalo db "0$" ; egy egyjegyu szamlalonak felel meg
szoveg1 db "a lenyomott nagybetuk szama: "
szamlalo1 db "0$"
szoveg2 db "a lenyomott kisbetuk szama: "
szamlalo2 db "0$"

; [kesobbi fobb feladatok]
; egyszerre egy számlálón számolja a 'a' és 'A' karaktert
; két számlálón számoljon: egyiken 'a' másikon 'C' betűket
; 4 számlálón számoljon 4 tetszőleges betű/szám karaktert
; Az 1-3 pontok módosítása úgy, hogy ha egy számláló értéke 10 lesz, akkor nem kiírjuk a helytelen értéket, hanem kilépünk
Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

