FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install ocaml libgcrypt20-dev ocaml-findlib opam m4 --yes
RUN opam init --disable-sandboxing --yes
RUN opam switch create 4.06.0 --yes
RUN eval `opam config env` --yes
RUN opam install camlp4 ocamlfind ocamlbuild batteries --yes

WORKDIR /app
COPY . /app

RUN git clone https://github.com/samee/obliv-c.git /app/obliv-c
WORKDIR /app/obliv-c
RUN ./configure && make

CMD ["/bin/bash"]
