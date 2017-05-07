(use-package python
  :ensure t
  :defer t
  :config
  (use-package company-jedi
    :ensure t
    :config
    ;; We don't add company-dabbrev-code since jedi does it for us
    (add-to-list 'company-backends '(company-jedi))
    :bind ( :map python-mode-map
	   ("C-c g" . jedi:goto-definition))
    )
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
)
(provide 'yw-python)
