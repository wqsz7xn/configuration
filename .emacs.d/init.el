;; init
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; basic
(setq inhibit-startup-message t)
(setq visible-bell t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

;; numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; packages
(use-package magit
  :commands magit-status)

(use-package dired
  :ensure nil)

(use-package general)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; theme
(use-package grandshell-theme
  :init (load-theme 'grandshell t))

