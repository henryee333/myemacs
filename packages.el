(require 'package)
(package-initialize)
(setq package-archives
      '(("MELPA Stable" . "http://stable.melpa.org/packages/")
        ("MELPA" . "http://melpa.org/packages/")
        ("GNU ELPA" . "http://elpa.gnu.org/packages/")
        ;;("marmalade" . "https://marmalade-repo.org/packages/")
        ;;("ELPA" . "http://tromey.com/elpa/")
        )
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("MELPA" . 5)
        ("GNU ELPA" . 0)))

(defvar my-packages
  '(auto-complete
    ac-math
    auctex
    magit
    multiple-cursors
    projectile
    helm-projectile

    cuda-mode
    web-mode
    coffee-mode
    scss-mode
    smart-tab

    json

    color-theme-solarized
    ace-window
    smartrep
    yaml-mode

    yasnippet

    python
    nose
    ))


(defun uninstalled-packages (packages)
  (delq nil
        (mapcar (lambda (package)
                  (if (package-installed-p package nil) nil package))
                packages)))

(defun confirm-install (packages)
  (delq nil
        (mapcar (lambda (package)
                  (if (y-or-n-p (format "Package %s is missing. Install?" package)) package nil))
                packages)))

(let ((need-to-install
       (confirm-install (uninstalled-packages my-packages))))
  (when need-to-install
    (progn
      (package-refresh-contents)
      (dolist (package need-to-install)
        (package-install package)
        ))))
