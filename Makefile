LEX=flex
YACC=bison
CC=g++ -I./src
OBJECT=main
SRCDIR=src
EXAMPLEDIR=examples

$(OBJECT): lex.yy.o  yacc.tab.o
	$(CC) lex.yy.o yacc.tab.o -o $(OBJECT)
	@./$(OBJECT)

lex.yy.o: lex.yy.c  yacc.tab.h  $(SRCDIR)/main.h
	$(CC) -c lex.yy.c

yacc.tab.o: yacc.tab.c  $(SRCDIR)/main.h
	$(CC) -c yacc.tab.c

yacc.tab.c  yacc.tab.h: $(SRCDIR)/yacc.y
	$(YACC) -d $(SRCDIR)/yacc.y

lex.yy.c: $(SRCDIR)/lex.l
	$(LEX) $(SRCDIR)/lex.l

clean:
	@rm -f $(OBJECT)  *.o lex.yy.c yacc.tab.*
