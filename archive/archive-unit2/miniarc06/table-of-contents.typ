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
  #text(weight: "bold")[I. Eigenvalue BVPs]
  #table_of_contents-subitem[Eigenvalue BVPs][3]
  
  #v(0.5em)

  // SECTION 2
  #text(weight: "bold")[II. The Cauchy-Euler Equation]
  #table_of_contents-subitem[Cauchy-Euler Substitution][8]

  
  #v(0.5em)

 // SECTION 3
  #text(weight: "bold")[III. Generalized Eigenvalue Problems]
  #table_of_contents-subitem[Definition and General Form][11]
  #table_of_contents-subitem[Boundary Conditions][11]
  #table_of_contents-subitem[General Solution Procedure][15]

   #v(0.5em)

 // SECTION 4
  #text(weight: "bold")[IV. Sturm–Liouville Problems]
  #table_of_contents-subitem[The Sturm-Liouville Equation][16]
  #table_of_contents-subitem[The Sturm-Liouville Theorem][17]

   #v(0.5em)
   
  // SECTION 5
  #text(weight: "bold")[V. Sturm-Liouville Applications]
  #table_of_contents-subitem[Special Second Order Differential Equations][19]

  #v(0.5em)
   
  // SECTION 5
  #text(weight: "bold")[VI. Power Series]
  #table_of_contents-subitem[Taylor and Maclaurin Series][22]
  #table_of_contents-subitem[Solving an ODE by Power Series][23]
  
  #v(0.5em)
  
  // SECTION END
  #text(weight: "bold")[VII. Miscellaneous]
  #table_of_contents-subitem[Contribution Log][25]
  #table_of_contents-subitem[References][25]


// END TITLE PAGE