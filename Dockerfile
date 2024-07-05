FROM alpine

RUN apk --no-cache add \
    emacs-nox git pre-commit shellcheck
RUN emacs --batch \
    --funcall package-initialize \
    --funcall package-refresh-contents \
    --eval "(package-install 'package-lint t)" \
    --eval "(package-install 'dash t)" \
    --funcall kill-emacs
