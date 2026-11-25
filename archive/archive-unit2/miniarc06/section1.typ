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

#let solution-box(body) = align(center)[
  #box(
    stroke: 1pt,
    inset: 5pt,
  )[
    #body
  ]
]

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE


#let boundary-conditions(body) = block(
  width: 100%,
  fill: rgb("#f0f0f0"),
  inset: 10pt,
  radius: 4pt,
  stroke: (left: 3pt + black),
  [
    #text(weight: "bold")[Boundary Conditions]
    #v(5pt)
    #body
  ],
)

#show: notes.with(
  title: [Eigenvalue BVPs],
)

For a matrix $A$, an eigenvector-eigenvalue problem is given by
$ A x = lambda x $
where $A$ represents some transformation that simply scales the vector $x$ by the constant $lambda$.

This can be extended to operators. Since differentiation is a linear operator that maps functions to other functions, we can express it as an eigenvalue problem: instead of finding a vector $x$ multiplied by a matrix $A$, we look for a non-zero function $y$ that is scaled by a constant when a differential operator is applied to it.

#definition(name: "Eigenvalue Problem for Differentiation", [ \
An eigenvalue problem for differentiation is in the form
$ y^((n)) = d^n/(d x^n) [y] = cal(L)_n [y] = -lambda [y] $
where $y$ is some function that is scaled by some constant $-lambda$ after applying the differentiation operator $cal(L)$ to itself $n$ times. Specifically, for second order ODEs, when $n=2$, the eigenvalue problem is given by
$ y'' + lambda y = 0 => y'' = -lambda y $])

Solving for $y$ for each sign of $lambda$, we get the following general solutions:

- *$lambda = 0$*: $ y'' = 0 => y = C_1 + C_2 x $

- *$lambda > 0$*: \
  Let $lambda = mu^2$ where $mu > 0$. The characteristic equation is $m^2 + mu^2 = 0 => m = plus.minus i mu$. The general solution is then
  $ y = C_1 cos(mu x) + C_2 sin(mu x) = C_1 cos(sqrt(lambda) x) + C_2 sin(sqrt(lambda) x) $

- *$lambda < 0$*: \
  Let $lambda = -mu^2$ where $mu > 0$. The characteristic equation is $m^2 - mu^2 = 0 => m = plus.minus mu$. The general solution is then
  $ y &= C_1 e^(mu x) + C_2 e^(-mu x) = C_1 e^(sqrt(-lambda) x) + C_2e^(-sqrt(-lambda) x) \
  &= C_1 cosh(mu x) + C_2 sinh(mu x) $
  

The general solutions above contain arbitrary constants $C_1 "and" C_2$, which must be determined using additional conditions imposed on the function and its derivatives at specified points. These are called *boundary conditions.* 

Depending on the problem, different types of boundary conditions may be imposed:

#boundary-conditions[
- *Dirichlet:* $y(0) = alpha, y(L) = beta$
- *Neumann:* $y'(0) = alpha, y'(L) = beta$
- *Mixed (D-N):* $y(0) = alpha, y'(L) = beta$
- *Mixed (N-D):* $y'(0) = alpha, y(L) = beta$
- *Periodic:* $y(0) = y(L), y'(0) = y'(L)$
- *Robin (Linear):* $alpha y(0) + beta y'(0) = 0, gamma y(L) + delta  y' (L) = 0$
]

In an eigenvalue problem, applying the boundary conditions
may also restrict the allowable values of $lambda$. Thus,
only certain values of $lambda$ may produce nontrivial
solutions satisfying all the prescribed conditions.



