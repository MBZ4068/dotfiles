;; -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
;; 字体大小（默认约 105 = 10.5pt，调到 120 = 12pt）
(set-face-attribute 'default nil :height 120)

(setq-default tab-width 2)
(setq c-basic-offset 2)
(setq truncate-partial-width-windows nil)
(setq-default truncate-lines nil)
(global-visual-line-mode 1)
(setq word-wrap t)

(provide 'core)

