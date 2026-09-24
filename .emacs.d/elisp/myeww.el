;; -*- lexical-binding: t; -*-



(defun my/elisp-doc-intro ()
  (interactive)
  (eww "https://immiq.github.io/eintr-cn/"))

(defun my/elisp-doc-ref ()
  (interactive)
  (eww "https://tao-boy.github.io/elisp-zh/"))
(defun archwiki ()
  (interactive)
  (eww "https://aw.lilydjwg.me/wiki/"))
(defun archcn ()
  (interactive)
  (eww "https://forum.archlinuxcn.org/"))

(global-set-key (kbd "C-c w e") 'my/elisp-doc-intro)  ; 入门教材
(global-set-key (kbd "C-c w r") 'my/elisp-doc-ref)    ; 参考手册
(global-set-key (kbd "C-c w a") 'archwiki)	      ; archwiki
(global-set-key (kbd "C-c w c") 'archcn)	      ; arch中文论坛

(provide 'myeww)
