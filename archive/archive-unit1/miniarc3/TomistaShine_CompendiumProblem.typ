#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

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

= Compendium Problems (Tomista, Fatima Shine)
#problem(number: "1", source: "Burden & Faires, Numerical Analysis, Exercise Set 7.3, #1a")[
  *Statement:* Find the first two iterations of the Jacobi method for
  the following linear system, using $x^((0)) = bold(0)$:

  $ 3x_1 - x_2 + x_3 &= 1 \
    3x_1 + 6x_2 + 2x_3 &= 0 \
    3x_1 + 3x_2 + 7x_3 &= 4 $

  *Solution:*

  Solving each equation for its corresponding variable:

  $ x_1^((k+1)) &= 1/3 (1 + x_2^((k)) - x_3^((k))) \
    x_2^((k+1)) &= 1/6 (-3x_1^((k)) - 2x_3^((k))) \
    x_3^((k+1)) &= 1/7 (4 - 3x_1^((k)) - 3x_2^((k))) $

  *Iteration 1*

  Substituting $x^((0)) = (0,0,0)$:

  $ x_1^((1)) &= 1/3 (1) approx 0.3333 \
    x_2^((1)) &= 1/6 (0) = 0 \
    x_3^((1)) &= 1/7 (4) approx 0.5714 $

  $ bold(x^((1)) = (0.3333,\ 0.0000,\ 0.5714)) $

  *Iteration 2*

  Using only components of $x^((1))$:

  $ x_1^((2)) &= 1/3 (1 + 0 - 0.5714) approx 0.1429 \
    x_2^((2)) &= 1/6 (-3(0.3333) - 2(0.5714)) approx -0.3571 \
    x_3^((2)) &= 1/7 (4 - 3(0.3333) - 3(0)) approx 0.4286 $

  $ bold(x^((2)) = (0.1429,\ -0.3571,\ 0.4286)) $
]

#problem(number: "2", source: "Burden & Faires, Numerical Analysis, Exercise Set 7.3, #13")[
  *Statement:*

  *(a)* Prove that

  $ ||x^((k)) - x|| <= ||T||^k ||x^((0)) - x||
    quad "and" quad
    ||x^((k)) - x|| <= (||T||^k)/(1-||T||) ||x^((1)) - x^((0))||, $

  where $T$ is an $n times n$ matrix with $||T|| < 1$ and

  $ x^((k)) = T x^((k-1)) + c, quad k=1,2,dots, $

  with $x^((0))$ arbitrary, $c in RR^n$, and $x = T x + c$.

  *(b)* Apply the bounds to Exercise 1, when possible, using the
  $ell_infinity$ norm.

  *Solution:*

  *Part (a)*

  Subtracting $x = T x+c$ from $x^((k)) = T x^((k-1))+c$ gives

  $ x^((k)) - x = T (x^((k-1)) - x). $

  Taking norms and applying submultiplicativity, $||T v|| <= ||T||\ ||v||$:

  $ ||x^((k)) - x|| <= ||T||\ ||x^((k-1)) - x||. $

  Applying this inequality repeatedly, $k$ times, gives the first bound:

  $ ||x^((k)) - x|| <= ||T||^k ||x^((0)) - x||. $

  For the second bound, telescope the difference $x^((m)) - x^((k))$
  for some $m > k$ as a sum of consecutive differences:

  $ x^((m)) - x^((k)) = sum_(i=k)^(m-1) (x^((i+1)) - x^((i))). $

  Since $x^((i+1)) - x^((i)) = T^i (x^((1)) - x^((0)))$, taking norms and
  summing the geometric series:

  $ ||x^((m)) - x^((k))|| <= sum_(i=k)^(m-1) ||T||^i ||x^((1)) - x^((0))||
    = ||T||^k (1 - ||T||^(m-k))/(1-||T||) ||x^((1)) - x^((0))||. $

  Letting $m -> infinity$, $||T|| < 1$ forces $||T||^(m-k) -> 0$, and
  $x^((m)) -> x$, giving:

  $ ||x^((k)) - x|| <= (||T||^k)/(1-||T||) ||x^((1)) - x^((0))||. $

  *Part (b)*

  Applying both bounds to Exercise 1(a) (Compendium Problem 1 above),
  with $T = T_J$:

  $ ||T_J||_infinity = 6/7 approx 0.8571 $

  $ x^((1)) - x^((0)) = vec(0.3333, 0.0000, 0.5714)
    quad arrow.r.double quad
    ||x^((1)) - x^((0))||_infinity = 4/7 approx 0.5714 $

  *First bound:*

  $ ||x^((k)) - x||_infinity <= (6/7)^k ||x^((0)) - x||_infinity $

  *Second bound:* solving for the minimum $k$ guaranteeing
  $||x^((k)) - x||_infinity <= 10^(-4)$:

  $ ((6/7)^k) / (1/7) dot 4/7 <= 10^(-4)
    quad arrow.r.double quad
    (6/7)^k <= 2.5 times 10^(-5) $

  $ k >= (ln(2.5 times 10^(-5)))/(ln(6/7)) approx 68.75 $

  $ bold(k = 69) $
]

