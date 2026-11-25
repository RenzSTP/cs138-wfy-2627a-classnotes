// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

// I really hate how this is not the default
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

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

// TITLE PAGE
#page(numbering: none)[
  #v(4em)
  #title[CLASS NOTES]
  #align(center)[
    #set text(size: 20pt)
    #v(-1em)
    *- Iterative Methods -*
  ]

  #v(-0.5em)
  #align(center)[
    #set text(size: 12pt)

    Basti Arceo, Samie Elizarde, John Manzano,\ Katrin Paraguya, Louie Torres, Liana Esquilona,\ Raphael Felix, Kyros Lim, Shine Tomista
  ]
  #align(center)[
    #set text(size: 10pt)
    September 23, 2026]

  #v(6em)

  #align(center)[Presented to  \ *UNIVERSITY OF THE PHILIPPINES\
  DEPARTMENT OF COMPUTER SCIENCE*
  ]

  #v(9em)
  #align(center)[
    In partial fulfillment of the course \
    *Elementary Numerical Computing II*
  ] #v(-0.5em)


  #v(1em)


  #line(length: 100%)
  #text(size: 16pt, weight: "bold")[Contents]
  #v(0.25em)
  #text(weight: "bold")[I. Overview]

  #v(0.5em)

  #text(weight: "bold")[II. Lecture 4: Jacobi, Gauss-Seidel, Overrelaxation]
  #table_of_contents-subitem[Setup and Notation][
    #context counter(page).at(<lec4_setup>).first()
  ]
  #table_of_contents-subitem[Jacobi Method][
    #context counter(page).at(<lec4_jacobi>).first()
  ]
  #table_of_contents-subitem[Gauss-Seidel Method][
    #context counter(page).at(<lec4_gauss>).first()
  ]
  #table_of_contents-subitem[Successive Over-relaxation][
    #context counter(page).at(<lec4_sor>).first()
  ]

  #v(0.5em)

  #text(weight: "bold")[III. Lecture 5: Matrix Formulation, Iterative Refinement]
  #table_of_contents-subitem[Iterative Refinement][
    #context counter(page).at(<lec5_refine>).first()
  ]
  #table_of_contents-subitem[Notes on Convergence][
    #context counter(page).at(<lec5_noc>).first()
  ]

  #v(0.5em)

  #text(weight: "bold")[IV. Miscellaneous]
  #table_of_contents-subitem[Contributions][
    #context counter(page).at(<miniarc3_contrib>).first()
  ]
  #table_of_contents-subitem[References][
    #context counter(page).at(<miniarc3_ref>).first()
  ]
  #pagebreak()
]
// END TITLE PAGE

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
// ============================================================
// 1. OVERVIEW
// ============================================================
= Overview

This sub-arc (POTW 3) covers *Iterative Methods* for solving systems of
linear equations: Jacobi, Gauss-Seidel, Successive Overrelaxation, and Iterative Refinement.

// ============================================================
// 2. Lecture 4
// ============================================================
= Lecture 4: Jacobi, Gauss-Seidel, Overrelaxation 

<lec4_setup>
== Setup and Notation 

Consider the system of linear equations
$ A x = b, $
where $A = (a_(i j)) in RR^(n times n)$ is the
coefficient matrix, $x in RR^n$ is the vector of
unknowns, and $b in RR^n$ is the right-hand-side vector.

Throughout this lecture, assume that
$a_(i i) != 0$ for every $i = 1, dots, n$.
This allows each equation to be solved for its
corresponding unknown.

#definition(title: "Iterative Method")[
  An iterative method for solving $A x = b$ starts
  from an initial approximation $x^((0))$ and
  generates a sequence of approximations
  $ x^((0)), x^((1)), x^((2)), dots $
  using a prescribed update rule.

  The method converges to a solution $x^ast$ if
  $ lim_(k -> infinity) x^((k)) = x^ast,
    quad A x^ast = b. $
]

The superscript $(k)$ denotes the iteration number,
while the subscript $i$ denotes a component.
Thus, $x_i^((k))$ is the approximation to the
$i$th unknown after $k$ iterations.

=== Matrix Splitting

#definition(title: "Diagonal and Triangular Parts")[
  The matrix $A$ can be written as
  $ A = D + L + U, $
  where $D$ is its diagonal part, $L$ is its
  strictly lower triangular part, and $U$ is its
  strictly upper triangular part.

  Their entries are defined by
  $ D_(i j) = cases(
      a_(i j) & "if" i = j,
      0 & "otherwise",
    )" ",
  quad
    L_(i j) = cases(
      a_(i j) & "if" i > j,
      0 & "otherwise",
    )" ",
  quad
    U_(i j) = cases(
      a_(i j) & "if" i < j,
      0 & "otherwise",
    ). $
]

Every entry of $A$ lies either on, below, or above
the main diagonal. It therefore appears in exactly
one of $D$, $L$, and $U$, which gives $A = D + L + U$.

#pagebreak()
Substituting this splitting into $A x = b$ gives
$ D x + L x + U x = b. $

Jacobi, Gauss-Seidel, and successive overrelaxation
differ in how they use old and newly computed
component values to update this equation.

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

=== Strict Diagonal Dominance

#definition(title: "Strictly Diagonally Dominant Matrix")[
  A matrix $A in RR^(n times n)$ is
  *strictly diagonally dominant by rows* if
  $ abs(a_(i i)) >
    sum_(j=1, j != i)^n abs(a_(i j))
    quad "for every" i = 1, dots, n. $

  In each row, the absolute value of the diagonal
  entry must exceed the sum of the absolute values
  of all other entries in that row.
]

