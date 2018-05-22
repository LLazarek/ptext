#lang br/quicklang

(require "tokenizer.rkt" "parser.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (datum->syntax #f
                 `(module ptext-module ptext/expander
                    ,parse-tree)))

(provide read-syntax)
