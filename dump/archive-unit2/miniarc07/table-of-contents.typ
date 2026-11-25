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
  #text(weight: "bold")[I. Linear Shooting Method]
  #table_of_contents-subitem[Problem][3]
  #table_of_contents-subitem[Definition][3]
  #table_of_contents-subitem[Theorem: Existence and Uniqueness of the Linear BVP][3]
  #table_of_contents-subitem[Linear Shooting Method Proof][4]
  #table_of_contents-subitem[Step by Step Process][5]
  #table_of_contents-subitem[Worked Example: Using Euler's Method][6]
  #table_of_contents-subitem[Worked Example: Using RK4][9]
  
  #v(0.5em)

  // SECTION 2
  #text(weight: "bold")[II. Nonlinear Shooting Method]
  #table_of_contents-subitem[Gist of the Method][12]
  #table_of_contents-subitem[Derivation and Explanation][12]
  #table_of_contents-subitem[Using Newton's Method][13]
  #table_of_contents-subitem[Example: Setup using Newthon's Method][14]

#v(0.5em)
  
  // SECTION END
  #text(weight: "bold")[III. Miscellaneous]
  #table_of_contents-subitem[Contribution Log][16]
  #table_of_contents-subitem[References][16]


// END TITLE PAGE