#theorem(title: "Convergence under Strict Diagonal Dominance")[
  If $A$ is strictly diagonally dominant by rows,
  then $A x = b$ has a unique solution, and both
  the Jacobi and Gauss-Seidel methods converge
  to that solution for every initial approximation
  $x^((0)) in RR^n$.
]

#pagebreak()
#example(number: "2")[
  Consider the system
  $ x_1 - 5 x_2 = -4, $
  $ 7 x_1 - x_2 = 6. $

  Its coefficient matrix
  $ A = mat(1, -5; 7, -1) $
  is not strictly diagonally dominant, since
  $abs(1) < abs(-5)$ and $abs(-1) < abs(7)$.

  Interchanging the two equations gives the
  equivalent system
  $ mat(7, -1; 1, -5) mat(x_1; x_2)
    = mat(6; -4). $

  The reordered matrix is strictly diagonally
  dominant because
  $ abs(7) > abs(-1),
    quad abs(-5) > abs(1). $

  Therefore, Jacobi and Gauss-Seidel converge
  for this reordered system from any initial
  approximation. Its unique solution is
  $ x^ast = mat(1; 1). $
]

#remark[
  Strict diagonal dominance is a sufficient
  condition for convergence, not a necessary one.
  Failing this condition alone does not prove
  that an iterative method diverges.

  When reordering equations, the entries of $b$
  must be reordered together with the rows of $A$.
  Not every system can be made strictly diagonally
  dominant by reordering its equations.
]

== Jacobi Method <lec4_jacobi>

#definition(title: "Jacobi Method")[
  Let $A x = b$ be a system with
  $a_(i i) != 0$ for every $i$.
  Given an initial approximation $x^((0))$,
  the *Jacobi method* generates successive
  approximations using
  $ x_i^((k+1)) =
    1/a_(i i)
    (b_i - sum_(j=1, j != i)^n
    a_(i j) x_j^((k))),
  $
  for $i = 1, dots, n$ and $k = 0, 1, dots$.

  Each new component uses only values from
  the previous iterate $x^((k))$.
]

#pagebreak()
=== Derivation

The $i$th equation of $A x = b$ is
$ sum_(j=1)^n a_(i j) x_j = b_i. $

Separating the term containing $x_i$ gives
$ a_(i i) x_i +
  sum_(j=1, j != i)^n a_(i j) x_j = b_i. $

Since $a_(i i) != 0$, solve for $x_i$:
$ x_i = 1/a_(i i)
  (b_i - sum_(j=1, j != i)^n a_(i j) x_j). $

To construct an iterative rule, replace the
unknown components on the right-hand side
with their previous approximations:
$ x_i^((k+1)) = 1/a_(i i)
  (b_i - sum_(j=1, j != i)^n
  a_(i j) x_j^((k))). $

For the matrix form, use $A = D + L + U$:
$ D x + (L + U) x = b. $

Evaluate the diagonal term at the new iterate
and the remaining terms at the previous iterate:
$ D x^((k+1)) = b - (L + U) x^((k)). $

Because $D$ has nonzero diagonal entries,
it is invertible. Multiplying by $D^(-1)$ gives
$ x^((k+1)) =
  D^(-1) b - D^(-1) (L + U) x^((k)). $

#remark[
  All components must be computed from the same
  previous iterate. For example, when computing
  $x_2^((k+1))$, use $x_1^((k))$, even if
  $x_1^((k+1))$ has already been calculated.

  The component updates can therefore be
  performed independently and in parallel.
]

=== Worked Examples

#example(number: "3")[
  *Problem.* Perform two Jacobi iterations for
  the system
  $ 5 x_1 - 2 x_2 + 3 x_3 = -1, $
  $ -3 x_1 + 9 x_2 + x_3 = 2, $
  $ 2 x_1 - x_2 - 7 x_3 = 3, $
  starting from $x^((0)) = mat(0; 0; 0)$.

  *Solution.* Solve each equation for its
  corresponding unknown:
  $ x_1^((k+1)) =
    -1/5 + 2/5 x_2^((k)) - 3/5 x_3^((k)), $

  $ x_2^((k+1)) =
    2/9 + 1/3 x_1^((k)) - 1/9 x_3^((k)), $

  $ x_3^((k+1)) =
    -3/7 + 2/7 x_1^((k)) - 1/7 x_2^((k)). $

  *First iteration.* Substitute the components
  of $x^((0))$ into every update:
  $ x_1^((1)) = -1/5 + 2/5 (0) - 3/5 (0)
    = -1/5, $

  $ x_2^((1)) = 2/9 + 1/3 (0) - 1/9 (0)
    = 2/9, $

  $ x_3^((1)) = -3/7 + 2/7 (0) - 1/7 (0)
    = -3/7. $

  Thus,
  $ x^((1)) =
    mat(-1/5; 2/9; -3/7)
    approx mat(-0.20000; 0.22222; -0.42857). $

  *Second iteration.* Use only the components
  of $x^((1))$:
  $ x_1^((2)) =
    -1/5 + 2/5 (2/9) - 3/5 (-3/7)
    = 46/315, $

  $ x_2^((2)) =
    2/9 + 1/3 (-1/5) - 1/9 (-3/7)
    = 64/315, $

  $ x_3^((2)) =
    -3/7 + 2/7 (-1/5) - 1/7 (2/9)
    = -163/315. $

  Therefore, after two iterations,
  $ x^((2)) approx
    mat(0.14603; 0.20317; -0.51746). $

  This is the second approximation, not the
  exact solution. Further iterations may be needed
  to meet the specified stopping tolerance, whatever
  that may be.
]

