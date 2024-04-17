(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(helm flycheck-rtags company cmake-ide)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Turn on helm-mode by default.
(helm-mode 1)

;; Turn on company-mode by default for auto-completion.
(global-company-mode 1)

;; For convenience.
(keymap-global-set "C-x C-f" 'helm-find-files)
(keymap-global-set "M-x" 'helm-M-x)

;; Line nunbers in programming mode.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
