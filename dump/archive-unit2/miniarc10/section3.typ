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
  [Cruz, Kim Geoffrey],
    [Nonlinear FDA - Detour],
  [Cruz, Lozano Jr.],
    [Nonlinear FDA - Solution],
  [Pagatpatan, Trance Kevin],
    [Nonlinear FDA - Detour],
)

\
#section-subheading("2", "References")
1. CS 138 Lecture Slides
