#lang brag
rapp-program : (text-str | rapp-sexp)*
rapp-sexp : SEXP-TOK
text-str : CHAR-TOK+
