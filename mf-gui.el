					;-------   Theme   -------\

(use-package sublime-themes
   :config
   (load-theme 'brin t))

					;-------   Gui-Menus   -------\
(menu-bar-mode -1) 
(tool-bar-mode -1) 

(global-set-key (kbd "<f5>") 'menu-bar-mode)
