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

;;
;; pyim input method
;;
(after! pyim
  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)
  (setq load-path (cons (file-truename "~/.doom.d/") load-path))
  (require 'liberime-core)
  (liberime-start "/usr/share/rime-data/" (file-truename "~/.doom.d/pyim/rime/"))
  (liberime-select-schema "luna_pinyin_simp")
  (setq pyim-default-scheme 'rime-quanpin)

  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe))

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
