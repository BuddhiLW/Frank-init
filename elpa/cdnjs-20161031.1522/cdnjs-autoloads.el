;;; cdnjs-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "cdnjs" "cdnjs.el" (0 0 0 0))
;;; Generated autoloads from cdnjs.el

(autoload 'cdnjs-install-gocdnjs "cdnjs" "\
Install `gocdnjs' command to `cdnjs--gocdnjs-bin-dir'.

wget and unzip commands are required to use this function." t nil)

(autoload 'cdnjs-list-packages "cdnjs" "\
List packages that are retrieved from cdnjs.com." t nil)

(autoload 'cdnjs-describe-package "cdnjs" "\
Describe the PACKAGE information." t nil)

(autoload 'cdnjs-insert-url "cdnjs" "\
Insert URL of a JavaScript or CSS package." t nil)

(autoload 'cdnjs-select-and-insert-url "cdnjs" "\
Select version and file of a JavaScript or CSS package, then insert URL." t nil)

(autoload 'cdnjs-update-package-cache "cdnjs" "\
Update the package cache file." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cdnjs" '("cdnjs-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cdnjs-autoloads.el ends here
