#set page(paper: "a4", margin: (x: 0.85in, y: 0.7in), numbering: "1")
#set text(font: "New Computer Modern", size: 11pt)
#set par(justify: true, leading: 0.55em)

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

#let problem(number: none, source: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: none,
)[
  #text(size: 18pt, fill: ink, weight: "bold")[
  Compendium Problem #if number != none [#number]
  ]
  #linebreak()
  #if source != none [
    #text(size: 9pt, fill: midgray)[(Source: #source)]
  ]
  #linebreak()
  #body
]

#problem(
  number: 1,
  source: [Burden & Faires, _Numerical Analysis_, Exercise 1(b), p. 467],
)[
  Use the successive over-relaxation (SOR) method with $omega = 1.1$ and
  initial approximation $x^((0)) = (0, 0, 0)^T$ to perform two iterations
  for the system
  $
    10x_1 - x_2 &= 9, \
    -x_1 + 10x_2 - 2x_3 &= 7, \
    -2x_2 + 10x_3 &= 6.
  $
]

*Solution.* The SOR update for the $i$th component is
$
  x_i^((k+1)) = (1-omega)x_i^((k))
  + frac(omega, a_(i i)) lr([
    b_i
    - sum_(j=1)^(i-1) a_(i j)x_j^((k+1))
    - sum_(j=i+1)^n a_(i j)x_j^((k))
  ]).
$
Thus, each component uses the newest available values. Substituting
$omega = 1.1$ gives
$
  x_1^((k+1)) &= -0.1x_1^((k)) + 0.11(9+x_2^((k))), \
  x_2^((k+1)) &= -0.1x_2^((k)) + 0.11(7+x_1^((k+1))+2x_3^((k))), \
  x_3^((k+1)) &= -0.1x_3^((k)) + 0.11(6+2x_2^((k+1))).
$

*First iteration ($k=0$).* Starting from $x^((0)) = (0,0,0)^T$,
$
  x_1^((1)) &= -0.1(0)+0.11(9+0) = 0.99, \
  x_2^((1)) &= -0.1(0)+0.11(7+0.99+2(0)) = 0.8789, \
  x_3^((1)) &= -0.1(0)+0.11(6+2(0.8789)) = 0.853358.
$
Therefore,
$ x^((1)) = mat(0.99; 0.8789; 0.853358). $

*Second iteration ($k=1$).* Using the values above without intermediate rounding,
$
  x_1^((2)) &= -0.1(0.99)+0.11(9+0.8789) \
             &= 0.987679, \
  x_2^((2)) &= -0.1(0.8789)+0.11(7+0.987679+2(0.853358)) \
             &= 0.97849345, \
  x_3^((2)) &= -0.1(0.853358)+0.11(6+2(0.97849345)) \
             &= 0.789932759.
$
Hence, after two SOR iterations, the approximation rounded to five decimal places is
#align(center)[
  #box(stroke: 0.6pt, inset: 8pt)[$ x^((2)) approx mat(0.98768; 0.97849; 0.78993) $]
]

#pagebreak()

#problem(
  number: 2,
  source: [Lecture 1b Practice Problems, Problem 1.],
)[
  Consider the linear system $A x=b$ and a nonsingular matrix $Q$.
  Let the intermediate approximation $x^((k+1) ast)$ be defined by
  $ Q x^((k+1) ast) = (Q-A)x^((k)) + b. $
  Show that the relaxed update
  $ x^((k+1)) = omega x^((k+1) ast) + (1-omega)x^((k)) $
  is equivalent to
  $ Q x^((k+1)) = (Q-omega A)x^((k)) + omega b. $
]

*Solution.* Here, $x^((k+1) ast)$ denotes the intermediate approximation
before relaxation, while $x^((k+1))$ denotes the relaxed approximation.

Multiplying the relaxed update by $Q$ gives
$
  Q x^((k+1))
  = omega Q x^((k+1) ast) + (1-omega)Q x^((k)).
$
Substituting the equation for the intermediate approximation,
$
  Q x^((k+1))
  &= omega lr([(Q-A)x^((k)) + b]) + (1-omega)Q x^((k)) \
  &= omega Q x^((k)) - omega A x^((k)) + omega b \
  &quad + Q x^((k)) - omega Q x^((k)) \
  &= Q x^((k)) - omega A x^((k)) + omega b.
$
Factoring the terms involving $x^((k))$, we obtain
#align(center)[
  #box(stroke: 0.6pt, inset: 8pt)[$ Q x^((k+1)) = (Q-omega A)x^((k)) + omega b $]
]

Conversely, since $Q$ is nonsingular, multiplying this equation by $Q^(-1)$ gives
$
  x^((k+1))
  &= Q^(-1)lr([(Q-omega A)x^((k)) + omega b]) \
  &= omega Q^(-1)lr([(Q-A)x^((k)) + b]) + (1-omega)x^((k)) \
  &= omega x^((k+1) ast) + (1-omega)x^((k)).
