
main: main.o unmarshell.o
	gcc -g main.o unmarshell.o -o main
main.o: main.s
	gcc -c -g main.s
unmarshell.o: unmarshell.s
	gcc -c -g unmarshell.s
