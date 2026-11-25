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
  #text(weight: "bold")[I. Introduction / Section 1]
  #table_of_contents-subitem[Overview][3]
  #table_of_contents-subitem[Motivating Problem][4]
  
  #v(0.5em)

  // SECTION 2
  #text(weight: "bold")[II. Section 2]
  #table_of_contents-subitem[Printing in terminal][10]
  #table_of_contents-subitem[Recursion][10]
  #table_of_contents-subitem[Max-Flow/Min-Cut][11]
  #table_of_contents-subitem[P vs NP][12]
  #table_of_contents-subitem[Unit Testing][14]
  
  #v(0.5em)

 // SECTION 3
  #text(weight: "bold")[III. Section 3]
  #table_of_contents-subitem[Virtualization][10]
  #table_of_contents-subitem[Concurrency][10]
  #table_of_contents-subitem[Persistence][11]


#v(0.5em)
  
  // SECTION END
  #text(weight: "bold")[IV. Miscellaneous]
  #table_of_contents-subitem[Contribution Log][24]
  #table_of_contents-subitem[References][25]


// END TITLE PAGE