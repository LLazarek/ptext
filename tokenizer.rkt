#lang br/quicklang

(require brag/support)

(define (make-tokenizer port)
  (define (next-token)
    (define ptext-lexer
      (lexer
       [(eof) eof]
       [(from/to "\n!@" "@!\n")
        ;; Read the sexp so that SEXP-TOK contains a sexp rather than
        ;; a string; this lets us decompose it in the expander.
        ;; This is the only thing on this line, so remove the line from output
        (token 'SEXP-TOK (read (open-input-string
                                (trim-ends "\n!@" lexeme "@!\n"))))]
       [(from/to "!@" "@!")
        ;; "Embedded" expressions (not sole thing on line) leave
        ;; surroundings completely intact
        (token 'SEXP-TOK (read (open-input-string
                                (trim-ends "!@" lexeme "@!"))))]
       [any-char (token 'CHAR-TOK lexeme)]))
    (ptext-lexer port))
  next-token)

(provide make-tokenizer)
