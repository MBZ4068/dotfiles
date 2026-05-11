

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)


(require 'package)  ;; 1. 引入package模块
(setq package-archives '(("melpa" . "https://melpa.org/packages/")  ;; 2. 添加MELPA源
                         ("gnu" . "https://elpa.gnu.org/packages/")))

(unless package-archive-contents  ;; 3. 如果本地还没有包索引，则刷新
  (package-refresh-contents))

;; 以下是你原有的use-package设置
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(unless (bound-and-true-p package--initalized)
  )

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
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

