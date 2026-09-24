;; -*- lexical-binding: t; -*-

;; -------- 此文件主要配置有关于插件的内容-----------

;;--------- ui 关于界面显示相关的chajian
(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
  (sml/setup))

;; -------- emacs 体验相关的插件
(use-package elisp-demos
  :demand t
  :config
  (advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1))

;; ; 2. 求值结果可视化（C-x C-e 结果显示在代码旁）
(use-package eros
  :hook (emacs-lisp-mode . eros-mode))

;; 3. 括号结构化编辑

(use-package paredit
  :hook (emacs-lisp-mode . enable-paredit-mode))

;; 4. 彩虹括号
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; 5. 增强帮助界面
(use-package helpful
  :bind
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key))

;; 6. 宏展开可视化
(use-package macrostep
  :bind ("C-c e" . macrostep-expand))

(use-package eglot
  :ensure nil
  :hook (c-mode . eglot-ensure)
  :config
  (setq eglot-autoshutdown t))

(use-package company
  :hook ((emacs-lisp-mode c-mode) . company-mode)
  :config
  (setq company-idle-delay 0.1		  ; 停 0.1 秒就弹出候选
        company-minimum-prefix-length 1)) ; 输 1 个字母就触发

;; --------语言相关插件





;; --------Org相关
;; Org 美化：隐藏 =code=、*粗体* 的标记字符
(setq org-hide-emphasis-markers t)

;; Org 现代化外观（标题符号、代码块、表格美化）
(use-package org-modern
  :hook (org-mode . org-modern-mode))

(provide 'plugins)
