(use-package tex
  :ensure auctex
  :mode (("\\.tex\\'" . tex-mode))
  :config
  (progn
	(setq TeX-view-program-selection '((output-pdf "Zathura")))
	(setq TeX-view-program-list '(("Zathura" "zathura %o")))
  ))
(provide 'yw-tex)

