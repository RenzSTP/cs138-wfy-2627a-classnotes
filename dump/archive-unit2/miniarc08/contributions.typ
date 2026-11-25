// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

  // I really hate how this is not the default
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE


// SECTION HEADER
#show: notes.with(
  title: [Miscellaneous],
)

#section-subheading("1", "Contribution Log")

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  align: horizon + left,
  [*Name*], [*Contribution*],
  [Felix, Raphael Anton], [Richardson Extrapolation (Central Difference and Truncation Error, Effect of Step Size and Error Cancellation, Generalized Richardson Extrapolation, Worked Example)],
  [Esquilona, Liana Estelle], [Method of Fictitious Points (General Equation and Boundary Conditions, Left and Right Boundary Derivation, Worked Example)],
  [Reyes, Samantha Mikaylah], [Central Difference (Idea, Derivation, Truncation Error and Accuracy, Effect of Step Size, Example, Algorithm, and When does it fail)],
  [Lim, Gabrielle Kyros], [General FDA for Neumann Boundary Conditions, Example (One-Sided Approximation), Note on Error],
  [Matias, Gabriel Ian Carl], [First Order Difference Formulas (Idea, Forward and Background Difference)],
  [Ognita, Daniel Dean], [Stencils and Undetermined Coefficients (From Taylor Series to Other Methods, Stencils, Undetermined Coefficients, Examples, Stencil Generalization)],
  [Sarmiento, Luis Antonio], [Taylor Series (Idea, Truncation Error)],
  [Tomista, Fatima Shine], [Generalized FDA (General Form Derivation, Finite Difference Stencil, Worked Example, Accuracy Comparison)],
)
\

#section-subheading("2", "References")
+ Burden and Faires. _Numerical Analysis_.
+ Chapra, S. C., & Canale, R. P. (2015). _Numerical methods for engineers_ (7th ed.).
+ CS 138. _Boundary Value Problems: Numerical Methods —Finite Difference Method._ Scientific Computing Laboratory, University of the Philippines Diliman.
+ Kiusalaas. _Numerical Methods in Engineering with Python_. Cambridge University Press, 2013.