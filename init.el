;; Package stuff
(package-initialize)

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path settings-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(magit
     better-defaults
     smex
     undo-tree
     helm
     helm-ls-git
     projectile
     helm-projectile
     helm-ag
     web-mode
     graphql-mode
     flycheck
     flycheck-flow
     flycheck-credo
     exec-path-from-shell
     alchemist
     multiple-cursors
     company
     org-tree-slide
     markdown-mode
     intero
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Require packages
(require 'better-defaults)
(require 'magit)
(require 'smex)

;; Do configs

(require 'sane-defaults)
(require 'setup-helm)
(require 'setup-projectile)
(require 'setup-web)
(require 'setup-elixir)
(require 'setup-multiplecursors)
(require 'setup-company)
(require 'setup-org-tree-slides)
(require 'setup-markdown-mode)
(require 'setup-haskell)

;;; Smex
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;;; Magit

(setq magit-display-buffer-function
      (lambda (buffer)
        (display-buffer buffer '(display-buffer-same-window))))

(global-set-key (kbd "C-x g") 'magit-status)
