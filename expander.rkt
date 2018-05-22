#lang br/quicklang
(require (for-syntax racket/string))

(define-macro (rapp-mb PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [rapp-mb #%module-begin]))

(define-macro (text-char CHAR-STR)
  #''(display CHAR-STR))

(define-macro (rapp-program TEXT/SEXP ...)
  #'(begin TEXT/SEXP ...))

(define-macro (rapp-sexp SEXP-STR)
  (with-pattern ([SEXP-STX (format-datum '~a #'SEXP-STR)])
    (if (string-contains? (syntax->datum #'SEXP-STR) "define") 
        #''SEXP-STX
        #''(display SEXP-STX))))

(provide text-char rapp-program rapp-sexp)

