;; Javascript
;; Configured according to:
;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

;; Installed packages:
;; flycheck, js2-mode, json-mode, web-mode, exec-path-from-shell

;; use web-mode for .js files
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

;; Disable auto-quoting
;; ie. ( style= → style="|")
(setq web-mode-enable-auto-quoting nil)

(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

;; set the tab width to 2
(setq-default tab-width 2)
(setq css-indent-offset 2)
(setq web-mode-css-indent-offset 2)

;; ;; Always start smartparens mode in js-mode.
;; (require 'smartparens-config)
;; (add-hook 'js-mode-hook #'smartparens-mode)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)
(require 'flycheck-flow)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
					'(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-next-checker 'javascript-eslint 'javascript-flow)
(flycheck-add-next-checker 'javascript-flow 'javascript-flow-coverage)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
					'(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(setq exec-path-from-shell-check-startup-files nil)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/
;; flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; (require 'flycheck-flow)
;; (with-eval-after-load 'flycheck
;;   (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
;;   (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
;;   (flycheck-add-next-checker 'javascript-flow 'javascript-eslint))

(add-to-list 'auto-mode-alist '("\\.graphql.js\\'" . graphql-mode))
(add-to-list 'auto-mode-alist '("\\.graphql\\'" . graphql-mode))

(provide 'setup-web)
