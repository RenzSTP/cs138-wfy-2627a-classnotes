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
#import "../assets.typ": qa, notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE


// `qa` wrapper: no first-line indent inside the question/answer boxes
#let problem(question, answer) = qa(
  { set par(first-line-indent: 0pt); question },
  { set par(first-line-indent: 0pt); answer },
)


// SECTION HEADER
#show: notes.with(
  title: [Sturm-Liouville Applications],
  subtitle: [Sean Kenji Tolentino]
)

#set math.equation(numbering: none)

// PROBLEM 1
#problem[
  *Compendium Problem \#1.* _Source:_ Edwards, Penney and Calvis. Differential Equations and Boundary Value Problems. Chapter 10, Problems 10.1, Item 2.

  Verify that the eigenvalues and eigenfunctions for the indicated Sturm-Liouville problem are those listed.

  $ y'' + lambda y =0, quad y(0) = y'(L) = 0
  \ lambda_n = ((2n-1)^2 pi^2) / (4L^2), quad y_n = sin(((2n-1) pi x)/(2L)), n >= 1 $

][
  *Solution.* Given that it is already in Sturm-Liouville form, we first check for the trivial and nontrivial solutions:

  *Case 1: $lambda < 0$*

  Let $lambda = -mu^2$ where $mu > 0$. The characteristic equation is:

  $ r^2 + lambda = 0 
  \ r^2 - mu^2 = 0
  \ r = plus.minus mu $
  
  Given the distinct real roots $r_1 = mu$ and $r_2 = -mu$, the general solution is:
  
  $ y(x) = C_1 e^(mu x) + C_2 e^(-mu x) $

  Applying the first boundary condition $y(0) = 0$:

  $ y(0) = C_1 e^0 + C_2 e^0 
  \ 0 = C_1 + C_2 
  \ C_2 = -C_1 
  $

  Updating the general solution:
  
  $ y(x) = C_1 (e^(mu x) - e^(-mu x)) 
  \ arrow.b
  \ y'(x) = C_1 mu (e^(mu x) + e^(-mu x)) $

  Applying $y'(L) = 0$:

  $ y'(L) = C_1 mu (e^(mu L) + e^(-mu L)) 
  \ 0 = C_1 mu (e^(mu L) + e^(-mu L)) $

  Since $mu > 0$ and $e^(mu L) + e^(-mu L) > 0$, we conclude that $C_1 = C_2 = 0$. Thus, concluding only the trivial solution exists for $lambda< 0.$

  *Case 2: $lambda = 0$*

  The differential equation becomes $y'' = 0 arrow r = 0 (2)$. Since we have real repeated roots, our general solution is:

  $ y(x) = C_1 + C_2 x $

  Applying the first boundary condition $y(0) = 0$:

  $ y(0) = C_1 + C_2 (0)
  \ C_1 = 0 $

  Updating the solution and taking the derivative:

  $ y(x) = C_2 x
  \ arrow.b
  \ y'(x) = C_2 $

  Applying the second boundary condition $y'(L) = 0$:

  $ y'(L) = C_2 
  \ C_2 = 0 $

  Since $C_1 = C_2 = 0$, only the trivial solution $y(x) = 0$ exists. Thus, $lambda = 0$ is not an eigenvalue.

  *Case 3: $lambda > 0$*

  Let $lambda = mu^2$ where $mu > 0$. The characteristic equation is:

  $ r^2 + lambda = 0
  \ r^2 + mu^2 = 0
  \ r = plus.minus i mu $

  Given the complex conjugate roots, the general solution is:

  $ y(x) = C_1 cos(mu x) + C_2 sin(mu x) $

  Applying the first boundary condition $y(0) = 0$:

  $ y(0) = C_1 cos(0) + C_2 sin(0)
  \ 0 = C_1 (1) + C_2 (0)
  \ C_1 = 0 $

  Updating the general solution and differentiating:

  $ y(x) = C_2 sin(mu x)
  \ arrow.b
  \ y'(x) = C_2 mu cos(mu x) $

  Applying the second boundary condition $y'(L) = 0$:

  $ y'(L) = C_2 mu cos(mu L) = 0 $

  For a non-trivial solution ($C_2 != 0$), and since $mu > 0$, we require:

  $ cos(mu L) = 0 
  \ mu L = ((2n-1)pi) / 2, quad n >= 1
  \ mu = ((2n-1) pi) / (2L), quad n >= 1 $

  Substituting $mu_n$ back into $lambda = mu^2$ and $y(x)$ yields the eigenvalues and eigenfunctions which aligns with the given:

  $ lambda_n = mu_n^2 = ((2n-1)^2 pi^2) / (4L^2), quad n >= 1 $
  $ y_n(x) = sin(((2n-1) pi x) / (2L)), quad n >= 1 $
]

