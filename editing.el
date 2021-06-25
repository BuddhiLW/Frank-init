;;; package --- quick flyspell functionality.
;;; Commentary:
;; Easy spell checking; one can activate diverse capabilites of
;; flycheck through <f8>-key combinations
;;; Code:
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-s-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word."
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

(provide 'flycheck)
;;; flycheck-<f8> ends here

(let ((langs '("american" "francais" "brasileiro")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
   (interactive)
   (let ((lang (ring-ref lang-ring -1)))
     (ring-insert lang-ring lang)
     (ispell-change-dictionary lang)))

(global-set-key [f6] 'cycle-ispell-languages)

(use-package rainbow-delimiters
  :hook ((special-mode . rainbow-delimiters-mode)
	 (text-mode . rainbow-delimiters-mode)
	 (prog-mode . rainbow-delimiters-mode)))

(use-package smartparens
  :hook (prog-mode . smartparens-mode))
;;          (lisp-mode . smartparens-mode)
;;          (cider-mode . smartparens-mode)
;;          (clojure-mode . smartparens-mode)
;;          (racket-mode . smartparens-mode)))

(use-package evil-smartparens
  :hook ((after-init . evil-smartparens-mode)
	 (prog-mode . evil-smartparens-mode)
	 (text-mode . evil-smartparens-mode)
	 (special-mode . evil-smartparens-mode)))

(use-package indent-guide
  :init (indent-guide-global-mode t)
  :hook (prog-mode . indent-guide-mode))

(use-package auto-complete
  :hook ((  )
	 (prog-mode . auto-complete-mode)))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets)
(use-package yasnippet-classic-snippets)

(use-package auctex
  :ensure tex-mode
  :hook (tex-mode . auctex-mode))

(use-package latex-extra)

(use-package outshine
  :hook ((outline-minor-mode-hook . outshine-mode)
	 (prog-mode . outshine-mode)))

(use-package org-ref)
(use-package bibtex-utils)
(use-package company-bibtex)
(use-package gscholar-bibtex)
(use-package helm-bibtex)
(use-package org-roam-bibtex)

(use-package org-roam
  :init
  (add-hook 'after-init-hook 'org-roam-mode))

;; (define-key key-translation-map (kbd "<tab> p") (kbd "φ"))
(define-key key-translation-map (kbd "<f9> x") (kbd "ξ"))
(define-key key-translation-map (kbd "<f9> i") (kbd "∞"))
(define-key key-translation-map (kbd "<f9> <right>") (kbd "→"))

(use-package org-evil)
