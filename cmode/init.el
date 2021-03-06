(defun screen-width nil -1)
(define-obsolete-function-alias 'make-local-hook 'ignore "21.1")
;;解决jdee使用了emacs 24不再支持的函数问题
;;(load-file "~/.emacs.d/cmode/cedet-1.1/common/cedet.el")
;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
(add-to-list 'load-path "~/.emacs.d/cmode/cedet-1.1/common")
(require 'cedet)
(require 'semantic-ia)
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;;
(add-to-list 'load-path
                     "~/.emacs.d/cmode/ecb-2.40")
;;(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-auto-activate 0
      ecb-tip-of-the-day 0)
(global-set-key [s-f8] 'ecb-activate)
(global-set-key [s-f7] 'ecb-deactivate)
;;load gdb many windows
(add-to-list 'load-path
	     "~/.emacs.d/cmode")

(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  ;;; hungry-delete and auto-newline
;;  (c-toggle-auto-hungry-state 1)
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  ;;定义快捷键
  (define-key c-mode-base-map [(C-f5)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
;;  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
;;  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (c-set-style "stroustrup")
;;  (define-key c++-mode-map [f3] 'replace-regexp)
)

;;配置Semantic搜索范围
(setq semanticdb-project-roots
	  (list
	   (expand-file-name "/")))
;;自定义补全命令，如果单词在中间就补全，否则就tab
(defun my-indent-or-complete()
  (interactive)
  (if (looking-at "\\>")
	  (hippie-expand nil)
	  (indent-for-tab-command))
  )
;;补全快捷键，ctrl+tab用senator补全，不显示列表
;;alt+/补全，显示列表让选择
(global-set-key [(control tab)] 'my-indent-or-complete)
(define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
(autoload 'senator-try-expand-semantic "senator")
(setq hippie-expand-try-functions-list
	  '(
		senator-try-expand-semantic
		try-expand-dabbrev
		try-expand-dabbrev-visible
		try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
		try-expand-list
		try-expand-list-all-buffers
		try-expand-line
		try-expand-line-all-buffers
		try-complete-file-name-partially
		try-complete-file-name
		try-expand-whole-kill
		)
	  )
;;==========================================================
;;加载cscope
;;==========================================================
(require 'xcscope)

;;
;;(add-to-list 'load-path
;;                     "~/.emacs.d/cmode/jdee-2.4.0.1/lisp")
;; 不自动加载jde-mode    
;;(setq defer-loading-jde t)  

;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/cmode/elib-1.0")) 
;; 编辑.java文件时加载jde    
;;(if defer-loading-jde    
;;    (progn    
;;      (autoload 'jde-mode "jde" "JDE mode." t)    
;;      (setq auto-mode-alist    
;;            (append    
;;             '(("\\.java\\'" . jde-mode))    
;;             auto-mode-alist)))    
;;(define-key jde-mode-map (kbd "C-c C-v g m") 'jde-gen-main-method)  
;;(define-key jde-mode-map (kbd "C-c C-v g p") 'jde-gen-println)  
;;(define-key jde-mode-map (kbd "C-c C-v g C") 'jde-gen-class)  
;;(define-key jde-mode-map (kbd "C-c C-v g c") 'jde-gen-inner-class)  
;;(define-key jde-mode-map (kbd "C-c C-v g a l") 'jde-gen-action-listener)  
;;(define-key jde-mode-map (kbd "C-c C-v g m l") 'jde-gen-mouse-listener)  
;;(define-key jde-mode-map (kbd "C-c C-v g w l") 'jde-gen-window-listener)  
;;(require 'jde)) 
 
;;(load-file "~/.emacs.d/cmode/cs/csharp-mode-0.8.5.el")
;;(setq auto-mode-alist
;;      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
;;C语言开发配置

;;配置注释工具
;;(add-to-list 'load-path  
;;             "~/.emacs.d/cmode/doxymacs");  
;;(require 'doxymacs) ;; 启动doxymacs  
;;注释高亮，针对C和C++程序  
;;(defun my-doxymacs-font-lock-hook ()  
;;  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))  
;;      (doxymacs-font-lock)))  
;;(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)  
;;(doxymacs-mode);doxymacs-mode常true  
;;(add-hook 'c-mode-common-hook 'doxymacs-mode) ;; 启动doxymacs-mode  
;;(add-hook 'c++-mode-common-hook 'doxyma;cs-mode) ;; 启动doxymacs-mode  
;;---C-c d i  
(require 'sr-speedbar)
(require 'compilation-settings)
(require 'speedbar-settings)
(require 'gdb-settings)
