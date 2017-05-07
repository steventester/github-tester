(use-package nlinum-relative
  :ensure t
  :defer 2
  :config
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))
(provide 'yw-nlinum-relative)
