(defun haskell-config ()
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
(use-package hindent
  :ensure t )
(add-hook 'haskell-mode-hook #'hindent-mode)
)
  )
(provide 'haskell-config)
