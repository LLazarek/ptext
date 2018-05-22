#lang br/quicklang
(require (for-syntax racket/string))

(define-macro (rapp-mb PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [rapp-mb #%module-begin]))

(define-macro (text-str CHAR-STR ...)
  #'(display (string-append CHAR-STR ...)))

(define-macro (rapp-program TEXT/SEXP ...)
  #'(begin TEXT/SEXP ...))

(define-macro-cases rapp-sexp
  [(rapp-sexp (define DEF ...))
   #'(define DEF ...)]
  [(rapp-sexp (require MOD ...))
   #'(require MOD ...)]
  [(rapp-sexp OTHER)
   #'(display OTHER)])

;; The reason that this doesn't work is that when we do format-datum,
;; we are creating a new syntax object for the identifiers being
;; defined inside the macro. Racket's macro hygiene ensures that
;; identifiers created inside macros cannot be seen by the surrounding
;; code.
;;
;; This also explains why the above macro DOES work (in combination
;; with converting the strings into sexps in the tokenizer); it does
;; *not* create the identifiers being defined (via conversion from a
;; string with format-datum).
;;
;; See https://beautifulracket.com/basic-3/command-line-arguments.html#the-limits-of-hygiene
#;(define-macro (rapp-sexp SEXP-STR)
  (with-pattern ([SEXP-STX (format-datum '~a #'SEXP-STR)])
    (if (string-contains? (syntax->datum #'SEXP-STR) "define") 
        #'SEXP-STX
        #'(display SEXP-STX))))

(require racket/base)
(provide text-str rapp-program rapp-sexp
         (except-out (all-from-out racket/base)
                     #%module-begin))