#pagebreak()
#example(number: "4")[
  *Problem.* Apply three Jacobi iterations to
  the system
  $ x_1 - 5 x_2 = -4, $
  $ 7 x_1 - x_2 = 6, $
  using $x^((0)) = mat(0; 0)$.
  Compare the iterates with the exact solution
  $x^ast = mat(1; 1)$.

  *Solution.* In the original equation order,
  the update formulas are
  $ x_1^((k+1)) = -4 + 5 x_2^((k)), $
  $ x_2^((k+1)) = -6 + 7 x_1^((k)). $

  The first iteration gives
  $ x^((1)) =
    mat(-4 + 5(0); -6 + 7(0))
    = mat(-4; -6). $

  The second iteration gives
  $ x^((2)) =
    mat(-4 + 5(-6); -6 + 7(-4))
    = mat(-34; -34). $

  The third iteration gives
  $ x^((3)) =
    mat(-4 + 5(-34); -6 + 7(-34))
    = mat(-174; -244). $

  These iterates move farther from
  $x^ast = mat(1; 1)$.

  To establish divergence, define the component errors
  relative to $x^ast = mat(1; 1)$:
  $
    e_1^((k)) = x_1^((k)) - 1,
    quad
    e_2^((k)) = x_2^((k)) - 1.
  $

  Subtracting $1$ from the first update gives
  $
    e_1^((k+1))
      &= x_1^((k+1)) - 1 \
      &= (-4 + 5x_2^((k))) - 1 \
      &= 5x_2^((k)) - 5 \
      &= 5(x_2^((k)) - 1) \
      &= 5e_2^((k)).
  $

  Similarly, subtracting $1$ from the second update gives
  $
    e_2^((k+1))
      &= x_2^((k+1)) - 1 \
      &= (-6 + 7x_1^((k))) - 1 \
      &= 7x_1^((k)) - 7 \
      &= 7(x_1^((k)) - 1) \
      &= 7e_1^((k)).
  $

  Applying these relations once more,
  $
    e_1^((k+2))
      &= 5e_2^((k+1))
       = 5(7e_1^((k)))
       = 35e_1^((k)), \
    e_2^((k+2))
      &= 7e_1^((k+1))
       = 7(5e_2^((k)))
       = 35e_2^((k)).
  $

  Thus, each component error is multiplied by $35$
  every two iterations. Since
  $
    e^((0)) = x^((0)) - x^ast
            = mat(0; 0) - mat(1; 1)
            = mat(-1; -1),
  $
  repeated application gives
  $
    e^((2m)) = 35^m e^((0))
             = mat(-35^m; -35^m),
    quad m = 0, 1, 2, dots.
  $

  Because $35^m -> infinity$ as $m -> infinity$,
  the errors at even-numbered iterations grow
  without bound. Therefore, the iterates cannot
  converge to $x^ast$, and Jacobi diverges for
  this initial approximation and equation ordering.
]

#remark[
  A unique solution does not guarantee that
  Jacobi converges. In Example 4, swapping
  the equations produces the strictly
  diagonally dominant system discussed
  in Setup and Notation, for which
  convergence is guaranteed.
]

== Gauss-Seidel Method <lec4_gauss>

#definition(title: "Gauss-Seidel Method")[
  Let $A x = b$ be a system with
  $a_(i i) != 0$ for every $i$.
  Given an initial approximation $x^((0))$,
  the *Gauss-Seidel method* updates the
  components in the order $i = 1, dots, n$ using
  $ x_i^((k+1)) = 1/a_(i i) (
      b_i
      - sum_(j=1)^(i-1) a_(i j) x_j^((k+1))
      - sum_(j=i+1)^n a_(i j) x_j^((k))
    ). $

  Components already updated during the current
  iteration use their new values. Components
  not yet updated use their previous values.
  Empty sums are interpreted as zero.
]

#pagebreak()
=== Derivation

Start with the $i$th equation of $A x = b$:
$ sum_(j=1)^n a_(i j) x_j = b_i. $

Separate the terms before, on, and after
the diagonal:
$ sum_(j=1)^(i-1) a_(i j) x_j
  + a_(i i) x_i
  + sum_(j=i+1)^n a_(i j) x_j = b_i. $

Solving for $x_i$ gives
$ x_i = 1/a_(i i) (
    b_i
    - sum_(j=1)^(i-1) a_(i j) x_j
    - sum_(j=i+1)^n a_(i j) x_j
  ). $

When computing component $i$, the components
$1, dots, i-1$ have already been updated.
Use these new values, together with the old
values of components $i+1, dots, n$:
$ x_i^((k+1)) = 1/a_(i i) (
    b_i
    - sum_(j=1)^(i-1) a_(i j) x_j^((k+1))
    - sum_(j=i+1)^n a_(i j) x_j^((k))
  ). $

*Matrix Form*

Because $D$, $L$, $U$ respectively hold the diagonal, strictly lower, and strictly upper entries of $A$:

$D$ has entries $D_(i i) = a_(i i)$ and zeros elsewhere, so
  $ (D bold(x))_i = sum_j D_(i j) x_j = a_(i i) x_i. $

