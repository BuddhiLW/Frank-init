;;; pnpm-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pnpm-mode" "pnpm-mode.el" (0 0 0 0))
;;; Generated autoloads from pnpm-mode.el

(autoload 'pnpm-mode "pnpm-mode" "\
Minor mode for working with pnpm projects.

If called interactively, enable Pnpm mode if ARG is positive, and
disable it if ARG is zero or negative.  If called from Lisp, also
enable the mode if ARG is omitted or nil, and toggle it if ARG is
`toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(put 'pnpm-global-mode 'globalized-minor-mode t)

(defvar pnpm-global-mode nil "\
Non-nil if Pnpm-Global mode is enabled.
See the `pnpm-global-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `pnpm-global-mode'.")

(custom-autoload 'pnpm-global-mode "pnpm-mode" nil)

(autoload 'pnpm-global-mode "pnpm-mode" "\
Toggle Pnpm mode in all buffers.
With prefix ARG, enable Pnpm-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Pnpm mode is enabled in all buffers where
`pnpm-mode' would do it.
See `pnpm-mode' for more information on Pnpm mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pnpm-mode" '("pnpm-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pnpm-mode-autoloads.el ends here
