(defun markdown-config ()
  (use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :diminish markdown-mode

  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
  )
(provide 'markdown-config)
