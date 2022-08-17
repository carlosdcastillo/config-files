;;; package -- Summary:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#262626"))
 '(custom-safe-themes
   '("aba75724c5d4d0ec0de949694bce5ce6416c132bb031d4e7ac1c4f2dbdd3d580" "d4f8fcc20d4b44bf5796196dbeabec42078c2ddb16dcb6ec145a1c610e0842f3" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" default))
 '(fci-rule-color "#3a3a3a")
 '(hl-sexp-background-color "#121212")
 '(package-selected-packages
   '(avy matlab-mode helm dashboard yaml-mode ripgrep rg rainbow-delimiters py-autopep8 material-theme flycheck expand-region evil-leader elpy clang-format autopair))
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a")))
 '(vc-annotate-very-old-color nil))

;;; Commentary:
(require 'package)
;;; Code:
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(elpy-enable)
(setq confirm-kill-emacs 'y-or-n-p)
(global-undo-tree-mode)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "t" 'helm-buffers-list)
(evil-leader/set-key "e" 'helm-find-files)
(evil-leader/set-key "k" 'kill-buffer-and-window)
(evil-leader/set-key "d" 'evil-quit)
(evil-leader/set-key "c " 'comment-or-uncomment-region)
(evil-leader/set-key "v" 'helm-show-kill-ring)
(evil-leader/set-key "b " 'elpy-format-code)
(evil-leader/set-key "g " 'avy-goto-word-0)

(setq evil-toggle-key "C-`")
(require 'evil)
(evil-mode 1)

(setq-default evil-search-module 'evil-search)

(eval-after-load "evil" '(setq expand-region-contract-fast-key "z"))
(evil-leader/set-key "xx" 'er/expand-region)

;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-classic)
(load-theme 'material t)
(add-hook 'python-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c++-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c-mode-hook #'rainbow-delimiters-mode)
(add-hook 'rust-mode-hook #'rainbow-delimiters-mode)
(require 'rg)
(rg-enable-default-bindings)

(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

(setq backup-directory-alist `(("." . "~/.saves")))

(defun untabify-except-makefiles ()
  "Replace tabs with spaces except in makefiles."
  (unless (derived-mode-p 'makefile-mode)
    (untabify (point-min) (point-max))))

(add-hook 'before-save-hook 'untabify-except-makefiles)


(defun reorder-python-imports()
  "Reorder python imports."
  (when (eq major-mode 'python-mode)
    (defvar carlos-q)
    (setq carlos-q (make-temp-file "carlos"))
    (append-to-file (point-min) (point-max) carlos-q)
    (shell-command-to-string (format "/home/carlos/virtualenvs/sw/bin/reorder-python-imports %s" carlos-q))
    (insert-file-contents carlos-q nil nil nil t)
  )
)

(add-hook 'before-save-hook 'reorder-python-imports)


(defun add-trailing-comma()
  "Reorder python imports."
  (when (eq major-mode 'python-mode)
    (defvar carlos-q)
    (setq carlos-q (make-temp-file "carlos"))
    (append-to-file (point-min) (point-max) carlos-q)
    (shell-command-to-string (format "/home/carlos/virtualenvs/sw/bin/add-trailing-comma %s" carlos-q))
    (insert-file-contents carlos-q nil nil nil t)
  )
)

(add-hook 'before-save-hook 'add-trailing-comma)


(tool-bar-mode -1)
(setq indent-tabs-mode nil)
(setq-default c-basic-offset 4)

(setq linum-format "%d ")
(global-linum-mode 1)

(defun flycheck-python-setup ()
  (flycheck-mode))
(add-hook 'python-mode-hook #'flycheck-python-setup)
(global-flycheck-mode)
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)


(tool-bar-mode -1)
(setq indent-tabs-mode nil)
(setq-default c-basic-offset 4)

(setq linum-format "%d ")
(global-linum-mode 1)

(require 'clang-format)
(setq-default c-basic-offset 4)
(global-set-key (kbd "<f9>") 'compile)
(global-set-key (kbd "<f5>") 'clang-format-buffer)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(setq evil-ex-search-case 'sensitive)


(require 'cc-mode)
 ;; ==========================================
 ;; (optional) bind M-o for ff-find-other-file
 ;; ==========================================
 (defvar my-cpp-other-file-alist
   '(("\\.cpp\\'" (".h" ".hpp" ".ipp"))
     ("\\.ipp\\'" (".hpp" ".cpp"))
     ("\\.hpp\\'" (".ipp" ".cpp"))
     ("\\.cxx\\'" (".hxx" ".ixx"))
     ("\\.ixx\\'" (".cxx" ".hxx"))
     ("\\.hxx\\'" (".ixx" ".cxx"))
     ("\\.c\\'" (".h"))
    ("\\.h\\'" (".cpp" "c"))))
(setq-default ff-other-file-alist 'my-cpp-other-file-alist)
;; (add-hook 'c-mode-common-hook (lambda ()
;;     (define-key c-mode-base-map (kbd "<f12>") 'ff-get-other-file)))
(define-key c-mode-base-map (kbd "<f12>") 'ff-get-other-file)
(define-key c-mode-base-map (kbd "<f9>") 'compile)

(define-key c-mode-base-map (kbd "<f12>") 'ff-get-other-file)
(define-key c-mode-base-map (kbd "<f9>") 'compile)
(global-set-key (kbd "<f7>") 'rg)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq-default show-trailing-whitespace t)

; Overload shifts so that they don't lose the selection
(define-key evil-visual-state-map (kbd ">") 'djoyner/evil-shift-right-visual)
(define-key evil-visual-state-map (kbd "<") 'djoyner/evil-shift-left-visual)
(define-key evil-visual-state-map [tab] 'djoyner/evil-shift-right-visual)
(define-key evil-visual-state-map [S-tab] 'djoyner/evil-shift-left-visual)

(defun djoyner/evil-shift-left-visual ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun djoyner/evil-shift-right-visual ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

;; (require 'autopair)
;; (autopair-global-mode)

;; change mode-line color by evil state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
             (add-hook 'post-command-hook
                       (lambda ()
                         (let ((color (cond ((minibufferp) default-color)
                                            ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                                            ((evil-emacs-state-p)  '("#444488" . "#ffffff"))
                                            ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                                            (t default-color))))
                           (set-face-background 'mode-line (car color))
                           (set-face-foreground 'mode-line (cdr color)))))
)

(require 'dashboard)
(dashboard-setup-startup-hook)

(global-hl-line-mode)
;; (org-indent-mode)
(visual-line-mode)

(setq visible-bell 1)

;; (print company-backends)
;; (setq company-backends (remove 'company-files company-backends))

(provide 'init)

;;; init.el ends here


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
