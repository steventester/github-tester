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

  (use-package company-statistics
    :ensure t
    :config
    (company-statistics-mode))

  (use-package company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode))
  :bind ( :map company-active-map
	("<tab>" . company-select-next)
	("<backtab>" . company-select-previous))
  :diminish company-mode)
(provide 'yw-company)
