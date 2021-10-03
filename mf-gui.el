;-------   Theme   -------\

(setq custom-theme-directory "~/.emacs.d/themes")

(use-package sublime-themes
   :config
   (load-theme 'brin t))

(use-package moe-theme)

(use-package doom-themes)

;-------   General   -------\

;;(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-set-key (kbd "<f5>") 'menu-bar-mode)
(set-fringe-mode 10)                    ; padding
(tooltip-mode -1)
;;(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		pdf-view-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;-------   GUI Packages   -------\

(use-package diminish)

(use-package rainbow-delimiters
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package mlscroll
  :config
;;  breaks evil status indicator
;;  (setq mlscroll-shortfun-min-width 11) ;truncate which-func, for default mode-line-format's
  (mlscroll-mode 1))

;-------   Fonts    -------\

;(set-face-attribute 'default nil :font "FONT NAME" :height ##)
