

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)


(setq package-archives '(("melpa" . "https://melpa.org/packages/")  ;; 2. 添加MELPA源
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(setq package-check-signature nil)

(require 'package)  ;; 1. 引入package模块

(unless (bound-and-true-p package--initalized))

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

;;video 15
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-soft t))

(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t
	sml/theme 'respectful)
   (sml/setup))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
