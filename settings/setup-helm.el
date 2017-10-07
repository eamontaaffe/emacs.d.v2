;; Completion: Helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Helm-ls-git
;; https://github.com/emacs-helm/helm-ls-git
(require 'helm-ls-git)
(global-set-key (kbd "C-c g") 'helm-ls-git-ls)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)

(provide 'setup-helm)
