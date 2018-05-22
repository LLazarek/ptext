#lang br/quicklang

(require brag/support)

(define (make-tokenizer port)
  (define (next-token)
    (define rapp-lexer
      (lexer
       [(eof) eof]
       [(from/to "!@" "@!")
        ;; Read the sexp so that SEXP-TOK contains a sexp rather than
        ;; a string; this lets us decompose it in the expander.
        (token 'SEXP-TOK (read (open-input-string
                                (trim-ends "!@" lexeme "@!"))))]
       [any-char (token 'CHAR-TOK lexeme)]))
    (rapp-lexer port))
  next-token)

(provide make-tokenizer)
