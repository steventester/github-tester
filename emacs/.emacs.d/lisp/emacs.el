(defun emacs-config ()
;; Following section inspired from Emacs, naked
;; https://emacs-doctor.com/emacs-strip-tease.html

  (blink-cursor-mode 0) ;; no blinking cursor

  ;; Don't use messages that you don't read
  (setq initial-scratch-message ""
        inhibit-startup-message t
 	inhibit-startup-echo-area-message t) 
  ;; remove toolbars and menus
  (tool-bar-mode 0)
  (menu-bar-mode 0)

  (scroll-bar-mode 0) ;; remove scroll bar

;; end of naked section
;:; Look and feel section ;;;

  ;; fonts
  (setq initial-frame-alist '((font . "xos4 Terminus-10")))
  (setq default-frame-alist '((font . "xos4 Terminus-10")))


  (setq tab-width 4)

  (show-paren-mode)
  (setq show-paren-delay 0)

  ;; follow symlinks in vc to their actual file
  (setq vc-follow-symlinks t)

  ;; backups & autosaves
(setq
 backup-directory-alist
   '(("." . "~/.emacs.d/.backups")) ; put everything in one directory
 auto-save-file-name-transforms
  `((".*" "~/.emacs.d/.backups" t))


 backup-by-copying t     ; don't clobber symlinks
 kept-new-versions 5    ; keep 5 latest versions
 kept-old-versions 0     ; don't bother with old versions
 delete-old-versions t   ; don't ask about deleting old versions
 version-control t       ; number backups
 vc-make-backup-files t  ; backup version controlled files
)

  ;; Some global remaps
  (global-set-key (kbd "C-x k") 'kill-this-buffer) ;; dont ask...
  (global-set-key (kbd "C-DEL") 'backward-kill-word) ;; bad habit?

  ;; resize windows
  (global-set-key (kbd "C-S-<left>") 'shrink-window-horizontally)
  (global-set-key (kbd "C-S-<right>") 'enlarge-window-horizontally)
  (global-set-key (kbd "C-S-<down>") 'shrink-window)
  (global-set-key (kbd "C-S-<up>") 'enlarge-window)

  ;; change yes no prompts to y n
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; copy and paste with X11
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
  
  ;; Dont litter my init.el
  (setq custom-file (expand-file-name ".custom.el" user-emacs-directory))
  (load custom-file 'noerror)
  
  ;; Limit Messages buffer max items
  (setq-default message-log-max 500)
  
  ;; auto revert
  (global-auto-revert-mode)

  (put 'dired-find-alternate-file 'disabled nil)
 )
(provide 'emacs-config)
