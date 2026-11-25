#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes


// SECTION HEADER
#show: notes.with(
  title: [Arc 8 Compendium Problems],
)

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  align: horizon + left,
  [*Name*], [*Problems*],
  [Felix, Raphael Anton], [Burden & Faires, Numerical Analysis, 9th ed., Exercise Set 4.2, Items 1(a) and 8, p. 191.],
  [Esquilona, Liana Estelle], [Gerald & Wheatly, _Applied Numerical Analysis_, Chapter 6, Example 6.7 and Exercises Section 6.7, Item 65],
  [Reyes, Samantha Mikaylah], [Kiusalaas. _Numerical Methods in Engineering with Python_. Cambridge University Press, 2013. Example 5.1],
  [Lim, Gabrielle Kyros], [],
  [Matias, Gabriel Ian Carl], [Burden and Faires, _Numerical Analysis_, 10th Edition,
  Chapter 9, Exercise Set 9.5, Items 8(a) and 8(b)],
  [Ognita, Daniel Dean], [Burden, Faires, and Burden, Numerical Analysis, 10th ed., Ch 4.1, Exercise 24–25, p. 183 \ Numerical Analysis Instructor's Solutions Manual for the 9th edition, Exercise Set 4.1, Exercise 22–23, pp. 76–77.],
  [Sarmiento, Luis Antonio], [Sauer, T. Numerical Analysis (2nd ed.), Exercise Set 5.1, Item 6a\ Iyengar and Jain, Numerical Methods. Exercise Set 3.1, Item 8],
  [Tomista, Fatima Shine], [Burden and Faires, 9th ed, Exercise 11.3 Item 3a and 3c],
)
\