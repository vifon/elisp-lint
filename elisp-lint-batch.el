#!/usr/bin/env -S emacs --batch --load
;;; -*- lexical-binding: t; -*-

(let ((pkg-root (expand-file-name ".emacs.d/straight/repos"
                                  (getenv "HOME"))))
  (dolist (pkg '("package-lint" "dash.el"))
    (add-to-list 'load-path
                 (expand-file-name pkg pkg-root))))

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