$L_(i j) = a_(i j)$ for $j < i$ and $0$ otherwise, so
  $ (L bold(x))_i = sum_j L_(i j) x_j = sum_(j<i) a_(i j) x_j. $

$U_(i j) = a_(i j)$ for $j > i$ and $0$ otherwise, so
  $ (U bold(x))_i = sum_(j>i) a_(i j) x_j. $
  
For the matrix form to be obtained, multiply each component
equation by $a_(i i)$ and substitute the equations:
$ D x^((k+1)) =
  b - L x^((k+1)) - U x^((k)). $

Move the lower triangular term to the left in order to isolate
all $x^((k+1))$ terms:
$ (D + L) x^((k+1)) = b - U x^((k)). $

#pagebreak()
Since the matrix $D + L$ is lower triangular with
nonzero diagonal entries, it is invertible.
Therefore,
$ x^((k+1)) =
  (D + L)^(-1) b
  - (D + L)^(-1) U x^((k)). $

#remark[
  The inverse notation expresses the method
  mathematically. In computation, one solves
  the lower triangular system
  $ (D + L) x^((k+1)) = b - U x^((k)) $
  by forward substitution instead of explicitly
  forming $(D + L)^(-1)$.
]

=== Worked Examples

#example(number: "5")[
  *Problem.* Perform two Gauss-Seidel iterations
  for the same lecture system used in Example 3:
  $  5x_1 &- 2x_2 &&+ 3 x_3 &&= -1
  \ -3x_1 &+ 9x_2 &&+ x_3   &&= 2 
  \  2x_1 &-  x_2 &&- 7 x_3 &&= 3 $
  starting from $x^((0)) = mat(0; 0; 0)$.

  *Solution.* Update the components in the
  order $x_1$, $x_2$, then $x_3$:
  $ x_1^((k+1)) &=
    &-1/5 &+ 2/5 x_2^((k)) &&- 3/5 x_3^((k))
  \ x_2^((k+1)) &=
    &2/9 &+ 1/3 x_1^((k+1)) &&- 1/9 x_3^((k))
  \ x_3^((k+1)) &=
    &-3/7 &+ 2/7 x_1^((k+1)) &&- 1/7 x_2^((k+1)). $

  *First iteration.* First compute
  $ x_1^((1)) =
    -1/5 + 2/5 (0) - 3/5 (0) = -1/5. $

  Immediately use this value to compute
  $ x_2^((1)) =
    2/9 + 1/3 (-1/5) - 1/9 (0) = 7/45. $

  Then use both new values to compute
  $ x_3^((1)) =
    -3/7 + 2/7 (-1/5) - 1/7 (7/45)
    = -32/63. $

  Thus,
  $ x^((1)) =
    mat(-1/5; 7/45; -32/63)
    approx mat(-0.20000; 0.15556; -0.50794). $

  *Second iteration.* Using the previous
  values of $x_2$ and $x_3$ gives
  $ x_1^((2)) =
    -1/5 + 2/5 (7/45) - 3/5 (-32/63)
    = 263/1575. $

  Use the new $x_1^((2))$ and the previous
  $x_3^((1))$:
  $ x_2^((2)) =
    2/9 + 1/3 (263/1575) - 1/9 (-32/63)
    = 677/2025. $

  Finally, use both new components:
  $ x_3^((2)) =
    -3/7 + 2/7 (263/1575) - 1/7 (677/2025)
    = -8506/19845. $

  Therefore, after two iterations,
  $ x^((2)) approx
    mat(0.16698; 0.33432; -0.42862). $

  These values differ from the Jacobi iterates
  because updated components are used
  immediately within each sweep.
  Fractions were retained during computation and
  final decimal values are rounded to five
  decimal places.
]

#example(number: "6")[
  *Problem.* Perform three Gauss-Seidel
  iterations for the lecture system
  $ x_1 - 5 x_2 &= -4
  \ 7 x_1 - x_2 &= 6 $
  starting from $x^((0)) = mat(0; 0)$.

  *Solution.* The update formulas are
  $ x_1^((k+1)) &= -4 + 5 x_2^((k))  
  \ x_2^((k+1)) &= -6 + 7 x_1^((k+1)) $

  *First iteration:*
  $ x_1^((1)) &= -4 + 5(0)  &&= -4 
  \ x_2^((1)) &= -6 + 7(-4) &&= -34 $

  *Second iteration:*
  $ x_1^((2)) &= -4 + 5(-34)  &&= -174
  \ x_2^((2)) &= -6 + 7(-174) &&= -1224 $

  *Third iteration:*
  $ x_1^((3)) &= -4 + 5(-1224) &&= -6124
  \ x_2^((3)) &= -6 + 7(-6124) &&= -42874 $

  Hence,
  $ x^((1)) = mat(-4; -34),
    quad x^((2)) = mat(-174; -1224),
    quad x^((3)) = mat(-6124; -42874)
  $

  To establish divergence, define the component errors
  relative to the exact solution $x^ast = mat(1; 1)$:
  $
    e_1^((k)) = x_1^((k)) - 1,
    quad
    e_2^((k)) = x_2^((k)) - 1.
  $

  Subtracting $1$ from the first update gives
  $
    e_1^((k+1))
      &= x_1^((k+1)) - 1 \
      &= (-4 + 5x_2^((k))) - 1 \
      &= 5x_2^((k)) - 5 \
      &= 5(x_2^((k)) - 1) \
      &= 5e_2^((k)).
  $

  The second update uses the newly computed
  $x_1^((k+1))$. Subtracting $1$ gives
  $
    e_2^((k+1))
      &= x_2^((k+1)) - 1 \
      &= (-6 + 7x_1^((k+1))) - 1 \
      &= 7x_1^((k+1)) - 7 \
      &= 7(x_1^((k+1)) - 1) \
      &= 7e_1^((k+1)).
  $

  Substituting $e_1^((k+1)) = 5e_2^((k))$,
  $
    e_2^((k+1))
      = 7(5e_2^((k)))
      = 35e_2^((k)).
  $

  Thus, the second component error is multiplied
  by $35$ every iteration. Initially,
  $
    e_2^((0)) = x_2^((0)) - 1 = 0 - 1 = -1.
  $

  Repeated application gives
  $
    e_2^((1)) &= 35(-1) = -35, \
    e_2^((2)) &= 35(-35) = -35^2, \
    e_2^((3)) &= 35(-35^2) = -35^3.
  $

  In general,
  $
    e_2^((k)) = -35^k,
    quad abs(e_2^((k))) = 35^k -> infinity.
  $

  Since this component error grows without bound,
  the iterates cannot converge to $x^ast$.
  Therefore, Gauss-Seidel diverges for this
  initial approximation and equation ordering.
]