$
Thus, the two iteration schemes are equivalent.

#pagebreak()

#problem(
  number: [3 — Remix],
  source: [Original remix inspired by Burden & Faires, _Numerical Analysis_,
    Exercise 1(b), p. 467, and Lecture 1b Practice Problems, Problem 1.],
)[
  A numerical model for three coupled temperature corrections leads to
  the linear system
  $
    4x_1-x_2 &= 2, \
    -x_1+4x_2-x_3 &= 6, \
    -x_2+3x_3 &= 1.
  $
  Two implementations of the model use different forms of the successive
  over-relaxation (SOR) method. To check their agreement, use
  $omega=1.2$ and $x^((0))=(0,1,0)^T$ to:

  + Compute one SOR iteration using the componentwise formula.
  + Compute the same iteration using
    $Q x^((1))=(Q-omega A)x^((0))+omega b$, where
    $A=D+L+U$ and $Q=D+omega L$.
  + Compare the results and explain the equivalence of the two formulations.

  Here, $D$, $L$, and $U$ are the diagonal, strictly lower-triangular,
  and strictly upper-triangular parts of $A$, respectively.
]

*Solution.*

*1. Componentwise SOR iteration*

For this system, the SOR update equations are
$
  x_1^((k+1)) &= (1-omega)x_1^((k)) + omega/4 (2+x_2^((k))), \
  x_2^((k+1)) &= (1-omega)x_2^((k)) + omega/4 (6+x_1^((k+1))+x_3^((k))), \
  x_3^((k+1)) &= (1-omega)x_3^((k)) + omega/3 (1+x_2^((k+1))).
$
Each component uses the newest available values. Since $omega=1.2$,
we have $1-omega=-0.2$, $omega/4=0.3$, and $omega/3=0.4$.
Starting from $x^((0))=(0,1,0)^T$,
$
  x_1^((1)) &= -0.2(0)+0.3(2+1)=0.9, \
  x_2^((1)) &= -0.2(1)+0.3(6+0.9+0)=1.87, \
  x_3^((1)) &= -0.2(0)+0.4(1+1.87)=1.148.
$
Thus, the first SOR approximation is
#align(center)[
  #box(stroke: 0.6pt, inset: 8pt)[$ x^((1))=mat(0.9;1.87;1.148) $]
]

#pagebreak()
#show math.equation: set block(above: 0.65em, below: 0.65em)

*2. Equivalent matrix relaxation scheme*

First, the general relaxation equations
$
  x^((k+1)) &= omega x^((k+1) ast)+(1-omega)x^((k)), \
  Q x^((k+1) ast) &= (Q-A)x^((k))+b
$
give, after multiplying the first equation by $Q$ and substituting the second,
$
  Q x^((k+1))
  &= omega lr([(Q-A)x^((k))+b])+(1-omega)Q x^((k)) \
  &= Q x^((k))-omega A x^((k))+omega b \
  &= (Q-omega A)x^((k))+omega b.
$
Here, $x^((k+1) ast)$ is the intermediate approximation before relaxation.

For the given system,
$
  A=mat(4,-1,0;-1,4,-1;0,-1,3), quad b=mat(2;6;1).
$
Using the sign convention $A=D+L+U$,
$
  D=mat(4,0,0;0,4,0;0,0,3), quad
  L=mat(0,0,0;-1,0,0;0,-1,0), quad
  U=mat(0,-1,0;0,0,-1;0,0,0).
$
Therefore,
$
  Q=D+1.2L=mat(4,0,0;-1.2,4,0;0,-1.2,3), quad
  Q-1.2A=mat(-0.8,1.2,0;0,-0.8,1.2;0,0,-0.6).
$
The right-hand side of the first iteration is
$
  (Q-1.2A)x^((0))+1.2b
  &= mat(-0.8,1.2,0;0,-0.8,1.2;0,0,-0.6)mat(0;1;0)+1.2mat(2;6;1) \
  &= mat(1.2;-0.8;0)+mat(2.4;7.2;1.2)=mat(3.6;6.4;1.2).
$
Solving $Q x^((1))=(3.6,6.4,1.2)^T$ by forward substitution gives
$
  4x_1^((1))=3.6 & arrow.r.double x_1^((1))=0.9, \
  -1.2(0.9)+4x_2^((1))=6.4 & arrow.r.double x_2^((1))=1.87, \
  -1.2(1.87)+3x_3^((1))=1.2 & arrow.r.double x_3^((1))=1.148.
$

*3. Comparison and conclusion*

Both computations give $x^((1))=(0.9,1.87,1.148)^T$.
Their agreement verifies the result for this example. More generally, substituting
$Q=D+omega L$ and $A=D+L+U$ into the matrix scheme yields
$
  (D+omega L)x^((k+1))=lr([(1-omega)D-omega U])x^((k))+omega b.
$
Its $i$th row, solved for $x_i^((k+1))$, is exactly the componentwise SOR
formula. Thus, the two formulations describe the same iteration.