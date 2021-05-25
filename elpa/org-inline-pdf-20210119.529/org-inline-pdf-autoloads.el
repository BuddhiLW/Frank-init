;;; org-inline-pdf-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-inline-pdf" "org-inline-pdf.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from org-inline-pdf.el

(autoload 'org-inline-pdf-mode "org-inline-pdf" "\
Toggle inline previewing of PDF images in Org buffer.

If called interactively, enable Org-Inline-Pdf mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-inline-pdf" '("org-inline-pdf-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-inline-pdf-autoloads.el ends here
