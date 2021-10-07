;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "*** Emacs loaded in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))

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
;(setq use-package-verbose t)

;-------   Completion   -------\
(use-package vertico
  :diminish
  :bind (:map vertico-map
	      ;; ("" . vertico-next)
	      ;; ("" . vertico-previous)
	      ("C-f" . vertico-exit))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :after vertico
  :config
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package orderless
  :after vertico 
  :init
  (setq completion-styles '(orderless)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

(defun mf/get-project-root ()
  (when (fboundp 'projectile-project-root)
    (projectile-project-root)))

(use-package consult
  :demand t
  :bind (("C-s" . consult-line)
	 ("C-M-l" . consult-imenu)
	 ("C-M-j" . persp-switch-to-buffer*)
	 :map minibuffer-local-map
	 ("C-r" . consult-history))
  :custom
  (consult-project-root-function #'mf/get-project-root)
  (completion-in-region-function #'consult-completion-in-region))

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

;-------   LSP   -------\

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . mf/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package eglot
  :after lsp-mode
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
	 (lambda () (require 'eglot) (lsp)))
  :config (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))) 

(use-package web-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))

;; 1. Start the server with `httpd-start'
;; 2. Use `impatient-mode' on any buffer
(use-package impatient-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'")

(use-package skewer-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'")

(use-package company
  :after lsp-mode
  :diminish 
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
	      ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :diminish 
  :hook (company-mode . company-box-mode))

;-------   Help   -------\

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
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

(use-package undo-tree
  :defer t) 

(use-package pdf-tools
  :defer t
  :pin manual ;; manually update
  :mode ("\\.pdf\\'" . pdf-view-mode)
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

(use-package magit
:commands magit-status)
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

;-------   File Types   -------\

;;  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
