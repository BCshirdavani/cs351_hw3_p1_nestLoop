nestedloop:	nestedloop.o
		gcc -o nestedloop nestedloop.o
nestedloop.o:	nestedloop.s
		as -o nestedloop.o nestedloop.s

