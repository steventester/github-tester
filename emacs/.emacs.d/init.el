;;; package --- summary:
;; my emacs configuration

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

;; Theme
;; inkpot-theme
;; cyberpunk-theme
(use-package cyberpunk-theme
  :ensure t
)


;; Dired-ranger
(use-package dired-ranger
  :ensure t
  :defer t
  :commands (dired)
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))

;; Undo Tree
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
  ;; wrap around at edges
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
  (electric-indent-mode)
  (electric-pair-mode))


;; c and c++
(use-package irony
  :ensure t
  :defer t
  :commands (c++-mode c-mode) 
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  :config
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  
  (use-package company-irony
    :ensure t
    :config
    (add-to-list 'company-backends '(company-irony  company-dabbrev)))
  (use-package company-irony-c-headers
    :ensure t
    :config
    (add-to-list 'company-backends '(company-irony-c-headers company-dabbrev)))
  (use-package flycheck-irony
    :ensure t
    :config 
    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
  (use-package irony-eldoc
    :ensure t
    :config 
    (add-hook 'irony-mode-hook 'irony-eldoc))
  :diminish irony-mode)

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



;; Completions
(use-package company	
  :ensure t
  :defer 2 
  :init 
  (add-hook 'prog-mode-hook 'company-mode)
  :config

  ;; tab expand snippet if present, else expand completion
  ;;(defun company-yasnippet-or-completion ()
  ;;  (interactive)
  ;;  (let ((yas-fallback-behavior nil))
  ;;    (unless (yas-expand)
  ;;	(call-interactively #'company-complete-common-or-cycle)))) 
  ;;(add-hook 'company-mode-hook (lambda ()
  ;;				 (substitute-key-definition 'company-complete-common
  ;;							    'company-yasnippet-or-completion
  ;; 							    company-active-map)))

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

;; Snippets
(use-package yasnippet
  :ensure t 
  :defer t
  :commands (yas-minor-mode)
  :init 
  ;; (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config 
  (progn

    ;; TODO SETUP BINDINGS FOR THIS
    ;; (use-package auto-yasnippet
    ;;  :ensure t) 

    (defvar company-mode/enable-yas t "Enable yasnippet for all backends.")

    (defun company-mode/backend-with-yas (backend)
      (if (or (not company-mode/enable-yas) (and (listp backend)    (member 'company-yasnippet backend)))
	  backend
	(append (if (consp backend) backend (list backend))
		'(:with company-yasnippet))))

    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
    (yas-reload-all)
    )
  :diminish yas-minor-mode)

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
      "c" 'comment-or-uncomment-region-or-line
      "," 'helm-M-x
      )
    )
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))
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


;; Syntax check
(use-package flycheck
  :ensure t
  :defer 5
  :config
  (use-package flycheck-pos-tip
    :ensure t
    :config
    (flycheck-pos-tip-mode)
    (custom-set-variables '(flycheck-pos-tip-timeout 60))
    )
  )

(use-package helm
  :diminish helm-mode
  :ensure t
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq 
      helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
      helm-input-idle-delay 0.01  ; this actually updates things
                                       ; reeeelatively quickly.
      helm-yas-display-key-on-candidate t
      helm-quick-update t
      helm-M-x-requires-pattern nil
      helm-ff-newfile-prompt-p nil
      helm-ff-skip-boring-files t
     
     ;; Helm fuzzy settings 
      helm-recentf-fuzzy-match t
      helm-locate-fuzzy-match nil ;; locate fuzzy is worthless
      helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-semantic-fuzzy-match t
      helm-apropos-fuzzy-match t
      helm-imenu-fuzzy-match t
      helm-lisp-fuzzy-completion t
      helm-completion-in-region-fuzzy-match t	  

      helm-autoresize-min-height 10
      helm-autoresize-max-height 35
	  
      )
   )
  :config
  (helm-mode 1)
  (helm-autoresize-mode 1)
  (use-package helm-swoop
    :ensure t)
	     
  :bind (:map helm-find-files-map
              ("<tab>" . helm-execute-persistent-action)
	      ("C-z" . helm-select-action)
              ("C-<backspace>" . helm-find-files-up-one-level))
  :bind (
         ("M-x" . helm-M-x)
	 ("C-x C-m" . helm-mini)
         ("C-x C-b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
	 ("C-x C-r" . helm-recentf)
	 ("C-x C-g" . helm-grep-do-git-grep)
         ("C-s" . helm-swoop)
	 ("C-x C-i" . helm-semantic-or-imenu)
	 ("C-x C-u" . helm-resume )
         )
 
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

(use-package go-mode
  :ensure t
  :defer t
  :commands (go-mode)
  :mode ("\\.go\\'" . go-mode)
  )

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

;; hindent
(use-package hindent
  :ensure t)
(add-hook 'haskell-mode-hook #'hindent-mode)
  )

(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :diminish markdown-mode 
  
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

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

(use-package ggtags
  :ensure t
  :defer 5
  :commands (ggtags-mode)
  :config 
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode)
		(ggtags-mode 1))))
  :diminish ggtags-mode
  ;;  (general-define-key
  ;;   :keymaps 'ggtags-mode-map
  ;;   :states '(normal)
  ;;   "g d" 'helm-gtags-dwim)
  ;;  (use-package helm-gtags
  ;;    :ensure t
  ;;   :commands (helm-gtags-dwim)
  ;;    :config (helm-gtags-mode))
  )

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

(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :init
  ;; Hooks are used here instead since there are quite a few configs and Bookmarks issue
  (add-hook 'pdf-view-mode-hook 'my/pdf-setup)
  ;; Fix blinking cursour around pdf image
  (add-hook 'pdf-view-mode-hook
	    (lambda ()
	      (set (make-local-variable 'evil-emacs-state-cursor) (list nil))))
  )


;; Don't use this for now
;; (use-package aggressive-indent
;;   :ensure t
;;   :config
;;   (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
;;   (add-hook 'prog-mode-hook #'aggressive-indent-mode)
;;   :diminish aggressive-indent-mode)

;;; End of usepackage


;; Run customizations
(init-emacs)


(provide 'init)
;;; init ends here
(put 'dired-find-alternate-file 'disabled nil)
