(require 'alchemist)

;; Override issues with nanobox locking files for editing.
(defun disable-file-lock-ask ()
  (interactive)
  (defun ask-user-about-supersession-threat (fn)
  "blatantly ignore files that changed on disk"
  )
  (defun ask-user-about-lock (file opponent)
    "always grab lock" t))

(add-hook 'elixir-mode-hook 'alchemist-mode)
(setq alchemist-test-truncate-lines nil)

(eval-after-load 'flycheck
  '(flycheck-credo-setup))
(add-hook 'elixir-mode-hook 'flycheck-mode)

(setq flycheck-elixir-credo-strict t)

(provide 'setup-elixir)