\

// PROBLEM 2
#problem[
  *Compendium Problem \#2.* _Source:_ Edwards, Penney and Calvis. Differential Equations and Boundary Value Problems. Chapter 10, Problems 10.1, Item 16.

  Beginning with the equation
  $ A(x) y'' + B(x) y' + C(x) y + lambda D(x) y = 0 $

  first divide by $A(x)$ and then multiply by $p(x) = exp( integral (B(x))/(A(x)) d x )$. Show that the resulting equation can be written in the Sturm-Liouville form
  $ d/(d x) [ p(x) (d y)/(d x) ] - q(x) y + lambda r(x) y = 0 $
  with $q(x) = - (p(x) C(x)) / A(x)$ and $r(x) = (p(x) D(x)) / A(x)$.

][
  *Solution.*

  Dividing the differential equation by $A(x)$:
  $ y'' + (B(x))/(A(x)) y' + (C(x))/(A(x)) y + lambda (D(x))/(A(x)) y = 0 $

  Multiplying through by $p(x) = e^( integral (B(x))/(A(x)) d x )$:
  $ p(x) y'' + p(x) (B(x))/(A(x)) y' + p(x) (C(x))/(A(x)) y + lambda p(x) (D(x))/(A(x)) y = 0 $

  Note that by the chain rule:
  $ p'(x) = d/(d x) [ e^( integral (B(x))/(A(x)) d x ) ] = p(x) (B(x))/(A(x)) $

  Substituting $p'(x)$ into the second term:
  $ p(x) y'' + p'(x) y' + (p(x) C(x))/(A(x)) y + lambda (p(x) D(x))/(A(x)) y = 0 $

  By the product rule, $p(x) y'' + p'(x) y' = d/(d x) [ p(x) (d y)/(d x) ]$, giving:
  $ d/(d x) [ p(x) (d y)/(d x) ] + (p(x) C(x))/(A(x)) y + lambda (p(x) D(x))/(A(x)) y = 0 $

  Comparing this to the Sturm-Liouville form $d/(d x) [ p(x) y'] - q(x) y + lambda r(x) y = 0$, we identify:
  $ q(x) = - (p(x) C(x)) / A(x), quad r(x) = (p(x) D(x)) / A(x) $
]

\

// REMIXED PROBLEM
#problem[
  *Remixed Problem.* Consider the Cauchy-Euler differential equation on $x in [1, L]$:

  $ x^2 y'' + x y' + lambda y = 0, quad y(1) = 0, quad y'(L) = 0 $

  1. Convert the differential equation into the Sturm-Liouville form:
  $ d/(d x) [p(x) y'] - q(x)y + lambda r(x)y = 0 $
  identifying $p(x)$, $q(x)$, and $r(x)$.

  2. Solve for its eigenvalues and eigenfunctions.

][
  *Solution.* Given that this is a Cauchy-Euler equation, we first convert it to Sturm-Liouville form, then change variables to solve for non-trivial solutions:

  #underline[*Part 1: Conversion to Sturm-Liouville Form*]

  Dividing the differential equation by $x^2$ to simplify $y''$:

  $ y'' + 1/x y' + lambda 1/x^2 y = 0 $

  where $A(x) = 1, B(x) = 1/x, C(x) = 0, D(x) = 1/x^2$.

  The integrating factor $p(x)$ is:

  $ p(x) = exp( integral (B(x))/(A(x)) d x ) = exp( integral 1/x d x ) = e^(ln x) = x $

  Multiplying the entire equation by $p(x) = x$:

  $ x y'' + y' + lambda 1/x y = 0 $

  Applying the product rule $x y'' + y' = d/(d x) [x y']$:

  $ d/(d x) [ x (d y)/(d x) ] + lambda 1/x y = 0 $

  Comparing this to the canonical Sturm-Liouville form $d/(d x) [p(x) y'] - q(x)y + lambda r(x)y = 0$, we identify:

  $ p(x) = x, quad q(x) = 0, quad r(x) = 1/x $

  #underline[*Part 2: Solving for Eigenvalues and Eigenfunctions*]

  We introduce the transformation $t = ln x$ (so $x = e^t$). As $x$ ranges from $1$ to $L$, $t$ ranges from $0$ to $ln L$.

  Using the chain rule:

  $ y'(x) = (d y) / (d t) (d t) / (d x) = 1/x (d y) / (d t) => x y'(x) = (d y) / (d t) $
  $ d / (d x) [ x y'(x) ] = d / (d t) [ (d y) / (d t) ] (d t) / (d x) = 1/x (d^2 y) / (d t^2) $

  Substituting into the Sturm-Liouville equation:

  $ 1/x (d^2 y) / (d t^2) + lambda 1/x y = 0 => (d^2 y) / (d t^2) + lambda y = 0 $

  Transforming the boundary conditions:
  - At $x = 1 => t = 0$: $y(0) = 0$
  - At $x = L => t = ln L$: $y'(L) = 1/L y'(ln L) = 0 => y'(ln L) = 0$

  Now we check for the trivial and nontrivial solutions across the three cases for $lambda$:

  *Case 1: $lambda < 0$*

  Let $lambda = -mu^2$ where $mu > 0$. The characteristic equation is:

  $ r^2 + lambda = 0
  \ r^2 - mu^2 = 0
  \ r = plus.minus mu $

  Given the distinct real roots $r_1 = mu$ and $r_2 = -mu$, the general solution is:

  $ y(t) = C_1 e^(mu t) + C_2 e^(-mu t) $

  Applying the first boundary condition $y(0) = 0$:

  $ y(0) = C_1 e^0 + C_2 e^0
  \ 0 = C_1 + C_2
  \ C_2 = -C_1 $

  Updating the general solution:

  $ y(t) = C_1 (e^(mu t) - e^(-mu t))
  \ arrow.b
  \ y'(t) = C_1 mu (e^(mu t) + e^(-mu t)) $

  Applying $y'(ln L) = 0$:

  $ y'(ln L) = C_1 mu (e^(mu ln L) + e^(-mu ln L))
  \ 0 = C_1 mu (L^mu + L^(-mu)) $

  Since $mu > 0$ and $L^mu + L^(-mu) > 0$, we conclude that $C_1 = C_2 = 0$. Thus, concluding only the trivial solution exists for $lambda < 0$.

  *Case 2: $lambda = 0$*

  The differential equation becomes $(d^2 y)/(d t^2) = 0 arrow r = 0 (2)$. Since we have real repeated roots, our general solution is:

  $ y(t) = C_1 + C_2 t $

  Applying the first boundary condition $y(0) = 0$:

  $ y(0) = C_1 + C_2 (0)
  \ C_1 = 0 $

  Updating the solution and taking the derivative:

  $ y(t) = C_2 t
  \ arrow.b
  \ y'(t) = C_2 $

  Applying the second boundary condition $y'(ln L) = 0$:

  $ y'(ln L) = C_2
  \ C_2 = 0 $

  Since $C_1 = C_2 = 0$, only the trivial solution $y(t) = 0$ exists. Thus, $lambda = 0$ is not an eigenvalue.

  *Case 3: $lambda > 0$*

  Let $lambda = mu^2$ where $mu > 0$. The characteristic equation is:

  $ r^2 + lambda = 0
  \ r^2 + mu^2 = 0
  \ r = plus.minus i mu $

  Given the complex conjugate roots, the general solution is:

  $ y(t) = C_1 cos(mu t) + C_2 sin(mu t) $

  Applying the first boundary condition $y(0) = 0$:

  $ y(0) = C_1 cos(0) + C_2 sin(0)
  \ 0 = C_1 (1) + C_2 (0)
  \ C_1 = 0 $

  Updating the general solution and differentiating:

  $ y(t) = C_2 sin(mu t)
  \ arrow.b
  \ y'(t) = C_2 mu cos(mu t) $

  Applying the second boundary condition $y'(ln L) = 0$:

  $ y'(ln L) = C_2 mu cos(mu ln L) = 0 $

  For a non-trivial solution ($C_2 != 0$), and since $mu > 0$, we require:

  $ cos(mu ln L) = 0
  \ mu ln L = ((2n-1) pi) / 2, quad n >= 1
  \ mu = ((2n-1) pi) / (2 ln L), quad n >= 1 $

  Substituting $t = ln x$ back into $y(t)$ and $mu_n$ back into $lambda = mu^2$ yields the eigenvalues and eigenfunctions:

  $ lambda_n = mu_n^2 = ((2n-1)^2 pi^2) / (4 (ln L)^2), quad n >= 1 $
  $ y_n (x) = sin(((2n-1) pi ln x) / (2 ln L)), quad n >= 1 $
]

\

#text(size: 10pt)[
  *References.*
  #set enum(numbering: "[1]")
  + C. H. Edwards, D. E. Penney, D. T. Calvis, _Differential Equations and Boundary Value Problems: Computing and Modeling 5th Edition_.
]