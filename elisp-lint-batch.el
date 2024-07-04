#!/usr/bin/env -S emacs --batch --load
;;; -*- lexical-binding: t; -*-

(let ((straight-path
       (expand-file-name ".emacs.d/straight/repos/"
                         (getenv "HOME"))))
  ;; Check if package-lint is installed with straight.el,
  ;; reuse it if possible.
  (if (file-directory-p straight-path)
      (dolist (pkg '("package-lint" "dash.el"))
        (add-to-list 'load-path
                     (expand-file-name pkg straight-path)))
    ;; Use package.el otherwise.
    (package-initialize)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'package-lint t)
    (package-install 'dash t)))

(when (string= (car command-line-args-left) "--main-file")
  (pop command-line-args-left)
  (setq package-lint-main-file (file-name-nondirectory (pop command-line-args-left))))

(advice-add 'package-lint--check-packages-installable :override #'always)

(require 'elisp-lint
         (expand-file-name "elisp-lint.el"
                           (file-name-directory load-file-name)))

(let ((indent-tabs-mode nil)
      (fill-column 80))
  (elisp-lint-files-batch))
