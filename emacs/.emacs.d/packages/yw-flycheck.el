(use-package flycheck
  :ensure t
  :config
    (add-hook 'prog-mode-hook 'flycheck-mode))
(provide 'yw-flycheck)
