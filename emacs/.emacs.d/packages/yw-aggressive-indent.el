(use-package aggressive-indent
  :ensure t
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'python-mode)
  :diminish aggressive-indent-mode)

(provide 'yw-aggressive-indent)
