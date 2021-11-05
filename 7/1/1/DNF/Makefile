CC=gcc

main: main.o dnf.o
	$(CC) main.o dnf.o -o main
main.o: main.s
	$(CC) -g -c main.s
dnf.o: dnf.s
	$(CC) -g -c dnf.s
clean:
	rm main.o dnf.o main
