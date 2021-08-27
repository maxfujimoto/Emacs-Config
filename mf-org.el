					;-------   Packages   -------\
(require 'org)
(require 'org-bullets)
(add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-todo-keywords
      '((type "TODO" "COM" "EE" "MUSIC" "GET" "|" "DONE" "HOLD")))
					;-------   Agenda   -------\
;(setq org-agenda-files
;      (list "~/org/Todo.org" "~/org/Notes.org" "~/org/Agenda.org"))
;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))        
;(define-key global-map "\C-cl" 'org-store-link)
;(define-key global-map "\C-ca" 'org-agenda)
;(define-key global-map "\C-cc" 'org-capture)
;(setq org-log-done t)
