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
      *- Numerical Differentiation and Finite Differences for BVPs -* // topic subtitle
    ]
  /// title end

  // authors
    #v(-0.5em)
    #align(center)[
      #set text(size: 12pt)  
      Raphael Anton Felix, Liana Estelle Esquilona, \ Gabrielle Kyros Lim, Gabriel Ian Carl Matias, \  Daniel Dean Ognita,  Samantha Mikaylah Reyes, \ Luis Antonio Sarmiento,\ Fatima Shine Tomista
      // Miguel Angelo Ramos, Andrea Mae Villanueva, \
      // John Patrick Mendoza, Camille Rose Fernandez, Joshua Daniel  \ 
      // Castillo, Francis Grace Piattos 
    ] 
  /// authors end
//  hello grp 5 !!  lagay niyo rin name niyo sa subheading ng part na ginawa niyo just in case :DD TYSM
  //okii

  // filler content 
    #v(9em)
    
    #align(center)[Presented to  \ *UNIVERSITY OF THE PHILIPPINES\
    DEPARTMENT OF COMPUTER SCIENCE*
    ]
    
    #v(16em)
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