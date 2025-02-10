;;; init.el -*- lexical-binding: t -*-

(setq inhibit-startup-message t)

 (set-frame-font "JetBrainsMono Nerd Font 13" nil t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook)) (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Set up the visible bell
(setq visible-bell t)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  )

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; ================== EVIL ================
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(evil-set-undo-system 'undo-redo)

;; ================== Vertico ================
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t)
  )

(use-package savehist
  :init
  (savehist-mode)
)

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))


;; TODO: config consult
(use-package consult)

;; embark, orderless

;; ================== Completion ================
(use-package corfu
  :ensure t
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


;; ================== LSP ================
(defun xq/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
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

;; ================== Treesitter ================

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


;; ================== Linter ================
    (use-package flycheck
      :ensure t
      :init (global-flycheck-mode)
      :bind (:map flycheck-mode-map
                  ("M-n" . flycheck-next-error) ; optional but recommended error navigation
                  ("M-p" . flycheck-previous-error)))


;; ================== Formatter ================
(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1)
  
  ;; Configure formatters
  (setq apheleia-formatters
        '((prettier . ("prettier" "--stdin-filepath" filepath))
          (nixfmt . ("nixfmt"))
          (rustfmt . ("rustfmt" "--edition" "2021"))
          ))

  ;; Associate modes with formatters
  (setq apheleia-mode-alist
        '((typescript-mode . prettier)
          (typescript-ts-mode . prettier)
          (tsx-ts-mode . prettier)
          (javascript-mode . prettier)
          (js-mode . prettier)
          (web-mode . prettier)
          (css-mode . prettier)
          (json-mode . prettier)
          (nix-mode . nixfmt)
          (rust-mode . rustfmt)
          (python-mode . black)
          (sh-mode . shfmt))))