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

=== Systems of Linear Equations: Existence and Uniqueness

==== Solved Problem #1
Exercise 29a from Chapter 1 Supplementary Exercises in Lay, Linear Algebra and Its Applications - 6th Edition.

#problem[
  Determine $h$ and $k$ such that the solution set of the system (i) is empty, (ii) contains a unique solution, and (iii) contains infinitely many solutions.

  $ cases(x_1 + 3x_2 = k,
          4x_1 + h x_2 = 8) $
]

*Solution:*\
We can represent the system using an augmented matrix $bold([A | b])$:

$ bold([A | b]) = mat(delim: "[", augment: #2,
  1, 3, k;
  4, h, 8;
) $

We perform Gaussian elimination to reduce the matrix to row echelon form.

$ mat(delim: "[", augment: #2,
  1, 3, k;
  4, h, 8;
)
attach(arrow.r, t: bold(R_2 <- R_2 - 4 R_1))
mat(delim: "[", augment: #2,
  1, 3, k;
  0, h - 12, 8 - 4k;
) $

The system's consistency depends entirely on the bottom row, which represents the equation $(h - 12)x_2 = 8 - 4k$.

(i) For the solution set to be *empty* (no solution), the system must be inconsistent. This occurs when the last row takes the form $[0" "0 | c]$ where $c != 0$.
Thus, we need $h - 12 = 0$ and $8 - 4k != 0$.
$ #box(stroke: 0.5pt, inset: 8pt)[$bold(h = 12 " and " k != 2)$] $

(ii) For a *unique solution*, the system must be consistent and have no free variables. This means every column in the coefficient matrix must contain a pivot.
Thus, we need $h - 12 != 0$. The value of $k$ does not affect uniqueness here.
$ #box(stroke: 0.5pt, inset: 8pt)[$bold(h != 12 " and " k " is any real number")$] $

(iii) For *infinitely many solutions*, the system must be consistent and have at least one free variable. This occurs if the last row is entirely zeros.
Thus, we need $h - 12 = 0$ and $8 - 4k = 0$.
$ #box(stroke: 0.5pt, inset: 8pt)[$bold(h = 12 " and " k = 2)$] $

\
==== Solved Problem #2
Exercise 30a from Chapter 1 Supplementary Exercises in Lay, Linear Algebra and Its Applications.

#problem[
  Consider the problem of determining whether the following system of equations is consistent:

  $ cases(4x_1 - 2x_2 + 7x_3 = -5,
          8x_1 - 3x_2 + 10x_3 = -3) $

  Define appropriate vectors, and restate the problem in terms of linear combinations. Then solve that problem.
]

*Solution:*\
First, we define the column vectors corresponding to the coefficient matrix and the constants vector.
Let
$ bold(v_1) = mat(delim: "[", 4; 8), quad
  bold(v_2) = mat(delim: "[", -2; -3), quad
  bold(v_3) = mat(delim: "[", 7; 10), quad
  bold(b) = mat(delim: "[", -5; -3) $

The problem can be restated as finding scalars $x_1, x_2, x_3$ such that the linear combination of vectors $bold(v_1), bold(v_2), bold(v_3)$ evaluates to vector $bold(b)$:
$ #box(stroke: 0.5pt, inset: 8pt)[$bold(x_1 v_1 + x_2 v_2 + x_3 v_3 = b)$] $

To solve this, we construct the augmented matrix and reduce it to echelon form.

$ mat(delim: "[", augment: #3,
  4, -2, 7, -5;
  8, -3, 10, -3;
)
attach(arrow.r, t: bold(R_2 <- R_2 - 2 R_1))
mat(delim: "[", augment: #3,
  4, -2, 7, -5;
  0, 1, -4, 7;
) $

The matrix is now in echelon form. The basic variables are $x_1$ and $x_2$, while $x_3$ is a free variable. Because there is no row of the form $[0" "0" "0" "| c]$ with $c != 0$, the system is consistent.

To find the general solution, we write the reduced equations:
$ x_2 - 4x_3 = 7 => x_2 = 7 + 4x_3 $
$ 4x_1 - 2x_2 + 7x_3 = -5 $

Substitute $x_2$ into the first equation:
$ 4x_1 - 2(7 + 4x_3) + 7x_3 = -5 \
  4x_1 - 14 - 8x_3 + 7x_3 = -5 \
  4x_1 - x_3 = 9 \
  x_1 = 9/4 + 1/4 x_3 $

$ #box(stroke: 0.5pt, inset: 8pt)[
  The system is consistent with infinitely many solutions given by: \
  $bold(x_1 = 9/4 + 1/4 x_3), quad bold(x_2 = 7 + 4x_3), quad bold(x_3 " is free")$
] $

#pagebreak()
==== Remixed Problem

#problem[
  Consider the following linear combination of vectors, where $h$ and $k$ are real parameters:

  $ x_1 mat(delim: "[", 2; 4) + x_2 mat(delim: "[", -1; h) + x_3 mat(delim: "[", 3; 6) = mat(delim: "[", 5; k) $

  (a) Restate this problem as a system of linear algebraic equations.

  (b) Determine the values of $h$ and $k$ such that the system has (i) no solution, and (ii) infinitely many solutions.

  (c) Can this system ever have a unique solution? Explain mathematically.
]

*Solution:*\
(a) We can distribute the scalars and combine the vectors to form a standard system of linear equations:
$ #box(stroke: 0.5pt, inset: 8pt)[
  $ cases(2x_1 - x_2 + 3x_3 = 5,
          4x_1 + h x_2 + 6x_3 = k) $
] $

\
(b) We represent the system using an augmented matrix and apply row operations to reach echelon form.

$ mat(delim: "[", augment: #3,
  2, -1, 3, 5;
  4, h, 6, k;
)
attach(arrow.r, t: bold(R_2 <- R_2 - 2 R_1))
mat(delim: "[", augment: #3,
  2, -1, 3, 5;
  0, h + 2, 0, k - 10;
) $

The second row corresponds to the equation $(h + 2)x_2 + 0x_3 = k - 10$.

(i) For the system to have *no solution*, we need an inconsistent row of the form $[0" "0" "0" "| c]$ where $c != 0$.
This requires $h + 2 = 0$ and $k - 10 != 0$.
$ #box(stroke: 0.5pt, inset: 8pt)[$bold(h = -2 " and " k != 10)$] $

(ii) For the system to have *infinitely many solutions*, it must be consistent. Since column 3 lacks a pivot, $x_3$ will always be a free variable as long as the system doesn't fail consistency. This gives us two valid scenarios:
- *Case 1 (Row of zeros):* $h + 2 = 0$ and $k - 10 = 0$, meaning $h = -2$ and $k = 10$. Here, both $x_2$ and $x_3$ are free variables.
- *Case 2 (Pivot in column 2):* $h + 2 != 0$, meaning $h != -2$. The system is consistent for any $k$, and $x_3$ remains a free variable.
Combining these cases, the system has infinitely many solutions as long as it isn't strictly inconsistent.
$ #box(stroke: 0.5pt, inset: 8pt)[$bold((h = -2 " and " k = 10) " OR " (h != -2 " and " k " is any real number"))$] $

\
(c)
$ #box(stroke: 0.5pt, inset: 8pt)[
  *No*, this system can never have a unique solution. A unique solution requires every column in the coefficient matrix to have a pivot (meaning zero free variables). Since this system has $3$ variables ($3$ columns) but only $2$ equations (maximum of $2$ rows), the maximum possible rank of the matrix is $2$. By definition, at least one variable (in this case, $x_3$) must be free, guaranteeing either zero or infinitely many solutions.
] $