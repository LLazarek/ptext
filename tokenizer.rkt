#lang br/quicklang

(require brag/support)

(define (make-tokenizer port)
  (define (next-token)
    (define rapp-lexer
      (lexer
       [(eof) eof]
       [(from/to "!@" "@!")
        (token 'SEXP-TOK (trim-ends "!@" lexeme "@!"))]
       [any-char (token 'CHAR-TOK lexeme)]))
    (rapp-lexer port))
  next-token)

(provide make-tokenizer)
