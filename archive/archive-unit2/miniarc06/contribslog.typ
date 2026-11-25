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

  [Aranas, John Ray], [Eigenvalue BVPs and Examples],
  [Dizon, Mikaela], [Eigenvalue BVPs and Examples],
  [Domingo, Adrian Christian], [Cauchy-Euler Equation and Examples],
  [Tingin, Hanna Charisse], [Cauchy-Euler Equation and Examples],
  [Santos, Chloe Althaia], [Sturm–Liouville Problems],
  [Sison, Russell Lawrence], [Power Series],
  [Tolentino, Sean Kenji], [Sturm-Liouville Applications],
  [Zuñiga, Nathaniel Silas], [Generalized Eigenvalue Problems],
)
\

#section-subheading("2", "References")
+ Burden and Faires. _Numerical Analysis_.
+ C. H. Edwards, D. E. Penney, D. T. Calvis, _Differential Equations and Boundary Value Problems: Computing and Modeling 5th Edition_.