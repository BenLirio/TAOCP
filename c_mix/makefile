main: main.o instruction.o constants.o run.o memory.o
	clang -Wall -g -o main main.o instruction.o constants.o run.o memory.o

main.o: main.c instruction.h constants.h run.h memory.h
	clang -c -g main.c

run.o: run.c run.h instruction.h constants.h memory.h
	clang -c -g run.c

instruction.o: instruction.c instruction.h constants.h run.h memory.h
	clang -c -g instruction.c

constants.o: constants.c constants.h run.h memory.h
	clang -c -g constants.c

memory.o: memory.c memory.h
	clang -c -g memory.c

clean:
	rm -f main main.o instruction.o run.o memory.o
