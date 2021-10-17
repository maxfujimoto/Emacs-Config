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
		Info-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		pdf-view-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;-------   Theme   -------\
(setq custom-theme-directory "~/.emacs.d/themes")

;; (use-package timu-spacegrey-theme
;;   :ensure t
;;   :config
;;   (load-theme 'timu-spacegrey t))

(load-theme 'mf-spacegrey t)

;; (use-package sublime-themes)
;; ;;	:config
;; ;;	(load-theme 'brin t))

;; (use-package moe-theme
;;   :defer 0)

;; (use-package doom-themes
;;   :defer 0)

;-------   GUI Packages   -------\

(use-package diminish)

(eval-after-load "eldoc"
   '(diminish 'eldoc-mode))

(diminish 'abbrev-mode)

(use-package rainbow-delimiters
  :diminish
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package mlscroll
  :config
;;  breaks evil status indicator
;;  (setq mlscroll-shortfun-min-width 11) ;truncate which-func, for default mode-line-format's
  (mlscroll-mode 1))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(autoload 'dired-omit-mode "dired-x")	

(use-package dired-single
  :commands (dired dired-jump))

(use-package dired-ranger
  :defer t)

(use-package dired-collapse
  :defer t)

;-------   Fonts    -------\

;(set-face-attribute 'default nil :font "FONT NAME" :height ##)
