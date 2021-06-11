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
