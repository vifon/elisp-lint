FROM ubuntu

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      emacs-nox git pre-commit shellcheck
RUN emacs --batch \
    --funcall package-initialize \
    --funcall package-refresh-contents \
    --eval "(package-install 'package-lint t)" \
    --eval "(package-install 'dash t)" \
    --funcall kill-emacs
