;-------   Tempo Templates   -------\

    (with-eval-after-load 'org
      ;; This is needed as of Org 9.2
      (require 'org-tempo)

      (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
      (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
      (add-to-list 'org-structure-template-alist '("eli" . "src emacs-lisp :tangle ./init.el"))
      (add-to-list 'org-structure-template-alist '("elg" . "src emacs-lisp :tangle ./mf-gui.el"))
      (add-to-list 'org-structure-template-alist '("elk" . "src emacs-lisp :tangle ./mf-keys.el"))
      (add-to-list 'org-structure-template-alist '("elo" . "src emacs-lisp :tangle ./mf-org.el"))
      (add-to-list 'org-structure-template-alist '("elt" . "src emacs-lisp :tangle ./mf-templates.el"))
      (add-to-list 'org-structure-template-alist '("els" . "src emacs-lisp :tangle ./mf-sh.el"))
      (add-to-list 'org-structure-template-alist '("py" . "src python"))
      (tempo-define-template "org-recipe"
		   '( "** "p n n
		      "*** Meta:" n n
		      "   Dificulty    : " n
		      "   Time         : " n
		      "   Time Cooking : " n
		      "   Servings     : " n
		      "   Equipment    : "n n
		      "*** Ingredients:"n n
		      "    | Ingredient | Amount |" n
		      "    |------------+--------|" n
		      "    |            |        |" n
		      "    |            |        |" n
		      "    |            |        |"n n
		      "*** Instrucions:"n n
		      "    1. "n n
		      "*** Notes:"n n
		      "    - " n
		      )
		   "<r" "Insert org-recipe" 'org-tempo-tags))


					;-------   Org Capture Templates   -------\

(setq org-capture-templates
      `(("t" "Tasks / Projects")
	("tt" "Task" entry (file+olp "/Org/todo.org" "Captured")
	 "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

	("j" "Journal Entries")
	("jj" "Journal" entry
	 (file+olp+datetree "~/Org/journal.org")
	 "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
	 ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
	 :clock-in :clock-resume
	 :empty-lines 1)))
	;; ("jm" "Meeting" entry
	;;  (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
	;;  "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
	;;  :clock-in :clock-resume
	;;  :empty-lines 1)))

	;; ("w" "Workflows")
	;; ("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
	;;  "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

	;; ("m" "Metrics Capture")
	;; ("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
	;;  "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))
