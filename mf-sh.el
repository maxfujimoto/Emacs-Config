;-------   Save Hooks   -------\

(defun mf/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
		      (expand-file-name user-emacs-directory))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'mf/org-babel-tangle-config)))


(defun mf/xrdb-xresources ()
  (when (string-equal (buffer-file-name)
		      (expand-file-name "~/.dotfiles/.Xresources"))
    (and (shell-command "xrdb ~/.Xresources")
	 (message "xrdb updated"))))


(add-hook 'conf-mode-hook (lambda () (add-hook 'after-save-hook #'mf/xrdb-xresources)))


;; (defun mf/dropbox ()
;;   (while (string-equal (file-name-directory)
;; 		       (expand-file-name "~/Dropbox"))
;;     (shell-command "dropbox")))

;; (add-hook ??)

     ;;     ;(defun xrdb-xresources ()
     ;;  "Running xrdb ~/.Xresources"
     ;;  (when (eq major-mode 'conf-mode)
     ;;    (shell-command-to-string (format "xrdb ~/.Xresources %s" buffer-file-name))))

     ;;(defun xrdb-xresources ()
     ;;  "xrdb ~/.Xresource"
     ;;  (let* ((match (assoc (buffer-file-name) xresrouces)))
     ;;    (when match
     ;;      (shell-command (cdr match)))))

     (setq gc-cons-threshold (* 2 1000 1000))
