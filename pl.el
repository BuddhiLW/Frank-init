(use-package sly
  :hook (sly . ac-sly))

(use-package ac-sly)

(use-package sly-asdf)

(use-package helm-sly)
(use-package sly-quicklisp)
(use-package sly-repl-ansi-color)
(use-package sly-named-readtables)

(use-package company-go)

(use-package go-snippets)

(use-package go-autocomplete)

;; Define function to call when go-mode loads
(defun my-go-mode-hook ()
  (setq gofmt-command "goimports")                ; gofmt uses invokes goimports
  (if (not (string-match "go" compile-command))   ; set compile command default
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ;; guru settings
  (go-guru-hl-identifier-mode)                    ; highlight identifiers

  ;; Key bindings specific to go-mode
  (local-set-key (kbd "M-.") 'godef-jump)         ; Go to definition
  (local-set-key (kbd "M-*") 'pop-tag-mark)       ; Return from whence you came
  (local-set-key (kbd "M-p") 'compile)            ; Invoke compiler
  (local-set-key (kbd "M-P") 'recompile)          ; Redo most recent compile cmd
  (local-set-key (kbd "M-]") 'next-error)         ; Go to next error (or msg)
  (local-set-key (kbd "M-[") 'previous-error)     ; Go to previous error or msg

  ;; Misc go stuff
  (auto-complete-mode 1)

  (lambda ()
    (set (make-local-variable 'company-backends) '(company-go))
    (company-mode)))
                                        ; Enable auto-complete mode

(use-package go-mode
  :hook ((go-mode . my-go-mode-hook)
         (before-save-hook . gofmt-before-save)) ; gofmt before every save
  :init
;; Ensure the go specific autocomplete is active in go-mode.
  (require 'go-autocomplete))

(use-package golint)

(use-package go-eldoc)

(use-package gomacro-mode)

(use-package go-stacktracer)

(use-package go-fill-struct)

(use-package helm-go-package)

(use-package flymake-golangci)

(use-package flycheck-gometalinter)

(use-package flymake-go-staticcheck)

(use-package flycheck-golangci-lint)

(use-package go-guru)

(use-package go-translate)

(use-package google-translate)

(use-package purescript-mode
  :hook (purescript-mode . purescript-indentation))
