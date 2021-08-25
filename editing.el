(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package flymake-proselint)

;; (use-package textlint)

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
  :hook ((prog-mode . auto-complete-mode)))

(use-package yasnippet
  :ensure t
  :config
  (add-to-list 'load-path
               "~/.emacs.d/etc/yasnippets/snippets/")
  (yas-global-mode 1))
(use-package yasnippet-snippets)
(use-package yasnippet-classic-snippets)

(use-package auctex
  :ensure tex-mode
  :hook (tex-mode . auctex-mode))

(use-package latex-extra)

(setq org-latex-listings 'minted)
(setq org-latex-custom-lang-environments
       '((emacs-lisp "common-lispcode")))
(setq org-latex-minted-options
      '(("frame" "lines")
        ("fontsize" "\\scriptsize")
        ("linenos" "")))
(setq org-latex-to-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

; SyncTeX basics

; un-urlify and urlify-escape-only should be improved to handle all special characters, not only spaces.
; The fix for spaces is based on the first comment on http://emacswiki.org/emacs/AUCTeX#toc20

(defun un-urlify (fname-or-url)
  "Transform file:///absolute/path from Gnome into /absolute/path with very limited support for special characters"
  (if (string= (substring fname-or-url 0 8) "file:///")
      (url-unhex-string (substring fname-or-url 7))
    fname-or-url))

(defun urlify-escape-only (path)
  "Handle special characters for urlify"
  (replace-regexp-in-string " " "%20" path))

(defun urlify (absolute-path)
  "Transform /absolute/path to file:///absolute/path for Gnome with very limited support for special characters"
  (if (string= (substring absolute-path 0 1) "/")
      (concat "file://" (urlify-escape-only absolute-path))
      absolute-path))


; SyncTeX backward search - based on http://emacswiki.org/emacs/AUCTeX#toc20, reproduced on https://tex.stackexchange.com/a/49840/21017

(defun th-evince-sync (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: Could not open %s" fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(defvar *dbus-evince-signal* nil)

(defun enable-evince-sync ()
  (require 'dbus)
  ; cl is required for setf, taken from: http://lists.gnu.org/archive/html/emacs-orgmode/2009-11/msg01049.html
  (require 'cl)
  (when (and
         (eq window-system 'x)
         (fboundp 'dbus-register-signal))
    (unless *dbus-evince-signal*
      (setf *dbus-evince-signal*
            (dbus-register-signal
             ;; :session nil "/org/gnome/evince/Window/0"
             "org.gnome.evince.Window" "SyncSource"
             'th-evince-sync)))))

(add-hook 'LaTeX-mode-hook 'enable-evince-sync)


; SyncTeX forward search - based on https://tex.stackexchange.com/a/46157

;; universal time, need by evince
(defun utime ()
  (let ((high (nth 0 (current-time)))
        (low (nth 1 (current-time))))
   (+ (* high (lsh 1 16) ) low)))

;; Forward search.
;; Adapted from http://dud.inf.tu-dresden.de/~ben/evince_synctex.tar.gz
;; (defun auctex-evince-forward-sync (pdffile texfile line)
;;   (let ((dbus-name
;;      (dbus-call-method :session
;;                "org.gnome.evince.Daemon"  ; service
;;                "/org/gnome/evince/Daemon" ; path
;;                "org.gnome.evince.Daemon"  ; interface
;;                "FindDocument"
;;                (urlify pdffile)
;;                t     ; Open a new window if the file is not opened.
;;                )))
;;     (dbus-call-method :session
;;           dbus-name
;;           "/org/gnome/evince/Window/0"
;;           "org.gnome.evince.Window"
;;           "SyncView"
;;           (urlify-escape-only texfile)
;;           (list :struct :int32 line :int32 1)
;;   (utime))))

(defun auctex-evince-view ()
  (let ((pdf (file-truename (concat default-directory
                    (TeX-master-file (TeX-output-extension)))))
    (tex (buffer-file-name))
    (line (line-number-at-pos)))
    (auctex-evince-forward-sync pdf tex line)))

;; New view entry: Evince via D-bus.
(setq TeX-view-program-list '())
(add-to-list 'TeX-view-program-list
         '("EvinceDbus" auctex-evince-view))

;; Prepend Evince via D-bus to program selection list
;; overriding other settings for PDF viewing.
(setq TeX-view-program-selection '())
(add-to-list 'TeX-view-program-selection
         '(output-pdf "EvinceDbus"))

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

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

(add-hook 'after-init-hook 'global-company-mode)

(use-package grammarly
  :config
  (setq grammarly-username "pedrogbranquinho@gmail.com")  ; Your Grammarly Username
  (setq grammarly-password "1Pa33word!!"))  ; Your Grammarly Password

(use-package flycheck-grammarly
  :config
  (setq flycheck-grammarly-check-time 1000))

(use-package keytar)

(use-package lsp-grammarly
  :ensure t
  :hook (text-mode . (lambda ()
                       (require 'lsp-grammarly)
                       (lsp))))  ; or lsp-deferred

;; Input method and key binding configuration.
(setq alternative-input-methods
      '(("chinese-tonepy" . [?\ä])
        ("chinese-sisheng"   . [?\å])))

(setq default-input-method
      (caar alternative-input-methods))

(defun toggle-alternative-input-method (method &optional arg interactive)
  (if arg
      (toggle-input-method arg interactive)
    (let ((previous-input-method current-input-method))
      (when current-input-method
        (deactivate-input-method))
      (unless (and previous-input-method
                   (string= previous-input-method method))
        (activate-input-method method)))))

(defun reload-alternative-input-methods ()
  (dolist (config alternative-input-methods)
    (let ((method (car config)))
      (global-set-key (cdr config)
                      `(lambda (&optional arg interactive)
                         ,(concat "Behaves similar to `toggle-input-method', but uses \""
                                  method "\" instead of `default-input-method'")
                         (interactive "P\np")
                         (toggle-alternative-input-method ,method arg interactive))))))

(reload-alternative-input-methods)
