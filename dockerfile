FROM gcc:latest
COPY . /app
WORKDIR /app/
RUN apt-get update
RUN apt-get install -y bison flex
RUN lex parcial1.l
RUN yacc -d yaccparcial1.y
RUN gcc -o tasks lex.yy.c y.tab.c -ll
CMD ["./tasks", "instructions.txt"]
 

