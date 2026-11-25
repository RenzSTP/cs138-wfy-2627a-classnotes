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
  [Surname, First Name], [e.g., "1.4 Step by Step Process of Linear Shooting Method"],
  [Albano, Elliot], [Motivating problem, proof basis and drafted method of Linear shooting method and also helped with the delegation],
  [Celestino, Leo], [Worked Example for Linear Shooting Method using RK4],
  [Pactolin, Renz], [Setup the styling format + styling demo for section WFY],
  [Padilla, Klex], [
    - Step-by-step Process for Linear Shooting Method
    - Worked Example for Linear Shooting Method using Euler's Method
    - Assist in final compilation
  ],
  [Salting, Ambernie], [Proofread and fixed the formatting for the Linear Shooting Method Section, setup title content contrib ref],
  [Domondon, Geron], [Provided derivation of Newton iteration scheme for the Nonlinear Shooting Method],
  [Esma, Georiza], [Wrote set-up example for nonliner shooting method using newton's method],
  [Lei, Lance], [],
  [Tibay, John], [Wrote sections 1 and 2 of Nonlinear shooting method],
  [Zabala, Rohan], [Proofread and added many corrections to both sections 1 and 2 of this arc, added existence theorem to section 1],
)
\

#section-subheading("2", "References")
+ Burden and Faires. _Numerical Analysis_.