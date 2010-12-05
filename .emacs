;; Path for external packages
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; This configuration assumes that the following package files/directories
;; exist within the load path at ~/.emacs.d/site-lisp:
;;
;; linum.el
;; pager.el
;; screen-256color.el
;;
;; undo-tree/
;; vimpulse/
;; erc/
;; emacs-rails-reloaded/


;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; enable emacs-rails-reloaded
(setq load-path (cons
  (expand-file-name "~/.emacs.d/site-lisp/rails-reloaded") load-path))
(require 'rails-autoload)

;;line numbers
(global-linum-mode 1)
(setq linum-format " %d ")

;;highlight current line
(global-hl-line-mode 1)
 
;;tab-width
(setq tab-width 2)
(setq c-basic-offset 2)
(setq indent-tabs-mode nil)

;;disable the menu bar
(menu-bar-mode -99)

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/color-themes/color-theme-miko256.el")
(color-theme-miko256)

;load path for external packages
(add-to-list 'load-path "~/.emacs.d/site-lisp/erc")

(require 'pager)
(require 'undo-tree)
;; replace the standard emacs undo system with the undo tree system
;; undo: C-_  redo: M-_
(global-undo-tree-mode)

;; load viper and vimpu
(require 'vimpulse)
(add-hook 'emacs-startup-hook 'viper-change-state-to-emacs) 

;erc
(require 'erc)
(require 'erc-stamp)
(require 'erc-match)

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
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