#example(number:"1")[
  #set math.equation(numbering: none)

  Given:

  #align(center)[$ y'' + lambda y = 0 $]

  With Dirichlet BC:

  #align(center)[$ y(0) = 0, quad y(L) = 0 $]

  *Case 1: $lambda = 0$*

  #align(center)[$ y'' = 0 $]

  #align(center)[$ y = C_1 + C_2 x $]

  Applying BC:

  #align(center)[$ y(0) = 0 => C_1 = 0 $]

  #align(center)[$ y(L) = 0 => C_2 L = 0 => C_2 = 0 $]

  Thus, only the trivial solution exists.

  *Case 2: $lambda > 0$*

  Let $lambda = mu^2$, where $mu > 0$.

  #align(center)[$ r^2 + mu^2 = 0 => r = +-mu i $]

  #align(center)[$ y = C_1 cos(mu x) + C_2 sin(mu x) $]

  Applying BC:

  #align(center)[$ y(0) = 0 => C_1 = 0 $]

  #align(center)[$ y(L) = 0 => C_2 sin(mu L) = 0 $]

  For a nontrivial solution, $C_2 != 0$:

  #align(center)[$ sin(mu L) = 0 $]

  #align(center)[$ mu L = n pi => mu = (n pi)/L $]

  #align(center)[$ lambda_n = (n pi / L)^2 $]

  #align(center)[$ y_n(x) = sin((n pi)/L x) $]

  *Case 3: $lambda < 0$*

  Let $lambda = -mu^2$, where $mu > 0$.

  #align(center)[$ r^2 - mu^2 = 0 => r = +-mu $]

  #align(center)[$ y = C_1 cosh(mu x) + C_2 sinh(mu x) $]

  Applying BC:

  #align(center)[$ y(0) = 0 => C_1 = 0 $]

  #align(center)[$ y(L) = 0 => C_2 sinh(mu L) = 0 $]

  Since $sinh(mu L) != 0$:

  #align(center)[$ C_2 = 0 $]

  Thus, only the trivial solution exists.

  *Final Answer:*
  #solution-box[

  #align(center)[$ lambda_n = ( (n pi) / L)^2 $]

  #align(center)[$ y_n(x) = sin((n pi x )/L ) $]]
]




#example(number:"2")[
  #set math.equation(numbering: none)

  Given:

  #align(center)[$ y'' + lambda y = 0 $]

  With Mixed (D-N) BC:

  #align(center)[$ y(0) = 0, quad y'(L) = 0 $]

  *Case 1: $lambda = 0$*

  #align(center)[$ y'' = 0 $]

  #align(center)[$ y = C_1 + C_2 x $]

  Applying BC:

  #align(center)[$ y(0) = 0 => C_1 = 0 $]

  #align(center)[$ y'(L) = 0 => C_2 = 0 $]

  Thus, only the trivial solution exists.

  *Case 2: $lambda > 0$*

  Let $lambda = mu^2$, where $mu > 0$.

  #align(center)[$ r^2 + mu^2 = 0 => r = plus.minus mu i $]

  #align(center)[$ y = C_1 cos(mu x) + C_2 sin(mu x) $]

  Applying BC:

  #align(center)[$ y(0) = 0 => C_1 = 0 $]

  #align(center)[$ y'(L) = 0 => C_2 mu cos(mu L) = 0 $]

  For a nontrivial solution, $C_2 != 0$:

  #align(center)[$ cos(mu L) = 0 $]

  #align(center)[$ mu L = (n + 1/2) pi => mu = ((n + 1/2) pi)/L $]

  #align(center)[$ lambda_n = (((n + 1/2) pi) / L)^2 $]

  #align(center)[$ y_n(x) = sin(((n + 1/2) pi x)/L) $]

  *Case 3: $lambda < 0$*

  Let $lambda = -mu^2$, where $mu > 0$.

  #align(center)[$ r^2 - mu^2 = 0 => r = plus.minus mu $]

  #align(center)[$ y = C_1 cosh(mu x) + C_2 sinh(mu x) $]

  Applying BC:

  #align(center)[$ y(0) = 0 => C_1 = 0 $]

  #align(center)[$ y'(L) = 0 => C_2 mu cosh(mu L) = 0 $]

  Since $mu > 0$ and $cosh(mu L) != 0$:

  #align(center)[$ C_2 = 0 $]

  Thus, only the trivial solution exists.

  *Final Answer:*
  #solution-box[

  #align(center)[$ lambda_n = (((n + 1/2) pi) / L)^2 $]

  #align(center)[$ y_n(x) = sin(((n + 1/2) pi x)/L)$]]
]


