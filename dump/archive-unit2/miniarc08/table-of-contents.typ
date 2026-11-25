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
  #text(weight: "bold")[I. Taylor Series]
  #table_of_contents-subitem[Idea and Formulas][4]
  // #table_of_contents-subitem[Motivating Problem][4]
  
  #v(0.5em)

  // SECTION 2
  #text(weight: "bold")[II. First Order Difference Formulas]
  #table_of_contents-subitem[Idea and Formulas][5]
  
  #v(0.5em)

 // SECTION 3
  #text(weight: "bold")[III. The Central Difference Method]
  #table_of_contents-subitem[Idea and Derivation][6]
  #table_of_contents-subitem[Truncation Error and Accuracy][7]
  #table_of_contents-subitem[Example][8-9]


#v(0.5em)

// SECTION 4
  #text(weight: "bold")[IV. Stencils and Undetermined Coefficients]
  #table_of_contents-subitem[Stencils][10]
  #table_of_contents-subitem[Undetermined Coefficients][11]
  #table_of_contents-subitem[Examples][12-14]
  #table_of_contents-subitem[Algorithm][14]


#v(0.5em)

// SECTION 5
  #text(weight: "bold")[V. Richardson Extrapolation]
  #table_of_contents-subitem[Central Difference and Truncation Error][15]
  #table_of_contents-subitem[Effect of Step Size and Error Cancellation][15-16]
  #table_of_contents-subitem[Generalized Richardson Extrapolation][16]
  #table_of_contents-subitem[Example][16-17]


#v(0.5em)

// SECTION 6
  #text(weight: "bold")[VI. Finite Difference Method]
  #table_of_contents-subitem[General Form of the FDA][18]
  #table_of_contents-subitem[Examples][19-20]


#v(0.5em)

// SECTION 7
  #text(weight: "bold")[VII. Finite-Difference Approximation for Neumann Boundary Conditions]
  #table_of_contents-subitem[General FDA for Neumann Boundary Conditions][21]
  #table_of_contents-subitem[Example][22]


#v(0.5em)

// SECTION 8
  #text(weight: "bold")[VIII. Method of Fictitious Points]
  #table_of_contents-subitem[General Form of FDA Using Methods of Fictitious Points][23-25]
  #table_of_contents-subitem[Example][25-26]


#v(0.5em)
  
  // SECTION END
  #text(weight: "bold")[IX. Miscellaneous]
  #table_of_contents-subitem[Contribution Log][27]
  #table_of_contents-subitem[References][27]

// END TITLE PAGE