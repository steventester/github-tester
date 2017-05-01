(defun latex-config ()
  (use-package tex
  :defer t
  :ensure auctex
  :config
  (progn
	(setq TeX-view-program-selection '((output-pdf "Zathura")))
	(setq TeX-view-program-list '(("Zathura" "zathura %o")))
  ))
  )
(provide 'latex-config)
