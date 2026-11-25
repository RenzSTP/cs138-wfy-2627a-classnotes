#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt, font: "New Computer Modern", lang: "en")
#set par(justify: true)

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

#show heading.where(level: 1): it => [
  #set text(fill: ink, size: 16pt, weight: "bold")
  #v(0.6em)
  #it
  #v(0.2em)
  #line(length: 100%, stroke: 1pt + ink)
  #v(0.4em)
]

#show heading.where(level: 2): it => [
  #set text(fill: ink, size: 13pt, weight: "bold")
  #v(0.5em)
  #it
  #v(0.2em)
]

#let definition(title: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #text(fill: ink, weight: "bold")[Definition #if title != none [(#title)].]
  #body
]

#let theorem(title: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: 1pt + ink,
)[
  #text(fill: ink, weight: "bold")[Theorem #if title != none [(#title)].]
  #emph(body)
]

#let example(number: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + midgray),
)[
  #text(fill: ink, weight: "bold")[Example #if number != none [#number].]
  #body
]

#let problem(number: none, source: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #text(fill: ink, weight: "bold")[Compendium Problem #if number != none [#number]]
  #if source != none [ #text(size: 9pt, fill: midgray)[(Source: #source)]]
  #linebreak()
  #body
]

#let remark(body) = block(
  fill: none,
  inset: (left: 10pt),
  width: 100%,
)[
  #text(style: "italic", fill: midgray)[Remark: ] #body
]

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


=== Gaussian Elimination

==== Solved Problem #1
Exercise Set 6.1, item 4b from Chapter 6: Direct Methods for Solving Linear Equiations in Burden and Faires, Numerical Analysis.

#problem[
  Use Gaussian elimination with backward substitution and two-digit rounding arithmetic to solve the following linear systems.Do not reorder theequations. (The exact solution to each system is $x_1=−1$,$x_2=1$,$x_3=3$.)

  $ cases(4x_1 + 2x_2 - x_3 = 5,
          1/9 x_1 + 1/9 x_2 - 1/3 x_3 = -1,
          x_1 + 4x_2 + 2x_3 = 9) $
]

Solution:\
We view our system of linear equations in the form $A x=b$, with the augmented matrix $bold([A | b])$ given by:

$ bold([A | b]) = mat(delim: "[", augment: #3,
  4, 2, -1, 5;
  1/9, 1/9, -1/3, -1;
  1, 4, 2, 9;
) $

We first perform the elimination phase to eliminate the entries below the diagonal of $A$:

$ mat(delim: "[", augment: #3,
    4, 2, -1, 5;
    1/9, 1/9, -1/3, -1;
    1, 4, 2, 9;
  )
$
  *$ R_2 <- R_2 - (1/36) R_1 $*
  *$ R_3 <- R_3 - (1/4) R_1 $*

$ = mat(delim: "[", augment: #3,
    4, 2, -1, 5;
    0, 1/18, -11/36, -41/36;
    0, 7/2, 9/4, 31/4;
  )
$
  *$ R_3 <- R_3 - 63 R_2 $*

$ = mat(delim: "[", augment: #3,
    4, 2, -1, 5;
    0, 1/18, -11/36, -41/36;
    0, 0, 43/2, 159/2;
  )
$

After converting the matrix into its upper triangular form, we proceed to do backward substitution to obtain all values of $x$. The upper triangular matrix system is represented as:

#align(center)[
  $ cases(
    4x_1 + 2x_2 - x_3 = 5,
    1/18 x_2 - 11/36 x_3 = -41/36,
    43/2 x_3 = 159/2
  ) $

  $ bold(x_3): x_3 = (159/2) / (43/2) = 159/43 approx 3.7 $

  $ bold(x_2): x_2 = 18[-41/36 + 11/36(159/43)] = -7/43 approx -0.16 $

  $ bold(x_1): x_1 = 1/4 [5 - 2(-7/43) + (159/43)] = 1/4 [5 + 173/43] = 97/43 approx 2.3 $
]

This gives us the solution:

$ #box(stroke: 0.5pt, inset: 8pt)[
  $bold(x approx [2.3, -0.16, 3.7]^T)$.
] $

==== Solved Problem #2
Exercise Set 6.1, item 6a from Chapter 6: Direct Methods for Solving Linear Equiations in Burden and Faires, Numerical Analysis.

#problem[
  Use the Gaussian Elimination Algorithm to solve the following linear systems, if possible , and determine whether row interchanges are necessary:

  $ cases(x_2 - 2x_3 = 4,
          x_1 - x_2 + x_3 = 6,
          x_1 - x_3 = 2) $
]
Solution:\
We view our system of linear equations in the form $A x=b$, with the augmented matrix $bold([A | b])$ given by:

$ bold([A | b]) = mat(delim: "[", augment: #3,
  0, 1, -2, 4;
  1, -1, 1, 6;
  1, 0, -1, 2;
) $

We first perform the elimination phase to eliminate the entries below the diagonal of $A$. However, we notice that our first pivot at entry $a_11$ is zero. Due to this, row swapping is done to the nearest non-zero row, $R_2$, since we cannot procede further.

  *$ R_1 <-> R_2 $*

$ = mat(delim: "[", augment: #3,
  1, -1, 1, 6;
  0, 1, -2, 4;
  1, 0, -1, 2;
) $

Proceeding with the elimination phase, we have:

  *$ R_3 <- R_3 - R_1 $*

$ = mat(delim: "[", augment: #3,
  1, -1, 1, 6;
  0, 1, -2, 4;
  0, 1, -2, -4;
) $

  $ R_3 <- R_3 - R_2 $

$ = mat(delim: "[", augment: #3,
  1, -1, 1, 6;
  0, 1, -2, 4;
  0, 0, 0, -8;
) $

#block(
  fill: white,
  inset: 10pt,
  width: 100%,
  stroke: 1pt + ink,
)[
  Looking at the third row of our reduced augmented matrix, the corresponding equation results in $0 = -8$, which is a contradiction. 

  Therefore, this system has *no solution* and a row interchange was necessary ($R_1 <-> R_2$).
]

==== Original Remix

#problem(
  number: [Remix],
)[

]