=== Comparison with Jacobi

Jacobi computes every new component using only
the previous iterate. Gauss-Seidel uses newly
computed components as soon as they become
available. This also means that the method may
achieve faster convergence.

For strictly diagonally dominant matrices,
both methods converge from every initial
approximation. Gauss-Seidel often converges
in fewer iterations, but it is not universally
faster, and convergence of one method does
not generally guarantee convergence of the other.

Jacobi allows independent component updates.
Gauss-Seidel generally requires sequential
updates because later components depend on
earlier updates within the same sweep.

Moreover, swapping rows in both the Jacobi 
and the Gauss-Seidel methods affect the convergence 
behavior and the speed of convergence. 

#remark[
  Using newer component values does not by
  itself guarantee convergence. Examples 4
  and 6 show that both methods can diverge,
  even when the system has a unique solution.
]

== Successive Over-Relaxation <lec4_sor>

#definition(title: "Successive Relaxation")[
  Let $A x = b$ have nonzero diagonal entries.
  Given an initial approximation $x^((0))$
  and a relaxation parameter $omega$, successive
  relaxation updates components in the order
  $i = 1, dots, n$ using
  $ x_i^((k)) =
    (1 - omega) x_i^((k-1))
    + omega/a_(i i) (
      b_i
      - sum_(j=1)^(i-1) a_(i j) x_j^((k))
      - sum_(j=i+1)^n a_(i j) x_j^((k-1))
    ), $
  or in vector form,
  $
    x^((k)) = T_omega x^((k-1)) + c_omega
  $
  where $T_omega$ is the transition matrix and $c_omega$ is the constant vector.

  The method is called *successive
  over-relaxation (SOR)* when $omega > 1$.
  It scales the correction suggested by
  a Gauss-Seidel component update.
]

The parameter controls the size of each correction:

- $0 < omega < 1$: *under-relaxation*;
  take a smaller correction.
- $omega = 1$: equivalent to regular *Gauss-Seidel*.
- $omega > 1$: *over-relaxation*;
  extend the correction beyond the
  Gauss-Seidel component value.

#remark[
  Setting $omega = 0$ gives
  $x^((k)) = x^((k-1))$, so no update occurs.
  It does not give the Jacobi method. Jacobi differs from Gauss-Seidel in which component values are used, not simply in
  the size of the correction.
]

#definition(title: "Residual Vector")[
  Suppose $tilde(x) in RR^n$ is an approximation to the solution of $A x = b$. Then the *residual vector* for $tilde(x)$ with respect to this system is $r = b - A tilde(x)$.
]

=== Derivation using Residual Vector

The idea is to generate a sequence of approximations such that the residual vectors will converge rapidly to zero.

Let
  $
    r_i^((k)) = mat(r_(1i)^((k)), r_(2i)^((k)), ..., r_(n i)^((k)))^top, x_i^((k)) = mat(x_1^((k)), x_2^((k)), ..., x_n^((k)))^top
  $
be the residual and solution vectors for the Gauss-Seidel method, respectively. Also, the $m$th component of $r_i^((k))$ is given by
  $
    r_(m i)^((k)) = b_m - sum_(j=1)^(i-1)a_(m j)x_j^((k)) - sum_(j=i)^n a_(m j)x_j^((k-1)) \ 
    arrow.long.double 
    r_(m i)^((k)) = b_m - sum_(j=1)^(i-1)a_(m j)x_j^((k)) - sum_(j=i+1)^n a_(m j)x_j^((k-1)) - a_(m i)x_i^((k-1)).
  $
  
In particular, its $i$th component can be rearranged as 
  $
    a_(i i)x_i^((k-1)) + r_(i i)^((k)) = b_i - sum_(j=1)^(i-1)a_(i j)x_j^((k)) - sum_(j=i+1)^n a_(i j)x_j^((k-1)),
  $
but we know that the Gauss-Seidel method uses
  $ 
    x_i^((k)) = 1/a_(i i) (
    b_i
    - sum_(j=1)^(i-1) a_(i j) x_j^((k))
    - sum_(j=i+1)^n a_(i j) x_j^((k-1))),
  $
