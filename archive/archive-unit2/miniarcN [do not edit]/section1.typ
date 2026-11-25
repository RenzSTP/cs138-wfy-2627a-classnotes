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
  title: [Introduction],
)

// SECTION SUBHEADER1

#section-subheading("1", "Overview")
#h(2em) // fix indent for 1st paragraph
#lorem(100)

#lorem(10)
\ \

// SECTION SUBHEADER2
#section-subheading("2", "Motivating Problem")
#h(2em) // fix indent for 1st paragraph
#lorem(100)

#lorem(10)
