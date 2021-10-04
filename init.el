;-------   General   -------\
(global-auto-revert-mode t)

;;(setq default-directory "")

;-------   Package Manager   -------\

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
(require 'use-package))
(setq use-package-always-ensure t)

;-------   Completion   -------\
(use-package vertico
  :diminish
;  :bind (:map vertico-map
;	      ("" . vertico-next)
;	      ("" . vertico-previous)
;	      ("" . vertico-exit)
;	      :map minibuffer-local-map
;	      ("" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; Alternatively try `consult-completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

    ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;-------   Help   -------\
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1.5))

(use-package helpful
;;  :custom                           ; for ivy
;;  (describe-fucntion-function #'helpful-callable)
;;  (describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

;-------   General Tools   -------\

(use-package undo-tree)

(use-package pdf-tools
 :pin manual ;; manually update
 :config
 (pdf-tools-install)
 (setq-default pdf-view-display-size 'fit-page)
 (setq pdf-annot-activate-created-annotations t)
 (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

;-------   Version Control   -------\
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  ;;:custom ((projectile-completion-system 'vertico))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Documents")
    (setq projectile-project-search-path '("~/Documents")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit)
;;  :Custom                             ; opens diff in current buffer
;;  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

(use-package forge
  :after magit)

;-------   Load Paths   -------\

(load "~/.emacs.d/mf-gui.el")
(load "~/.emacs.d/mf-keys.el")
(load "~/.emacs.d/mf-templates.el")
(load "~/.emacs.d/mf-org.el")
(load "~/.emacs.d/mf-sh.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(which-key visual-fill-column vertico use-package undo-tree sublime-themes rainbow-delimiters projectile pdf-tools org-bullets orderless moe-theme mlscroll marginalia hydra helpful general forge evil-collection ebib doom-themes diminish)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
