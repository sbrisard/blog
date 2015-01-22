;; -*- coding: utf-8 -*-
(require 'ox)
(require 's)

;; Global variables
;; ================

;; Get path to file being loaded.
(defvar sb-blog-root (file-name-directory load-file-name))
(defvar sb-blog-base-directory (concat sb-blog-root "org/"))
(defvar sb-blog-publishing-directory (concat sb-blog-root "html/"))
(defvar sb-blog-pages-base-directory (concat sb-blog-root "org/pages"))
(defvar sb-blog-pages-publishing-directory (concat sb-blog-root "html/pages"))
(defvar sb-blog-posts-base-directory (concat sb-blog-root "org/posts"))
(defvar sb-blog-posts-sitemap-filename "archives.org")
(defvar sb-blog-posts-publishing-directory (concat sb-blog-root "html/posts"))

;; Scripts for embedded gadgets
;; ============================

;; Twitter buttons
;; ---------------
(defvar sb-blog-twitter-follow-button-script "<a href=\"https://twitter.com/SebBrisard\" class=\"twitter-follow-button\" data-show-count=\"false\">Follow @SebBrisard</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
")

;; Disqus comments embed
;; ---------------------
(defvar sb-blog-disqus-script-format "<div id=\"disqus_thread\"></div>
<script type=\"text/javascript\">
var disqus_shortname = 'sbrisard';
var disqus_identifier = '%s';
var disqus_title = '%s';
var disqus_url = '%s';
(function() {
var dsq = document.createElement('script');
dsq.type = 'text/javascript';
dsq.async = true;
dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();
</script>
<noscript>Please enable JavaScript to view the <a href=\"http://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>
<a href=\"http://disqus.com\" class=\"dsq-brlink\">blog comments powered by <span class=\"logo-disqus\">Disqus</span></a>
")

(defun sb-blog-disqus-script (info)
  (let (id url)
    (setq id (s-chop-prefix sb-blog-base-directory
                            (s-chop-suffix ".org" buffer-file-name)))
    (setq url (concat "http://sbrisard.github.io/" id ".html"))
    (format sb-blog-disqus-script-format
            id
            (org-export-data (plist-get info :title) info)
            url)))

;; Custom backend
;; ==============

(org-export-define-derived-backend 'sb-blog 'html
                                   :export-block "SB BLOG"
                                   :options-alist
                                   '((:comments-allowed nil "comments" nil)))

(defun sb-blog-publish-to-html (plist filename pub-dir)
  (org-publish-org-to 'sb-blog filename
		      (concat "." (or (plist-get plist :html-extension)
				      org-html-extension "html"))
		      plist pub-dir))

(defun sb-blog-path-to-root (level)
  (let ((path "./"))
    (dotimes (number level path)
      (setq path (concat path "../")))))

(defun sb-blog-link (link description)
  (format "<a href=\"%s\">%s</a>" link description))

(defun sb-blog-rel-link (link description level)
  (sb-blog-link (concat (sb-blog-path-to-root level) link) description))

(defun sb-blog-html-head (level)
  (format "<link href=\"%stheme.css\" rel=\"stylesheet\" />"
          (sb-blog-path-to-root level)))

(defun sb-blog-html-preamble (level)
  (let ((sep "&nbsp;&nbsp;&nbsp;&nbsp;"))
    (concat "<img id=\"banner\" src=\"" (sb-blog-path-to-root level) "images/banner.jpg\"/>"
            "<div class=\"navbar\">"
            "<ul>"
            "<li>" (sb-blog-rel-link "index.html" "Home" level) "</li>"
            "<li>" (sb-blog-rel-link "pages/about.html" "About me" level) "</li>"
            "<li>" (sb-blog-rel-link "pages/references.html" "References" level) "</li>"
            "<li>" (sb-blog-rel-link "posts/archives.html" "Archives" level) "</li>"
            "<li>" (sb-blog-rel-link "feed.xml" "RSS" level) "</li>"
            "</ul>"
            "</div>")))

;; To allow for comments
;; #+OPTIONS: comments:t
(defun sb-blog-html-postamble (info)
  (concat "<p>This blog was generated with <a href=\"http://www.gnu.org/software/emacs/\">Emacs</a> and <a href=\"http://orgmode.org/\">Org mode</a>. The theme is inspired from <a href=\"http://orgmode.org/worg/\">Worg</a>.</p>
"
          sb-blog-twitter-follow-button-script
          (when (and (plist-get info :comments-allowed)
                     (not (s-ends-with? sb-blog-posts-sitemap-filename
                                        buffer-file-name)))
            (sb-blog-disqus-script info))))

;; From http://lists.gnu.org/archive/html/emacs-orgmode/2008-11/msg00571.html
;;
;; Hi Richard,
;;
;; no, variables are not interpolated into quoted lists, any list preceded by
;; "'" is quoted.
;;
;; If you can guarantee that the value of the variables is defined at the time
;; the
;;
;;   (setq org-publish-projects-alist ...
;;
;; is executed, then you can use backquote syntax: Quote the main list with
;; the backquote, and then preceed any variable inside you would like to
;; have evaluated with a comma so
;;
;; (setq org-publish-projects-alist
;;        `( .............
;;            ,rgr-souerce
;;            ....))
;;
;; Note that this works only once, so if you later change the value, this list
;; will not be changed.
::
;; If you wanted dynamic behavior, then we would have to patch org-publish.el.
;;
;; HTH
;;
;; - Carsten
;;
(setq org-publish-project-alist
      `(("sb-blog-root"
         :base-directory ,sb-blog-base-directory
         :publishing-directory ,sb-blog-publishing-directory
         :base-extension "org"
         :exclude nil
         :recursive nil
         :publishing-function sb-blog-publish-to-html
         :auto-sitemap nil
         :html-doctype "html5"
         :html-container "div"
         :html-head ,(sb-blog-html-head 0)
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :html-preamble nil
         :html-preamble ,(sb-blog-html-preamble 0)
         :html-postamble sb-blog-html-postamble
         :section-numbers nil
         :with-toc nil
         :language "en"
         :comments-allowed nil
         )
        ("sb-blog-pages"
         :base-directory ,sb-blog-pages-base-directory
         :publishing-directory ,sb-blog-pages-publishing-directory
         :base-extension "org"
         :exclude nil
         :recursive t
         :publishing-function sb-blog-publish-to-html
         :auto-sitemap nil
         :sitemap-sort-files chronologically
         :html-doctype "html5"
         :html-container "div"
         :html-head ,(sb-blog-html-head 1)
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :html-preamble ,(sb-blog-html-preamble 1)
         :html-postamble sb-blog-html-postamble
         :section-numbers nil
         :with-toc nil
         :language "en"
         :comments-allowed nil
         )
        ("sb-blog-posts"
         :base-directory ,sb-blog-posts-base-directory
         :publishing-directory ,sb-blog-posts-publishing-directory
         :base-extension "org"
         :exclude nil
         :recursive t
         :publishing-function sb-blog-publish-to-html
         :auto-sitemap t
         :sitemap-filename ,sb-blog-posts-sitemap-filename
         :sitemap-title "Blog archive"
         :sitemap-sort-files anti-chronologically
         :sitemap-file-entry-format "%d -- %t"
         :html-doctype "html5"
         :html-container "div"
         :html-head ,(sb-blog-html-head 1)
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :html-preamble ,(sb-blog-html-preamble 1)
         :html-postamble sb-blog-html-postamble
         :section-numbers nil
         :with-toc nil
         :language "en"
         :comments-allowed t
         )
        ("sb-blog-attachments"
         :base-directory ,sb-blog-base-directory
         :publishing-directory ,sb-blog-publishing-directory
         :base-extension "jpg\\|gif\\|png\\|xml\\|css"
         :recursive t
         :publishing-function org-publish-attachment)
        ("sb-blog"
         :components ("sb-blog-root"
                      "sb-blog-pages"
                      "sb-blog-posts"
                      "sb-blog-attachments"))))
