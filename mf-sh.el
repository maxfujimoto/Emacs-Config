;(defun xrdb-xresources ()
;  "Running xrdb ~/.Xresources"
;  (when (eq major-mode 'conf-mode)
;    (shell-command-to-string (format "xrdb ~/.Xresources %s" buffer-file-name))))

;(add-hook 'after-save-hook #'xrdb-xresources)

;(defvar xresrouces
 ; '(("~/.Xresources" . "xrdb ~/.Xresrouces"))
 ; )

;(defun xrdb-xresources ()
;  "xrdb ~/.Xresource"
;  (let* ((match (assoc (buffer-file-name) xresrouces)))
;    (when match
;      (shell-command (cdr match)))))

;(add-hook 'after-save-hook 'xrdb-xresources)
