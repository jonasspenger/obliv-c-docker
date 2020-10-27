FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install ocaml libgcrypt20-dev ocaml-findlib opam m4 --yes
RUN opam init --disable-sandboxing --yes \
  && opam switch create 4.06.0 --yes \
  && opam switch 4.06.0 \
  && eval `opam config env` \
  && opam install camlp4 ocamlfind ocamlbuild batteries --yes

WORKDIR /app
COPY . /app

RUN git clone https://github.com/samee/obliv-c.git /app/obliv-c
WORKDIR /app/obliv-c
RUN eval `opam config env` \
  && ./configure && make

CMD ["/bin/bash"]
