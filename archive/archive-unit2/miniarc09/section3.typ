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
  stroke: 0.5pt,
  [*Name*], [*Contribution*],
  [Arceo, Jose Sebastian],
    [Collocation Method - Monomial basis,
     Radial basis functions],
  [Elizarde, Samantha Coleen],
    [Linear Collocation - Solution],
  [Manzano, John Anthony],
    [Collocation Method - Radial basis functions,
     \ Linear Collocation - Choice of points],
  [Paraguya, Katrin Lara],
    [Collocation Method - Examples 1, 3, 5],
  [Torres, Aloysius Reve],
    [Collocation Method - Introduction, Monomial basis],
)

\
#section-subheading("2", "References")
1. Heath, M. T. (2018). _Scientific computing: An introductory survey_. Society for Industrial and Applied Mathematics.
2. Liaw, W. (2025, February 2). _Overfitting in human behavior_. William Liaw. [https://williamliaw.com/overfitting](https://williamliaw.com/overfitting)
