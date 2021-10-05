;-------   Save Hooks   -------\

(defun mf/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
		      (expand-file-name user-emacs-directory))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'mf/org-babel-tangle-config)))


;;  (defun mf/xrdb-xresources ()
;;    (when (string-equal (file-name-directory (buffer-file-name)
;; 					    (expand-file-name ~/.Xresources))
;; 		   (let ((shell-command

;; ;; (add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'mf/xrdb-xresources)))


;;     ;(defun xrdb-xresources ()
;;  "Running xrdb ~/.Xresources"
;;  (when (eq major-mode 'conf-mode)
;;    (shell-command-to-string (format "xrdb ~/.Xresources %s" buffer-file-name))))

;;(add-hook 'after-save-hook #'xrdb-xresources)

;;(defvar xresrouces
;; '(("~/.Xresources" . "xrdb ~/.Xresrouces"))
;; )

;;(defun xrdb-xresources ()
;;  "xrdb ~/.Xresource"
;;  (let* ((match (assoc (buffer-file-name) xresrouces)))
;;    (when match
;;      (shell-command (cdr match)))))

	;(add-hook 'after-save-hook 'xrdb-xresources)

(setq gc-cons-threshold (* 2 1000 1000))
