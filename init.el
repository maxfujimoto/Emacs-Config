					;-------   General   -------\

					;sets default visit file directory
					;must end in slash?

;(setq default-directory "")

					;-------   Packages   -------\

(package-initialize)
(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


					;-------   Custom   -------\
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package sublime-themes ebib org-bullets))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))


					;------- use-package -------\


(eval-when-compile
  (require 'use-package))

					;-------   Load Paths   -------\

(load "~/.emacs.d/mf-gui.el")
;(load "~/.emacs.d/mf-keys.el")
(load "~/.emacs.d/mf-org.el")
(load "~/.emacs.d/mf-templates.el")
