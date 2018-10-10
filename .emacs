(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile flycheck-rtags dash cmake-ide company-rtags rtags irony ac-helm helm helm-ebdb))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

(eval-when-compile
  (require 'use-package)
)
	   
(use-package helm
  :diminish helm-mode
  :ensure t
  :bind (
	 ("C-x C-f" . helm-find-files)
         ("M-x" . helm-M-x)
         ("C-x b" . helm-mini)
         ("C-x C-b" . helm-mini)
         ("M-y" . helm-show-kill-ring)
         (:map helm-map
          ("<tab>" . helm-execute-persistent-action) ; Rebind TAB to expand
          ("C-i" . helm-execute-persistent-action) ; Make TAB work in CLI
          ("C-z" . helm-select-action) ; List actions using C-z
	 )
	)
  :config
  (progn
    (setq-default helm-split-window-in-side-p t)
    (helm-mode 1)
  )
  )

(use-package rtags
  :ensure t
  :config
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  :bind
  ("M-." . rtags-find-symbol-at-point)
  ("M-[" . rtags-location-stack-back)
  ("M-]" . rtags-location-stack-forward)
  )

(use-package company
  :ensure t
  :config
  (push 'company-rtags company-backends)
  (global-company-mode)
  :bind
  (("C-o" . company-complete))
  )

(defun my-flycheck-rtags-setup ()
 (flycheck-select-checker 'rtags)
 (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays
					; (setq-local flycheck-check-syntax-automatically nil)
 )

(use-package flycheck-rtags
  :ensure t
  :config
  (progn
    ;; ensure that we use only rtags checking
    ;; https://github.com/Andersbakken/rtags#optional-1
    (add-hook 'c-mode-common-hook 'flycheck-mode)
    (defun setup-flycheck-rtags ()
      (flycheck-select-checker 'rtags)
      (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
      (setq-local flycheck-check-syntax-automatically nil)
      (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
      )
    (add-hook 'c-mode-hook #'setup-flycheck-rtags)
    (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
    ))

(cmake-ide-setup)

; random key-binds
(add-hook 'c-mode-common-hook
 (lambda() (local-set-key  (kbd "C-c o") 'ff-find-other-file))) ; switch between header/impl

; enable line numbers
(global-linum-mode t)
(setq linum-format "%4d \u2502 ") ; add padding between line number and text
