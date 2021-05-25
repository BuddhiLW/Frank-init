;;; lockfile-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "lockfile-mode" "lockfile-mode.el" (0 0 0 0))
;;; Generated autoloads from lockfile-mode.el

(autoload 'lockfile-mode "lockfile-mode" "\
A minimalistic major mode for `.lock' files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.lock\\'" . lockfile-mode))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; lockfile-mode-autoloads.el ends here
