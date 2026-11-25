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
  title: [Sturm–Liouville Problems],

)

// `notes` numbers every display equation. The source notes only number
// (1)–(7), so numbering is switched off here and re-enabled locally with
// #[ #set math.equation(numbering: "(1)") ... ] on those seven.
#set math.equation(numbering: none)


// SECTION SUBHEADER1
#section-subheading("1", "The idea behind the theory")
#h(2em) // fix indent for 1st paragraph
A boundary value problem (BVP) specifies a differential equation together with
conditions at the ends of an interval. In an eigenvalue BVP, a parameter
$lambda$ appears in the equation, and only certain values of $lambda$ allow a
solution that is not identically zero.

#definition(name: "Eigenvalues and eigenfunctions")[
  Such values of $lambda$ are called *eigenvalues*; their associated nonzero
  solutions $y(x)$ are called *eigenfunctions*.
]

#h(2em)
This is analogous to the matrix equation $A bold(v) = lambda bold(v)$, except
that a differential operator acts on functions instead of a matrix acting on
vectors.

\

// SECTION SUBHEADER2
#section-subheading("2", "The Sturm–Liouville equation")
#h(2em) // fix indent for 1st paragraph
Consider the generalized second-order boundary value problem

#[
  #set math.equation(numbering: "(1)")
  $ P_0(x)y''+P(x)y'+Q(x)y+ lambda R(x)y=0, quad a <= x <= b. $
]

Under suitable conditions, this equation can be transformed into the *Sturm–Liouville form*:

$ cal(L)[y] = [p y']' + q y = -lambda r y $

#[
  #set par(first-line-indent: 0pt)
  #set list(indent: 2em)
  where:

  - $p(x)$ and $q(x)$ are coefficient functions that define the differential operator.
  - $r(x)$ is the weight function.
  - $lambda$ is the eigenvalue parameter.
  - $y(x)$ is the unknown function, which becomes an eigenfunction when it is nontrivial and satisfies the boundary conditions.
]

The *Sturm–Liouville operator* is defined as:
$ cal(L)[y] = [p y']' + q y $

#h(2em)The expression $[p(x)y']'$ is particularly important because it gives the operator a symmetric structure under appropriate boundary conditions. This property is fundamental to understanding the behavior of Sturm–Liouville eigenvalues and eigenfunctions.

The equation is considered together with homogeneous boundary conditions, for
example

$ y(a) = y(b) = 0 #h(0.5em) "(Dirichlet)", quad
  y'(a) = y'(b) = 0 #h(0.5em) "(Neumann)". $

#definition(name: "Separated conditions")[
  Separated boundary conditions specify an independent condition at each endpoint of the interval. They may involve the function $y$, its derivative $y'$, or a linear combination of both. Their general form is:

$
alpha_1y(a)+ beta_1y'(a)=0,
$

$ alpha_2y(b)+beta_2y'(b)=0. $

where the coefficients in each condition cannot both be zero.
]

#h(2em)
The boundary conditions matter because they determine which eigenfunctions are
allowed.

\

// SECTION SUBHEADER3
#section-subheading("3", "Why the Sturm–Liouville form is useful")
// fix indent for 1st paragraph
Many second-order equations initially look like

$ y'' + A(x) y' + B(x) y + lambda C(x) y = 0. $

Multiplying by the integrating factor

#[
  #set math.equation(numbering: "(1)")
  #counter(math.equation).update(1)
  $ mu(x) = e ^(integral A(x) dif x) $
]

combines the first two terms, since $(mu y')' = mu y'' + mu A y'$. Therefore,

$ (mu y')' + mu B y = -lambda mu C y, $

which is in Sturm–Liouville form with $p = mu$, $q = mu B$, and $r = mu C$.

\

// SECTION SUBHEADER4
#section-subheading("4", "Worked example")
#h(2em) // fix indent for 1st paragraph
Rewrite the following equation in Sturm–Liouville form:

#[
  #set math.equation(numbering: "(1)")
  #counter(math.equation).update(2)
  $ y'' + 2y' + lambda y = 0, quad 0 <= x <= 1, quad y(0) = y(1) = 0. $
]

#example(number: "1")[
  \
  *Step 1:* The coefficient of $y'$ is $A(x) = 2$, so
  $ mu(x) = e^(integral 2 dif x) = e^(2x). $

  *Step 2:* Multiply equation (3) by $e^(2x)$:
  $ e^(2x) y'' + 2 e^(2x) y' + lambda e^(2x) y = 0. $

  *Step 3:* Recognize the product derivative:
  #[
    #set math.equation(numbering: "(1)")
    #counter(math.equation).update(3)
    $ (e^(2x) y')' = -lambda e^(2x) y. $
  ]

  Thus $p(x) = e^(2x)$, $q(x) = 0$, and $r(x) = e^(2x)$. The boundary
  conditions remain $y(0) = y(1) = 0$. This example shows the conversion, not
  the calculation of the eigenvalues.
]

\

// SECTION SUBHEADER5
#section-subheading("5", "Sturm–Liouville Theorem")
#h(2em) // fix indent for 1st paragraph
For a *regular* problem on a finite interval, with sufficiently smooth
coefficients, $p(x) > 0$, $r(x) > 0$, and suitable homogeneous separated
boundary conditions, the following properties hold.

*A. The operator is symmetric*
\ For functions $u$ and $v$ satisfying the boundary conditions,
  #[
    #set math.equation(numbering: "(1)")
    #counter(math.equation).update(4)
    $ integral_a^b u(x) L[v(x)] dif x = integral_a^b v(x) L[u(x)] dif x. $
  ]
In other words, the roles of $u$ and $v$ can be exchanged in these integrals. Integration by parts makes this possible because the boundary terms cancel.


*B. The eigenvalues are real and ordered*
\ There is an infinite sequence
  #[
    #set math.equation(numbering: "(1)")
    #counter(math.equation).update(5)
    $ lambda_0 < lambda_1 < lambda_2 < dots.c, quad lambda_n -> +infinity. $
  ]
  The eigenvalues are real, but they are not necessarily all positive. For
  separated boundary conditions, each eigenvalue has one linearly independent
  eigenfunction, up to scaling.


*C. Different eigenfunctions are orthogonal*
\ If $y_m$ and $y_n$ correspond to different eigenvalues, then
  #[
    #set math.equation(numbering: "(1)")
    #counter(math.equation).update(6)
    $ integral_a^b r(x) y_m (x) y_n (x) dif x = 0, quad m != n. $
  ]
  The factor $r(x)$ is important: orthogonality is measured using the
  *weighted inner product*
  $ chevron.l u, v chevron.r_r = integral_a^b r(x) u(x) v(x) dif x. $
  This is one reason eigenfunctions are useful for expressing more complicated
  functions as sums of simpler modes.

\

