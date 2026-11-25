#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt, font: "New Computer Modern", lang: "en")
#set par(justify: true)


// STYLING
#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)


/// END STYLING

// TITLE PAGE
#page(numbering: none)[
    // #line(length: 100%)

  // title proper
  #align(center)[
    #v(6em)
    #title[CLASS NOTES]
    #align(center)[
      #set text(size: 20pt) 
      #v(-1em)
      *- Collocation Method for BVPs -* // topic subtitle
    ]
  /// title end

  // authors
    #v(-0.5em)
    #align(center)[
      #set text(size: 12pt)  
      Jose Sebastian Arceo,
      Samantha Coleen Elizarde,
      \
      John Anthony Manzano, 
      Katrin Lara Paraguya,
      Aloysius Reve Torres
    ]
  /// authors end

  

  // filler content 
    #v(13em)
    
    #align(center)[Presented to  \ *UNIVERSITY OF THE PHILIPPINES\
    DEPARTMENT OF COMPUTER SCIENCE*
    ]
    
    #v(18em)
    #align(center)[
      In partial fulfillment of the course \
      *Elementary Numerical Computing II* \

    ] #v(-0.5em)

    \
     #text(size: 10pt)[
       
       #datetime.today().display("[month repr:long] [day], [year]")
     ]
    
  /// end filler content
    // #line(length: 100%)
  ]
]
// END TITLE PAGE