(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f6>") 'org-tree-slide-move-next-tree)
  (global-set-key (kbd "<f5>") 'org-tree-slide-move-previous-tree)
  (global-set-key (kbd "<f8>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
  (org-tree-slide-simple-profile))

(provide 'setup-org-tree-slides)
