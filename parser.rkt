#lang brag
ptext-program : (text-str | ptext-sexp)*
ptext-sexp : SEXP-TOK
text-str : CHAR-TOK+
