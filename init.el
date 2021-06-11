;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

;; You will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)

;; Make frame transparency overridable
(defvar efs/frame-transparency '(93 . 93))

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

(load-file "~/.emacs.d/desktop.el")
(load-file "~/.emacs.d/editing.el")

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
(global-display-line-numbers-mode t)

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
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
	 '(93 . 93) '(100 . 100)))))
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

(use-package unicode-fonts
   :ensure t
   :config
    (unicode-fonts-setup))

(defun my-correct-symbol-bounds (pretty-alist)
  "Prepend a TAB character to each symbol in this alist,
this way compose-region called by prettify-symbols-mode
will use the correct width of the symbols
instead of the width measured by char-width."
  (mapcar (lambda (el)
            (setcdr el (string ?\t (cdr el)))
            el)
          pretty-alist))

(defun my-ligature-list (ligatures codepoint-start)
  "Create an alist of strings to replace with
codepoints starting from codepoint-start."
  (let ((codepoints (-iterate '1+ codepoint-start (length ligatures))))
    (-zip-pair ligatures codepoints)))

                                        ; list can be found at https://github.com/i-tu/Hasklig/blob/master/GlyphOrderAndAliasDB#L1588
(setq my-hasklig-ligatures
      (let* ((ligs '("&&" "***" "*>" "\\\\" "||" "|>" "::"
                     "==" "===" "==>" "=>" "=<<" "!!" ">>"
                     ">>=" ">>>" ">>-" ">-" "->" "-<" "-<<"
                     "<*" "<*>" "<|" "<|>" "<$>" "<>" "<-"
                     "<<" "<<<" "<+>" ".." "..." "++" "+++"
                     "/=" ":::" ">=>" "->>" "<=>" "<=<" "<->")))
        (my-correct-symbol-bounds (my-ligature-list ligs #Xe100))))

;; nice glyphs for haskell with hasklig
(defun my-set-hasklig-ligatures ()
  "Add hasklig ligatures for use with prettify-symbols-mode."
  (setq prettify-symbols-alist
        (append my-hasklig-ligatures prettify-symbols-alist))
  (prettify-symbols-mode))

(add-hook 'haskell-mode-hook 'my-set-hasklig-ligatures)

(setq my-fira-code-ligatures
  (let* ((ligs '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
                "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
                "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
                "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
                ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
                "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
                "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
                "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
                ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
                "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
                "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
                "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
                "x" ":" "+" "+" "*")))
    (my-correct-symbol-bounds (my-ligature-list ligs #Xe100))))

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
         (text-mode . prettify-symbols-mode)))

;; (use-package nyan-mode
;;   :hook ((special-mode . nyan-mode)
;;          (text-mode . nyan-mode)
;;          (prog-mode . nyan-mode)))

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
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))
    "h" 'shrink-window-horizontally
    "l" 'enlarge-window-horizontally))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
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
  :config
  (evil-collection-init)
  (delete 'mu4e evil-collection-mode-list)
  (delete 'mu4e-conversation evil-collection-mode-list))

(use-package general
  :config
  (general-evil-setup t))

;; (general-create-definer dw/leader-key-def
;;   :keymaps '(normal insert visual emacs)
;;   :prefix "SPC"
;;   :global-prefix "C-SPC")

;;   (general-create-definer dw/ctrl-c-keys
;;     :prefix "C-c")

(use-package evil-tutor)

(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'ewal-spacemacs-classic t))
;;wildavil's default -> doom-paletnight

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

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

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

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
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0)))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Habits.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Birthdays.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Monday.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Tuesday.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Wendnesday.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Thrusday.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Friday.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Saturday.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Sunday.org"))

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
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(setq org-image-actual-width nil)

;; (use-package org-plus-contrib)

(require 'ox-taskjuggler)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (ipython . t)
     (python . t)
     ;; (julia . t)
     (ein . t)
     (browser . t)
     (ditaa . t)
     (css . t)
     (lisp . t)
     (clojure . t)
     (clojurescript . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(require 'ob-clojure)
(setq org-babel-clojure-backend 'cider)

(use-package ob-ipython)

(require 'org-tempo)

;; System
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;; Scientific
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("ju" . "src julia"))
(add-to-list 'org-structure-template-alist '("cl" . "src clojure"))
(add-to-list 'org-structure-template-alist '("ej" . "src ein-julia :session localhost"))
(add-to-list 'org-structure-template-alist '("ep" . "src ein-python :session localhost"))

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

(use-package org-download)

(use-package org-roam)

(use-package org-ref)

(use-package bibtex-utils)
(use-package company-bibtex)
(use-package gscholar-bibtex)

(use-package helm-bibtex)

(use-package org-roam-bibtex)

(use-package tj3-mode)

;; (use-package org-inline-image)

;;     (use-package org
 ;;     :init)
 ;; (eval-after-load 'ox-latex
 ;; (add-to-list 'org-export-latex-classes 'abntex2))

 (with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
		'("abntex2"
		  "\\documentclass{abntex2}"

		  ;; ("\\chapter{%s}" . "\\chapter*{%s}")
		  ("\\chapter{%s}" . "\\chapter*{%s}")
		  ("\\subsection{%(setq )}" . "\\section*{%s}")
		  ("\\subsubsection{%s}" . "\\subsection*{%s}")

		  )))

;; ("\\chapter{%s}" . "\\chapter*{%s}")
 ;;		      ("\\section{%s}" . "\\section*{%s}")
 ;;		      ("\\subsection{%(setq )}" . "\\subsection*{%s}")
 ;;		      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")

(defun reload-pdf ()
  (interactive
  (let* ((fname buffer-file-name)
        (fname-no-ext (substring fname 0 -4))
        (pdf-file (concat fname-no-ext ".pdf"))
        (cmd (format "pdflatex %s" fname)))
    (delete-other-windows)
    (split-window-horizontally)
    (split-window-vertically)
    (shell-command cmd)
    (other-window 2)
    (find-file pdf-file)
    (balance-windows))))

(global-set-key "\C-x\p" 'reload-pdf)

;; to use pdfview with auctex
 (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
    TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
    TeX-source-correlate-start-server t) ;; not sure if last line is neccessary

 ;; to have the buffer refresh after compilation
 (add-hook 'TeX-after-compilation-finished-functions
        #'TeX-revert-document-buffer)

(global-set-key (kbd "C-c C-x C-l") 'org-latex-preview)

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
    :keymaps 'lsp-mode-map
    :prefix lsp-keymap-prefix
    "d" '(dap-hydra t :wk "debugger")))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  (python-shell-interpreter "python3")
  (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

(use-package ein)
;; (use-package ob-ein)

(defun ob-ipython-inline-image (b64-string)
    "Write the b64-string to a temporary file.
    Returns an org-link to the file."
    (let* ((tfile (make-temp-file "ob-ipython-" nil ".png"))
	   (link (format "[[file:%s]]" tfile)))
      (ob-ipython--write-base64-string tfile b64-string)
      link))


  (defun org-babel-execute:ipython (body params)
    "Execute a block of IPython code with Babel.
    This function is called by `org-babel-execute-src-block'."
    (let* ((file (cdr (assoc :file params)))
	   (session (cdr (assoc :session params)))
	   (result-type (cdr (assoc :result-type params))))
      (org-babel-ipython-initiate-session session params)
      (-when-let (ret (ob-ipython--eval
		       (ob-ipython--execute-request
			(org-babel-expand-body:generic (encode-coding-string body 'utf-8)
						       params (org-babel-variable-assignments:python params))
			(ob-ipython--normalize-session session))))
	(let ((result (cdr (assoc :result ret)))
	      (output (cdr (assoc :output ret))))
	  (if (eq result-type 'output)
	      (concat
	       output 
	       (format "%s"
		       (mapconcat 'identity
				  (loop for res in result
					if (eq 'image/png (car res))
					collect (ob-ipython-inline-image (cdr res)))
				  "\n")))
	    (ob-ipython--create-stdout-buffer output)
	    (cond ((and file (string= (f-ext file) "png"))
		   (->> result (assoc 'image/png) cdr (ob-ipython--write-base64-string file)))
		  ((and file (string= (f-ext file) "svg"))
		   (->> result (assoc 'image/svg+xml) cdr (ob-ipython--write-string-to-file file)))
		  (file (error "%s is currently an unsupported file extension." (f-ext file)))
		  (t (->> result (assoc 'text/plain) cdr))))))))

;; #   (defun ob-ijulia-inline-image (b64-string)
;; #     "Write the b64-string to a temporary file.
;; #   Returns an org-link to the file."
;; #     (let* ((tfile (make-temp-file "ob-ijulia-" nil ".png"))
;; # 	   (link (format "[[file:%s]]" tfile)))
;; #       (ob-ijulia--write-base64-string tfile b64-string)
;; #       link))


;; #   (defun org-babel-execute:ijulia (body params)
;; #     "Execute a block of IJulia code with Babel.
;; #   This function is called by `org-babel-execute-src-block'."
;; #     (let* ((file (cdr (assoc :file params)))
;; # 	   (session (cdr (assoc :session params)))
;; # 	   (result-type (cdr (assoc :result-type params))))
;; #       (org-babel-ijulia-initiate-session session params)
;; #       (-when-let (ret (ob-ijulia--eval
;; # 		       (ob-ijulia--execute-request
;; # 			(org-babel-expand-body:generic (encode-coding-string body 'utf-8)
;; # 						       params (org-babel-variable-assignments:julia params))
;; # 			(ob-ijulia--normalize-session session))))
;; # 	(let ((result (cdr (assoc :result ret)))
;; # 	      (output (cdr (assoc :output ret))))
;; # 	  (if (eq result-type 'output)
;; # 	      (concat
;; # 	       output 
;; # 	       (format "%s"
;; # 		       (mapconcat 'identity
;; # 				  (loop for res in result
;; # 					if (eq 'image/png (car res))
;; # 					collect (ob-ijulia-inline-image (cdr res)))
;; # 				  "\n")))
;; # 	    (ob-ijulia--create-stdout-buffer output)
;; # 	    (cond ((and file (string= (f-ext file) "png"))
;; # 		   (->> result (assoc 'image/png) cdr (ob-ijulia--write-base64-string file)))
;; # 		  ((and file (string= (f-ext file) "svg"))
;; # 		   (->> result (assoc 'image/svg+xml) cdr (ob-ijulia--write-string-to-file file)))
;; # 		  (file (error "%s is currently an unsupported file extension." (f-ext file)))
;; # 		  (t (->> result (assoc 'text/plain) cdr))))))))

(use-package latex-math-preview)

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))
(use-package lsp-jedi)
(use-package jedi-core)
(use-package company-jedi)

(use-package elpy
    :init
    (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
    :bind (:map elpy-mode-map
	      ("<M-left>" . nil)
	      ("<M-right>" . nil)
	      ("<M-S-left>" . elpy-nav-indent-shift-left)
	      ("<M-S-right>" . elpy-nav-indent-shift-right)
	      ("M-." . elpy-goto-definition)
	      ("M-," . pop-tag-mark))
    :config
    (setq elpy-rpc-backend "jedi"))

(use-package anaconda-mode)
(use-package company-anaconda)
(use-package conda)

(use-package conda)
(setq 
 conda-env-home-directory (expand-file-name "~/.conda/") ;; as in previous example; not required
conda-env-subdirectory "envs")
(custom-set-variables '(conda-anaconda-home "/opt/anaconda/"))
;; if you want interactive shell support, include:
(conda-env-initialize-interactive-shells)
;; if you want eshell support, include:
(conda-env-initialize-eshell)
;; if you want auto-activation (see below for details), include:
(conda-env-autoactivate-mode t)

(use-package css-mode
  :bind ("C-c m" . css-lookup-symbol))

;; (use-package artist-mode)

(use-package indium
:hook (js-mode . indium-interaction-mode))

(use-package web-beautify
  :hook ((css-mode . web-beautify-css)
         ;; (js-mode . web-beautify-js)
         (html-mode . web-beautify-html)))

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

(use-package js2-mode
  :hook ((js-mode . js2-minor-mode)
         (js2-mode . ac-js2-mode)))

(use-package tern
  :load-path "~/.emacs.d/tern/"
  :after ((js-mode)
          (js2-mode))
  :hook ((js-mode . tern-mode)
         (js2-mode . tern-mode))
  :config (autoload 'tern-mode "tern.el" nil t))

(use-package rjsx-mode
  :ensure t
  :mode "\\.js\\'")

(defun setup-tide-node()
  "Setup function for tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save-mode-enabled))
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package tide
  :ensure t
  :after (rjsx-mode company flycheck)
  :hook (rjsx-mode . setup-tide-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode)
  :init
  (global-flycheck-mode t))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(use-package company
  :ensure t
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation nil
        )
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))

(use-package tide
  :init
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)))

(use-package css-mode
  :config
(setq css-indent-offset 2))

(use-package prettier-js
:ensure t
:after (rjsx-mode)
:hook (rjsx-mode . prettier-js-mode))

;; (use-package geiser
  ;; :after racket-mode
  ;; :hook (racket-mode . geiser-mode))

(use-package racket-mode
  :bind ("C-c l" . racket-insert-lambda)
  :config
  (when (racket-mode)
    (exec-path-from-shell-initialize)))

(use-package paredit)
  ;; :hook (prog-mode . paredit-mode))
  ;; :hook (prog-mode . paredit-mode))

(use-package evil-paredit)
  ;; :hook prog-mode)
  ;; :hook (prog-mode . paredit-mode))

;; (use-package smartparens
;;   :hook ((emacs-lisp-mode . smartparens-mode)
;;          (lisp-mode . smartparens-mode)
;;          (cider-mode . smartparens-mode)
;;          (clojure-mode . smartparens-mode)
;;          (racket-mode . smartparens-mode)))

(use-package evil-smartparens
  :hook ((after-init . evil-smartparens-mode)
	 (prog-mode . evil-smartparens-mode)
	 (text-mode . evil-smartparens-mode)
	 (special-mode . evil-smartparens-mode)))

(use-package slime
  :config
  (setq inferior-lisp-program "sbcl"))
(use-package ac-slime)
(use-package slime-company)

(global-set-key [f5] 'slime-js-reload)
 (add-hook 'js2-mode-hook
           (lambda ()
             (slime-js-minor-mode 1)))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

(use-package cider
  ;; :mode "\\.clj[sc]?\\'"
  :config
  (evil-collection-cider-setup)
  (setq cider-font-lock-dinamically '(macro core fucntion var))
  (setq cider-reader-conditional-face t))

(use-package clojure-mode)
;; (put '>defn 'clojure-doc-string-elt 2)
    ;;    (use-package clojure-mode-extra-font-locking
    ;;      :hook (clojure-mode . clojure-mode-extra-font-locking))
    ;; (use-package sotclojure
    ;;   :hook ((clojure-mode . sotclojure-mode)
    ;; 	     (cider-mode .sotclojure-mode)))
    ;; (use-package helm-clojuredocs
    ;;   :hook ((clojure-mode . helm-clojuredocs-mode)
    ;; 	     (cider-mode .sotclojure-mode)))
    ;; (use-package ivy-clojuredocs
    ;;   :hook ((clojure-mode . ivy-clojuredocs-mode)
    ;; 	     (cider-mode .sotclojure-mode)))
    ;; (use-package flycheck-clojure
    ;;   :hook ((clojure-mode . flycheck-mode)
    ;; 	     (cider-mode .sotclojure-mode)))

  ;;   (use-package clojure-snippets
  ;;     :hook ((clojure-mode . clojure-snippets-mode)
  ;;            (cider-mode .sotclojure-mode)))
  ;; ;; (use-package clojure-essential-ref
  ;;   :hook ((clojure-mode . clojure-essential-ref-mode)
  ;;          (cider-mode .sotclojure-mode)))
  ;; (use-package 4clojure
  ;;     :hook ((clojure-mode . 4clojure-mode)
  ;;            (cider-mode .sotclojure-mode)))
    ;; (use-package clojure-extra-font-locking
      ;; :hook (clojure-mode . clojure-extra-font-locking-mode))

(use-package lsp-julia)

(use-package julia-shell)
(use-package julia-vterm)
(use-package julia-snail)
(use-package flycheck-julia)
(use-package ob-ess-julia)
(use-package ob-julia-vterm)
(use-package julia-repl)

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

(use-package load-bash-alias
  :hook (eshell-mode . load-bash-alias))

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

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(use-package ace-link)
(ace-link-setup-default)

(define-key org-mode-map (kbd "ö") 'ace-link-org)
