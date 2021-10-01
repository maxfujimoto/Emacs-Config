					;-------   Theme   -------\

(use-package sublime-themes
   :config
   (load-theme 'brin t))

					;-------   Menus & Gui   -------\

;;(setq inhibit-startup-message t)
;;(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-set-key (kbd "<f5>") 'menu-bar-mode)
(set-fringe-mode 10)                    ; paddingcolumn
;;(tooltip-mode -1)
;;(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		pdf-view-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

					;-------   Fonts    -------\

;(set-face-attribute 'default nil :font "FONT NAME" :height ##)
