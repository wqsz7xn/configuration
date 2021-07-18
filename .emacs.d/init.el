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

;; parenthesis
(show-paren-mode 1)

;; fill column
(setq-default fill-column 80)
(add-hook 'text-mode-hook #'auto-fill-mode)
;;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;;(global-fci-mode 1)

;; smooth-scrolling
(use-package smooth-scrolling
  :init
  (setq scroll-margin 1
    scroll-conservatively 0
    scroll-up-aggressively 0.01
    scroll-down-aggressively 0.01))
(smooth-scrolling-mode 1)

;; packages
(use-package ivy
  :diminish
  :defer 0.1
  :bind (("C-c C-r" . ivy-resume)
         ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package ivy-rich
  :after ivy
  :custom
  (ivy-virtual-abbreviate 'full
                          ivy-rich-switch-buffer-align-virtual-buffer t
                          ivy-rich-path-style 'abbrev))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package counsel
  :after ivy
  :config (counsel-mode))

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

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
    (setq lsp-keymap-prefix "C-c l")
  :config
    (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package company
  :after lsp-mode
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; org
(use-package org
  :bind (:map org-mode-map
	      ("C-c a" . org-agenda))
  :hook (org-mode . flyspell-mode)
  :custom (org-agenda-files
	   (list "~/org/todo.org")))

;; TODO: Put this in custom block
;; agenda span a month
(setq org-agenda-start-on-weekday 1)
(setq org-agenda-start-day "-7d")
(setq org-agenda-span 'month)
(setq org-directory "~/org/")
(setq org-archive-location (concat org-directory "/archive.org::"))

(use-package org-download
  :bind (("C-c i" . org-download-screenshot)
         ("C-c y" . org-download-clipboard))
  :custom
  (org-download-screenshot-method "scrot -s %s")
  (org-download-image-dir "~/org/images/")
  (org-download-image-width 400))

;; org-bullets
(use-package org-bullets
  :ensure t
  :init
    (add-hook 'org-mode-hook (lambda ()
    (org-bullets-mode 1))))

(use-package htmlize)

;; evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; haskell
(use-package haskell-mode)

(use-package lsp-haskell
  :hook ((haskell-mode . lsp)
         (haskell-literate-mode . lsp)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-haskell haskell-mode htmlize org-bullets org-download company lsp-ui lsp-mode rainbow-delimiters which-key general magit counsel swiper ivy-rich ivy smooth-scrolling use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
