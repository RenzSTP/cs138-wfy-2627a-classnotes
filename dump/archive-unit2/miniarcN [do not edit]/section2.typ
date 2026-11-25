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
  title: [Section 2],
)


// SECTION SUBHEADER1
#section-subheading("1", "Printing in terminal")
#h(2em) // fix indent for 1st paragraph
#lorem(100)

#lorem(10)

#definition(name: "Printing")[
  #lorem(20) \ \
  #align(center)[print("Hello World!")] \
]

#h(2em)
#lorem(15)

\ 

// SECTION SUBHEADER2
#section-subheading("2", "Recursion")
#h(2em) // fix indent for 1st paragraph
#lorem(100)

\

#theorem(name: "Base Case")[
#v(0.4em) Don't forget your base cases! #lorem(20)
  
]

\ 

// SECTION SUBHEADER3
#section-subheading("3", "Max-Flow/Min-Cut")
#h(2em) // fix indent for 1st paragraph
#lorem(100)


#section-emphasis[Max-Flow]
Blah blah blah, here's a section to show emphasis. #lorem(40)

#section-emphasis[Min-Cut]
#lorem(40)


// taken from LE1-miniarc3
#example(number: "1")[
  For the system from the lecture,
  $ mat(
      5, -2, 3;
      -3, 9, 1;
      2, -1, -7
    )
    mat(x_1; x_2; x_3)
    =
    mat(-1; 2; 3), $

  the matrix splitting is
  $ D = mat(
      5, 0, 0;
      0, 9, 0;
      0, 0, -7
    ), $

  $ L = mat(
      0, 0, 0;
      -3, 0, 0;
      2, -1, 0
    ),
    quad
    U = mat(
      0, -2, 3;
      0, 0, 1;
      0, 0, 0
    ). $

  Adding these three matrices reconstructs $A$.
  Since every diagonal entry is nonzero, $D$ is
  invertible, and, by algebra, we have:
  $ D^(-1) = mat(
      1/5, 0, 0;
      0, 1/9, 0;
      0, 0, -1/7
    ). $
]



#lorem(50)

\ 

// SECTION SUBHEADER4
#section-subheading("4", "P vs NP")
#h(2em) // fix indent for 1st paragraph
#lorem(100)

#lorem(10)

\

// SECTION SUBHEADER5
#section-subheading("4", "Unit Testing")
#h(2em) // fix indent for 1st paragraph
#lorem(100)

#lorem(10)

