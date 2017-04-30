;;; package --- summary:
;;; Commentary:
;;; Code:

;; Initialize use-package
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;;; Load files in lisp folder
(cl-loop for file in (directory-files ".emacs.d/lisp" t)
	 when (string-match "\\.el$" file)
	 do (load file))

;; Packages
(use-package zenburn-theme
  :ensure t
)

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
    :ensure t
    :config 
    (company-statistics-mode))
  (use-package company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode))
  :diminish company-mode)


(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1)
  :diminish yas-minor-mode
    )

(ivy-config)

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
      "cl" 'evilnc-comment-or-uncomment-lines
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

(use-package undo-tree
  :diminish undo-tree-mode)

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

(use-package aggressive-indent
  :ensure t
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-hook 'prog-mode-hook #'aggressive-indent-mode)
  :diminish aggressive-indent-mode)

(use-package rg
  :ensure t)
;;; End of usepackage

;; customizations
(emacs-config)
(haskell-config)
(python-config)
(latex-config)
(markdown-config)
