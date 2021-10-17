;-------   Key Packages   -------\

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-mode-line-format 'before)
  (setq evil-disable-insert-state-bindings t)
  ;;(setq evil-undo-system undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :diminish evil-collection-unimpaired-mode
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-create-definer mf/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC"
    ))

 (use-package which-key
   :defer 0 
   :diminish which-key-mode
   :config
   (which-key-mode)
   (setq which-key-idle-delay 1.5))

(use-package hydra
  :defer t)

;-------   Key Binds   -------\


(evil-collection-define-key 'normal 'dired-mode-map
  "h" 'dired-single-up-directory
  "H" 'dired-omit-mode
  "l" 'dired-single-buffer
  "y" 'dired-ranger-copy
  "X" 'dired-ranger-move
  "p" 'dired-ranger-paste)

;-------   Which and Leader Keys   -------\

(mf/leader-keys
  "t" '(:ignore t :which-key "toggles")
  "f" '(:ignore t :which-key "find")
  "ts" '(hydra-text-scale/body :which-key "scale text")
  "ff" '(hydra-find-file/body :which-key "find file")
  "fd" '(hydra-find-dir/body :which-key "find directory")
  "b" '(hydra-switch-buffer/body :which-key "switch buffer")
  "w" '(hydra-switch-window/body :which-key "switch window"))

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("<escape>" nil "finished" :exit t))

(defhydra hydra-find-file (:timeout 4)
  "select file"
  ("e" (find-file (expand-file-name "~/.emacs.d/emacs.org"))"emacs.org" :exit t)
  ("t" (find-file (expand-file-name "~/Org/todo.org"))"todo.org" :exit t)
  ("n" (find-file (expand-file-name "~/Org/notes.org"))"notes.org" :exit t)
  ("r" (find-file (expand-file-name "~/Documents/Recipe_Book/Recipe_Book_2/recipes.org"))"recipes.org" :exit t)
  ("<escape>" nil "exit" :exit t))

(defhydra hydra-find-dir (:timeout 4)
  "select dir"
  ("e" (dired (expand-file-name "~/.emacs.d"))".emacs.d" :exit t)
  ("c" (dired (expand-file-name "~/Code"))"Code" :exit t)
  ("p" (dired (expand-file-name "~/Documents/PDFs"))"PDFs" :exit t)
  ("<escape>" nil "exit" :exit t))

(defhydra hydra-switch-buffer (:timeout 4)
  "switch buffer"
  ("j" (switch-to-next-buffer)"next")
  ("k" (switch-to-prev-buffer)"previous")
  ("q" (delete-window)"close")
  ("Q" (kill-this-buffer)"kill")
  ("<escape>" nil "exit" :exit t))

(defhydra hydra-switch-window (:timeout 4)
  "switch window"
  ("j" (other-window 1)"next")
  ("k" (other-window -1)"previous")
  ("q" (delete-window)"close") 
  ("Q" (kill-this-buffer)"kill") 
  ("<escape>" nil "exit" :exit t))
