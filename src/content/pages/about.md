Title: About this blog

I have been writing a blog since about 2011. I first used the
[blogger](https://www.blogger.com/) platform, then a fully hand-crafted, static
platform based on [Emacs](https://www.gnu.org/software/emacs/) and
[Org-mode](https://www.orgmode.org/). In fall 2019, I decided to adopt a
[Pelican](https://blog.getpelican.com/)-based setup, which is more flexible.

Meanwhile, I have been thinking a lot on how to make this website more
eco-friendly. Two resources have made a deep impression on me

- [The Internet’s Carbon
  Footprint](https://irlpodcast.org/season5/episode3/) (IRL podcast)
- [Low←Tech Magazine](https://solar.lowtechmagazine.com/)

and I decided I would go low-tech, too. I will not go to extremes such as
dithering all images, but I will try to limit as much as possible communications
whith third-party servers. In particular:

1. I will use default fonts only,
2. I will no longer use CDNs,
3. I will not use external (dynamic) services for comments.

Regarding the first point, using default fonts might result in ill-matched font
sizes: in particular, depending on your web-browser, monospace fonts might
appear larger or smaller than the remainder of the text. If you notice such
problems, please send a message or report a bug on
[GitHub](https://github.com/sbrisard/sbrisard.github.io) and I will do my best
to improve the æsthetics of the website (although I am no web designer!).

The second point is more problematic, as I used to use
[MathJax](https://www.mathjax.org/) to render equations. I thought of several
options. **Option 1** would be to use unicode only equations (see for example
the wonderful work done by the
[SimPy](https://docs.sympy.org/latest/tutorial/printing.html#unicode-pretty-printer)
developers), but that option is far from ideal. **Option 2** would be to
generate `MathML` code with my own
[PyMathML](https://github.com/sbrisard/pymathml) library, but my understanding
is that `MathML` is still not widely supported. **Option 3** is
[KaTeX](https://katex.org/), which is a light-weight alternative to
[MathJax](https://www.mathjax.org/). I chose option 3, and I am quite happy with
this solution: posts with a lot of equations load much faster now. Although the
LaTeX coverage is not as wide as [MathJax](https://www.mathjax.org/), the
overall result is quite satisfactory. I use a self-hosted, minified version of
the KaTeX CSS file.

As for the third point – well, we will have to resort to low-tech tools. If you
would like to comment on one of my posts (including this one), please send an
email to **sebastien [dot] brisard [at] ifsttar [dot] fr**. Your comment will be
published alongside the post. I will of course *not* publish your email address.

<!-- Local Variables: -->
<!-- fill-column: 80 -->
<!-- End: -->
