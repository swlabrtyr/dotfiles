;;;;
;; Packages
;;;;

;; Define package repositories
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("marmalade" . "https://marmalade-repo.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("tromey" . "https://tromey.com/elpa/") t)
;; (add-to-list 'package-archives
;;              '("melpa" . "https://melpa.org/packages/"))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa-stable.milkbox.net/packages/")))

;; Multiple Cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/add-cursor-on-click)

;; js2-refactor
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.



;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-ubiquitous

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit
    ))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")

;; web-mode
(load "~/.emacs.d/elpa/web-mode/web-mode.el")

;; Smooth scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

;; Run Processing 
(setq processing-location "/usr/local/bin/processing-java")
(setq processing-application-dir "/Applications/Processing.app")
(setq processing-sketchbook-dir "~/Documents/Processing")

;; SLIME 
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; Run SuperCollider
;; (add-to-list 'load-path "/usr/local/bin/sclang")
;; (require 'sclang)

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; sets C-n to create new line
(setq next-line-add-newlines t)

;; web-mode jsx
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   [zenburn-bg zenburn-red zenburn-green zenburn-yellow zenburn-blue zenburn-magenta zenburn-cyan zenburn-fg])
 '(ansi-term-color-vector
   [unspecified "#1B2B34" "#EC5f67" "#99C794" "#FAC863" "#6699CC" "#C594C5" "#6699CC" "#C0C5CE"])
 '(blink-cursor-mode nil)
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (base16-eighties-dark)))
 '(custom-safe-themes
   (quote
    ("294834baa9ca874795a3181cce7aaf228b1e3fb3899587ffd3ae7546de328c90" "744c95ef0117ca34c5d4261cb00aff6750fd60338240c28501adb5701621e076" "e2e4e109357cfcebccb17961950da6b84f72187ade0920a4494013489df648fe" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "101a10b15bbbd0d5a0e56e4773e614962197886780afb2d62523a63a144ad96c" "43aeadb0c8634a9b2f981ed096b3c7823c511d507a51c604e4667becb5ef6e35" "d1a42ed39a15a843cccadf107ee0242b5f78bfbb5b70ba3ce19f3ea9fda8f52d" "1edf370d2840c0bf4c031a044f3f500731b41a3fd96b02e4c257522c7457882e" "cb18233197cedab557c70d171b511bed49cc702f428750925280090c31498bd2" "aa87469691932ff791f966bffb885ecd97ebfa4dc4d42e479f3819ac4a3fbcaf" "e254f8e18ba82e55572c5e18f3ac9c2bd6728a7e500f6cc216e0c6f6f8ea7003" "f2503f0a035c2122984e90eb184185769ee665de5864edc19b339856942d2d2d" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "e681c4fc684a543ce97c2d55082c6585182c0089f605dc9a5fe193870f03edc6" "e8bba3c8e8caea2c7a8b6932b0db8d9bdb468c9b44bf554f37b56093d23fde57" "f245c9f24b609b00441a6a336bcc556fe38a6b24bfc0ca4aedd4fe23d858ba31" "1dfd7a150e80fdb4563f594716d09d849f4c50bcea12825bd8d284c05a87a3e1" "9567c8b113a53efdf4e7f3ab47564cb44b27ee231ece20811bb191698b1b8b6b" "36012edb5bc7070a17e989984e0ecc1d1e9c94326bdd0fbd76c2a45ebfe7da54" "a922c743710bb5d7c14995345549141f01211ff5089057dc718a5a33104c3fd1" "232f715279fc131ed4facf6a517b84d23dca145fcc0e09c5e0f90eb534e1680f" "39e93a10eb292941640adfe28509e0c3eeb84e30cbfed6ef9841be136081ca34" "1d6a2b8d5719875cd5f268ea4c2d4a24254122f9c63619b45d82404dd7359951" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "b6d649c9f972b491686e7fa634535653e6222c1faca1ab71b3117854470a79ae" "50e7f9d112e821e42bd2b8410d50de966c35c7434dec12ddea99cb05dd368dd8" "9f6750057fefba39c184783c7b80ddd9c63bc6e8064846b423b4362c9e930404" "5424f18165ed7fd9c3ec8ea43d801dc9c71ab9da2b044000162a47c102ef09ea" "e1551b5516e0a439b6ab019ba00cee866e735f66f22ff67a5d882ad0f1383454" "df7dd02705b5868a4bf38069d3b5335412b8210cabfbcd86860cea3b19ba2a3d" "e8e744a1b0726814ac3ab86ad5ccdf658b9ff1c5a63c4dc23841007874044d4a" "7e346cf2cb6a8324930c9f07ce050e9b7dfae5a315cd8ed3af6bcc94343f8402" "d43120398682953ef18fd7e11e69c94e44d39bb2ab450c4e64815311542acbff" "b6db49cec08652adf1ff2341ce32c7303be313b0de38c621676122f255ee46db" "01c5ebefcabc983c907ee30e429225337d0b4556cc1d21df0330d337275facbb" "9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" default)))
 '(fci-rule-color "#393939")
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Defualt font
(set-face-attribute 'default t :font "Ubuntu Mono")

;; Sublmity
(require 'sublimity)
(require 'sublimity-scroll)

(require 'sublimity-map)

(add-hook 'sublimity-map-setup-hook
          (lambda ()
            (setq buffer-face-mode-face '(:family "Monospace"))
            (buffer-face-mode)))

(sublimity-map-set-delay nil)


(put 'upcase-region 'disabled nil)
