(defun python-config ()
  (use-package python
  :ensure t
  :defer t
  :commands (python-mode)
  :config

  (use-package company-jedi
    :ensure t
    :config
    ;; We don't add company-dabbrev-code since jedi does it for us
    (add-to-list 'company-backends '(company-jedi))
    )

  (use-package yapfify
    :ensure t)

  (use-package py-isort
    :ensure t
    :config
    (add-hook 'before-save-hook 'py-isort-before-save) 
  )

  (use-package py-autopep8
    :ensure t)


  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  )
  )
(provide 'python-config)
