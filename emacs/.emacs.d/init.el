;;
;; Packages and General stuff
;;
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;;(require 'exwm)
;;(require 'exwm-config)
;;(exwm-config-default)
;;(require 'exwm-systemtray)
;;(exwm-systemtray-enable)

(setq-default ring-bell-function 'ignore
              mac-allow-anti-aliasing nil
              scroll-step 1
              scroll-conservatively  10000
              mouse-wheel-scroll-amount '(1 ((shift) . 1))
              mouse-wheel-progressive-speed nil
              mouse-wheel-follow-mouse 't
              indent-tabs-mode nil
              c-basic-offset 4
              tab-width 4
              initial-scratch-message nil
              inhibit-startup-screen t
              auto-save-default nil
              make-backup-files nil
              backup-directory-alist '(("" . "~/.emacs.d/backup"))
              default-directory "~/workspace/"
              custom-file "~/.emacs.d/custom.el")

(shell-command "touch ~/.emacs.d/custom.el")
(setenv "PATH" (concat "/usr/local/go/bin:" (getenv "PATH")))
(setenv "PATH" (concat "~/go/bin:" (getenv "PATH")))
(setenv "PATH" (concat "~/bin:" (getenv "PATH")))
(setenv "PATH" (concat "~/.cargo/bin:" (getenv "PATH")))
(setenv "GTAGSLIBPATH" "~/.gtags")
(add-to-list 'exec-path "/usr/local/go/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/go/bin")
(add-to-list 'exec-path "~/bin")
(add-to-list 'exec-path "~/.cargo/bin")
(load custom-file)

;;transparency
;(set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;(add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; Bootstrap `use-package`
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
;;(use-package benchmark-init
  ;;:ensure t
  ;;:config
  ;; To disable collection of benchmark data after init is done.
  ;;(add-hook 'after-init-hook 'benchmark-init/deactivate))

;;
;; custom functions
;;
(defun helm-persp-projectile-switch-project ()
  (interactive)
  (persp-switch (let ((temp-charset "1234567890abcdefghijklmnopqrstuvwxyz")
                      (random-string ""))
                  (dotimes (i 6 random-string)
                    (setq random-string
                          (concat
                           random-string
                           (char-to-string (elt temp-charset (random (length temp-charset)))))
                          ))
                  ))
  (helm-projectile-switch-project)
  (persp-rename (projectile-project-name)))

(defun my-toggle-shell (the-shell)
  "toggles the shells visibility to the right split window,
'the-shell' parameter should be the symbol name as a string for the
shell, e.g. 'shell' or 'eshell'"
  (interactive)
  (let ((shell-string (concat "*" the-shell "*")))
    ;; if shell exists toggle view on/off
    (if (get-buffer shell-string)
        (if (and (get-buffer-window shell-string))
            (delete-other-windows)
          (let ((w2 (split-window-horizontally)))
            (set-window-buffer w2 shell-string)))
      ;; else split the screen and create eshell
      (let ((w1 (selected-window))
            (w2 (split-window-horizontally)))
        (select-window w2)
        (funcall (intern the-shell))
        (display-line-numbers-mode -1)
        (select-window w1)
        (set-window-buffer w2 shell-string)))))

(defun my-clear-shell ()
  "clears the eshell buffer, does not set my-last-eshell-cmd"
  (interactive)
  (my-send-to-shell "clear 1"))

(defun my-send-to-shell (cmd &optional set-last-cmd-p)
  (interactive)
  (with-current-buffer "*vterm*"
    (read-only-mode -1)
    (vterm-send-string cmd)
    (vterm-send-return)
    (if set-last-cmd-p
        (setq my-last-shell-cmd cmd))))

(eval-after-load "comint"
  '(progn
      (setq comint-move-point-for-output 'others)))

(defun my-send-to-shell-again ()
  "sends the previous command to the active shell"
  (interactive)
  (my-send-to-shell my-last-shell-cmd t))

(defun my-send-to-shell-input ()
  "gets the user command and sends to the buffer containing an active shell"
  (interactive)
  (my-send-to-shell (read-string "CMD: ") t))

(defun my-start-code-block ()
  "starts a code block in org mode"
  (interactive)
  (insert "#+BEGIN_SRC\n\n#+END_SRC")
  (previous-line)
  (previous-line))

(defun my-org-refresh ()
  "refreshes tag alignment and table contents"
  (interactive)
  (org-align-all-tags)
  (org-table-recalculate-buffer-tables))

(defun my-org-timestamp ()
  "sets heading timestamp field"
  (interactive)
  (insert ":DATE: ")
  (org-insert-time-stamp (current-time)))

(defun my-reload-config ()
  "saves the perspective and reloads the config"
  (interactive)
  (persp-state-save)
  (load-file "~/.emacs.d/init.el")
  (persp-state-load "~/.emacs.d/perspective.save")
)

(setq my-font-size 120)
(defun my-global-font-size (size)
  (interactive)
  (set-face-attribute 'default nil
                      :height (+ size my-font-size))
  (setq my-font-size (+ size my-font-size)))


;; start package and keybind usage

;; Use delight for hiding modelines of certain modes.
(use-package delight
  :ensure t
  :config
  (delight '((eldoc-mode nil "eldoc")
             (auto-revert-mode nil "arev")
             (magit-auto-revert-mode nil "arev"))))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (use-package evil-collection
    :ensure t
    :config
    (setq evil-collection-company-use-tng nil)
    (evil-collection-init)))

(use-package string-inflection :ensure t)

(use-package undo-tree
  :delight
  :after evil
  :config
  (global-undo-tree-mode)
  (evil-set-undo-system 'undo-tree))

(use-package vterm :ensure t)

(use-package general
  :demand 
  :config
  (general-evil-setup)
  (general-create-definer my-leader-def
    :prefix "SPC"
    :non-normal-prefix "C-SPC")
  (my-leader-def '(normal visual)
        "n T" 'treemacs
        "n t" 'neotree-toggle
        "c o" '(lambda () (interactive) (find-file "~/.emacs.d/init.el")) 
        "c l" 'my-reload-config

        "s s" 'ispell
        "s S" 'ispell-region
        "s g" 'writegood-mode

        "t t" (lambda () (interactive) (my-toggle-shell "vterm"))
        "t c" 'my-clear-shell
        "v p" 'my-send-to-shell-input
        "v l" 'my-send-to-shell-again

        "u v" 'undo-tree-visualize

        ;; rg stuff
        "s r" 'helm-projectile-rg
        "s R" 'helm-rg
        "s e" 'rg
        "s t" 'rg-literal
        "s p" 'rg-project
        "s m" 'rg-menu
        "s d" 'rg-dwim

        ;; "u d" (lambda () (interactive) (setq undo-tree-visualizer-diff (if (= undo-tree-visualizer-diff 1) 0 1)))
        ;; buffer keybindings
        "n e" 'window-swap-states
        "n n" 'next-buffer
        "n s" 'next-multiframe-window 
        "n p" 'previous-buffer
        "n o" 'delete-other-windows
        "n d" 'kill-buffer-and-window
        "n b" 'helm-mini
        "n m" 'helm-projectile
        "n v" 'helm-projectile-switch-project
        "n V" 'helm-persp-projectile-switch-project
        "n c" 'projectile-persp-switch-project
        "n i" 'helm-imenu
        "i" 'helm-imenu
        ":" 'helm-M-x
        "n r" '(lambda () (interactive) (switch-to-buffer "*scratch*"))
        "n a" '(lambda () (interactive) (find-file "~/workspace/notes.org"))
        "j" 'evil-scroll-down
        "k" 'evil-scroll-up
        ;; magit
        "m s" 'magit
        "m b" 'magit-blame
        "m d" 'magit-diff-buffer-file

        ;; cycle case
        "c s" 'string-inflection-cycle

        ;;code-jump
        "f j" 'xref-find-definitions
        "f k" 'xref-pop-marker-stack
        "f r" 'xref-find-references
        "f h" 'beginning-of-defun
        "f l" 'end-of-defun

        ;; Perspectives
        "p n" 'persp-next
        "p p" 'persp-prev
        "p S" 'persp-switch
        "p s" 'persp-switch-last
        "p l" 'persp-state-load
        "p r" 'persp-state-restore

        ;;window splits
        "w h" 'split-window-horizontally
        "w v" 'split-window-vertically
        "w x" 'delete-window

        ;; compile
        "r r" 'projectile-compile-project

        ;; view
        "d t" (lambda () (interactive) (progn (disable-theme 'gruvbox-dark-medium) (disable-theme 'acme) (load-theme 'tsdh-light) (set-face-background 'mode-line "gold")))
        "d g" (lambda () (interactive) (load-theme 'gruvbox-dark-medium))
        "d a" (lambda () (interactive) (load-theme 'acme))
        "d f" (lambda () (interactive) (toggle-frame-fullscreen))
        "=" (lambda () (interactive) (my-global-font-size 10))
        "-" (lambda () (interactive) (my-global-font-size -10))
   )
  )


(use-package pdf-tools
  :ensure t
  :config
  (custom-set-variables
    '(pdf-tools-handle-upgrades nil))
  (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page)
  )

(use-package web-mode
  :mode ("\\.html?\\'" . web-mode))

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp-deferred)
  :init
  (setq rust-format-on-save t)
  (setq indent-tabs-mode nil)
  (setq lsp-rust-analyzer-server-display-inlay-hints t))

(use-package helm
  :ensure t
  :init
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "M-j") 'helm-next-line)
  (global-set-key (kbd "M-k") 'helm-previous-line)
  :config
  (setq helm-boring-buffer-regexp-list
      (quote
       (  "\\Minibuf.+\\*"
          "\\` "
          "\\magit"
          "\\*.+\\*"))))

(use-package helm-gtags
  :after helm
  :hook ((c-mode . helm-gtags-mode)
         (c++-mode . helm-gtags-mode)
         (asm-mode . helm-gtags-mode)
         (helm-gtags-mode . (lambda ()
              (define-key evil-normal-state-local-map (kbd "SPC g g") 'helm-gtags-find-tag-from-here)
              (define-key evil-normal-state-local-map (kbd "SPC g p") 'helm-gtags-pop-stack)
              (define-key evil-normal-state-local-map (kbd "SPC g f") 'helm-gtags-select)
              (define-key evil-normal-state-local-map (kbd "SPC g u") 'helm-gtags-update-tags)))))

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode)
  :hook (yaml-mode . (lambda () (setq-default tab-width 2))))

(use-package powershell
  :mode ("\\.ps1\\'" . powershell-mode))

(use-package dockerfile-mode
  :mode ("\\Dockerfil.*\\" . dockerfile-mode))

(use-package helm-themes
  :after helm)

(use-package acme-theme
  :ensure t)

(use-package magit
  :ensure t)

(setenv "PDFLATEX" "pdflatex --shell-escape")
(use-package latex-preview-pane
  :ensure t)

(require 'ox-latex)
(add-hook 'latex-mode-hook 'latex-preview-pane-mode)
(setq org-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))


(use-package org
  :mode "\\.org\\'"
  :hook (org-mode . (lambda ()
              (org-indent-mode)
              ;(add-hook 'after-save-hook 'org-preview-latex-fragment)
              (define-key evil-normal-state-local-map (kbd "SPC r r") 'org-preview-latex-fragment)
              (define-key evil-normal-state-local-map (kbd "SPC E") 'org-gfm-export-to-markdown)
              (define-key evil-normal-state-local-map (kbd "SPC M") 'org-md-export-to-markdown)
              (define-key evil-normal-state-local-map (kbd "SPC F") 'org-table-toggle-coordinate-overlays)
              (define-key evil-normal-state-local-map (kbd "SPC P") 'org-present)
              (define-key evil-normal-state-local-map (kbd "SPC R") 'my-org-refresh)
              (define-key evil-normal-state-local-map (kbd "SPC T") 'my-org-timestamp)
              (define-key evil-normal-state-local-map (kbd "SPC p") 'org-cycle)
              (define-key evil-normal-state-local-map (kbd "SPC t") 'org-table-create)
              (define-key evil-normal-state-local-map (kbd "SPC g p") 'org-global-cycle)
              (define-key evil-normal-state-local-map (kbd "SPC s n") 'my-start-code-block)
              (define-key evil-normal-state-local-map (kbd "SPC s o") 'org-edit-src-code)
              (define-key evil-normal-state-local-map (kbd "SPC u") 'org-todo)
              (define-key evil-normal-state-local-map (kbd "SPC o") 'org-toggle-checkbox)))
  :config
  (setq org-plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  (use-package ox-gfm
    :ensure t)
  (use-package org-present
    :ensure t
    :init
    (defun org-present-add-overlays ()
    "Add overlays for this mode."
    (add-to-invisibility-spec '(org-present))
    (save-excursion
        ;; cycle code blocks that are tagged as :hidden
        (goto-char (point-min))
        (while (re-search-forward "^[[:space:]]*\\(#\\+\\)\\(BEGIN_SRC\\).*\\(:hidden\\).*" nil t)
          ;;(while (progn
          ;;         (forward-line 1)
          ;;          (not (looking-at "^.*\\#\\+END_SRC.*")))
          ;;  (org-present-add-overlay (line-beginning-position) (line-end-position))
          ;; )
          (if (org-invisible-p (line-end-position)) nil (org-cycle))
        )
        ;; hide org-mode options starting with #+
        (goto-char (point-min))
        (while (re-search-forward "^[[:space:]]*\\(#\\+\\)\\([^[:space:]]+\\).*" nil t)
        (let ((end (if (org-present-show-option (match-string 2)) 2 0)))
            (org-present-add-overlay (match-beginning 1) (match-end end))))
        ;; hide stars in headings
        (goto-char (point-min))
        (while (re-search-forward "^\\(*+\\)" nil t)
        (org-present-add-overlay (match-beginning 1) (match-end 1)))
        ;; hide emphasis/verbatim markers if not already hidden by org
        (if org-hide-emphasis-markers nil
        ;; TODO https://github.com/rlister/org-present/issues/12
        ;; It would be better to reuse org's own facility for this, if possible.
        ;; However it is not obvious how to do this.
        (progn
            ;; hide emphasis markers
            (goto-char (point-min))
            (while (re-search-forward org-emph-re nil t)
            (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
            (org-present-add-overlay (1- (match-end 2)) (match-end 2)))
            ;; hide verbatim markers
            (goto-char (point-min))
            (while (re-search-forward org-verbatim-re nil t)
            (org-present-add-overlay (match-beginning 2) (1+ (match-beginning 2)))
            (org-present-add-overlay (1- (match-end 2)) (match-end 2)))))))


    :hook ((org-present-mode . (lambda ()
                   (local-set-key (kbd "C-c +") '(lambda () (interactive) (my-global-font-size 10)))
                   (local-set-key (kbd "C-c -") '(lambda () (interactive) (my-global-font-size -10)))
                   (local-set-key (kbd "C-c q") '(lambda () (interactive) (org-present-quit)))
                   (turn-off-evil-mode)
                   (hide-mode-line-mode)
                   (org-present-big)
                   (display-line-numbers-mode -1)
                   (org-display-inline-images)
                   (org-present-hide-cursor)
                   (org-present-read-only)))
       (org-present-mode-quit . (lambda ()
                   (turn-on-evil-mode)
                   (hide-mode-line-mode -1)
                   (display-line-numbers-mode t)
                   (org-present-small)
                   (org-remove-inline-images)
                   (org-present-show-cursor)
                   (org-present-read-write))))
  )
  (setq org-todo-keywords
        '((sequence "PROJECT" "TODO" "IN-PROGRESS" "BACKLOG" "|" "DONE")))
)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :hook (markdown-mode . (lambda ()
              (turn-on-orgtbl)
              (turn-on-orgstruct++)))
  :init
  (setq markdown-command "multimarkdown"))

(use-package plantuml-mode
  :ensure t
  :mode ("\\.plantuml|.puml\\'" . plantuml-mode)
  :hook (plntuml-mode . (lambda () (
  (setq plantuml-executable-path "/usr/bin/plantuml")
  (setq plantuml-default-exec-mode 'executable)))
  ))

(use-package projectile
  :after helm
  :config
  (projectile-mode +1)
  (use-package helm-projectile
    :after (projectile helm)
    :init
    (setq projectile-completion-system 'helm-mini)
    (setq projectile-switch-project-action '(lambda () (neotree-projectile-action) (neotree-hide)))

    )
  (use-package org-projectile
    :after (projectile org)
    :bind (("C-c n p" . org-projectile-project-todo-completing-read)
            ("C-c c" . org-capture))
    :config
    (progn
        (org-projectile-per-project)
        (setq org-projectile-per-project-filepath "TODO.org")
        (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
        (push (org-projectile-project-todo-entry) org-capture-templates))
    )
)

(use-package helm-rg
  :after helm)

(use-package lsp-mode
  :hook ((go-mode . lsp-deferred)
         (rust-mode . lsp-deferred))
  :commands lsp-deferred
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all nil)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-idle-delay 0.1)
  (gc-cons-threshold 100000000)
  (read-process-output-max (* 1024 1024 3)) ;; 1mb
  (lsp-completion-provider :capf)
  (lsp-enable-file-watchers nil)
  (lsp-log-io nil)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure 
  :commands lsp-ui-mode
  :custom
    (lsp-ui-peek-always-show t)
    (lsp-ui-sideline-show-hover t)
    (lsp-ui-sideline-enable nil)
    (lsp-ui-doc-enable t)
  :hook (
  (lsp-ui-mode . (lambda ()
      (define-key evil-normal-state-local-map (kbd "SPC l i") 'lsp-ui-imenu)
      (define-key evil-normal-state-local-map (kbd "SPC l s") 'lsp-ui-sideline-toggle-symbols-info)
      (define-key evil-normal-state-local-map (kbd "SPC l r") 'lsp-ui-peek-find-references)
      (define-key evil-normal-state-local-map (kbd "SPC l d") 'lsp-ui-peek-find-definitions)))
  (lsp-ui-peek-mode . (lambda ()
      (define-key lsp-ui-peek-mode-map (kbd "l") 'lsp-ui-peek--select-next-file)
      (define-key lsp-ui-peek-mode-map (kbd "h") 'lsp-ui-peek--select-prev-file)
      (define-key lsp-ui-peek-mode-map (kbd "j") 'lsp-ui-peek--select-next)
      (define-key lsp-ui-peek-mode-map (kbd "k") 'lsp-ui-peek--select-prev)))))

(use-package helm-lsp
  :after (helm lsp-mode)
  :commands helm-lsp-workspace-symbol)

(use-package which-key
  :ensure t
  :delight
  :config
  (which-key-mode))

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  ;;:general
  ;;(general-evil-define-key 'normal go-mode-map
  ;; "g g" 'godef-jump)
    ;("g p" 'pop-tag-mark)
    ;("g d" 'godoc-at-point)
  :hook
  ;((go-mode . (lambda ()
  ;            (define-key evil-normal-state-local-map (kbd "SPC g g") 'godef-jump)
  ;            (define-key evil-normal-state-local-map (kbd "SPC g p") 'pop-tag-mark)
  ;            (define-key evil-normal-state-local-map (kbd "SPC g d") 'godoc-at-point)
  ;  		  ))
   (before-save . gofmt-before-save)
  :config
  (setq gofmt-command "goimports")
  (use-package go-eldoc
    :ensure t
    :hook (go-mode . go-eldoc-setup)
    )
)

(use-package rg
  :ensure t
  :init
  (rg-enable-menu))

(use-package poly-markdown
  :defer t)

(use-package poly-R
  :defer t)

(use-package rjsx-mode
  :mode ("components\\/.*\\.js\\'" . rjsx-mode))

(use-package js2-mode
  :mode "\\.js\\'")

(use-package ess
  :mode (("\\*\\.R" . ess-site)
         ("\\*\\.Rmd" . ess-site)
         ("\\.Rmd\\'" . poly-markdown+R-mode))
  :commands R
  :hook (ess-mode . (lambda ()
              (subword-mode)
              (define-key evil-normal-state-local-map (kbd "SPC r s") 'my-ess-start-R)
              (define-key evil-normal-state-local-map (kbd "SPC r r") (lambda () (interactive) (ess-eval-function-or-paragraph-and-step)))))
  :defer t
  :init
  (setq ess-ask-for-ess-directory nil)
  (setq ess-local-process-name "R")
  (setq scroll-down-aggressively 0.01)
  (setq ess-fancy-comments nil)
  (defun my-ess-start-R ()
    (interactive)
    (if (not (get-process "R"))
    ;(if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
        (progn
          (setq w1 (selected-window))
          (setq w2 (split-window-horizontally))
          (R)
          (display-line-numbers-mode -1)
          (set-window-buffer w2 "*R*")
          (select-window w1))
      (if (and (get-buffer-window "*R*"))
          (delete-other-windows)
        (progn (let ((w1 (selected-window))
                     (w2 (split-window-horizontally)))
                 (set-window-buffer w2 "*R*")
                 (selecte-window w1))))))
)

(use-package company
  :ensure t
  :delight
  :hook 
  (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1)
  (setq company-lsp-cache-candidates t)
  (setq company-lsp-async t)
  (add-to-list 'company-backends 'company-gtags)(with-eval-after-load 'company
    (define-key company-active-map [tab] 'company-select-next)
    (define-key company-active-map (kbd "TAB") 'company-select-next)))

;;
;; neotree
;;
(defun neo-open-file-hide (full-path &optional arg)
  "Open a file node and hides tree."
  (neo-global--select-mru-window arg)
  (find-file full-path)
  (neotree-hide))

(defun neotree-enter-hide (&optional arg)
  "Enters file and hides neotree directly"
  (interactive "P")
  (neo-buffer--execute arg 'neo-open-file-hide 'neo-open-dir))

(use-package neotree
  :after evil
  :ensure t
  :init
  (setq neo-theme 'arrow)
  (setq neo-window-fixed-size nil)
  (display-line-numbers-mode -1)
  (add-hook 'neotree-mode-hook
			(lambda ()
              (display-line-numbers-mode -1)
			  (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter-hide)
			  (define-key evil-normal-state-local-map (kbd "SPC n t") 'neotree-hide)
			  (define-key evil-normal-state-local-map (kbd "SPC n s") 'next-multiframe-window)
			  (define-key evil-normal-state-local-map (kbd "n") 'neotree-create-node)
			  (define-key evil-normal-state-local-map (kbd "C") 'neotree-copy-node)
			  (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
			  (define-key evil-normal-state-local-map (kbd "h") 'neotree-hidden-file-toggle)
			  (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
			  (define-key evil-normal-state-local-map (kbd "p") 'neotree-change-root))))

(use-package treemacs
  :ensure t)
  ;;:hook (treemacs-mode . (lambda() (
  ;;             (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter-hide)                    ))))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)
(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)
(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)


(use-package perspective
  :ensure t
  :hook
  (after-init . persp-mode)
  :init
  (setq persp-state-default-file "~/.emacs.d/perspective.save")
  (add-hook 'kill-emacs-hook #'persp-state-save)

  (use-package persp-projectile
    :ensure t
    :after perspective
    :hook (persp-switch . cm/persp-neo)
    :bind ("C-c x" . hydra-persp/body)

    :config
    (defun cm/persp-neo ()
      "Make NeoTree follow the perspective"
      (interactive)
      (let ((cw (selected-window))
            (path (buffer-file-name))) ;; save current window and buffer
            (progn
              (when (and (fboundp 'projectile-project-p)
                         (projectile-project-p)
                         (fboundp 'projectile-project-root))
                (neotree-dir (projectile-project-root)))
              (neotree-find path))
            (select-window cw)
            (neotree-hide)))

    (defhydra hydra-persp (:columns 4
                           :color blue)
      "Perspective"
      ("a" persp-add-buffer "Add Buffer")
      ("i" persp-import "Import")
      ("c" persp-kill "Close")
      ("n" persp-next "Next")
      ("p" persp-prev "Prev")
      ("k" persp-remove-buffer "Kill Buffer")
      ("r" persp-rename "Rename")
      ("A" persp-set-buffer "Set Buffer")
      ("s" persp-switch "Switch")
      ("C-x" persp-switch-last "Switch Last")
      ("b" persp-switch-to-buffer "Switch to Buffer")
      ("P" projectile-persp-switch-project "Switch Project")
      ("q" nil "Quit"))))

(use-package default-text-scale
:ensure t)

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-easymotion
  :after evil
  :config
  (evilem-default-keybindings "e"))

(use-package dash
  :ensure t)

(use-package monitor
  :ensure t)

(use-package hydra
  :ensure t)

(use-package evil-org
  :after (evil dash org)
  :ensure t
  :hook (org-mode . (lambda ()
              (evil-org-mode)
         ))
  :config 
    (setf evil-org-key-theme '(navigation insert textobjects additional shift todo heading))
    (setf org-special-ctrl-a/e t)
    )



(use-package vimish-fold
  :delight
  :after evil)

(use-package evil-vimish-fold
  :delight
  :after vimish-fold
  :hook ((prog-mode conf-mode text-mode) . evil-vimish-fold-mode))

(use-package flycheck
  :ensure t
  :delight
  :init (global-flycheck-mode))

(use-package rustic
  :ensure t
  :mode ("\\.rs\\'" . rustic-mode)
  :after flycheck)

(use-package page-break-lines
  :ensure t)

(use-package dashboard
  :after page-break-lines
  :config
  (dashboard-setup-startup-hook))

(if (display-graphic-p)
    (progn
      (scroll-bar-mode -1)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(xterm-mouse-mode 1)
(electric-pair-mode 1) ;; close braces
(show-paren-mode) ;; show matching parens

(fset 'yes-or-no-p 'y-or-n-p)
(company-tng-configure-default)
;(load-theme 'tsdh-light)
;(set-face-background 'mode-line "gold")
(use-package gruvbox-theme
  :ensure t)
(load-theme 'gruvbox-dark-medium)
;(use-package powerline
;  :ensure t
;  :init (powerline-vim-theme))

(set-face-attribute 'default nil
                    :family "Iosevka Term"
                    :height my-font-size
                    :weight 'medium)

(global-display-line-numbers-mode)
(global-hl-line-mode)
