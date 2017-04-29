;;; package --- summary:
;;; Commentary:
;;; Code:

;; Initialize use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;;; Load files in config folder
(cl-loop for file in (directory-files ".emacs.d/config" t)
	 when (string-match "\\.el$" file)
	 do (load file))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Packages
(use-package zenburn-theme
  :ensure t
)

(use-package undo-tree
  :diminish undo-tree-mode)

;; windmove
(use-package windmove
  :defer 2
  :bind (("M-h" . windmove-left)
	 ("M-j" . windmove-down)
	 ("M-k" . windmove-up)
	 ("M-l" . windmove-right)
	 )
  :config
  (use-package buffer-move
    :ensure t
    :bind (("M-S-h" . buf-move-left)
	   ("M-S-j" . buf-move-down)
	   ("M-S-k" . buf-move-up)
	   ("M-S-l" . buf-move-right))
    )
  (setq windmove-wrap-around t))

;; highlight parens
(use-package paren
  :defer 2
  :init
  (setq show-paren-delay 0)
  :config (show-paren-mode))

;; Automatic things
(use-package electric
  :defer 2
  :config
  (electric-indent-mode))

;; Completions
(use-package company	
  :ensure t
  :defer 2 
  :init 
  (add-hook 'prog-mode-hook 'company-mode)
  :config
  (setq 
   company-idle-delay              0.15
   company-minimum-prefix-length   1
   company-selection-wrap-around   t
   company-tooltip-limit           20
   company-dabbrev-downcase        nil
   )
  (define-key company-active-map (kbd "<tab>") 'company-select-next)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (use-package company-statistics
    :config 
    (company-statistics-mode)
    )
  :diminish company-mode)


(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 10)
  (setq ivy-count-format "")
  ;; no regexp by default
  (setq ivy-initial-inputs-alist nil)
  ;; configure regexp engine.
  (setq ivy-re-builders-alist
	;; allow input not in order
        '((t   . ivy--regex-ignore-order))))f

  (use-package ivy-historian
    :ensure t
    (ivy-historian-mode))

  (use-package swiper
    :ensure t
    :diminish swiper-mode)

  (use-package counsel-projectile
    :ensure t)

  (use-package counsel
    :ensure t
    :bind (("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-files)
	   ("C-x C-b" . ivy-switch-buffer)
	   ("C-x C-r" . counsel-recentf) 
	   ("C-x C-g" . counsel-git-grep)
	   ("C-x C-p" . counsel-projectile)
	   ("C-s" . swiper)
	   )
    :diminish counsel-mode)
:diminish ivy-mode)

;; vim emulation
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key 
      "SPC" 'evil-search-highlight-persist-remove-all
      "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
      "," 'counsel-M-x
      )
    )
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))
  (use-package evil-nerd-commenter
    :ensure t)
  (use-package evil-escape
    :ensure t
    :diminish evil-escape-mode
    :config
    (evil-escape-mode)
    (setq-default evil-escape-key-sequence "jk"))
  (use-package evil-search-highlight-persist
    :ensure t
    :config
    (require 'highlight)
    (global-evil-search-highlight-persist t))
  (use-package evil-matchit
    :ensure t
    :config
    (global-evil-matchit-mode 1))
  (use-package evil-mc
    :ensure t
    :diminish evil-mc-mode
    :config
    ;;  (global-evil-mc-mode 1)
    )
  )

(use-package flycheck
  :ensure t
  :defer 5
  :config
  )

(use-package nlinum-relative
  :ensure t
  :defer 2
  :config
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))   

(use-package smart-mode-line
  :ensure t
  :defer 2
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  (sml/setup))

(use-package org
  :defer t
  :mode ("\\.org\\'" . org-mode)
  :diminish org-mode)

(use-package magit
  :ensure t
  :defer 3
  :diminish magit-mode)

(use-package projectile
  :ensure t
  :commands (projectile-mode)
  :diminish projectile-mode)

(use-package eldoc
  :ensure t
  :defer 2 
  :config
  (global-eldoc-mode)
  :diminish eldoc-mode)

(use-package hl-todo
  :ensure t
  :defer 5
  :config
  (global-hl-todo-mode)
  :diminish hl-todo-mode)

(use-package smooth-scrolling
  :ensure t
  :defer 5
  :config
  (smooth-scrolling-mode)
  :diminish smooth-scrolling-mode)

(use-package git-timemachine
  :ensure t
  :defer t
  :commands (git-timemachine))

;; Don't use this for now
;; (use-package aggressive-indent
;;   :ensure t
;;   :config
;;   (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
;;   (add-hook 'prog-mode-hook #'aggressive-indent-mode)
;;   :diminish aggressive-indent-mode)

;; Languages
;; python
(use-package python 
  :ensure t
  :defer t
  :commands (python-mode)
  :config

  (use-package company-jedi
    :ensure t
    :config
    ;; We don't add company-dabbrev-code since jedi does it for us
    (add-to-list 'company-backends '(company-jedi))
    )

  ;; temp fix for error message
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
	  (python-shell-completion-native-output-timeout
	   python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_")))
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  )

;; Markdown
(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :diminish markdown-mode 
  
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; haskell
(use-package haskell-mode
  :ensure t
  :defer t
  :mode ("\\.hs\\'" . haskell-mode)
  :commands (haskell-mode)
  :config

 (use-package intero
   :ensure t
   :init (add-hook 'haskell-mode-hook 'intero-mode) 
   :bind (("C-c g" . intero-goto-definition))
   )
(use-package hindent
  :ensure t)
(add-hook 'haskell-mode-hook #'hindent-mode)
  )

;; latex
(use-package tex
  :defer t
  :ensure auctex
  :config
  (progn
	(setq TeX-view-program-selection '((output-pdf "Zathura")))
	(setq TeX-view-program-list '(("Zathura" "zathura %o")))
	(use-package company-auctex
		:ensure t
		:config
		(company-auctex-init))
  ))
;;; End of usepackage


;; customizations
 (setq inhibit-startup-message t) ;;no more gnu startup page
  (tool-bar-mode -1) ;;hides toolbar

  (setq initial-frame-alist '((font . "xos4 Terminus-10")))
  (setq default-frame-alist '((font . "xos4 Terminus-10")))

  ;; Don't use messages that you don't read
  (setq initial-scratch-message "")
  (setq inhibit-startup-message t)
  
  ;; remove toolbars and menus
  (tool-bar-mode 0)
  (menu-bar-mode 0)

;; backups
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/.temp"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

  ;; Some global remaps
  ;; remap C x k to kill current buffer instead of asking
  (global-set-key (kbd "C-x k") 'kill-this-buffer)
  (global-set-key (kbd "C-DEL") 'backward-kill-word)
  (global-set-key (kbd "M--") 'previous-buffer)
  (global-set-key (kbd "M-=") 'next-buffer)
  (global-set-key (kbd "M-r") 'resize-window)


  ;; change yes no prompts to y n
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; Save whatever’s in the current (system) clipboard before
  ;; replacing it with the Emacs’ text.
  ;; https://github.com/dakrone/eos/blob/master/eos.org
  (setq save-interprogram-paste-before-kill t)
  
  ;; Dont litter my init.el
  (setq custom-file "~/.emacs.d/custom.el")
  (load custom-file)
  
  ;; Limit Messages buffer max items
  (setq-default message-log-max 100)
  
  (global-auto-revert-mode 1)
  (put 'dired-find-alternate-file 'disabled nil)
;;; init ends here
