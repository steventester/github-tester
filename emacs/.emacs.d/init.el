;;; init.el --- emacs configuration
;;; Commentary:
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'load-path (expand-file-name "packages" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(package-initialize)

(setq load-prefer-newer t)              ; Always load newer compiled files
(setq ad-redefinition-action 'accept)   ; Silence advice redefinition warnings
(setq message-log-max 1000)

;; Allow more than 800Kb cache during init
(setq gc-cons-threshold 50000000)

;; Reset threshold to its default after Emacs has startup, because a large
;; GC threshold equates to longer delays whenever GC happens
(defun yw-set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))
(add-hook 'emacs-startup-hook 'yw-set-gc-threshold)

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; Validate
(use-package validate
  :ensure t)

;; Backups
(validate-setq
 backup-directory-alist '((".*" . "~/.emacs.d/backup"))
 version-control        t          ; Version number for backup files
 delete-old-versions    t
 backup-by-copying      t
 kept-new-versions      5
 kept-old-versions      0
 vc-make-backup-files   t
)

(validate-setq
 auto-save-list-file-prefix     "~/.emacs.d/autosave/"
 auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

;; Dont litter my init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Some global key remaps
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;;; Naked Emacs Section --
(blink-cursor-mode 0) ;; no blinking cursor

;; Don't use messages that you don't read
(validate-setq initial-scratch-message ""
	       inhibit-startup-message t
	       inhibit-startup-echo-area-message "yiqiao")

;; remove toolbars and menus
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; fonts & themes
;; Other decent themes:
;; Leuven
;; Kaolin
(use-package nord-theme
  :ensure t)

(validate-setq
 initial-frame-alist '((font . "xos4 Terminus-10"))
 default-frame-alist '((font . "xos4 Terminus-10")))

;; Misc
(global-eldoc-mode)
(show-paren-mode)
(fset 'yes-or-no-p 'y-or-n-p) ;; change yes no prompts to y n
(global-auto-revert-mode)
(put 'dired-find-alternate-file 'disabled nil)
(validate-setq
 confirm-kill-emacs #'y-or-n-p
 vc-follow-symlinks t ; Follow symlinks to their actual file
 tab-width 4
 show-paren-delay 0)
(setq-default major-mode 'org-mode)
(setq-default initial-major-mode 'org-mode)


;;; Packages
;; Local
;(global-set-key (kbd "M-r") 'resize-window)
(use-package resize-window
  :bind
    ("M-r" . resize-window))

;; Remote
(use-package yw-evil)
(use-package yw-git-timemachine)
(use-package yw-markdown)
(use-package yw-smooth-scrolling)
(use-package yw-company)
(use-package yw-haskell)
(use-package yw-nlinum-relative)
(use-package yw-telephone-line)
(use-package yw-ivy)
(use-package yw-projectile)
(use-package yw-tex)
(use-package yw-flycheck)
(use-package yw-magit)
(use-package yw-python)
; (use-package yw-aggressive-indent)
(use-package yw-undo-tree)
(use-package yw-ranger)
