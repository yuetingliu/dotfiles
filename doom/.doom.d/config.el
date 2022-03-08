;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Set org agenda files
(setq org-agenda-files (list "~/org/gtd.org"
                             "~/org/backend_dev.org"
                             "~/org/capra.org"))

;; Workflow sequence, track TODO state changes
(after! org
     (setq org-todo-keywords
           '((sequence "TODO(t)" "INPROGRESS(i!)" "WAITING(w@/!)" "HOLDING(h)" "PROJECT(p)" "|" "DONE(d!)" "CANCELLED(c@)"))))
;; Set org latex preview scale
;;(setq org-format-latex-options 
;;      (plist-put org-format-latex-options :scale 2.5))

;; Skip Done tasks in agenda view
(setq org-agenda-skip-scheduled-if-done t)


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Yueting Liu"
      user-mail-address "yueting1106.liu@gmail.com")

;; set up elfeed feeds
(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org"))
;;(require 'elfeed-goodies)
;;(elfeed-goodies/setup)
;;(setq elfeed-goodies/entry-pane-size 0.5)
;(setq elfeed-feeds
;      '(("https://www.youtube.com/feeds/videos.xml?channel_id=UCVls1GmFKf6WlTraIb_IaJg" youtube linux) ;; distrotube
;        ("https://www.youtube.com/feeds/videos.xml?channel_id=UCMUnInmOkrWN4gof9KlhNmQ" youtube interest) ;; Mr & Mrs Gao
;        ("https://fs.blog/feed" blog knowledge) ;; farnamstreet blog
;        ("https://ryanholiday.net/feed" blog books) ;; Ryan Holiday blog
;        ("https://www.technologyreview.com/feed" tech) ;; Technology review
;        ("https://syncedreview.com/feed" tech) ;; Synced review
;        ("https://www.reddit.com/r/MachineLearning/.rss" tech ai reddit) ;; Reddit Machine Learning
;        ("https://distill.pub/rss.xml" tech ai) ;; distill
;        ("http://news.mit.edu/rss/topic/artificial-intelligence2" tech ai mit) ;; mit AI news
;        ("https://openai.com/blog/rss" tech ai blog) ;; Open AI blog
;        ("https://www.fast.ai/atom.xml" tech ai blog) ;; fast.ai
;        ("http://feeds.feedburner.com/blogspot/gJZg" tech ai blog) ;; Google AI blog
;        ("https://medium.com/feed/ai2-blog" tech ai institute) ;; Allen Institute for AI
;        ("https://deepmind.com/blog/feed/basic/" tech ai institute) ;; DeepMind blog
;        ("https://www.reddit.com/r/reinforcementlearning/.rss?format=xml" tech ai reddit) ;; Reddit RL
;        ("https://www.reddit.com/r/singularity/.rss?format=xml" tech) ;; Reddit singulairty rss feed
;        ("https://www.sciencedaily.com/rss/computers_math/artificial_intelligence.xml" tech ai) ;; science daily ai news
;        ("https://www.artificial-intelligence.blog/news?format=rss" tech ai) ;; Artificial-Intelligence.Blog
;        ("http://feeds.hbr.org/harvardbusiness" magazine hbr) ;; Harvard business review
;        ("https://seths.blog/feed" blog) ;; Seth Godin blog
;        ("https://www.theguardian.com/technology/self-driving-cars/rss" tech ai self-driving-car) ;; Guardian Self-Driving car
;        ("https://medium.com/feed/self-driving-cars" tech ai self-driving-car) ;; medium topic self driving car
;        ("https://blog.waymo.com/rss.xml" tech ai self-driving-car) ;; Waymo official blog
;        ("https://news.mit.edu/topic/mitrobotics-rss.xml" tech ai self-driving-car) ;; MIT news about Robotics
;        ("https://news.mit.edu/topic/mitautonomous-vehicles-rss.xml" tech ai self-driving-car) ;; MIT news about autonomous vehicles
;        ("https://www.theverge.com/transportation/rss/index.xml" tech ai self-driving-car) ;; The Verge Transportation
;        ("https://www.reddit.com/r/SelfDrivingCars/.rss" tech ai self-driving-car) ;; Reddit Self-Driving Car
;        ("https://medium.com/feed/cruise" tech ai self-driving-car medium) ;; Medium Cruise
;        ("https://www.autoblog.com/rss.xml" tech ai self-driving-car) ;; auto-blog
;        ("https://www.mckinsey.com/insights/rss" insights mckinsey) ;; Mckinsey insights
;        ("https://blogs.cfainstitute.org/investor/feed/" finance investment) ;; Enterprising investors
;        ("https://www.blog.invesco.us.com/feed/" finance investment) ;; Investo blog
;        ("https://vanguardblog.com/feed/" finance investment) ;; Vanguard blog
;        ("https://feeds.a.dj.com/rss/RSSMarketsMain.xml" finance investment) ;; Wallstreet journal
;        ("https://www.blackrockbkcc.com/rss/news-releases.xml?items=15" finance investment) ;; blackrock press news
;))

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
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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

;; org-roam
(setq org-roam-directory (concat org-directory "roam"))
;; org-roam-dailies
(setq org-roam-dailies-directory "dailies/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry #'org-roam-capture--get-point
         "* %?"
         :file-name "dailies/%<%Y-%m-%d>"
         :head "#+title: %<%Y-%m-%d>\n")))

;; log status change
(setq org-log-done t)
;;(setq org-log-into-drawer LOGBOOK)
