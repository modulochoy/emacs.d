(setq auto-mode-alist
      (cons '("\\.as$" . c-mode)
	    auto-mode-alist))

(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (if (eq 'shell-mode major-mode)
	  (comint-dynamic-complete)
	(dabbrev-expand arg))
    (indent-according-to-mode)))

(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))

(add-hook 'c-mode-hook'my-tab-fix)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
     (add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cb" 'org-iswitchb)

(setq org-todo-keywords
			'((sequence "TODO(t)" "|" "DONE(d)")
				(sequence "FIXME(f)" "|" "FIXED(x)")
				(sequence "Q:(q)" "|" "A:(a)")
				(sequence "BUT")
				(sequence "OR")
				(sequence "NOTE")
				(sequence "CAUTION")
				))

(add-hook 'comint-mode-hook
 (lambda ()
   (define-key comint-mode-map (kbd "M-p") 'comint-previous-matching-input-from-input)))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'js2-mode "js2-mode.el" nil t)
(autoload 'batch-mode "batch-mode.el" nil t)
(add-to-list 'auto-mode-alist '("\\.bat$" . batch-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(add-hook 'eshell-mode-hook (lambda ()
			      (custom-color-shell-theme)))

(cua-mode 1)

(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-gnome2)
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-buffer-local")
(require 'color-theme-buffer-local)

(add-hook 'org-mode-hook (lambda ()
			    (custom-color-org-theme)))

(add-hook 'java-mode-hook (lambda ()
			    (custom-color-code-theme)))

;; Set Linum-Mode on
(global-linum-mode 1)
;; Linum-Mode and add space after the number
(setq linum-format "%d ")

(global-set-key (kbd "C-c n") 'comment-region)
(global-set-key (kbd "C-c m") 'uncomment-region)

(show-paren-mode 1) ; turn on paren match highlighting
(setq show-paren-style 'expression) ; highlight entire bracket expression

(require 'js-comint)
(setq inferior-js-program-command "rhino")
(add-hook 'js2-mode-hook '(lambda () 
			    (local-set-key "\C-x\C-e" 'js-send-last-sexp)
			    (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
			    (local-set-key "\C-cb" 'js-send-buffer)
			    (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
			    (local-set-key "\C-cl" 'js-load-file-and-go)
			    (custom-color-code-theme)
			    ))

(custom-set-variables
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(transient-mark-mode (quote (only . t))))
(custom-set-faces
 )
(put 'erase-buffer 'disabled nil)

(global-set-key (kbd "\C-x <down>") 'custom-shrink-window)
(global-set-key (kbd "\C-x <up>") 'custom-enlarge-window)

(defun custom-enlarge-window ()
  (interactive)
  (enlarge-window 8))

(defun custom-shrink-window ()
  (interactive)
  (shrink-window 8))

(defun custom-color-light-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-aalto-light (current-buffer)))

(defun custom-color-default-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-gnome2 (current-buffer)))

(defun custom-color-dark-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-charcoal-black (current-buffer)))

(defun custom-color-shell-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-euphoria (current-buffer)))

(defun custom-color-org-theme ()
  (interactive)
 ;; (color-theme-euphoria))
  (color-theme-buffer-local 'color-theme-pok-wog (current-buffer)))

(defun custom-color-code-theme ()
  (interactive)
  (color-theme-buffer-local 'color-theme-bharadwaj-slate (current-buffer)))

(setq org-startup-truncated nil)

(setq default-directory (concat (getenv "HOME")))

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

(setq backup-directory-alist '(("." . "~/.emacs_backups")))