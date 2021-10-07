;-------   Org Function   -------\

(defun mf/org-mode-setup ()
  (diminish 'org-indent-mode)
  ;;  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(defun mf/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

;-------   Packages   -------\

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . mf/org-mode-setup)
  :config (setq org-startup-folded t
		;;org-ellipsis " ▾"
		org-log-agenda-sater-with-log-mode t
		org-log-done 'time
		org-log-into-drawer t))

(setq org-todo-keywords
      '((type "TODO(t)" "HOLD(h)" "NEXT(n)" "|" "DONE(d!)")))

(setq org-refile-targets
      '(("Archive.org" :maxlevel . 1)
	("Tasks.org" :maxlevel . 1)))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

(use-package visual-fill-column
   :hook (org-mode . mf/org-mode-visual-fill))

;-------   Agenda   -------\

(setq org-agenda-files
      '("~/Documents/Org/todo.org"
	"~/Documents/Org/to_get.org"))


(setq org-agenda-custom-commands
      '(("o" "Overview"
	 ((agenda "" ((org-deadline-warning-days 7)))
	  (todo "NEXT"
		((org-agenda-overriding-header "Next Tasks")))
	  (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

	("n" "Next Tasks"
	 ((todo "NEXT"
		((org-agenda-overriding-header "Next Tasks")))))


	("d" "Computer" tags-todo "computer")

	("l" "Learn" tags-todo "learn")

	("r" "Write" tags-todo "write")

	("w" "Elec Eng" tags-todo "ee")

	("p" "Music Production" tags-todo "music")

	("W" "Workflow"
	 ((todo "PLAN"
		((org-agenda-overriding-header "Plan")
		 (org-agenda-FILES ORG-AGENDA-files)))
	  (todo "DESIGN"
		((org-agenda-overriding-header "Design")
		 (org-agenda-files org-agenda-files)))
	  (todo "MAKE"
		((org-agenda-overriding-header "Make")
		 (org-agenda-files org-agenda-files)))))))

(setq org-tag-alist
      '((:startgroup)
	;; Put mutually exclusive tags here
	(:endgroup)
	("computer" . ?d)
	("learn" . ?l)
	("write" . ?r)
	("make" . ?f)
	("ee" . ?w)
	("music" . ?p)
	("idea" . ?i)))

;-------   Org Keys   -------\

;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))        
;;(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
;;(define-key global-map (kbd "C-c c")
;;    (lambda () (interactive) (org-capture nil "jj")))
