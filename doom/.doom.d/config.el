;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Set org agenda files
(setq org-agenda-files (append '("~/org/gtd.org"
                               "~/org/backend_dev.org"
                               "~/org/capra.org")
                               (file-expand-wildcards "~/org/projects/*/*.org")))

;; Workflow sequence, track TODO state changes
(after! org
     (setq org-todo-keywords
           '((sequence "TODO(t)" "NEXT(n)" "INPROGRESS(i)" "WAITING(w@/!)" "HOLDING(h)" "PROJECT(p)" "ACTIVE(a)" "INACTIVE(I)" "|" "DONE(d!)" "CANCELLED(c@)")))

     ;; start agenda today
     (setq org-agenda-start-day nil) ;today
     ;; Skip Done tasks in agenda view
     (setq org-agenda-skip-scheduled-if-done t)
     (setq org-agenda-skip-deadline-if-done t)

     ;; Show the daily agenda by default.
     ;(setq org-agenda-span 'day)

     ;; Hide tasks that are scheduled in the future.
     (setq org-agenda-todo-ignore-scheduled 'future)

     ;; Use "second" instead of "day" for time comparison.
     ;; It hides tasks with a scheduled time like "<2020-11-15 Sun 11:30>"
     (setq org-agenda-todo-ignore-time-comparison-use-seconds t)

     ;; Hide the deadline prewarning prior to scheduled date.
     (setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)

     ;; org super agenda config
     (setq org-agenda-custom-commands
           '(("z" "Super zaen view"
             ((agenda "" ((org-agenda-span 'day)
                          (org-super-agenda-groups
                          '((:name "Today"
                                   :time-grid t
                                   :date today
                                   :todo "TODAY"
                                   :scheduled today
                                   :order 0)
                            (:name "InProgress"
                                   :todo "INPROGRESS"
                                   :order 10)
                            (:name "Due Today"
                                    :deadline today
                                    :order 20)
                            (:name "Due Soon"
                                    :deadline future
                                    :order 40)
                            (:name "Done today"
                                    :and (:regexp "State \"DONE\""
                                          :log t)
                                    :order 25)
                            (:name "Overdue"
                                    :deadline past
                                    :scheduled past
                                    :order 30)))))
              (alltodo "" ((org-agenda-overriding-header "")
                           (org-super-agenda-groups
                            '((:name "Next Items"
                                     :todo "NEXT"
                                     :order 0)
                              (:name "Waiting"
                                      :todo "WAITING"
                                      :order 10)
                              (:name "Important"
                                      :priority "A"
                                      :order 30)
                              (:name "Quick Picks"
                                      :effort< "0:30"
                                      :order 20)
                              (:name "Projects"
                                      :file-path "projects"
                                      :order 40)
                              (:priority<= "B"
                                      :scheduled future
                                      :order 50)
                              (:auto-category t
                                      :order 90)
                              ))))))
             ))
)
(use-package! org-super-agenda
  :after org
  :config
  (org-super-agenda-mode 1))

;; Set org latex preview scale
(after! org
     (setq org-format-latex-options
      (plist-put org-format-latex-options :scale 2.5)))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Yueting Liu"
      user-mail-address "yueting1106.liu@gmail.com")

;; set up elfeed feeds
(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))
;; set database location
(setq elfeed-db-directory "~/org/data/elfeed")
(use-package! elfeed-tube
  :after elfeed
  :config
  (elfeed-tube-setup)
  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)))
(use-package! elfeed-tube-mpv
    :bind (:map elfeed-tube-mpv-follow-mode-map
                ("C-c C-f" . elfeed-tube-mpv-follow-mode)
                ("C-c C-w" . elfeed-tube-mpv-where)))

;; set up org-journal
(setq org-journal-file-type 'weekly)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-dark-high-contrast)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; set dictionary server
(setq dictionary-server "dict.org")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; set global keybindings
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
;; set org capture
(setq org-default-notes-file (concat org-directory "notes.org"))
(after! org
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Inbox")
         "* TODO %?\nEntered on %U\n  %i\n  %a")
        ("n" "Notes" entry (file+datetree "~/org/notes.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("s" "Slipbox" entry  (file "~/org/roam/inbox.org")
         "* %?\n"))))

;; org-roam
(setq org-roam-directory (concat org-directory "roam"))
;; org-roam-dailies
(setq org-roam-dailies-directory "dailies/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry #'org-roam-capture--get-point
         "* %?"
         :file-name "dailies/%<%Y-%m-%d>"
         :head "#+title: %<%Y-%m-%d>\n")))
;; rog roam capture template
(setq org-roam-capture-templates
      '(("c" "concept" plain "%?"
         :if-new
         (file+head "concept/%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new
         (file+head "reference/%<%Y%m%d%H%M%S>-${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "article" plain "%?"
         :if-new
         (file+head "articles/%<%Y%m%d%H%M%S>-${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t)))

;; Projectile config
(setq projectile-project-search-path '("~/org/projects/"))
(setq projectile-switch-project-action #'projectile-dired)

;; log status change
(setq org-log-done t)
;;(setq org-log-into-drawer LOGBOOK)
;;
;;split window to the right or below
(setq evil-vsplit-window-right t
     evil-split-window-below t)

;; set up vertical line indicator
(add-hook 'python-mode-hook 'fci-mode)
(setq fci-rule-column 80
      fci-rule-color "red")

;; load keychain-environment to handle ssh agent
(keychain-refresh-environment)

(use-package! dap-mode
:after lsp-mode
:commands dap-debug
:hook ((python-mode . dap-ui-mode) (python-mode . dap-mode))
:config
(require 'dap-python)
(setq dap-python-debugger 'debugpy)
(defun dap-python--pyenv-executable-find (command)
  (with-venv (executable-find "python"))))

;; set up tabnine auto completion
(after! company
  ;; (setq +lsp-company-backends '(company-tabnine))
  (add-to-list '+lsp-company-backends 'company-tabnine)
  ;; (add-to-list 'company-backends #'company-tabnine)
  ;; trigger completion immediately
  (setq company-idle-delay 0)
  (setq company-show-quick-access t))

;; set up numpydoc for python docstring generation
(use-package! numpydoc
  :after python-mode
  :config
  (setq numpydoc-insert-examples-block nil)
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

;; pdftool
;; auto-revert after Tex comlilation
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; diagram with plantUML
;; (setq plantuml-executable-path "/usr/bin/plantuml")
;; (setq plantuml-default-exec-mode 'executable)
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
;; (setq plantuml-server-url "http://localhost:8080")
;; (setq plantuml-default-exec-mode 'server)