so we rewrite the equation as
  $
    a_(i i)x_i^((k-1)) + r_(i i)^((k)) = a_(i i)x_i^((k))
    arrow.long.double x_i^((k)) = x_i^((k-1)) + frac(r_(i i)^((k)), a_(i i))
  $

We can modify the equation above by multiplying $omega$ to $frac(r_(i i)^((k)), a_(i i))$. Note that conventional Gauss-Seidel uses $omega = 1$, but we can accelerate the convergence  by setting $omega > 1$.

We can now rewrite the full form of the equation as
$ x_i^((k)) =
    (1 - omega) x_i^((k-1))
    + omega/a_(i i) (
      b_i
      - sum_(j=1)^(i-1) a_(i j) x_j^((k))
      - sum_(j=i+1)^n a_(i j) x_j^((k-1))
    ). $

#remark[
  This residual component uses a mixture of
  updated and previous values within the sweep.
  It is generally different from the $i$-th
  component of $b - A x^((k))$.
]

=== Matrix Form

We rewrite the equation above, isolating all $x^((k))$ terms on the left:
  $
    a_(i i)x_i^((k)) + omega sum_(j=1)^(i-1)a_(i j)x_j^((k)) = (1 - omega)a_(i i)x_i^((k-1)) - omega sum_(j=i+1)^n a_(i j)x_j^((k-1)) + omega b_i
  $
which corresponds (via $A = D + L + U$) to
$
D x^((k)) + omega L x^((k))
 &= (1 - omega) D x^((k + 1)) - omega U x^((k-1)) + omega b
\ (D + omega L) x^((k))
 &= [(1 - omega) D - omega U] x^((k-1)) + omega b
\ x^((k))
 &= (D + omega L)^(-1)[(1 - omega) D - omega U] x^((k-1))
    + (D + omega L)^(-1) [omega b]
$

Let $T_omega = (D + omega L)^(-1)[(1 - omega)D - omega U]$,
and $c_omega = (D + omega L)^(-1)[omega b]$.

Thus, we obtain the form
$
  x^((k)) = T_omega x^((k-1)) + c_omega.
$

#remark[
  This matrix formula follows from the
  component update using the convention
  $A = L + D + U$. In computation, solve
  the corresponding lower triangular system
  instead of explicitly forming the inverse.
]

#theorem(title: "Kahan")[
  If $a_(i i) != 0$ for $i = 1, 2, ..., n$, then $rho(T_omega) >= |omega - 1|$, thus the SOR method can converge only if $0 < omega < 2$.
]

#theorem(title: "Ostrowski-Reich")[
  If $A$ is a positive definite matrix and $0 < omega < 2$, then the SOR method converges for any choice of initial approximate vector $x^((0))$.
]

#theorem(title: "Optimal Relaxation Factor")[
  If $A$ is positive definite and tridiagonal, then $rho(T_g) = [rho(T_j)]^2 < 1$, and the optimal choice of $omega$ for SOR is given by
  $
    omega = frac(2, 1 + sqrt(1 - [rho(T_j)]^2)),
  $
  which implies $rho(T_omega) = omega - 1$.
]

=== Worked Examples

#example(number: "7")[
  *Problem.* Perform two SOR iterations for
  the lecture system
  $
     5 &x_1 &&- 2 &&x_2 &&+ 3 &&x_3 &&= -1
  \ -3 &x_1 &&+ 9 &&x_2 &&+   &&x_3 &&= 2
  \  2 &x_1 &&-   &&x_2 &&- 7 &&x_3 &&= 3
  $
  starting from $x^((0)) = mat(0; 0; 0)$
  with the chosen parameter $omega = 1.1$.

  *Solution.* Since $1 - omega = -0.1$,
  the update formulas are
  $ x_1^((k+1)) &=
    -0.1 x_1^((k))
    + 1.1 (
      -1/5 + 2/5 x_2^((k))
      - 3/5 x_3^((k))
    )

  \ x_2^((k+1)) &=
    -0.1 x_2^((k))
    + 1.1 (
      2/9 + 1/3 x_1^((k+1))
      - 1/9 x_3^((k))
    )

  \ x_3^((k+1)) &=
    -0.1 x_3^((k))
    + 1.1 (
      -3/7 + 2/7 x_1^((k+1))
      - 1/7 x_2^((k+1))
    ). $

  *First iteration:*
  $ x_1^((1)) &=
    -0.1(0) + 1.1(-1/5)
    = -11/50

  \ x_2^((1)) &=
    -0.1(0)
    + 1.1(2/9 + 1/3(-11/50))
    = 737/4500

  \ x_3^((1)) &=
    -0.1(0)
    + 1.1(
      -3/7 + 2/7(-11/50)
      - 1/7(737/4500)
    )
    = -178387/315000. $

  Thus,
  $ x^((1)) approx
    mat(-0.22000; 0.16378; -0.56631). $

  *Second iteration.* First update $x_1$:
  $ x_1^((2)) =
    -0.1(-11/50)
    + 1.1(
      -1/5 + 2/5(737/4500)
      - 3/5(-178387/315000)
    )
    approx 0.24783. $

  Next, use the newly computed $x_1^((2))$:
  $ x_2^((2)) =
    -0.1(737/4500)
    + 1.1(
      2/9 + 1/3 x_1^((2))
      - 1/9(-178387/315000)
    )
    approx 0.38815. $

  Finally, use both newly computed components:
  $ x_3^((2)) =
    -0.1(-178387/315000)
    + 1.1(
      -3/7 + 2/7 x_1^((2))
      - 1/7 x_2^((2))
    )
    approx -0.39790. $

  Therefore,
  $ x^((2)) approx
    mat(0.24783; 0.38815; -0.39790). $

  Intermediate values were retained without
  rounding; displayed decimals are rounded
  to five decimal places.
]

