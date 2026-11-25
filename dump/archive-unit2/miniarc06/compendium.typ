// hello pa-order nalang sa grp niyo mwa <3



#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt, font: "New Computer Modern", lang: "en")
#set par(justify: true)


// STYLING
#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")


/// END STYLING

// TITLE PAGE
#page(numbering: none)[
    // #line(length: 100%)

  // title proper
  #align(center)[
    #v(6em)
    #title[COMPENDIUM]
    #align(center)[
      #set text(size: 20pt) 
      #v(-1em)
      *- Boundary Value Problems -* // topic subtitle
    ]
  /// title end

  // authors
    #v(-0.5em)
    #align(center)[
      #set text(size: 12pt)  
      Aranas, John Ray, \
      Dizon, Mikaela, \
      Domingo, Adrian Christian,  \ 
      Tingin, Hanna Charisse \
      Santos, Chloe Althaia\      
      Sison, Russell Lawrence \
      Tolentino, Sean Kenji \
      Zuñiga, Nathaniel Silas

    ]
  /// authors end
  
  // filler content 
    #v(13em)
  
    #align(center)[Presented to  \ *UNIVERSITY OF THE PHILIPPINES\
    DEPARTMENT OF COMPUTER SCIENCE*
    ]
    
    #v(13.5em)
    #align(center)[
      In partial fulfillment of the course \
      *Elementary Numerical Computing II* \

    ] #v(-0.5em)

     #text(size: 10pt)[
       #datetime.today().display("[month repr:long] [day], [year]")
     ]
    
  /// end filler content
    // #line(length: 100%)
  ]
]
// END TITLE PAGE

#pagebreak()
= Arc 6 Compendium Problems
#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  align: horizon + left,
  [*Name*], [*Problems*],

  [Aranas, John Ray], [William Trench. Elementary Differential Equations with BVPs (Items 16 & 27, 13.2 Exercises)],
  [Dizon, Mikaela], [William Trench. Elementary Differential Equations with BVPs (Items 1 & 23, 11.1 Exercises)],
  [Domingo, Adrian Christian], [William Trench. Elementary Differential Equations with BVPs (Item 24(a), 13.1.6) & Russel Herman. Math 420: Differential Equations (Item 50, 5.7.1)],
  [Tingin, Hanna Charisse], [Russel Herman. Math 420: Differential Equations (Items 1 & 51, 5.7.1)],
  [Santos, Chloe Althaia], [Burden and Faires, Numerical Analysis, 9th ed., (Exercises 8.2.14 & 9.5.13)],
  [Sison, Russell Lawrence], [CS 138 Lecture Slides - Eigenvalue BVPs (Power Series Example 1), Burden and Faires, Numerical Analysis, 9th ed., (Exercise Set 11.3, 3(c))],
  [Tolentino, Sean Kenji], [C. H. Edwards, D. E. Penney, D. T. Calvis, Differential Equations and Boundary Value Problems: Computing and Modeling 5th Edition (10.1 Problems, Item 2 and 16)],
  [Zuñiga, Nathaniel Silas], [CS 138 Lecture Slides - Eigenvalue BVPs (Homework, Eigenvalue Problems)]
)
\

#pagebreak()

// FIRST GROUP
#include "AranasJohnRay_Compendium.typ"
#include "DizonMikaela.typ"
#include "DomingoIan_Compendium.typ"
#include "TinginHannaCharisse_Compendium.typ"

// SECOND GROUP
#include "SantosChloe_Compendium.typ"
#pagebreak()
#include "TolentinoSeanKenji_Compendium.typ"
#pagebreak()
#include "ZuñigaNathanielSilas_Compendium.typ"
#pagebreak()
#include "SisonRussellLawrence_Compendium.typ"

