
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX


Program_Vege:
	mov ax, 4c00h
	int 21h
	
	;kurzor mozg (kiiras elott kell meghivni, es erdemes elotte egy clr)
	; 10h megszakitas -> 02 funkcio (ah), xy koordinatak (dh, dl), melyik video page (nem lapozgatunk, szoval bh-ba 0-t toltunk) 
	
Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

