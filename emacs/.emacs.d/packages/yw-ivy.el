(use-package ivy                        ; Incremental Vertical completYon
  :ensure t
  :bind (("C-x u" . ivy-resume)
   ("C-x b" . ivy-switch-buffer)
   :map ivy-minibuffer-map
   ("RET" . ivy-alt-done))
  :init (ivy-mode 1)
  :config
    (setq
     ivy-count-format ""
     ivy-virtual-abbreviate 'full         ; Show full file path
     ;; Jump back to first candidate when on the last one
     ivy-wrap t
     ;; Show recently killed buffers when calling `ivy-switch-buffer'
     ivy-use-virtual-buffers t
     ;; Always ignore buffers set in `ivy-ignore-buffers'
     ivy-use-ignore-default 'always
     ;; Ignore some buffers in `ivy-switch-buffer'
     ivy-ignore-buffers '("company-statistics-cache.el"))

;; Bind C-k to kill buffer from `ivy-switch-buffer'
(defun mu-ivy-kill-buffer ()
  (interactive)
  (ivy-set-action 'kill-buffer)
  (ivy-done))

(bind-key "C-k" #'mu-ivy-kill-buffer ivy-switch-buffer-map)
  :diminish ivy-mode)

(use-package ivy-historian              ; Store minibuffer candidates
  :ensure t
  :init (ivy-historian-mode +1))

(use-package swiper                     ; Isearch with an overview
  :ensure t
                ;  :bind (("C-c s s" . swiper-all)
                ;         :map isearch-mode-map
                ;         ("M-i" . swiper-from-isearch))
  :config
    (setq
     ;; Always recentre when leaving Swiper
     swiper-action-recenter t
     ;; Jump to the beginning of match when leaving Swiper
     swiper-goto-start-of-match t))

(use-package smex                       ; Better M-x interface
  :ensure t)

(use-package counsel                    ; Completion functions with Ivy
  :ensure t
  :init (counsel-mode)
  :bind (
   ("C-s"   . counsel-grep-or-swiper)
   ("C-r"   . counsel-grep-or-swiper)
   ("C-x g" . counsel-git-grep)
   ("C-x i" . counsel-imenu)
   ("C-x j" . counsel-bookmark)
   ([remap execute-extended-command] . counsel-M-x)
   ([remap find-file]                . counsel-find-file)
   ([remap bookmark-jump]            . counsel-bookmark)
   ([remap describe-function]        . counsel-describe-function)
   ([remap describe-variable]        . counsel-describe-variable)
   ([remap info-lookup-symbol]       . counsel-info-lookup-symbol)
   ([remap find-file-read-only]      . counsel-recentf))
  :config
   (setq
    counsel-bookmark-avoid-dired t
    counsel-mode-override-describe-bindings t
    counsel-grep-post-action-hook '(recenter)
    counsel-find-file-at-point t
    counsel-find-file-ignore-regexp
      (concat
        ;; File names beginning with # or .
        "\\(?:\\`[#.]\\)"
        ;; File names ending with # or ~
        "\\|\\(?:\\`.+?[#~]\\'\\)"))
:diminish counsel-mode)

(provide 'yw-ivy)
