(use-package ranger
  :ensure t
  :init
    (require 'cl)
  :config
    (ranger-override-dired-mode t)
    (setq ranger-cleanup-on-disable t)
)
(provide 'yw-ranger)
