;;; company-nand2tetris-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "company-nand2tetris" "company-nand2tetris.el"
;;;;;;  (22321 16854 0 0))
;;; Generated autoloads from company-nand2tetris.el

(define-namespace company-nand2tetris (defun /candidates (prefix) "Gather Candidates from `nand2tetris-core-builtin-chips' that match PREFIX." (let ((res)) (dolist (option nand2tetris-core-builtin-chips) (let ((name (car option))) (when (string-prefix-p prefix name) (push name res)))) res)) (defun /display-doc-buffer (candidate) "Return documentation buffer for chosen CANDIDATE." (let ((buf (get-buffer-create "*company-nand2tetris-doc*")) (doc (cdr (assoc "description" (assoc candidate nand2tetris-core-builtin-chips))))) (when doc (with-current-buffer buf (view-mode -1) (erase-buffer) (insert doc) (goto-char (point-min)) (view-mode 1) buf)))) (defun /get-annotation (candidate) "Get the specification of the chip defined by CANDIDATE as annotated text." (let ((spec (cdr (assoc "spec" (assoc candidate nand2tetris-core-builtin-chips))))) (format "    %s" spec))) (defun /grab-symbol nil "Grab last symbol with a dotty syntax." (buffer-substring (point) (save-excursion (skip-syntax-backward "w_.") (point)))) (defun /grab-prefix nil "Grab prefix at point." (or (/grab-symbol) 'stop)))

(autoload 'company-nand2tetris "company-nand2tetris" "\
Company backend for `nand2tetris-mode'.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; company-nand2tetris-autoloads.el ends here
