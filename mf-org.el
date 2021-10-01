					;-------   Packages   -------\
(defun mf/org-mode-setup ()
  (org-indent-mode)
;;  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . mf/org-mode-setup)
  :config ;((setq org-ellipsis " ▾")
	   (setq org-startup-folded t))
  

(setq org-todo-keywords
      '((type "TODO" "HOLD" "|" "DONE")))

(use-package org-bullets
  :after org
  :hook (orgmode . org-bullets-mode))

 (defun mf/org-mode-visual-fill ()
   (setq visual-fill-column-width 50
         visual-fill-column-center-text t)
   (visual-fill-column-mode 1))

(use-package visual-fill-column
   :hook (org-mode . mf/org-mode-visual-fill))

					;-------   Agenda   -------\
(setq org-agenda-files
      '("~/Documents/Org/todo.org"
	"~/Documents/org/to_get.org"
	"~/Documents/Org/agenda.org"))

(setq org-log-agenda-sater-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)

;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))        
;(define-key global-map "\C-cl" 'org-store-link)
;(define-key global-map "\C-ca" 'org-agenda)
;(define-key global-map "\C-cc" 'org-capture)
