(defun init-emacs ()
  (setq inhibit-startup-message t) ;;no more gnu startup page
  (tool-bar-mode -1) ;;hides toolbar

  (setq initial-frame-alist '((font . "Terminus-10")))
  (setq default-frame-alist '((font . "Terminus-10")))

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
)
(provide 'init-emacs)