#example(number: "8")[
  *Problem.* For the reordered lecture system
  $ 7 x_1 - x_2 = 6, $
  $ x_1 - 5 x_2 = -4, $
  compare Gauss-Seidel with SOR using
  $omega = 1.5$, starting from
  $x^((0)) = mat(0; 0)$.
  The exact solution is $x^ast = mat(1; 1)$.

  *Solution.* The relaxation formulas are
  $ x_1^((k+1)) =
    (1 - omega) x_1^((k))
    + omega(6/7 + 1/7 x_2^((k))), $

  $ x_2^((k+1)) =
    (1 - omega) x_2^((k))
    + omega(4/5 + 1/5 x_1^((k+1))). $

  For Gauss-Seidel, set $omega = 1$:
  $ x_1^((1)) = 6/7, $
  $ x_2^((1)) = 4/5 + 1/5(6/7) = 34/35. $

  Therefore,
  $ x^((1)) approx mat(0.85714; 0.97143). $

  For SOR with $omega = 1.5$:
  $ x_1^((1)) =
    -0.5(0) + 1.5(6/7) = 9/7, $

  $ x_2^((1)) =
    -0.5(0) + 1.5(4/5 + 1/5(9/7))
    = 111/70. $

  Therefore,
  $ x^((1)) approx mat(1.28571; 1.58571). $

  Repeating the respective update rules gives:

  #table(
    columns: (auto, 1fr, 1fr),
    inset: 6pt,
    stroke: 0.5pt + midgray,
    [$k$], [*Gauss-Seidel*], [*SOR: $omega = 1.5$*],
    [1],
    [$mat(0.85714; 0.97143)$],
    [$mat(1.28571; 1.58571)$],
    [2],
    [$mat(0.99592; 0.99918)$],
    [$mat(0.98265; 0.70194)$],
    [3],
    [$mat(0.99988; 0.99998)$],
    [$mat(0.94480; 1.13247)$],
  )

  For these three iterations, Gauss-Seidel
  produces smaller maximum absolute component
  errors than SOR with $omega = 1.5$.
  Choosing an overrelaxation parameter does
  not automatically improve convergence speed.
]

=== Notes on the Relaxation Parameter

By Kahan, for SOR to converge to the solution from
every initial approximation, it is necessary
that
$ 0 < omega < 2. $

This condition is not sufficient for a
general coefficient matrix. Convergence
also depends on the matrix and the chosen
parameter.

A suitable overrelaxation parameter can
accelerate convergence, while a poor choice
can slow convergence or cause divergence.
The best parameter depends on the system;
there is no single value that is optimal
for all matrices.

// ============================================================
// 3. Lecture 5
// ============================================================
= Lecture 5: Iterative Refinement, Notes on Convergence


== Iterative Refinement <lec5_refine>
  Iterative refinement is the process of repeatedly improving an approximate solution until it reaches the desired solution or the convergence criteria is met. 

#definition(title: "Iterative Refinement")[
  For a System of Linear Equations (SLE) with $n$ equations represented in matrix form by $A x=b$, some iterative method (LU Decomposition) can be applied to the system to get an *approximate solution $macron(x)$*, where

$ macron(x) = mat(delim: "[", macron(x_1); macron(x_2); ...; macron(x_n))  $

  The approximate solution $macron(x)$ can be refined by
  some vector, called a *correction vector $Delta x$*, to
  get the *corrected vector $x$*.
]

Given that $macron(x)$ is only an approximate to the true solution, there is some difference between the true solution $x$ and the calculated $macron(x)$. Let this difference be the *correction vector*, denoted by $Delta x$, such that $ Delta x = x-macron(x) $

Additionally, with $macron(x)$, the error $E$ can be calculated as the residual vector $ E = b-A macron(x) $

Given that $A x = b$,
$ E = A x - A macron(x) $
$ E = A (x - macron(x)) $
$ E = A (Delta x) $

Since error $E$ measures the difference between the true solution $x$ and the approximate solution $macron(x)$ of the iteration, it is the vector of constants equivalent to the matrix $A$ multiplied by the difference of $x$ and $macron(x)$, or $Delta x$.

Now, $Delta x$ can be solved by manipulating the above
equation. Swapping the left and right sides,
$
A(Delta x) &= E
\ Delta x &= A^(-1) E
$

The *corrected vector* $x$ can be calculated by substituting the calculated $macron(x)$ and $Delta x$ into
$ x = macron(x) + Delta x $


#example(number: "9")[
  *Problem.* Consider the equation from the lecture

$ mat(
  4, 2, 0;
  2, 10, -6;
  0, -6, 8;
) mat(
  x_1;
  x_2;
  x_3;
) = mat(
  12;
  42;
  -24
)
$

and its Cholesky's decomposition ($A = L L^T$),

$ L = mat(
  2, 0, 0;
  1, 3, 0;
  0, -2, 2;
) $

Given the low-precision solution $x=mat(2, 2, 1)^T$, apply iterative refinement to find a 'better' solution.

*Solution.* \
Compute the error $E=b-A overline(x)$
$ A overline(x) = 
 mat(
  4(2) &+ &2(2)  &+ &0(1);
  2(2) &+ &10(2) &+ &-6(1);
  0(2) &- &6(2)  &+ &8(1);
) =
mat(12; 18; -4;) 
$

