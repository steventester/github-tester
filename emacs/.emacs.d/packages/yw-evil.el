(use-package evil
  :ensure t
  :config
  (evil-mode 1)
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
    ; (global-evil-mc-mode 1)
    )
  )
(provide 'yw-evil)
