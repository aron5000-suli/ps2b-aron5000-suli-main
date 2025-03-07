and: and.o
	ld and.o -o and

and.o: and.s
	as -c and.s -o and.o