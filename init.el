;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

;; You will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(95 . 90))

(setq org-roam-v2-ack t)

(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha value))

(defun  efs/screen-layout ()
  (interactive)
  ;; NOTE: You will need to update this to a valid background path!
  (start-process-shell-command
   "sh" nil  "sh ~/.screenlayout/default.sh"))
;; (efs/screen-layout)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)
;; (global-display-line-numbers-mode t)

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                ;; treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(100 . 90) '(95 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(set-face-attribute 'default nil :font "Fira Code Retina" :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height efs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)


(defun init-my-font ()
  (set-face-font
   'default
   (font-spec
    :family "Fira Code Retina"
    :height efs/default-font-size
    :slant 'normal))
  (set-face-attribute 'default nil :height 103)
  ;; emoji font
  (set-fontset-font
   t 'symbol
   (font-spec :family "Noto Color Emoji"
              :height efs/default-variable-font-size
              :weight 'normal
              :width 'normal
              :slant 'normal))
  ;; fallback font
  (set-fontset-font
   t nil
   (font-spec
    :family "DejaVu Sans Mono"
    :height efs/default-font-size
    :slant 'normal)))

;; "CCSymbol"  U+1F16D - U+1F10F
(set-fontset-font "fontset-default"
                  (cons (decode-char 'ucs #x1F10D)
                        (decode-char 'ucs #x1F10f))
                  "CC Symbols")

  (set-fontset-font "fontset-default"
                  (cons (decode-char 'ucs #x1F16D)
                        (decode-char 'ucs #x1F16f))
                  "CC Symbols")
   ;; (set-fontset-font "fontset-default"
   ;;                   (cons (decode-char 'ucs #x05D0))
   ;;                   "Noto Serif Hebew")

(set-fontset-font "fontset-default"
                  (cons (decode-char 'ucs #x05B0)
                        (decode-char 'ucs #x05F4))
                  "Noto Serif Hebrew")

(use-package unicode-fonts
   :ensure t
   :config
    (unicode-fonts-setup))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(setq emojify-user-emojis '((":emacs:" . (("name" . "Emacs")
                                              ("image" . "~/.emacs.d/emoji/emacs.svg")
                                              ("style" . "github")))
                            (":lambda:" . (("name" . "Lambda")
                                              ("image" . "~/.emacs.d/emoji/lambda.jpg")
                                              ("style" . "github")))))
;; If emojify is already loaded refresh emoji data
(when (featurep 'emojify)
  (emojify-set-emoji-data))

(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x" "*" "**" "***" ":" "::" "www" "->" "->>" "+"))
  :hook (
         (prog-mode . prettify-symbols-mode)
         (prog-mode . fira-code-mode)
         (special-mode . prettify-symbols-mode)
         (special-mode . fira-code-mode)
         (text-mode . prettify-symbols-mode)
         ))

;; (use-package nyan-mode
;;   :hook ((special-mode . nyan-mode)
;;          (text-mode . nyan-mode)
;;          (progn-mode . nyan-mode)))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.default/Emacs.org")) :which-key "Emacs config")
    "k" '(lambda () (interactive) (org-babel-previous-src-block) :which-key "Previous block")
    "j" '(lambda () (interactive) (org-babel-next-src-block) :which-key "Next block")
    "ph" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/Habits.org")) :which-key "Habits")
    "pi" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/IMPA.org")) :which-key "IMPA")
    "pps" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/ProcSel.org")) :which-key "Processo Seletivo")
    "ppp" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/Programming.org")) :which-key "Programming")
    "pr" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/Research.org")) :which-key "Reasearch")
    "pt" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/Tasks.org")))
    "pu" '(lambda () (interactive) (find-file (expand-file-name "~/Projects/University.org")))))

(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-collection-init))

;;   (use-package general
;;   :config
;;   (general-evil-setup t)

;;   (general-create-definer dw/leader-key-def
;;     :keymaps '(normal insert visual emacs)
;;     :prefix "SPC"
;;     :global-prefix "C-SPC")

;;   (general-create-definer dw/ctrl-c-keys
;;     :prefix "C-c"))

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'doom-Iosvkem t)) ;;wildavil's default -> doom-palenight

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10))
  :config
  (setq doom-modeline-buffer-file-name-style 'truncate-with-project)
  (setq doom-modeline--batery-status t)
  (setq doom-modeline-lsp t)
  (display-battery-mode 1))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         ("C-c r" . 'revert-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(efs/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package pdf-tools
  :config
  (pdf-loader-install))

(use-package julia-mode)

(use-package julia-snail)

(setq inferior-julia-program-name "julia")

(package-install-file "~/.emacs.default/ob-julia-vterm.el/ob-julia-vterm.el")

(defalias 'org-babel-execute:julia 'org-babel-execute:julia-vterm)

(use-package clojure-mode
  :hook ((clojure-mode . subword-mode)
         (clojure-mode . paredit-mode)
         (clojure-mode . smartparens-strict-mode)
         (clojure-mode . aggressive-indent-mode)))
;; :hook ((paredit-mode . clojure-mode))

(setq clojure-align-forms-automatically t)

(use-package clojure-mode-extra-font-locking)

(use-package kibit-helper)

(use-package anakondo)
(use-package flymake-kondor)
(use-package flycheck-clj-kondo)

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; ;; Set faces for heading levels
  ;; (dolist (face '((org-level-1 . 1.2)
  ;;                 (org-level-2 . 1.1)
  ;;                 (org-level-3 . 1.05)
  ;;                 (org-level-4 . 1.0)
  ;;                 (org-level-5 . 1.1)
  ;;                 (org-level-6 . 1.1)
  ;;                 (org-level-7 . 1.1)
  ;;                 (org-level-8 . 1.1)))
  ;;   (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-format-latex-options nil :inherit 'fixed-pitch)
  ;; ;
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 3.0)))

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory 
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

;; (defun bw/org-motion-setup ()
;;   (general-create-definer bw/org-leader-keys
;;     :keymaps '(normal visual emacs)
;;     :prefix "SPC")
;;   (bw/org-leader-keys
;;    "j" '(lambdaorg-babel-next-src-block)
;;    "k" '(org-babel-previous-src-block)
;;    "SPC" '(org-ctrl-c-ctrl-c)))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook ((org-mode . efs/org-mode-setup)
         ;; (org-mode . bw/org-motion-setup)
         (org-mode . auto-fill-mode))
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Projects/Tasks.org"
          "~/Projects/Habits.org"
          "~/Projects/IMPA.org"
          "~/Projects/ProcSel.org"
          "~/Projects/University.org"
          "~/Projects/Research.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
        '(("Archive.org" :maxlevel . 1)
          ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
        `(("t" "Tasks / Projects")
          ("tt" "Task" entry (file+olp "~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

          ("j" "Journal Entries")
          ("jj" "Journal" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
          ("jm" "Meeting" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

          ("w" "Workflows")
          ("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

          ("m" "Metrics Capture")
          ("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
           "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (efs/org-font-setup))

(use-package org-bullets
  :after org
  ;; :hook (org-mode . org-bullets)
  :custom
  ;; (org-superstar-remove-leading-stars t)
  (org-bullets-bullet-list '("家" "ॐ" "同" "Ø" "א" "҉ " "҈ ")))
;; ("֍" "ॐ" "፠" "Ø" "א" "҉" "҈")

(use-package org-superstar
  ;; :if (not dw/is-termux)
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("家" "ॐ" "同" "Ø" "א" "҉ " "҈ ")))
;; ("◉" "○" "●" "○" "●" "○" "●")
;; Replace list hyphen with dot
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Increase the size of various headings
;; (set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
;; (dolist (face '((org-level-1 . 1.2)
;;                 (org-level-2 . 1.1)
;;                 (org-level-3 . 1.05)
;;                 (org-level-4 . 1.0)
;;                 (org-level-5 . 1.1)
;;                 (org-level-6 . 1.1)
;;                 (org-level-7 . 1.1)
;;                 (org-level-8 . 1.1)))
;;   (set-face-attribute (car face) nil :font "Cantarell" :weight 'medium :height (cdr face)))

;; Make sure org-indent face is available
(require 'org-indent)

;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; Get rid of the background on column views
(set-face-attribute 'org-column nil :background nil)
(set-face-attribute 'org-column-title nil :background nil)

;; TODO: Others to consider
;; '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;; '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;; '(org-property-value ((t (:inherit fixed-pitch))) t)
;; '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;; '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
;; '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;; '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Increase the size of various headings
;; Noto Serif CJK TC
 (set-face-attribute 'org-document-title nil :font "Bitstream Vera Serif" :weight 'bold :height 1.3)
 (dolist (face '((org-level-1 . 1.2)
		 (org-level-2 . 1.1)
		 (org-level-3 . 1.05)
		 (org-level-4 . 1.0)
		 (org-level-5 . 1.1)
		 (org-level-6 . 1.1)
		 (org-level-7 . 1.1)
		 (org-level-8 . 1.1)))
   (set-face-attribute (car face) nil :font "Bitstream Vera Serif" :weight 'medium :height (cdr face)))

 ;; Make sure org-indent face is available
 (require 'org-indent)

 ;; Ensure that anything that should be fixed-pitch in Org files appears that way
 (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
 (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
 (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
 (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
 (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

 ;; Get rid of the background on column views
 (set-face-attribute 'org-column nil :background nil)
 (set-face-attribute 'org-column-title nil :background nil)

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(setq org-image-actual-width nil)

(use-package ein)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
(add-hook 'org-mode-hook 'org-display-inline-images)

;; (use-package ob-julia)

(add-to-list 'load-path "~/.emacs.d/ob-julia")

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (browser . t)
     (ditaa . t)
     (R . t)
     (go . t) 
     ;; (ipython . t)
     (julia-vterm . t)
     ;; (julia . t)
     (ein . t)
     (ditaa . t)
     (css . t)
     (lisp . t)
     (latex . t)
     (clojure . t)
     (clojurescript . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(custom-set-variables
 '(ob-ein-languages
  '(("ein-python" . python)
    ("ein-R" . R)
    ("ein-r" . R)
    ("ein-julia" . julia))))

(require 'ob-clojure)
(setq org-babel-clojure-backend 'cider)

(require 'org-tempo)

;; System
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;; Scientific
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("ju" . "src julia"))
(add-to-list 'org-structure-template-alist '("cl" . "src clojure"))

;; Web
(add-to-list 'org-structure-template-alist '("c4" . "src css :tangle ../css/.css :mkdirp yes"))
(add-to-list 'org-structure-template-alist '("js" . "src js :tangle ../js/.js"))
(add-to-list 'org-structure-template-alist '("h4" . "src html :tangle ../html/index.html :mkdirp yes"))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(defun dw/org-present-prepare-slide ()
  (org-overview)
  (org-show-entry)
  (org-show-children))

(defun dw/org-present-hook ()
  (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
				     (header-line (:height 4.5) variable-pitch)
				     (org-document-title (:height 1.75) org-document-title)
				     (org-code (:height 1.55) org-code)
				     (org-verbatim (:height 1.55) org-verbatim)
				     (org-block (:height 1.25) org-block)
				     (org-block-begin-line (:height 0.7) org-block)))
  (setq header-line-format " ")
  (org-appear-mode -1)
  (org-display-inline-images)
  (dw/org-present-prepare-slide))

(defun dw/org-present-quit-hook ()
  (setq-local face-remapping-alist '((default variable-pitch default)))
  (setq header-line-format nil)
  (org-present-small)
  (org-remove-inline-images)
  (org-appear-mode 1))

(defun dw/org-present-prev ()
  (interactive)
  (org-present-prev)
  (dw/org-present-prepare-slide))

(defun dw/org-present-next ()
  (interactive)
  (org-present-next)
  (dw/org-present-prepare-slide))

(use-package org-present
  :bind (:map org-present-mode-keymap
	      ("C-c C-j" . dw/org-present-next)
	      ("C-c C-k" . dw/org-present-prev))
  :hook ((org-present-mode . dw/org-present-hook)
	 (org-present-mode-quit . dw/org-present-quit-hook)))

(use-package org-download)

(use-package org-auto-tangle)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/buddhi-roam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-db-autosyc-mode)
  (require 'org-roam-protocol))

(use-package graphviz-dot-mode
  :ensure t)

(use-package org-ref)

(use-package bibtex-utils)
(use-package company-bibtex)
(use-package gscholar-bibtex)

(use-package helm-bibtex)

(use-package org-roam-bibtex)

;; (use-package org-ql)

(use-package ts)

(use-package s)

(use-package dash)

;; (add-to-list 'load-path (concat user-emacs-directory "lisp/elgantt/test.orgmode")) ;; Or wherever it is located
;; (require 'elgantt)
;; ;; (setq elgantt-agenda-files (concat user-emacs-directory "lisp/elgantt/test.org"))

(use-package conda
  :config
  (setq
   conda-env-home-directory (expand-file-name "~/.conda/")
   conda-env-subdirectory "envs")
  (custom-set-variables '(conda-anaconda-home "/opt/anaconda2/"))
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (conda-env-autoactivate-mode t))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
				("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; (use-package dired-details) 

(use-package dired-rainbow
  :defer 2
  :config
  (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
  (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
  (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
  (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
  (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
  (dired-rainbow-define media "#de751f" ("mp3" "mp4" "mkv" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
  (dired-rainbow-define log "#c17d11" ("log"))
  (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
  (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
  (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
  (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
  (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
  (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*"))

(use-package dired-single
  :defer t)

(use-package dired-ranger
  :defer t)

(use-package dired-collapse
  :defer t)

(evil-collection-define-key 'normal 'dired-mode-map
  "h" 'dired-single-up-directory
  "H" 'dired-omit-mode
  "l" 'dired-single-buffer
  "y" 'dired-ranger-copy
  "X" 'dired-ranger-move
  "p" 'dired-ranger-paste)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(use-package ace-link)
(ace-link-setup-default)

(define-key org-mode-map (kbd "ö") 'ace-link-org)

;; Copyright (C) 2014 Matus Goljer <matus.goljer@gmail.com>
;; Package-requires: ((dash "2.5.0"))
(defun org-inline-image--get-current-image ()
  "Return the overlay associated with the image under point."
  (car (--select (eq (overlay-get it 'org-image-overlay) t) (overlays-at (point)))))

(defun org-inline-image--get (prop)
  "Return the value of property PROP for image under point."
  (let ((image (org-inline-image--get-current-image)))
    (when image
      (overlay-get image prop))))

(defun org-inline-image-animate ()
  "Animate the image if it's possible."
  (interactive)
  (let ((image-props (org-inline-image--get 'display)))
    (when (image-multi-frame-p image-props)
      (image-animate image-props))))

(defun org-inline-image-animate-auto ()
  (interactive)
  (when (eq 'org-mode major-mode)
    (while-no-input 
      (run-with-idle-timer 0.3 nil 'org-inline-image-animate))))

(setq org-inline-image--get-current-image (byte-compile 'org-inline-image--get-current-image))
(setq org-inline-image-animate  (byte-compile 'org-inline-image-animate ))
(add-hook 'post-command-hook 'org-inline-image-animate-auto)

(use-package org-present)

;;  (use-package versuri)
(use-package esxml)
(use-package prescient)
(use-package company-prescient)
(use-package xelb)
(use-package cider)

(defun my-scratch-buffer ()
"Create a new scratch buffer -- \*hello-world\*"
(interactive)
  (let ((n 0)
        bufname buffer)
    (catch 'done
      (while t
        (setq bufname (concat "*hello-world"
          (if (= n 0) "" (int-to-string n))
            "*"))
        (setq n (1+ n))
        (when (not (get-buffer bufname))
          (setq buffer (get-buffer-create bufname))
          (with-current-buffer buffer
            (org-mode))
          ;; When called non-interactively, the `t` targets the other window (if it exists).
          (throw 'done (display-buffer buffer t))) ))))



(use-package chembalance)
(use-package chemtable)

(use-package calfw-org)
(use-package calfw-cal)
(use-package calfw-ical)
(use-package calfw-gcal)

(use-package ox-reveal)

(use-package htmlize)

(defun tidy-html ()
  "Tidies the HTML content in the buffer using `tidy'"
  (interactive)
  (shell-command-on-region
   ;; beginning and end of buffer
   (point-min)
   (point-max)
   ;; command and parameters
   "tidy -i -w 120 -q"
   ;; output buffer
   (current-buffer)
   ;; replace?
   t
   ;; name of the error buffer
   "*Tidy Error Buffer*"
   ;; show error buffer?
   t))

(use-package celestial-mode-line
  :config
  (setq calendar-longitude "20.54S")
  (setq calendar-latitude "47.40W")
  (setq calendar-location-name "Franca, SP")
  (setq global-mode-string '("" celestial-mode-line-string display-time-string))
  (defvar celestial-mode-line-phase-representation-alist '((0 . "○") (1 . "☽") (2 . "●") (3 . "☾")))
  (defvar celestial-mode-line-sunrise-sunset-alist '((sunrise . "☀↑ ") (sunset . "☀↓ ")))
  (defvar celestial-mode-line-phase-representation-alist '((0 . "( )") (1 . "|)") (2 . "(o)") (3 . "|)")))
  (defvar celestial-mode-line-sunrise-sunset-alist '((sunrise . "*^") (sunset . "*v")))
  (celestial-mode-line-start-timer)
  :init
  (define-key global-map
    (kbd "µ")
    (display-message-or-buffer (message "`%s'" (eval '(solar-sunrise-sunset-string (calendar-current-date)))))))

(message "hello")

(use-package load-relative)

(load-relative "./pl.el")
(load-relative "./editing.el")
(load-relative "./desktop.el")
