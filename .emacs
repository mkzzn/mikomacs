;; Path for external packages
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; This configuration assumes that the following package files/directories
;; exist within the load path at ~/.emacs.d/site-lisp:
;;
;; linum.el
;; pager.el
;; screen-256color.el
;; snippet.el
;; find-recursive.el
;;
;; undo-tree/
;; vimpulse/
;; erc/
;; emacs-rails-reloaded/
;; rinari

;; Add color to a shell running in emacs 'M-x shell'
;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;(add-ui-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)
;
;; Rinari
(add-to-list 'load-path "~/.emacs.d/site-lisp/rinari")
(require 'rinari)

;; enable emacs-rails-reloaded
; (require 'snippet)
; (require 'find-recursive)
; (setq load-path (cons (expand-file-name "~/.emacs.d/site-lisp/emacs-rails-reloaded") load-path))
; (require 'rails-autoload)

;; CEDET
;(load-file "~/.emacs.d/site-lisp/cedet-1.0/common/cedet.el")
;(global-ede-mode 1)                      ; Enable the Project management system
;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;(global-srecode-minor-mode 1)            ; Enable template insertion menu
;
;;ECB
;(add-to-list 'load-path "~/.emacs.d/site-lisp/ecb-2.40")
;(load-file "~/.emacs.d/site-lisp/ecb-2.40/ecb.el")
;(require 'ecb)

;; ruby packages
(require 'haml-mode)

;;line numbers
(global-linum-mode 1)
(setq linum-format " %d ")

;;highlight current line
(global-hl-line-mode 1)
 
;;tab-width
(setq-default tab-width 2)
(setq-default c-basic-offset 0)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)

;; file-type-specific indent variables 
(setq-default ruby-indent-level 2)
(setq-default js-indent-level 2)

;;disable the menu bar
(menu-bar-mode -99)

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/color-themes/color-theme-miko256.el")
(load-file "~/.emacs.d/color-themes/color-theme-viper-vim.el")
(load-file "~/.emacs.d/color-themes/color-theme-viper-insert.el")
(color-theme-miko256)

;  (eval-after-load 'viper
;    '(progn
;       (setq viper-vi-state-id (concat (propertize "<V>" 'face 'hi-blue-b) " "))
;       (setq viper-emacs-state-id (concat (propertize "<E>" 'face 'hi-red-b) " "))
;       (setq viper-insert-state-id (concat (propertize "<I>" 'face 'hi-blue-b) " "))
;       (setq viper-replace-state-id (concat (propertize "<R>" 'face 'hi-blue-b) " "))
;       ;; The property `risky-local-variable' is a security measure
;       ;; for mode line variables that have properties
;       (put 'viper-mode-string 'risky-local-variable t)))

;load path for external packages
(add-to-list 'load-path "~/.emacs.d/site-lisp/erc")

(require 'pager)
(require 'undo-tree)
;; replace the standard emacs undo system with the undo tree system
;; undo: C-_  redo: M-_
(global-undo-tree-mode)

;; load viper and vimpulse
(require 'vimpulse)
(require 'viper-theme)
(add-hook 'emacs-startup-hook 'viper-change-state-to-emacs)
(add-hook 'change-major-mode-hook 'viper-change-state-to-emacs)
(setq viper-shift-width 2)

;erc
(require 'erc)
(require 'erc-stamp)
(require 'erc-match)

;;various minor modes for web development
(require 'rspec-mode)
(require 'haml-mode)
(require 'sass-mode)
;(require 'js2-mode)
(require 'ruby-mode)
(require 'yaml-mode) 

;; espresso mode (provides better jQuery support than js-2 mode)
; (autoload #'espresso-mode "espresso" "Start espresso-mode" t)
; (add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
; (add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;; org mode
(require 'org-install)
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-font-lock-mode 1)                     ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;; show the current cursor line, column numbers
(column-number-mode t)
(line-number-mode t)

;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Use the Printing Package
;; set the PDF printer as default
;;(setq printer-name "PDF_file_generator")
;;(setq printer-name t)
(setq ps-printer-name "PDF_file_generator")
(setq ps-printer-name t)


(defun print-to-pdf ()
  (interactive)
  (ps-spool-buffer-with-faces)
  (switch-to-buffer "*PostScript*")
  (write-file "/tmp/tmp.ps")
  (kill-buffer "tmp.ps")
  (setq cmd (concat "ps2pdf14 /tmp/tmp.ps " (buffer-name) ".pdf"))
  (shell-command cmd)
  (shell-command "rm /tmp/tmp.ps")
  (message (concat "Saved to:  " (buffer-name) ".pdf"))
  )

;; save numbered backups
(setq version-control t)
;; delete the oldest backups backups
(setq delete-old-versions t)

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosave/" t)
(make-directory "~/.emacs.d/backup/" t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backup/"))))

; (custom-set-variables (ecb-options-version "2.40"))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

(put 'scroll-left 'disabled nil)
