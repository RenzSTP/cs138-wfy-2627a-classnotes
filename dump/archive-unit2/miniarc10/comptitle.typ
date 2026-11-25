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
    #title[MINIARC 10 \ PROBLEM \ COMPENDIUM]
    #align(center)[
      #set text(size: 20pt) 
      #v(-1em)
      *- Linearization of NLSODEs and Newton's Method for NLS-* // topic subtitle
    ]
  /// title end

  // authors
    #v(-0.5em)
    #align(center)[
      #set text(size: 12pt)  
      Kim Geoffrey Cruz, Lozano Jr. Cruz, Trance Kevin Pagatpatan
    ]
  /// authors end


  
  // filler content 
    #v(9em)
    
    #align(center)[Presented to  \ *UNIVERSITY OF THE PHILIPPINES\
    DEPARTMENT OF COMPUTER SCIENCE*
    ]
    
    #v(12em)
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