#problem(number: "Remix", source: "Compendium Problems 1 and 2")[
  *Statement:* Let $A$ and $b$ be as in Compendium Problem 1, and let
  $x^((0)) = bold(0)$.

  *(a)* State $T_J$ and find $||T_J||_infinity$.

  *(b)* Find $x^((1))$ and $||x^((1)) - x^((0))||_infinity$.

  *(c)* Using the bound from Compendium Problem 2, find the least $k$
  satisfying $||x^((k)) - x^*||_infinity <= 10^(-2)$.

  *(d)* Repeat part (c), this time satisfying
  $||x^((k)) - x^*||_infinity <= 10^(-4)$.

  *(e)* Repeat part (c) once more, satisfying
  $||x^((k)) - x^*||_infinity <= 10^(-6)$.

  *(f)* Compare the three answers. What happens to $k$ each time the
  required bound shrinks by a factor of $10^2$?

  *Solution:*

  *(a)*

  $ T_J = mat(0, 1/3, -1/3; -1/2, 0, -1/3; -3/7, -3/7, 0) $

  $ bold(||T_J||_infinity = 6/7 approx 0.8571) $

  *(b)*

  $ bold(x^((1)) = (0.3333,\ 0.0000,\ 0.5714)) $

  $ bold(||x^((1)) - x^((0))||_infinity = 4/7 approx 0.5714) $

  *(c)* Satisfying $||x^((k)) - x^*||_infinity <= 10^(-2)$:

  $ (6/7)^k / (1/7) dot 4/7 <= 10^(-2)
    quad arrow.r.double quad
    (6/7)^k <= 2.5 times 10^(-3) $

  $ bold(k = 39) $

  *(d)* Satisfying $||x^((k)) - x^*||_infinity <= 10^(-4)$:

  $ (6/7)^k / (1/7) dot 4/7 <= 10^(-4)
    quad arrow.r.double quad
    (6/7)^k <= 2.5 times 10^(-5) $

  $ bold(k = 69) $

  *(e)* Satisfying $||x^((k)) - x^*||_infinity <= 10^(-6)$:

  $ (6/7)^k / (1/7) dot 4/7 <= 10^(-6)
    quad arrow.r.double quad
    (6/7)^k <= 2.5 times 10^(-7) $

  $ bold(k = 99) $

  *(f)*

  #box(stroke: 0.5pt, inset: 8pt, radius: 3pt)[
    $ 10^(-2) arrow.r k=39, quad
      10^(-4) arrow.r k=69, quad
      10^(-6) arrow.r k=99 $

    Each time the required bound shrinks by a factor of $10^2$, $k$
    increases by exactly *30* iterations ($69-39=30$,
    $99-69=30$), tightening the bound by the same relative amount
    always costs the same number of extra iterations.
  ]
]

+ Burden, R. L., and Faires, J. D. _Numerical Analysis_. Exercise Set 7.3, #1 and #13.