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

=== Gaussian Jordan Elimination

==== Solved Problem #1
Example 3a from 6.1 Linear Systems of Equations of Burden and Faires. Numerical Analysis.

#problem(
  number: 1,
  )[
 Use Gaussian elimination with backward substitution and two-digit rounding arithmetic to solve the following linear systems. Do not reorder the equations. (The exact solution to each system is $x_1 = 1$, $x_2 =−1$, $x_3 = 3$.)

  $ cases(4x_1 - x_2 + x_3 = 8,
          2x_1 + 5x_2 + 2x_3 = 3,
          x_1 + 2x_2 + 4x_3 = 11) $
]

===== Solution
The augmented matrix from $A x = b$ is

$ [A | b] = mat(delim: "[", augment: #3,
    4, -1, 1, 8;
    2, 5, 2, 3;
    1, 2, 4, 11;
  ) $

Applying Gaussian elimination (keeping in mind the two-digit rounding arithmetic):
   $ bold(R_2 -> R_2 - 0.5 R_1) $ 
   $ bold(R_3 -> R_3 - 0.25 R_1) $
$
  mat(delim: "[", augment: #3,
    4, -1, 1, 8;
    0, 5.5, 1.5, -1;
    0, 2.3, 3.8, 9;
  ) 
$ 
  $ bold(R_3 -> R_3 - 0.42 R_2) $
$
  mat(delim: "[", augment: #3,
    4, -1, 1, 8;
    0, 5.5, 1.5, -1;
    0, 0, 3.2, 9.4;
  )  = bold(U) $

Performing backward substitution:
$ x_3 = 9.4/3.2 = 2.9375 approx 2.9 \
  x_2 = (-1 - 1.5 (2.9))/5.5 = (-1 - 4.4)/5.5 = (-5.4)/5.5 = -0.9818 approx -0.98 \
  x_1 = (8 - (-1)(-0.98) - 1 (2.9))/4 = (8 - 0.98 - 2.9)/4 = (7.0 - 2.9)/4 = 4.1/4 = 1.025 approx 1.0 $
\
  Thus, our solution to the system via Gaussian elimination with two-digit arithmetic is:
$ #box(stroke: 0.5pt, inset: 8pt)[
  $bold(x_(G E) = [1.0, -0.98, 2.9]^T)$.
] $

==== Solved Problem #2
Example 13 from 6.1 Linear Systems of Equations of Burden and Faires. Numerical Analysis.

#problem(
  number: 2,
  )[
Use the Gauss-Jordan method and two-digit rounding arithmetic to solve the systems in Exercise 3(a).

  $ cases(4x_1 - x_2 + x_3 = 8,
          2x_1 + 5x_2 + 2x_3 = 3,
          x_1 + 2x_2 + 4x_3 = 11) $
]

As Gauss-Jordan is essentially an extension of Gaussian elimination, we may use our matrix $bold(U)$ from Problem 1 and continue off from there to obtain $bold(I x = x)$. 

$
  bold(U) = mat(delim: "[", augment: #3,
    4, -1, 1, 8;
    0, 5.5, 1.5, -1;
    0, 0, 3.2, 9.4;
  ) 
$

   $ bold(R_1 -> R_1 - 0.31 R_3) $ 
   $ bold(R_2 -> R_2 - 0.47 R_3) $

$ 
  mat(delim: "[", augment: #3,
    4, -1, 0, 5.1;
    0, 5.5, 0, -5.4;
    0, 0, 3.2, 9.4;
  ) 
$

   $ bold(R_1 -> R_1 + 0.18 R_2) $ 

$ 
  mat(delim: "[", augment: #3,
    4, 0, 0, 4.1;
    0, 5.5, 0, -5.4;
    0, 0, 3.2, 9.4;
  ) 
$

Thus, we have:
$ x_1 = 4.1 / 4 = 1.025 approx 1.0 $
$ x_2 = -5.4 / 5.5 = -0.9818 approx -0.98 $
$ x_3 = 9.4 / 3.2 = 2.9375 approx 2.9 $

Thus, our solution to the system via Gauss Jordan elimination with two-digit arithmetic is:
$ #box(stroke: 0.5pt, inset: 8pt)[
  $bold(x_(G J) = [1.0, -0.98, 2.9]^T)$.
] $

==== Original Remix

#problem(
  number: [Remix],
)[
  Consider the following well-conditioned system. Using two-digit rounding arithmetic:

$ cases(
  0.1x_1 + 8.4x_2 = -8.2,
  3.6x_1 + 9.5x_2 = -2.3
) $
(The exact solution to the system is $x_1 = 2$ and $x_2 = -1$.)

(a) Solve the system using Gaussian elimination with backward substitution.

(b) Solve the same system using the Gauss-Jordan method.

(c) Compare the two results and explain how the additional operations in Gauss-Jordan affect the rounding error.
]

===== Solution

(a) For Gaussian elimination with backward substitution, we have augmented matrix $A x = b$:

$ 
mat(delim: "[", augment: #2,
  0.1, 8.4, -8.2;
  3.6, 9.5, -2.3;
)
$

Applying Gaussian elimination (keeping in mind the two-digit rounding arithmetic):

$ bold(R_2 -> R_2 - 36 R_1) $
$
mat(delim: "[", augment: #2,
  0.1, 8.4, -8.2;
  0, -290, 300;
) = bold(U)
$

Performing backward substitution:
$ x_2 = 300 / (-290) approx -1.0 $

$ x_1 = (-8.2 - 8.4(-1.0)) / 0.1
= 0.2 / 0.1 = 2.0 $

Thus, our answer to the system using Gauss elimination with two-digit rounding arithmetic is:
$ #box(stroke: 0.5pt, inset: 8pt)[
  $bold(x_(G E) = [2.0, -1.0]^T)$.
] $

(b) For Gauss-Jordan elimination, we continue on from $bold(U)$, to obtain $bold(I x = x)$ (keeping in mind the two-digit rounding arithmetic):

$ bold(R_1 -> R_1 + 0.029 R_2) $
$
mat(delim: "[", augment: #2,
  0.1, 0, 0.5;
  0, -290, 300;
)
$

Thus, we have:
$ x_1 = 0.5 / 0.1 = 5.0 $

$ x_2 = 300 / (-290) approx -1.0 $

Therefore, our answer to the system using Gauss-Jordan with two-digit rounding arithmetic is:
$ #box(stroke: 0.5pt, inset: 8pt)[
  $bold(x_(G J) = [5.0, -1.0]^T)$.
] $

(c) Analysis between Gaussian elimination and Gauss-Jordan elimination:
#remark[
Both methods begin with the same Gaussian elimination stage, however, Gauss-Jordan generally performs additional arithmetic operations in order to further reduce the system from $U x = b'$ to $I x = x$. As we noticed, under finite-precision rounding, each additional operation provides another opportunity for rounding errors to be  introduced and propagated. This implies that the risk of computation errors  are amplified using Gauss-Jordan due to the increased arithmetic, and may even be exacerbated further in even larger systems than this system. \ \ Therefore, we may conclude that based on the solutions to this system, Gauss-Jordan algorithms are more prone to computation errors due to increased arithmetic operations despite the system being well-conditioned.
]