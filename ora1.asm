
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX

  MOV AH,2
  MOV DL,41h
  INT 21h

  ;21es megszakitas hivasa -> AH-bol kiveszi az erteket, ami most a 2-es funkcio(karakterkiiras)
  ; ez a funkcio azt a karaktert irja ki, aminek a karakter kodjat betoltottuk a DL-be
  ; 41h -> 0100 0001 -> 65 -> ascii-ben ez az 'A'

Program_Vege:
	mov ax, 4c00h
	int 21h

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