#example(number:"3")[
  Given:

  #align(center)[$y'' + lambda y = 0$]

  With Periodic BC on interval $[0, L]$:

  #align(center)[$y(0) = y(L), quad y'(0) = y'(L)$]

  *Case 1: $lambda = 0$*

  #align(center)[$y = C_1 + C_2 x \ y' = C_2 $]
  Applying BC:
  - Applying $y(0) = y(L): quad C_1 = C_1 + C_2 L => C_2 L = 0  => C_2 = 0$
  - The condition $y'(0) = y'(L) "is automatically satisfied since" C_2 = 0.$

  Thus, $C_1$ is free, giving the first eigenvalue:
  #align(center)[$lambda_0 = 0, quad y_0(x) = 1$]

  *Case 2: $lambda > 0$*

  Let $lambda = mu^2$ ($mu > 0$). The general solution is
  #align(center)[$y = C_1 cos(mu x) + C_2 sin(mu x) \ 
  y' = -C_1 mu sin(mu x) + C_2 mu cos(mu x)$]

  Applying BC:
  - Applying $y(0) = y(L): quad C_1 = C_1 cos(mu L) + C_2 sin(mu L)$ $quad quad dots (1)$
  - Applying $y'(0) = y'(L): quad C_2 mu = -C_1 mu sin(mu L) + C_2 mu cos(mu L)$ $quad quad dots (2)$

  Dividing (2) by $mu != 0$,
  #align(center)[$C_2 = -C_1 sin(mu L) + C_2 cos(mu L)$]
  Rearranging into matrix form,
  #align(center)[$M = mat(cos(mu L) - 1, sin(mu L); -sin(mu L), cos(mu L) - 1) \
  M mat(C_1; C_2) = mat(0; 0)$]

  A non-trivial solution requires $det(M)=0$, so:
  #align(center)[$(cos(mu L) - 1)^2 + sin^2(mu L) = 2 - 2 cos(mu L) = 4 sin^2(frac(mu L, 2)) = 0$]

  This holds when:
  #align(center)[$mu L = 2 n pi => mu_n = frac(2 n pi, L), quad n = 1, 2, 3, dots $]

  At these values, $sin(mu L) = 0$ and $cos(mu L) = 1$, so both equations become $0 = 0$. Squaring $mu$, we get the eigenvalues:
  #align(center)[$mu^2 =lambda_n = (frac(2 n pi, L))^2$]

  Because both $C_1$ and $C_2$ are free, we get a pair of linearly independent eigenfunctions for each $n$:
  #align(center)[$y_(n,1)(x) = cos(frac(2 n pi x, L)), quad y_(n,2)(x) = sin(frac(2 n pi x, L))$]

  *Case 3: $lambda < 0$*

  Let $lambda = -mu^2$ ($mu > 0$). Using hyperbolic functions, the general solution is
  #align(center)[$y = C_1 cosh(mu x) + C_2 sinh(mu x) \
  y' = mu C_1 sinh(mu x) + mu C_2 cosh(mu x)$]

  Applying BC:
  - Applying $y(0) = y(L): quad C_1 = C_1 cosh(mu L) + C_2 sinh(mu L)$ $quad quad dots (1)$
  - Applying $y'(0) = y'(L): quad C_2 mu = mu C_1 sinh(mu L) + mu C_2 cosh(mu L)$ $quad quad dots (2)$

  Dividing (2) by $mu != 0$,
  #align(center)[$C_2 = C_1 sinh(mu L) + C_2 cosh(mu L)$]
  Rearranging into matrix form,
  #align(center)[$M = mat(cosh(mu L) - 1, sinh(mu L); sinh(mu L), cosh(mu L) - 1) \ M mat(C_1; C_2) = mat(0; 0)$]

  Since a non-trivial solution requires $det(M) = 0$:
  #align(center)[$det(M) = (cosh(mu L) - 1)^2 - sinh^2(mu L) = 2 - 2 cosh(mu L) $]

  Since $cosh(mu L) > 1$ for $mu L > 0$, we have $det(M) < 0$, so $det(M) != 0$ for every $mu > 0$. The only possible solution is $C_1 = C_2 = 0$. Thus, only the trivial solution exists.

  *Final Answer:*
  #solution-box[
  #align(center)[$\ lambda_0 = 0, quad y_0(x) = 1$]
  #align(center)[$lambda_n = (frac(2 n pi, L))^2, quad n = 1, 2, 3, dots$]
  #align(center)[$y_n(x) in { cos(frac(2 n pi x, L)), space sin(frac(2 n pi x, L)) } \ \ $]
  ]
]