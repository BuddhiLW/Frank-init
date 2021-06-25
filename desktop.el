;; (defun efs/run-in-background (command)
    ;;   (let ((command-parts (split-string command "[ ]+")))
    ;;     (apply #'call-process `(,(car command-parts) nil 0 nil ,@(cdr command-parts)))))

    (defun  efs/set-wallpaper ()
      (interactive)
      ;; note: you will need to update this to a valid background path!
      (start-process-shell-command
       "feh" nil  "feh --bg-scale ~/wpp/3354772.jpg"))

    ;; # (defun efs/exwm-init-hook ()
    ;; #     ;; make workspace 1 be the one where we land at startup
    ;; #     (exwm-workspace-switch-create 1)

    ;; #     ;; open eshell by default
    ;; #     ;;(eshell)

    ;; #     ;; NOTE: The next two are disabled because we now use Polybar!

    ;; #     ;; Show battery status in the mode line
    ;; #     ;;(display-battery-mode 1)

;; Show the time and date in modeline
(setq display-time-day-and-date t)
(display-time-mode 0)
;; #     ;; Also take a look at display-time-format and format-time-string

;; Start the Polybar panel
;; (efs/start-panel)

;; Launch apps that will run in the background
;; (efs/run-in-background "dunst")
    ;; #     ;; (efs/run-in-background "nm-applet")
    ;; #     (efs/run-in-background "pasystray"i))
    ;; #     ;; (efs/run-in-background "blueman-applet"))

(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

       (defun efs/exwm-update-title ()
	 (pcase exwm-class-name
	   ("Brave" (exwm-workspace-rename-buffer (format "Brave: %s" exwm-title)))
	   ("Nyxt" (exwm-workspace-rename-buffer (format "Nyxt: %s" exwm-title)))))

    ;; #   ;; This function isn't currently used, only serves as an example how to
    ;; #   ;; position a window
    ;; #   (defun efs/position-window ()
    ;; #     (let* ((pos (frame-position))
    ;; # 	   (pos-x (car pos))
    ;; # 	    (pos-y (cdr pos)))

    ;; #       (exwm-floating-move (- pos-x) (- pos-y))))

    ;; #   (defun efs/configure-window-by-class ()
    ;; #     (interactive)
    ;; #     (pcase exwm-class-name
    ;; #       ("Firefox" (exwm-workspace-move-window 2))
    ;; #       ("Sol" (exwm-workspace-move-window 3))
    ;; #       ("mpv" (exwm-floating-toggle-floating)
    ;; # 	     (exwm-layout-toggle-mode-line))))

    ;; #   ;; This function should be used only after configuring autorandr!
    ;; #   (defun efs/update-displays ()
    ;; #     (efs/run-in-background "autorandr --change --force")
    ;; #     (efs/set-wallpaper)
    ;; #     (message "Display config: %s"
    ;; # 	     (string-trim (shell-command-to-string "autorandr --current"))))

    ;; #   (use-package exwm
    ;; #     :config
    ;; #     ;; Set the default number of workspaces
    ;; #     (setq exwm-workspace-number 5)

    ;; #     ;; When window "class" updates, use it to set the buffer name
    ;; #     (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

    ;; #     ;; When window title updates, use it to set the buffer name
    ;; #     (add-hook 'exwm-update-title-hook #'efs/exwm-update-title)

    ;; #     ;; Configure windows as they're created
    ;; #     (add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

    ;; #     ;; When EXWM starts up, do some extra confifuration
    ;; #     (add-hook 'exwm-init-hook #'efs/exwm-init-hook)

    ;; #     ;; Rebind CapsLock to Ctrl
    ;; #     (start-process-shell-command "xmodmap" nil "xmodmap ~/.emacs.d/exwm/Xmodmap")

    ;; #     ;; NOTE: Uncomment the following two options if you want window buffers
    ;; #     ;;       to be available on all workspaces!

    ;; #     ;; Automatically move EXWM buffer to current workspace when selected
    ;; #     ;; (setq exwm-layout-show-all-buffers t)

    ;; #     ;; Display all EXWM buffers in every workspace buffer list
   (setq exwm-workspace-show-all-buffers t)

    ;; #     ;; NOTE: Uncomment this option if you want to detach the minibuffer!
    ;; #     ;; Detach the minibuffer (show it with exwm-workspace-toggle-minibuffer)
    ;; #     ;;(setq exwm-workspace-minibuffer-position 'top)

    ;; #     ;; Set the screen resolution (update this to be the correct resolution for your screen!)
    ;; #     (require 'exwm-randr)
    ;; #     (exwm-randr-enable)
    ;; #     (start-process-shell-command "xrandr" nil "xrandr --output Virtual-1 --primary --mode 2048x1152 --pos 0x0 --rotate normal")

    ;; #     ;; This will need to be updated to the name of a display!  You can find
    ;; #     ;; the names of your displays by looking at arandr or the output of xrandr
    ;; #     (setq exwm-randr-workspace-monitor-plist '(2 "Virtual-2" 3 "Virtual-2"))

    ;; #     ;; NOTE: Uncomment these lines after setting up autorandr!
    ;; #     ;; React to display connectivity changes, do initial display update
    ;; #     ;; (add-hook 'exwm-randr-screen-change-hook #'efs/update-displays)
    ;; #     ;; (efs/update-displays)

    ;; #     ;; Set the wallpaper after changing the resolution
	(efs/set-wallpaper)

    ;; #     ;; NOTE: This is disabled because we now use Polybar!
    ;; #     ;; Load the system tray before exwm-init
    ;; #     ;; (require 'exwm-systemtray)
    ;; #     ;; (setq exwm-systemtray-height 32)
    ;; #     ;; (exwm-systemtray-enable)

;;     ;; Automatically send the mouse cursor to the selected workspace's display
;;     (setq exwm-workspace-warp-cursor t)

;;     ;; Window focus should follow the mouse pointer
;;     (setq mouse-autoselect-window t
;;           focus-follows-mouse t)

;;     ;; These keys should always pass through to Emacs
;;     (setq exwm-input-prefix-keys
;;           '(?\C-x
;;             ?\C-u
;;             ?\C-h
;;             ?\M-x
;;             ?\M-`
;;             ?\M-&
;;             ?\M-:
;;             ?\C-\M-j  Buffer list
;;             ?\C-\ )) ;; Ctrl+Space

;; Ctrl+Q will enable the next key to be sent directly
;; (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;;     ;; Set up global key bindings.  These always work, no matter the input state!
;;     ;; Keep in mind that changing this list after EXWM initializes has no effect.
(setq exwm-input-global-keys
      `(
	;;             Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
	([?\s-r] . exwm-reset)

	;;             Move between windows
	([s-left] . windmove-left)
	;; ([s-j] . windmove-left)
	([s-right] . windmove-right)
	;; ([s-left] . windmove-left)
	([?\s-k] . windmove-up)
	([s-up] . windmove-up)
	([?\s-j] . windmove-down)
	([s-down] . windmove-down)

;;             ;; Launch applications via shell command
	([?\s-&] . (lambda (command)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command command nil command)))

;;             ;; Switch workspace
	([?\s-w] . exwm-workspace-switch)
	([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))

;;             ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
      ,@(mapcar (lambda (i)
		  `(,(kbd (format "s-%d" i)) .
		    (lambda ()
		      (interactive)
		      (exwm-workspace-switch-create ,i))))
		(number-sequence 0 9))))

;; (exwm-input-set-key (kbd "s-SPC") 'counsel-linux-app)

;;     (exwm-enable))

(use-package desktop-environment
  :after exwm
  :config (desktop-environment-mode)
  :custom
  (desktop-environment-brightness-small-increment "2%+")
  (desktop-environment-brightness-small-decrement "2%-")
  (desktop-environment-brightness-normal-increment "5%+")
  (desktop-environment-brightness-normal-decrement "5%-"))

;; Make sure the server is started (better to do this in your main Emacs config!)
(server-start)

(defvar efs/polybar-process nil
  "Holds the process of the running Polybar instance, if any")

(defun efs/kill-panel ()
  (interactive)
  (when efs/polybar-process
    (ignore-errors
      (kill-process efs/polybar-process)))
  (setq efs/polybar-process nil))

(defun efs/start-panel ()
  (interactive)
  (efs/kill-panel)
  (setq efs/polybar-process (start-process-shell-command "polybar" nil "polybar panel")))

(defun efs/send-polybar-hook (module-name hook-index)
  (start-process-shell-command "polybar-msg" nil (format "polybar-msg hook %s %s" module-name hook-index)))

(defun efs/send-polybar-exwm-workspace ()
  (efs/send-polybar-hook "exwm-workspace" 1))

;; Update panel indicator when workspace changes
(add-hook 'exwm-workspace-switch-hook #'efs/send-polybar-exwm-workspace)

(global-set-key (kbd "s-b") 'efs/start-panel)
(global-set-key (kbd "C-x s-b") 'efs/kill-panel)

(defun efs/disable-desktop-notifications ()
  (interactive)
  (start-process-shell-command "notify-send" nil "notify-send \"DUNST_COMMAND_PAUSE\""))

(defun efs/enable-desktop-notifications ()
  (interactive)
  (start-process-shell-command "notify-send" nil "notify-send \"DUNST_COMMAND_RESUME\""))

(defun efs/toggle-desktop-notifications ()
  (interactive)
  (start-process-shell-command "notify-send" nil "notify-send \"DUNST_COMMAND_TOGGLE\""))

(setq erc-server "irc.libera.chat"
      erc-nick "buddhilw"
      src-user-full-name "Litte White"
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc-libera.chat" "#systemcrafters" "#emacs"))
      erc-kill-buffer-on-part t
      erc-auto-query 'bury)

;; (use-package mu4e)
;; (use-package evil-mu4e)

(use-package mu4e
:ensure nil
;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
;; :defer 20 ; Wait until 20 seconds after startup
:config

;; This is set to 't' to avoid mail syncing issues when using mbsync
(setq mu4e-change-filenames-when-moving t)

;; Refresh mail using isync every 10 minutes
(setq mu4e-update-interval (* 10 60))
(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-maildir "~/Mail")

(setq mu4e-drafts-folder "/[Gmail]/Drafts")
(setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
(setq mu4e-refile-folder "/[Gmail]/All Mail")
(setq mu4e-trash-folder  "/[Gmail]/Trash")

(setq mu4e-maildir-shortcuts
  '((:maildir "/Inbox"    :key ?i)
    (:maildir "/[Gmail]/Sent Mail" :key ?s)
    (:maildir "/[Gmail]/Trash"     :key ?t)
    (:maildir "/[Gmail]/Drafts"    :key ?d)
    (:maildir "/[Gmail]/All Mail"  :key ?a))))

;; (use-package mu4e-alert)

;; (add-to-list 'load-path "~/yay/")
;; 
;; (require 'mu4e)

;; ;; Input method and key binding configuration.
;; (setq alternative-input-methods
;;       '(("chinese-tonepy" . [?\œ])
;;         '("chinese-sisheng"   . [?\¶])))

;; (setq default-input-method
;;       (caar alternative-input-methods))

;; (defun toggle-alternative-input-method (method &optional arg interactive)
;;   (if arg
;;       (toggle-input-method arg interactive)
;;     (let ((previous-input-method current-input-method))
;;       (when current-input-method
;;         (deactivate-input-method))
;;       (unless (and previous-input-method
;;                    (string= previous-input-method method))
;;         (activate-input-method method)))))

;; (defun reload-alternative-input-methods ()
;;   (dolist (config alternative-input-methods)
;;     (let ((method (car config)))
;;       (global-set-key (cdr config)
;;                       `(lambda (&optional arg interactive)
;;                          ,(concat "Behaves similar to `toggle-input-method', but uses \""
;;                                   method "\" instead of `default-input-method'")
;;                          (interactive "P\np")
;;                          (toggle-alternative-input-method ,method arg interactive))))))

;; (reload-alternative-input-methods)

(defun efs/exwm-update-class ()
  (exwm-workspace-rename-buffer exwm-class-name))

(use-package exwm
  :config
  ;; Set the default number of workspaces
  (setq exwm-workspace-number 5)

  ;; When window "class" updates, use it to set the buffer name
  ;; (add-hook 'exwm-update-class-hook #'efs/exwm-update-class)

  ;; These keys should always pass through to Emacs
  (setq exwm-input-prefix-keys
        '(?\C-x
          ?\C-u
          ?\C-h
          ?\M-x
          ?\M-`
          ?\M-&
          ?\M-:
          ?\C-\M-j  ;; Buffer list
          ?\C-\ ))  ;; Ctrl+Space

  ;; Ctrl+Q will enable the next key to be sent directly
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

  ;; Set up global key bindings.  These always work, no matter the input state!
  ;; Keep in mind that changing this list after EXWM initializes has no effect.
  (setq exwm-input-global-keys
        `(
          ;; Reset to line-mode (C-c C-k switches to char-mode via exwm-input-release-keyboard)
          ([?\s-r] . exwm-reset)

          ;; Move between windows
          ([s-left] . windmove-left)
          ([s-right] . windmove-right)
          ([s-up] . windmove-up)
          ([s-down] . windmove-down)

          ;; Launch applications via shell command
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))

          ;; Switch workspace
          ([?\s-w] . exwm-workspace-switch)

          ;; 's-N': Switch to certain workspace with Super (Win) plus a number key (0 - 9)
          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))

  (exwm-enable))

(use-package restart-emacs)

;; (global-set-key (kbd "s-l") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x s-b") 'efs/kill-panel)

(use-package evil-multiedit
  :hook (web-mode . evil-multiedit-mode))

(use-package calendar
  :config
  (require 'generic)
  (define-generic-mode 'fancy-diary-display-mode
    nil
    (list "Exception" "Location" "Desc")
    '(
      ("\\(.*\\)\n\\(=+\\)"            ;; Day title / separator lines
       (1 'font-lock-keyword-face) (2 'font-lock-preprocessor-face))
      ("^\\(todo [^:]*:\\)\\(.*\\)$"   ;; To do entries
       (1 'font-lock-string-face) (2 'font-lock-reference-face))
      ("\\(\\[.*\\]\\)"                ;; Category labels
       1 'font-lock-constant-face)
      ("^\\(0?\\([1-9][0-9]?:[0-9][0-9]\\)\\([ap]m\\)?\\(-0?\\([1-9][0-9]?:[0-9][0-9]\\)\\([ap]m\\)?\\)?\\)"
       1 'font-lock-type-face))        ;; Time intervals at start of lines.
    nil
    (list
     (function
      (lambda ()
	(turn-on-font-lock))))
    "Mode for fancy diary display."))

(use-package unicode-fonts
   :ensure t
   :config
    (unicode-fonts-setup))

(use-package dynamic-fonts)

(use-package ucs-utils)

;; (use-package powerline
  ;; :ensure
  ;; :init
  ;; (powerline-evil-theme))
(require 'powerline)
(powerline-center-evil-theme)

(setq frame-title-format
      '(buffer-file-name "%b - %f" ; File buffer
        (dired-directory dired-directory ; Dired buffer
         (revert-buffer-function "%b" ; Buffer Menu
          ("%b - Dir: " default-directory)))))
