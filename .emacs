;; -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; 字体大小（默认约 105 = 10.5pt，调到 120 = 12pt）
(set-face-attribute 'default nil :height 120)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")  ;; 2. 添加MELPA源
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-check-signature nil)

(require 'package)  ;; 1. 引入package模块

(package-initialize)

;; 以下是你原有的use-package设置
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-always-demand nil
      use-package-expand-minimally t
      use-package-verbose t)
(require 'use-package)

(use-package doom-themes
  :init (load-theme 'doom-one t))

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
   (sml/setup))
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

;; 5. 增强帮助界面（可选）
(use-package helpful
  :bind
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h k" . helpful-key))

;; 6. 宏展开可视化（可选，学宏时再加）
(use-package macrostep
  :bind ("C-c e" . macrostep-expand))

(use-package company
  :hook (emacs-lisp-mode . company-mode)
  :config
  (setq company-idle-delay 0.1        ; 停 0.1 秒就弹出候选
        company-minimum-prefix-length 1)) ; 输 1 个字母就触发

(defun my/elisp-doc-intro ()
  (interactive)
  (eww "https://immiq.github.io/eintr-cn/"))

(defun my/elisp-doc-ref ()
  (interactive)
  (eww "https://tao-boy.github.io/elisp-zh/"))

(global-set-key (kbd "C-c w e") 'my/elisp-doc-intro)  ; 入门教材
(global-set-key (kbd "C-c w r") 'my/elisp-doc-ref)    ; 参考手册

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(doom-themes gruvbox-theme helpful org-modern smart-mode-line vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ===== 本地 elisp-zh 中文手册查询（查函数中文说明）=====
(defvar my/elisp-zh-dir (expand-file-name "~/.emacs.d/elisp-zh/docs/"))

(defun my/elisp-zh-goto (name)
  "精确跳转到函数 NAME 的定义位置。"
  (let ((files (file-expand-wildcards (concat my/elisp-zh-dir "*.org")))
        (regexp (concat "^\\*+ =" (regexp-quote name) "[ =]"))
        found-file found-line)
    (catch 'done
      (dolist (f files)
        (with-temp-buffer
          (insert-file-contents f)
          (goto-char (point-min))
          (when (re-search-forward regexp nil t)
            (setq found-file f
                  found-line (line-number-at-pos))
            (throw 'done t)))))
    (if found-file
        (progn
          (find-file found-file)
          (goto-char (point-min))
          (forward-line (1- found-line))
          (recenter 0)
          (message "已定位到 %s 的中文说明" name))
      (message "在 elisp-zh 中未找到 %s" name))))

(defun my/elisp-zh-lookup (name)
  "在本地 elisp-zh 中文手册中模糊查找函数 NAME。
输入前缀如 forward，会列出所有匹配函数供选择；唯一匹配则直接跳转。"
  (interactive "s函数名(可模糊): ")
  (let ((files (file-expand-wildcards (concat my/elisp-zh-dir "*.org")))
        (regexp (concat "^\\*+ =" (regexp-quote name)))
        candidates)
    (dolist (f files)
      (with-temp-buffer
        (insert-file-contents f)
        (goto-char (point-min))
        (while (re-search-forward regexp nil t)
          (let ((line (buffer-substring-no-properties
                       (line-beginning-position) (line-end-position))))
            (let ((start (string-match "=" line)))
              (when start
                (let ((end (string-match "[ =]" line (1+ start))))
                  (when end
                    (let ((fn (substring line (1+ start) end)))
                      (unless (member fn candidates)
                        (push fn candidates)))))))))))
    (setq candidates (nreverse candidates))
    (cond
     ((null candidates)
      (message "在 elisp-zh 中未找到匹配 %s 的函数" name))
     ((null (cdr candidates))
      (my/elisp-zh-goto (car candidates)))
     (t
      (my/elisp-zh-goto (completing-read "选择函数: " candidates nil t name))))))

(global-set-key (kbd "C-c w f") 'my/elisp-zh-lookup)

;; 候选列表垂直显示（解决 completing-read 看不到候选的问题）
(use-package vertico
  :init (vertico-mode 1))

;; Org 美化：隐藏 =code=、*粗体* 的标记字符
(setq org-hide-emphasis-markers t)

;; Org 现代化外观（标题符号、代码块、表格美化）
(use-package org-modern
  :hook (org-mode . org-modern-mode))

