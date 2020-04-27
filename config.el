;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!



;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "billbai"
      user-mail-address "billbai@tencent.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Sarasa Mono SC" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-vibrant)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;
;; load util.el for some useful command
;;
(load! "util")

;;
;; Configure GN and gclient
;;
(load! "gn-mode")
(add-to-list 'auto-mode-alist '("\\.gn\\'" . gn-mode))
(add-to-list 'auto-mode-alist '("\\DEPS\\'" . python-mode))

;;
;; auto header
;;
(load! "header2")
(load! "auto-header")
(load! "include-guard")

;;
;; Clang-format
;;
(map! "C-c r" #'clang-format-region
      "C-c b" #'clang-format-buffer)
(add-hook 'c-mode-common-hook
          (function (lambda () (local-set-key (kbd "TAB") 'clang-format-region))))

;;
;; google-c-style
;;
(load! "google-c-style")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; .h as c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;;
;; pyim input method
(use-package! liberime)
(use-package! pyim
  :init
  (setq pyim-title "R")
  :config
  ;; (use-package pyim-basedict
  ;;   :config
  ;;   (pyim-basedict-enable))
  (global-set-key (kbd "M-j") 'pyim-convert-string-at-point)
  (setq pyim-dcache-auto-update nil)
  (setq default-input-method "pyim")
  ;; 我使用全拼
  (setq pyim-default-scheme 'rime)
  (setq pyim-page-tooltip 'posframe)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
		        '(pyim-probe-dynamic-english
		          pyim-probe-isearch-mode
		          pyim-probe-program-mode
                  pyim-probe-evil-normal-mode
		          pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
		        '(pyim-probe-punctuation-line-beginning
		          pyim-probe-punctuation-after-punctuation)))

;;
;; lsp
;;
(after! lsp-mode
  (setq lsp-enable-file-watchers nil))

;;
;; dap
;;
;; (after! dap-mode
;;   (dap-mode 1)
;;   (dap-ui-mode 1)
;;   ;; enables mouse hover support
;;   (dap-tooltip-mode 1)
;;   ;; use tooltips for mouse hover
;;   ;; if it is not enabled `dap-mode' will use the minibuffer.
;;   (tooltip-mode 1)
;;   (require 'dap-gdb-lldb)
;;   )
