#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt, font: "New Computer Modern", lang: "en")
#set par(justify: true)

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")


// STYLING

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

#let table_of_contents-subitem(title, page) = {
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 0.5em,

    [#h(1em) #title],
    box(
      width: 100%,
      clip: true,
      repeat[.]
    ),
    [#page],
  )
}

/// END STYLING

// TABLE OF CONTENTS
  #text(size: 16pt, weight: "bold")[
    #align(center)[Contents]
  ]
  #v(0.25em)

  // SECTION 1
  #text(weight: "bold")[I. Collocation method]
  #table_of_contents-subitem[Overview][3]
  #table_of_contents-subitem[Basis Functions][4]
  
  #v(0.5em)

  // SECTION 2
  #text(weight: "bold")[II. Linear Collocation]
  #table_of_contents-subitem[Solution][8]
  #table_of_contents-subitem[Choice of Points][10]
  #table_of_contents-subitem[Examples][9]
  
  #v(0.5em)

    // SECTION 2
  #text(weight: "bold")[III. Miscellaneous]
  #table_of_contents-subitem[Contribution Log][10]
  #table_of_contents-subitem[References][10]
  
  #v(0.5em)

// END TITLE PAGE