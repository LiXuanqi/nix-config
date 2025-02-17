;;; init.el -*- lexical-binding: t -*-

;;(defvar xq/default-font "JetBrainsMono Nerd Font")
 ;; (defvar efs/default-font-size 180)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun xq/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'xq/display-startup-time)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq package-enable-at-startup nil)

  (straight-use-package 'use-package)

(defun xq/open-emacs-config ()
  (interactive)
  (find-file "~/.config/emacs/config.org"))

(use-package general
  :straight t
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "s" '(:ignore t :which-key "switch")
    "sb" '(consult-buffer :which-key "switch buffer")
    "w"  '(:ignore t :which-key "window")
    "w-" '(evil-window-split :which-key "Split window -")
    "w|" '(evil-window-vsplit :which-key "Split window |")
    "wj" '(evil-window-down :which-key "Move to down window")
    "wk" '(evil-window-up :which-key "Move to up window")
    "wh" '(evil-window-left :which-key "Move to left window")
    "wl" '(evil-window-right :which-key "Move to right window")
    "f"  '(:ignore t :which-key "files")
    "fp" '(xq/open-emacs-config :which-key "open emacs config")))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(use-package evil
  :straight t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(setq inhibit-startup-message t) ; No welcome messsage

      (scroll-bar-mode -1)        ; Disable visible scrollbar
      (tool-bar-mode -1)          ; Disable the toolbar
      (tooltip-mode -1)           ; Disable tooltips
      (set-fringe-mode 10)        ; Give some breathing room
      (menu-bar-mode -1)            ; Disable the menu bar
      ;; Set up the visible bell
      ;; (setq visible-bell t)


  ;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

;;(set-face-attribute 'default nil :font xq/default-font :height xq/default-font-size)

;; Set the fixed pitch face
;;(set-face-attribute 'fixed-pitch nil :font xq/default-font :height xq/default-font-size)

;; Set the variable pitch face
;;(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

(column-number-mode)
  (global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package doom-themes
    :straight t
    :init (load-theme 'doom-one t))

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1)
  )

(use-package which-key
  :straight t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

;; ================== Vertico ================
  (use-package vertico
    :straight t
    :init
    (vertico-mode)
    :custom
    (vertico-cycle t)
    )

  (use-package savehist
    :straight t
    :init
    (savehist-mode)
  )

  (use-package marginalia
    :straight t
    :after vertico
    :custom
    (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
    :init
    (marginalia-mode))


  ;; TODO: config consult
  (use-package consult
    :straight t)

;; Optionally use the `orderless' completion style.
(use-package orderless

  :straight t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

  ;; embark, 

  ;; ================== Completion ================
  (use-package corfu
    :straight t
    ;; Optional customizations
    :custom
    (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
    (corfu-auto t)                 ;; Enable auto completion
    (corfu-auto-prefix 2)          ;; Complete with minimum 2 characters
    (corfu-auto-delay 0.0)         ;; No delay for completion
    (corfu-echo-documentation 0.25) ;; Show documentation for selected candidate

    ;; Enable Corfu only for certain modes
    ;; :hook ((prog-mode . corfu-mode)
    ;;       (shell-mode . corfu-mode)
    ;;       (eshell-mode . corfu-mode))

    ;; Recommended: Enable Corfu globally.
    ;; This is recommended since Dabbrev can be used globally (M-/).
    :init
    (global-corfu-mode))

  ;; cape, kind-icon

(use-package copilot
:straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package org-bullets
  :straight t
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun xq/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :straight t
  :hook (org-mode . xq/org-mode-visual-fill))

(setq-default indent-tabs-mode nil)

(use-package evil-commentary
  :straight t)
(evil-commentary-mode)

(defun xq/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (rust-ts-mode . lsp-deferred)
         ((tsx-ts-mode typescript-ts-mode) . lsp-deferred)
	 (lsp-mode . xq/lsp-mode-setup))
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  ;; (setq lsp-rust-analyzer-linked-projects ["/Users/1_x7/dev/bazel-rust-example/rust-project.json"])
  :config
  (lsp-enable-which-key-integration t))

(use-package treesit
      :mode (("\\.tsx\\'" . tsx-ts-mode)
             )
      :preface
      (defun xq/setup-install-grammars ()
        "Install Tree-sitter grammars if they are absent."
        (interactive)
        (dolist (grammar
                 '((css . ("https://github.com/tree-sitter/tree-sitter-css" "v0.20.0"))
                   (bash "https://github.com/tree-sitter/tree-sitter-bash")
                   (html . ("https://github.com/tree-sitter/tree-sitter-html" "v0.20.1"))
                   (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "v0.21.2" "src"))
                   (json . ("https://github.com/tree-sitter/tree-sitter-json" "v0.20.2"))
                   (python . ("https://github.com/tree-sitter/tree-sitter-python" "v0.20.4"))
                   (go "https://github.com/tree-sitter/tree-sitter-go" "v0.20.0")
                   (markdown "https://github.com/ikatyang/tree-sitter-markdown")
                   (make "https://github.com/alemuller/tree-sitter-make")
                   (elisp "https://github.com/Wilfred/tree-sitter-elisp")
                   (cmake "https://github.com/uyha/tree-sitter-cmake")
                   (c "https://github.com/tree-sitter/tree-sitter-c")
                   (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
                   (toml "https://github.com/tree-sitter/tree-sitter-toml")
                   (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "tsx/src"))
                   (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "v0.20.3" "typescript/src"))
                   (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "v0.5.0"))
                   (prisma "https://github.com/victorhqc/tree-sitter-prisma")))
          (add-to-list 'treesit-language-source-alist grammar)
          ;; Only install `grammar' if we don't already have it
          ;; installed. However, if you want to *update* a grammar then
          ;; this obviously prevents that from happening.
          (unless (treesit-language-available-p (car grammar))
            (treesit-install-language-grammar (car grammar)))))

      :config
      (xq/setup-install-grammars))

(use-package apheleia
  :straight t
  :config
  (apheleia-global-mode +1))

(use-package flycheck
  :straight t
  :init (global-flycheck-mode)
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error) ; optional but recommended error navigation
              ("M-p" . flycheck-previous-error)))

(use-package nix-mode
  :straight t
  :mode "\\.nix\\'")

(use-package typescript-ts-mode
  ;; :straight t
  :mode
  ("\\.tsx?\\'")
  :hook
  (typescript-ts-mode . lsp-deferred)
  :custom
  (typescript-ts-mode-indent-offset 4))
