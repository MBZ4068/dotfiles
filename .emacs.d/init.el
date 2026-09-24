;; -*-lexical-binding: t; -*-


(setq package-archives '(("melpa" . "https://melpa.org/packages/")  ;; 2. 添加MELPA源
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-check-signature nil)
(setq display-line-numbers-type t)
(global-display-line-numbers-mode t)

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

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))
(require 'core)
(require 'plugins)
(require 'myeww)