$ E = mat(12; 42; -24;) - mat(12; 18; -4;) = mat(0; 24; -20;) $

Solve for $A( delta x) = E$ using forward and back substitution

$ L y = E => mat(
  2, 0, 0;
  1, 3, 0;
  0, -2, 2;
) mat(y_1; y_2; y_3) 
=
mat(
  0;
  24;
  -20;
) $

$ 
&=> 2 y_1 = 0 \
&=> 1(0) + 3y_2 = 24 => y_2 = 8 \
&=> -2(8) + 2y_3 = -20 => y_3 = -2 
$

$ => y = mat(0; 8; -2) $

$ L^T (Delta x) = y => mat(
  2, 1, 0;
  0, 3, -2;
  0, 0, 2;
) mat( Delta x_1; Delta x_2; Delta x_3) 
=
mat(0; 8; -2;) 
$

$ 
&=> 2 (Delta x_3) = -2 => Delta x_3 = -1\
&=> 3(Delta x_2) -2(-1) = 8 => Delta x_2 = 2 \
&=> 2 (Delta x_1) + (2) = 0 => Delta x_1 = -1\
$

$ => Delta x = mat(-1; 2; -1) $

Therefore, the corrected vector $x=overline(x) + Delta x$
$ x = 
 mat(2; 2; 1;) + mat(-1; 2; -1;) = mat(1; 4; 0;) 
$

Verifying, 
$ A x = 
 mat(
  4(1)+ 2(4)+0(0);
  2(1)+10(4)+-6(0);
  0(1)-6(4)+8(0);
) =
mat(12; 42; -24;) 
$

Therefore, in this example, one iteration of iterative refinement recovers the true solution $x=mat(1, 4, 0)^T$ exactly. 

]

== Notes on Convergence <lec5_noc>

For the Jacobi, Gauss-Seidel, and SOR techniques discussed,
they can all be written in the general iterative form:
$
x^((k)) = T x^((k-1)) +c
$

where $T$ is the iteration matrix, which is applied to the
previous iterate $x^((k+1))$ and added to some constant
vector $c$ to generate the next iterate.

The convergence of these techniques can then be analyzed and
determined by looking at certain conditions.

=== Convergence of a matrix

#theorem(title: "7.17, Burden and Faires")[
The following statements are equivalent:
 + $lim_(n -> infinity) A^n = 0$, or $A$ is a convergent matrix
 + $lim_(n -> infinity) ||A^n|| = 0$ for some or all natural norm(s)
 + $rho(A) < 1$
 + $lim_(n -> infinity) A^n bold(x) = bold(0)$ for every
   $bold(x)$
]

=== Special matrices

Certain forms of matrices can sufficiently guarantee that specific iteration methods will converge.

Strictly diagonally dominant matrices ($r_(i i) > r_(i j) "for all rows" i "and " i != j$) can guarantee convergence for Jacobi and Gauss-Seidel methods, but is not sufficient for SOR.

Symmetric positive definite matrices guarantee convergence for SOR with $0 < omega < 2$, including Gauss-Seidel with $omega = 1$, but may or may not converge for Jacobi method.

=== Spectral radius
The spectral radius $rho$ is defined as the maximum absolute eigenvalue of a matrix. Formally,
#definition(title: "Spectral Radius")[
Let $S = {lambda_1, lambda_2, ... , lambda_n}$ be the eigenvalues of $T$ (or $S$ is the spectrum of $T$). The spectral radius of $T$ is defined as

$
rho(T) = max{abs(lambda_1), abs(lambda_2), ... abs(lambda_n)}
$
]

We then have the following theorem on convergence:
#theorem(title: "7.11, Burden and Faires")[
  For any initial vector $bold(x)^((0)) in RR^n$,
  the sequence ${bold(x)^((k))}_(k=0)^infinity$ defined by
  $
  bold(x)^((k)) = T bold(x)^((k-1)) + bold(c)
  $
  converges to the unique solution of
  $bold(x) = T bold(x) + bold(c)$ if and only if
  $rho(T) < 1$.
]

// ============================================================
// 4. INDIVIDUAL CONTRIBUTION LOG
// ============================================================
#pagebreak()
= Contribution Log <miniarc3_contrib>

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  [*Name*], [*Contribution*],
  [Esquilona, Liana], [2.3 Gauss-Seidel Method],
  [Felix, Raphael], [Worked Examples for Lecture 4],
  [Lim, Kyros], [2.4 Successive Overrelaxation],
  [Tomista, Shine], [2.2 Jacobi Method],
  [Arceo, Sebastian], [3.2 Notes on Convergence],
  [Elizarde, Samantha], [3.1 Iterative Refinement],
  [Manzano, John], [3.2 Notes on Convergence],
  [Paraguya, Katrin], [3.1 Example Problem 9],
  [Torres, Aloysius], [3.2 Notes on Convergence, Cheatsheet]
)

// ============================================================
// REFERENCES
// ============================================================
= References <miniarc3_ref>

+ Burden and Faires. _Numerical Analysis_.
+ Edwards, Penney, and Calvis. _Differential Equations and Boundary Value Problems_.
+ Oxford Robotics Institute._Engineering Computation: Iterative Solution of Simultaneous Equations Ax=b_. www.robots.ox.ac.uk/\~sjrob/Teaching/EngComp/linAlg34.pdf.
+ Chapra and Canale. _Numerical Methods for Engineers_.

