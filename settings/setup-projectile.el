(require 'projectile)
(require 'helm-projectile)

(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(projectile-global-mode t)
(helm-projectile-on)

(global-set-key (kbd "C-c p .") 'helm-projectile-find-file-dwim)

(provide 'setup-projectile)
