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
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis, qa

#let problem(question, answer) = qa(
  { set par(first-line-indent: 0pt); question },
  { set par(first-line-indent: 0pt); answer },
)

#show: notes.with(
  title: [Generalized Eigenvalue Problems],
  subtitle: [Nathaniel Silas Zuñiga]
)

// Justify and indent to preference (re-applied after show rule per assets note)
#set par(
  justify: true,
  first-line-indent: (amount: 2.0em, all: true)
)

#problem[ 
  *Solved Problem \#1.* _Source: CS 138 2627A Boundary Value Problems Handout, Homework_
  
  
  Solve the following boundary value problem:
  $ x^2 y'' + x y' + lambda y = 0, quad y(1) = 0, quad y(2) = 0 $

][
  *Step 1: Apply Cauchy-Euler substitution.*
  Let $x = e^t$, which means $t = ln(x)$. Under this substitution:
  $ y'(x) = (d y)/(d t) e^(-t), quad y''(x) = e^(-2t) ( (d^2 y)/(d t^2) - (d y)/(d t) ) $

  Substituting these back into the original ODE gives us:
  $ (e^t)^2 [ e^(-2t) ( (d^2 y)/(d t^2) - (d y)/(d t) ) ] + e^t [ (d y)/(d t) e^(-t) ] + lambda y &= 0 \
    ( (d^2 y)/(d t^2) - (d y)/(d t) ) + (d y)/(d t) + lambda y &= 0 \
    (d^2 y)/(d t^2) + lambda y &= 0 $

\

  *Step 2: Transform the Dirichlet boundary conditions.*
  - At $x = 1$, $t = ln(1) = 0$, so $y(0) = 0$.
  - At $x = 2$, $t = ln(2)$, so $y(ln 2) = 0$.

  This transforms the original equation into a standard Dirichlet boundary value problem on the domain $t in [0, ln 2]$.

\
  
  *Step 3: Solve the Dirichlet BVP for non-trivial solutions.*
  For $lambda > 0$, the general solution in terms of $t$ is:
  $ y(t) = C_1 cos(sqrt(lambda) t) + C_2 sin(sqrt(lambda) t) $

  Applying the boundary condition $y(0) = 0$:
  $ y(0) = C_1 cos(0) + C_2 sin(0) = C_1 = 0 $

  Applying the boundary condition $y(ln 2) = 0$:
  $ y(ln 2) = C_2 sin(sqrt(lambda) ln 2) = 0 $

  For a non-trivial solution ($C_2 != 0$), we set $sqrt(lambda) ln 2 = n pi$ for $n = 1, 2, 3, ...$. Solved for $lambda$, the eigenvalues are:
  $ lambda_n = ((n pi) / (ln 2))^2 $

  The corresponding eigenfunctions in terms of $t$ are $y_n(t) = sin(((n pi) / (ln 2)) t)$.

\
  
  *Step 4: Convert back to the variable $x$.*
  Substituting $t = ln(x)$ gives the final eigenfunctions under Dirichlet boundary conditions:
  
  #align(center)[$y_n(x) = sin(((n pi) / (ln 2)) ln x), quad n = 1, 2, 3, ...$]
  #h(1fr) $square$
  
]