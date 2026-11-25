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

// TITLE PAGE
#page(numbering: none)[
  
  #align(center)[
    #v(4em)
    #title[CLASS NOTES]
    #align(center)[
      #set text(size: 20pt) 
      #v(-1em)
      *- Direct Methods -*
    ]
    
    #v(-0.5em)
    #align(center)[
      #set text(size: 12pt)
    
      Kim Cruz, Lozano Cruz, Kevin Pagatpatan,
      \ Chloe Santos, Russ Sison, Sean Tolentino, Nate Zuñiga
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
  ]
  

  #pagebreak()
  #line(length: 100%)
  #text(size: 16pt, weight: "bold")[Contents]
  #v(0.25em)
  
  #text(weight: "bold")[I. Introduction]
  #table_of_contents-subitem[Systems of Algebraic Linear Equations][3]
  #table_of_contents-subitem[Matrix and Vector Representation][4]
  #table_of_contents-subitem[Existence and Uniqueness of Solutions][4]
  #table_of_contents-subitem[Fundamentals of Vector Norms][5]
  #table_of_contents-subitem[Matrix Conditioning and Error Analysis][7]
  
  #v(0.5em)
  
  #text(weight: "bold")[II. Direct Methods for Systems of Linear Equations]
  #table_of_contents-subitem[Introduction to Direct Methods][10]
  #table_of_contents-subitem[Elementary Row Operations][10]
  #table_of_contents-subitem[Gaussian Elimination][11]
  #table_of_contents-subitem[Gauss-Jordan Elimination][12]
  #table_of_contents-subitem[Pivoting Strategies for Gaussian Elimination][14]
  
  #v(0.5em)
  
  #text(weight: "bold")[III. End Matter]
  #table_of_contents-subitem[Contribution Log][24]
  #table_of_contents-subitem[References][25]

]
// END TITLE PAGE

// ============================================================
// 1. OVERVIEW
// TODO: edit overview
// ============================================================
= Overview

This sub-arc (POTW1) covers the foundations and direct methods used for solving systems of linear equations. It begins with the representation and properties of linear systems, including vector and matrix norms, conditioning, and error analysis. It then develops Gaussian elimination and Gauss-Jordan reduction, together with pivoting strategies for improving numerical stability.



// ============================================================
// Lecture 0
// ============================================================

= Lecture 0: Introduction to Systems of Linear Equations (SLEs)

== Systems of Algebraic Linear Equations
=== Algebraic Standard Form
#definition(title: "Linear Equation")[
  A *linear equation* in the variables $x_1, dots, x_n$ (degree of 1) is written in the form:
  $ a_1 x_1 + a_2 x_2 + dots + a_n x_n = b $
  The constant $b$ and the coefficients $a_1, dots, a_n$ are real or complex numbers. The subscript $n$ may be any positive integer, typically ranging from 2 to 5 for textbook problems, and much larger for real-life computational problems.
]

#example(number: "1")[
  *Linear vs. Non-Linear Equations* \
  Equations are linear if they can be algebraically rearranged into the standard form.
  - *Linear:* 
    $ x_1 + 4x_2 - 6x_3 = x_3 - 7 \
      x_2 + x_3 = 2(x_1 + sqrt(6)) - 5x_4 $
    _(These rearrange to $x_1 + 4x_2 - 7x_3 = -7$ and $-2x_1 + x_2 + x_3 + 5x_4 = 2 sqrt(6)$)_
  
  - *Non-Linear:* 
    $ x_1 = sqrt(x_2) - 6x_3 \
      7x_1 + 5x_2 = x_1 x_2 $
    _(These fail due to the non-linear terms $sqrt(x_2)$ and $x_1 x_2$)_
]

#definition(title: "Systems of Linear Equations")[
  A *linear system* is a collection of one or more linear equations involving the same variables:
  $ a_(11) x_1 + a_(12) x_2 + dots.c + a_(1n) x_n &= b_1 \
    a_(21) x_1 + a_(22) x_2 + dots.c + a_(2n) x_n &= b_2 \
    &dots.v \
    a_(n 1) x_1 + a_(n 2) x_2 + dots.c + a_(n n) x_n &= b_n $
  
  - *Solution:* A list of numbers $(s_1, s_2, dots, s_n)$ that makes every equation in the system true when substituted for $x_1, x_2, dots, x_n$.
  - *Solution Set:* The set of all possible solutions to a given system.
  - *Equivalent Systems:* Two linear systems are considered equivalent if they share the exact same solution set.
]

#example(number: "2")[
  The coordinate list $(1, 2)$ is a valid solution to the following system because $2(1) + (2) = 4$ and $(1) - 7(2) = -13$:
  $ 2x_1 + x_2 = 4 \
    x_1 - 7x_2 = -13 $
]

#remark[
  If you take a system of two linear equations in two variables, the solution set geometrically represents the intersection of two lines on a graph. A linear system falls into one of three cases:
  1. *No solution* (parallel lines).
  2. *Exactly one solution* (intersecting at a single point).
  3. *Infinitely many solutions* (coinciding lines).
  
  A system is classified as *consistent* if it has a solution (one or infinitely many) and *inconsistent* if it has none.
]

=== Matrix and Vector Representation
The essential information of a linear system can be compactly recorded in a rectangular array called a matrix, which simplifies calculations and provides a useful representation for computational purposes.

$ mat(delim: "[",
  a_(11), a_(12), dots.c, a_(1n);
  a_(21), a_(22), dots.c, a_(2n);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), dots.c, a_(n n)
)
mat(delim: "[", x_1; x_2; dots.v; x_n)
=
mat(delim: "[", b_1; b_2; dots.v; b_n) $

This is often expressed more simply as the matrix equation: $A x = b$.

#definition(title: "Matrix Definitions")[
  - *Size of a Matrix:* Indicates how many rows and columns it has ($m times n$). The number of rows is always listed first.
  - *Coefficient Matrix:* A matrix containing only the coefficients of the variables, aligned in columns.
  - *Augmented Matrix:* Denoted as $[A | b]$, it consists of the coefficient matrix with an added final column containing the constant vector $b$.
]

#example(number: "3")[
  *Matrix Formulation*
  Given the following linear system:
  $ x_1 - 2x_2 + x_3 = 0 \
    2x_2 - 8x_3 = 8 \
    5x_1 - 5x_3 = 10 $
  
  The *Coefficient Matrix* is a $3 times 3$ array:
  $ mat(delim: "[",
    1, -2, 1;
    0, 2, -8;
    5, 0, -5
  ) $
  
  The *Augmented Matrix* is a $3 times 4$ array:
  $ mat(delim: "[",
    1, -2, 1, 0;
    0, 2, -8, 8;
    5, 0, -5, 10
  ) $
]

=== Existence and Uniqueness of Solutions
To determine the nature of the solution set for a particular linear system, we must ask two fundamental questions:
1. Is the system consistent; that is, does at least one solution exist?
2. If a solution exists, is it the only one; that is, is the solution unique?

#theorem(title: "Singularity and the Coefficient Matrix")[
  A system of $n$ linear equations in $n$ unknowns has a unique solution provided that the determinant of the coefficient matrix is nonsingular, meaning $|A| != 0$. The rows and columns of a nonsingular matrix are linearly independent.
  
  If the coefficient matrix is singular, the equations may have an infinite number of solutions, or no solutions at all, depending on the constant vector $b$:
  
  #align(center)[
    #table(
      columns: 4,
      fill: (col, row) => if row == 0 { luma(230) } else { none },
      align: center,
      [*Matrix* $A$], [*Constant Vector* $b$], [*Solution Set*], [*Inverse* $A^(-1)$],
      [*Nonsingular* ($||A|| != 0$)], [Arbitrary vector], [Exactly One], [Exists],
      [*Singular*], [$b in "span"(A)$], [Infinitely Many], [Does not exist],
      [*Singular*], [$b in.not "span"(A)$], [None], [Does not exist]
    )
  ]
]

#remark[
  When converting an augmented matrix into triangular form via row operations, the resulting equations reveal the system's consistency:
  - *Unique Solution:* Each variable can be uniquely determined via back-substitution.
  - *Infinite Solutions:* One equation is simply a multiple of another. The number of combinations satisfying both is infinite.
  - *Inconsistent (No Solution):* The row operations result in a built-in contradiction, such as a row translating to $0 = 15$. Because $0x_1 + 0x_2 + 0x_3 = 15$ is never true, no values satisfy the system.
]

== Fundamentals of Vector Norms
  
    In $RR^n$, a vector norm is a function that maps a vector to a real non-negative value, representing "length" or "magnitude".
    A vector norm is a function 
    $ norm(dot) : RR^n -> RR $
    that satisfies the following axioms for all vectors $x, y in RR^n$ and scalars $alpha in RR$

  -  *Positivity:* $norm(bold(x)) >= 0$, and $norm(bold(x)) = 0$ if and only if $bold(x) = bold(0)$.
  -  *Scalar Multiplicity (Homogeneity):* $norm(alpha bold(x)) = abs(alpha) norm(bold(x))$.
  -  *Triangle Inequality:* $norm(bold(x) + bold(y)) <= norm(bold(x)) + norm(bold(y))$.

  === Standard $l_p$ Norms
  - *General formula*: $norm(x)_p = (sum abs(x_i)^p)^(1/p)$
  - $l_1$ *Norm (Manhattan):* $norm(bold(x))_1 = sum_(i=1)^n |x_i|$.
  - $l_2$ *Norm (Euclidean):* $norm(bold(x))_2 = (sum_(i=1)^n x_i^2)^(1/2)$.
  - $l_oo$ *Norm (Maximum):* $norm(bold(x))_oo = max_(1 <= i <= n) |x_i|$.

  === Cauchy-Schwarz Inequality: $abs(bold(x)^T bold(y)) <= norm(bold(x))_2 norm(bold(y))_2$

  === Norm Equivalence
  - All norms are equivalent in finite-dimensional spaces (such as $RR^n$)
  - If a. sequence of vectors converges in one norm, it converges in all others
  - For $x in RR^n$:
    - $norm(bold(x))_oo <= norm(bold(x))_2 <= sqrt(n) norm(bold(x))_oo$
    - $norm(bold(x))_oo <= norm(bold(x))_1 <= n norm(bold(x))_oo$
    - $1/sqrt(n) norm(bold(x))_1 <= norm(bold(x))_2 <= norm(bold(x))_1$

== Axiomatic Definition of Matrix Norms
  To be considered a valid matrix norm, the function must satisfy five axioms: 
  - $norm(A) >= 0$
  - $norm(A) = 0$ if and only if $A = 0$ (the zero matrix).
  - $norm(alpha A) = abs(alpha) norm(A)$
  - $norm(A + B) <= norm(A) + norm(B)$ (Triangle Inequality)
  - $norm(A B) <= norm(A) norm(B)$ (Consistency Property or Submultiplicativity)  

== Induced Matrix Norms and Fundamental Inequalities
A natural or induced matrix norm is derived directly form a corresponding vector norm
 === Induced norm
 Represets the maximum magnification that the linear transformation $A$ can apply to any vector at the unit sphere
 $ norm(A) = max_(norm(bold(x))=1) norm(A bold(x)) $

 === Inequality
 Used to bound error propagation 
 $ norm(A bold(x)) <= norm(A) norm(bold(x)) $

 === Spectral Radius
 The spectral radius $rho(A)$ is the maximum absolute value of the eigenvalues of $A$. For any $norm(dot)$, the following is the lower bound:
  $ rho(A) <= norm(A) $

=== Spectral Radius and Convergence
  A matrix $A$ is convergent if 
  $
  lim_(k -> oo) A^k = 0 "iff" rho(a)<1
  $

== Key Matrix Norms

#table(
  columns: 3,
  align: (left, center, left),
  [*Max Row Sum*],
  [$norm(A)_oo$],
  [$max_(1 <= i <= n) sum_(j=1)^n |a_(i j)|$],

  [*Max Column Sum*],
  [$norm(A)_1$],
  [$max_(1 <= j <= n) sum_(i=1)^n |a_(i j)|$],

  [*Spectral Norm*],
  [$norm(A)_2$],
  [
    $sqrt(rho(A^T A))$ \
    Induced by $l_2$. For symmetric $A$, $norm(A)_2 = rho(A)$.
  ],

  [*Frobenius Norm*],
  [$norm(A)_F$],
  [
    $sqrt(sum_(i=1)^n sum_(j=1)^n a_(i j)^2)$ \
 
  ]
)

== Matrix Conditioning and Error Analysis

There are SLEs $bold(A)arrow(x) = arrow(b)$ where the residual vector's norm $||arrow(r)||$ grows very slowly relative to $||arrow(x)-tilde(x)||$. Take the following SLE. For example:
$
x_1+2x_2=3
$
$
1.0001x_1+2x_2=3.0001
$
For this SLE, the exact value of $arrow(x)$ is $[1 space 1]^T$. If we have a bad approximate $tilde(x) = [3 space -0.0001]^T$, the residual vector would be $[0.0002 space 0]^T$, but $||arrow(x) - tilde(x)|| = 2$, which would not be an acceptable solution difference. Working with such SLEs using computers would be very problematic due to potential rounding errors in how a provided algorithm approaches the values involved becoming significantly magnified once an approximate solution is computed.

The condition number serves as a measure to check whether an approximate solution yields a small enough error assuming that its residual vector is also small. For matrices, this is its definition:

#definition(title: "Matrix condition number")[
Let $A$ be a nonsingular matrix and \ $||dot||$ be a matrix norm. The condition number $kappa$ is defined as
$
kappa(A) = ||A|| dot ||A^(-1)||
$ 
]
The matrix is ill-conditioned if $kappa(A) >> 1$.

We also have the following inequality for a nonsingular matrix $A$, a natural norm $||dot||$, and a residual vector $arrow(r)$:

#theorem(title: "Condition Number Error Bound")[
Let $arrow(x)$ be the exact solution of the SLE $A bold(x) = arrow(b)$, $tilde(x)$ an approximate solution, and $arrow(r)$ be the residual vector. Then,
$
(||arrow(x) - tilde(x)||)/(||arrow(x)||) <= kappa(A) (||arrow(r)||)/(||arrow(b)||)
$
Proof:

- (Application of submultiplicity property): $||arrow(x) - tilde(x)|| = ||A^(-1)arrow(r)|| <= ||A^(-1)|| dot ||arrow(r)||$
- (Application of submultiplicity property): 
$
arrow(b) = A arrow(x) \ ||arrow(b)|| = ||A arrow(x)|| \ ||arrow(b)|| <= ||A|| dot ||arrow(x)|| \ 1/(||arrow(x)||) <= (||A||) / (||b||)
$
- Combining the two inequalities we have
$
(||arrow(x) - tilde(x)||)/(||arrow(x)||) <= (||A^(-1)|| dot ||arrow(r)||)((||A||) / (||b||)) \ (||arrow(x) - tilde(x)||)/(||arrow(x)||) <= kappa(A) (||arrow(r)||)/(||arrow(b)||)
$ which is what we wanted to show. 
]
This inequality shows how an SLE's condition number affects the worst-case relative error of an approximate solution. 

#theorem(title: "CNEB with Perturbations")[Consider the SLE $A bold(x) = bold(b)$, where $A$ is nonsingular. Let $delta bold(x)$, $delta bold(b)$, and $delta A$ be perturbations on $bold(x)$ and $bold(b)$, and $A$, respectively. Then, 

$
(norm(delta bold(x))) / (norm(bold(x))) <= (kappa(A)) / (1 - kappa(A) (norm(delta A)) / (norm(A))) ( (norm(delta bold(b))) / (norm(bold(b))) + (norm(delta A)) / (norm(A)) )
$

Proof: 

After introducing said perturbations, we end up with the following system:
$
(A + delta A)(bold(x) + delta bold(x)) = bold(b) + delta bold(b) \ A bold(x) + A delta bold(x) + delta A bold(x) + delta A delta bold(x) = bold(b) + delta bold(b)
$

Since $A bold(x) = bold(b)$, we can cancel those terms in the equation:
$
A delta bold(x) = delta bold(b) - delta A(bold(x) - delta bold(x))
$
Multiplying both sides by $A^(-1)$,
$
delta bold(x) = A^(-1)(delta bold(b) - delta A(bold(x) - delta bold(x)))
$

Applying matrix norm properties,

$
norm(delta bold(x)) = norm(A^(-1)(delta bold(b) - delta A(bold(x) - delta bold(x)))) \
norm(delta bold(x)) <= ||A^(-1)|| dot norm((delta bold(b) - delta A(bold(x) - delta bold(x)))) \
norm(delta bold(x)) <= ||A^(-1)|| dot (norm(delta bold(b)) + norm(delta A (bold(x) - delta bold(x)))) \
norm(delta bold(x)) <= ||A^(-1)|| dot (norm(delta bold(b)) + norm(delta A) dot (norm(bold(x)) + norm(delta bold(x)))) \
norm(delta bold(x)) <= norm(A^(-1)) dot norm(delta bold(b)) + norm(A^(-1)) dot norm(delta A) dot norm(bold(x)) + norm(A^(-1)) dot norm(delta A) dot norm(delta bold(x))
$

Isolating $delta bold(x)$ and expressing matrix norms in terms of $kappa(A)$,
$
norm(delta bold(x)) (1 - norm(A^(-1)) dot norm(delta A)) <=norm(A^(-1))(norm(delta bold(b)) + norm(delta A) dot norm(bold(x))) \ 
norm(delta bold(x)) <= (kappa(A)(norm(delta bold(b)) + norm(delta A) dot norm(bold(x))))/(norm(A)(1 - kappa(A)norm(delta A)/norm(A)))
$

Multiplying both sides by $norm(bold(x))$ and simplifying,

$
norm(delta bold(x))/norm(bold(x)) <= (kappa(A)(norm(delta bold(b))/norm(bold(x)) + norm(delta A)))/(norm(A)(1 - kappa(A)norm(delta A)/norm(A))) \ 
norm(delta bold(x))/norm(bold(x)) <= kappa(A)/(1 - kappa(A)norm(delta A)/norm(A))(norm(delta bold(b))/(norm(bold(x)) dot norm(A)) + norm(delta A)/norm(A))
$

note that $norm(bold(b)) <= norm(A) dot norm(x)->1/(norm(A) dot norm(x)) <= 1/norm(bold(b))$, so we have 
$
norm(delta bold(x))/norm(bold(x)) <= kappa(A)/(1 - kappa(A)norm(delta A)/norm(A))(norm(delta bold(b))/(norm(bold(b))) + norm(delta A)/norm(A))
$
which is what we wanted to show.
]

#pagebreak()
// ============================================================
// Lecture 1
// ============================================================
= Lecture 1: Gaussian Elimination, Gauss-Jordan Reduction, Pivoting Strategies

== Introduction to Direct Methods
Solving systems of linear equations of the form $A x = b$ can be done directly or iteratively. Direct methods are ways to theoretically give the exact solution to the system in a finite number of steps.
#footnote[Burden & Faires, Numerical Analysis, 9th ed., Sec. 6 “Direct Methods for Solving Linear Equations,” pp. 358]
The following are some examples of direct methods and how they manipulate $A x = b$ into a form that is easier to obtain a solution from:

#align(center)[
  #table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    table.header([*Method*], [*Initial Form*], [*Final Form*]),
    [Gaussian Elimination], [$A x = b$], [$U x = c$],
    [Gauss-Jordan Reduction], [$A x = b$], [$I x = c$],
    [LU Decomposition], [$A x = b$], [$L U x = b$],
  )
]

To transform these matrices without changing the system's original solution, direct methods rely on elementary row operations to simplify them.

== Elementary Row Operations
When dealing with systems of linear equations, we use a sequence of elementary row operations to systematically transform them into a new linear system that is more easily solved whilst maintaining the same solution.
#footnote[Burden & Faires, Numerical Analysis, 9th ed., Sec. 6.1 “Linear Systems of Equations,” p. 358]

#definition(title: "Elementary Row Operations")[
  Elementary row operations are basic matrix manipulations that do not alter the solution set of the corresponding system of linear equations.
  
  - *EO1:* Exchanging two equations ($R_i <-> R_j$)
  - *EO2:* Multiplying an equation by a non-zero constant ($R_i <- c R_i$)
  - *EO3:* Multiplying an equation by a non-zero constant and then subtracting it from another equation ($R_i <- R_i - c R_j$)
]

While elementary row operations don't affect the solution of a linear system, they are able to modify the determinant of $A$, depending on the operation being performed.
- *EO1:* Changes the sign of $det(A)$
- *EO2:* Multiplies $det(A)$ by the non-zero constant $c$
- *EO3:* Leaves $det(A)$ unchanged

== Gaussian Elimination
The Gaussian Elimination method involves converting the augmented matrix $[A | b]$ into an upper triangular matrix $[U | c]$ using elementary row operations. This process involves two phases for conversion:

1. *Elimination Phase* for converting the matrix into its upper triangular form.
2. *Back Substitution Phase* for obtaining the solution $x$.

*Elimination Phase:*
The elimination phase focuses on converting the augmented matrix $[A | b]$ into an upper triangular matrix $[U | c]$:

$
[A | b] =
mat(
  delim: "[",
  augment: #5,
  a_11, a_12, ..., a_(1, n-1), a_(1n), b_1;
  a_21, a_22, ..., a_(2, n-1), a_(2n), b_2;
  a_31, a_32, ..., a_(3, n-1), a_(3n), b_3;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  a_(n 1), a_(n 2), ..., a_(n, n-1), a_(n n), b_n
)
=>
[U | c] =
mat(
  delim: "[",
  augment: #5,
  a_11, a_12, ..., a_(1, n-1), a_(1n), c_1;
  0, a_22, ..., a_(2, n-1), a_(2n), c_2;
  0, 0, ..., a_(3, n-1), a_(3n), c_3;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  0, 0, ..., 0, a_(n n), c_n
)
$

In order to reduce the entries below the main diagonal of matrix $A$ to zero, we make use of the EO3 operation. Specifically, we subtract a scalar multiple $gamma$ of the pivot row $k$ from each non-pivot row $i$ (where $i > k$):

$ R_i <- R_i - gamma R_k, quad gamma = a_(i k) / a_(k k) $

Doing this, we guarantee that entries below the pivot $a_(k k)$ are reduced to zero, giving us a new augmented matrix $[U | c]$.

#remark[
  Note that in cases where the pivot $a_(k k) = 0$, the multiplier $gamma$ cannot be computed due to division by zero. As such, row swapping techniques such as partial pivoting, which involve swapping the current row $R_k$ with a row $R_i$ (where $i > k$) that contains a non-zero entry for column $k$, must be used.
]

*Back Substitution Phase:*
Once the augmented matrix $[A | b]$ has been converted into an upper triangular matrix $[U | c]$, the system can be solved in reverse order (from row $n$ to row $1$).

Given a linear system $[U | c]$, we can expand it into the form $U x = c$:

$
[U | c] =
mat(
  delim: "[",
  augment: #5,
  a_11, a_12, ..., a_(1, n-1), a_(1n), c_1;
  0, a_22, ..., a_(2, n-1), a_(2n), c_2;
  0, 0, ..., a_(3, n-1), a_(3n), c_3;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  0, 0, ..., 0, a_(n n), c_n
)
=>
mat(
  delim: "[",
  a_11, a_12, ..., a_(1, n-1), a_(1n);
  0, a_22, ..., a_(2, n-1), a_(2n);
  0, 0, ..., a_(3, n-1), a_(3n);
  dots.v, dots.v, dots.down, dots.v;
  0, 0, ..., 0, a_(n n)
)
mat(
  delim: "[",
  x_1; x_2; x_3; dots.v; x_n
)
=
mat(
  delim: "[",
  c_1; c_2; c_3; dots.v; c_n
)
$

where we can see each individual algebraic expression as follows:

$
a_11 x_1 + a_12 x_2 + dots.h + a_(1, n-1) x_(n-1) + a_(1n) x_n &= c_1 \
a_22 x_2 + dots.h + a_(2, n-1) x_(n-1) + a_(2n) x_n &= c_2 \
&dots.v \
a_(n n) x_n &= c_n
$

Starting at the lowest row $n$, we see that the equation contains only one unknown $x_n$, which can be easily solved by:

$ a_(n n) x_n = c_n => x_n = c_n / a_(n n) $

By continuing this process as we move up in each row $i$ (where $i = n-1, n-2, ..., 1$), we subtract all the previously computed $x_j$ values (where $j > i$) from $c_i$. This gives us the general formula:

$ x_i = 1 / a_(i i) (c_i - sum_(j=i+1)^n a_(i j) x_j) quad "for" i = n, n-1, ..., 1 $

Combining both the elimination and back substitution phases, the complete procedure can be summarized into the following general algorithm:

#definition(title: "Gaussian Elimination")[
  To solve a system $A x = b$ of size $n times n$ using Gaussian Elimination:

  1. *Form the Augmented Matrix:* Construct $[A | b]$.

  2. *Forward Elimination Phase:*
     For $k = 1, 2, ..., n - 1$:
     - Select pivot $a_(k k)$. If $a_(k k) = 0$, swap row $k$ with row $i$ ($i > k$) where $a_(i k) != 0$ (Partial Pivoting).
     - For each row $i = k + 1, k + 2, ..., n$:
       - Calculate multiplier: $gamma = a_(i k) / a_(k k)$
       - Perform row operation: $R_i <- R_i - gamma R_k$

  3. *Back Substitution Phase:*
     - Compute $x_n = c_n / a_(n n)$.
     - For $i = n - 1, n - 2, ..., 1$:
       $ x_i = 1 / a_(i i) (c_i - sum_(j=i+1)^n a_(i j) x_j) $
]
== Gauss-Jordan Elimination
Gauss-Jordan elimination serves as an extension to the aforementioned Gaussian elimination; however, instead of stopping at some $[U | c]$, we continue to eliminate the upper triangular matrix to leave an identity matrix $[I | x]$ using elementary row operations.

Gauss-Jordan utilizes both forward elimination to obtain $[U | c]$ from $[A | b]$, then performing backward elimination to obtain $[I | x]$ from $[U | c]$ 
#footnote[Burden & Faires, _Numerical Analysis_, 9th ed., Sec. 6 "Direct Methods for Solving Linear Systems," p. 370.]. 
These methods utilize the same aforementioned elementary row operations introduced under Gaussian elimination, as well as following the determinant changes per elementary row operation performed.

*Forward Elimination:*
The forward elimination phase is more or less the same as the elimination phase in Gaussian Elimination, using elementary row operations to eliminate all entries below the pivot.

$
[A | b] =
mat(
  delim: "[",
  augment: #5,
  a_11, a_12, ..., a_(1, n-1), a_(1n), b_1;
  a_21, a_22, ..., a_(2, n-1), a_(2n), b_2;
  a_31, a_32, ..., a_(3, n-1), a_(3n), b_2;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  a_(n 1), a_(n 2), ..., a_(n, n-1), a_(n n), b_n
)
=>
[U | c] =
mat(
  delim: "[",
  augment: #5,
  a_11, a_12, ..., a_(1, n-1), a_(1n), c_1;
  0, a_22, ..., a_(2, n-1), a_(2n), c_2;
  0, 0, ..., a_(3, n-1), a_(3n), c_2;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  0, 0, ..., 0, a_(n n), c_n
)
$

*Backward Elimination:*
Then, instead of immediately performing back substitution, Gauss-Jordan continues applying elementary row operations to eliminate all entries above each pivot.

Starting from the last pivot and moving upward:

$
[U | c] =
mat(
  delim: "[",
  augment: #5,
  a_11, a_12, ..., a_(1, n-1), a_(1n), c_1;
  0, a_22, ..., a_(2, n-1), a_(2n), c_2;
  0, 0, ..., a_(3, n-1), a_(3n), c_3;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  0, 0, ..., 0, a_(n n), c_n
)
=>
[I | x]
=
mat(
  delim: "[",
  augment: #5,
  1, 0, ..., 0, 0, x_1;
  0, 1, ..., 0, 0, x_2;
  0, 0, ..., 1, 0, x_(n-1);
  dots.v, dots.v, dots.down, dots.v, dots.v;
  0, 0, ..., 0, 1, x_n
)
$

After all entries above the pivots have been eliminated, the matrix has the form $[I | x]$. Then, the solution can then be read directly from the augmented column.

*Summary:*
Therefore, we may conclude the differences of Gaussian Elimination and Gauss-Jordan Elimination as follows:

#align(center)[
  #table(
    columns: (auto, auto),
    align: (left, left),
    table.header([*Gaussian Elimination*], [*Gauss-Jordan Elimination*]),
    [Eliminate below pivots], [Eliminate above and below pivots],
    [Stops at $U$], [Reduces $U$ to $I$],
    [Requires back substitution], [No need for back substitution],
  )
]

#pagebreak()

// ============================================================
// PIVOTING STRATEGIES
// ============================================================

== Pivoting Strategies for Gaussian Elimination


// ============================================================
// NUMERICAL MOTIVATION
// ============================================================

=== Numerical Motivation for Pivoting

During Gaussian elimination, the diagonal entry
$a_(k k)^((k))$ used at elimination stage $k$ is called the
*pivot*. To eliminate an entry $a_(i k)^((k))$ below the pivot,
we compute the multiplier

$ m_(i k)
  = frac(a_(i k)^((k)), a_(k k)^((k))) $

and perform the row operation

$ R_i arrow.r.double R_i - m_(i k) R_k. $

Equivalently, the corresponding coefficient update is

$ a_(i j)^((k+1))
  = a_(i j)^((k))
  - m_(i k) a_(k j)^((k)). $

Since the pivot appears in the denominator of the multiplier,
its value directly affects the elimination process.

A poor choice of pivot can cause numerical problems:

- A *zero pivot* makes the multiplier undefined.
- A *very small pivot* can produce a large multiplier, which may
  magnify rounding errors in finite-precision arithmetic.

For this reason, Gaussian elimination commonly uses *pivoting* to
select a more suitable element before carrying out an elimination
step.


==== Breakdown Due to Zero Pivots

Suppose that, at elimination stage $k$,

$ a_(k k)^((k)) = 0. $

Then the multiplier

$ m_(i k)
  = frac(a_(i k)^((k)), a_(k k)^((k))) $

would require division by zero.

However, a zero pivot does not necessarily mean that the matrix is
singular. If a nonzero entry exists below the pivot in the same
column, a row interchange can move that entry into the pivot
position.

#example[
  Consider

  $
  A = mat(
    0 & 1;
    2 & 3
  ).
  $

  The first diagonal entry is zero, but the entry below it is
  nonzero. Interchanging the rows,

  $
  R_1 <-> R_2,
  $

  gives

  $
  A = mat(
    2 & 3;
    0 & 1
  ).
  $

  Gaussian elimination can now continue using $2$ as the first
  pivot.
]

Thus, pivoting allows Gaussian elimination to continue when the
natural diagonal entry cannot be used as a pivot.


==== Effects of Small Pivots on Numerical Error

A pivot may be nonzero but still be numerically unfavorable.

Suppose

$ |a_(k k)^((k))|
  << |a_(i k)^((k))|. $

Since

$ |m_(i k)|
  = frac(
      |a_(i k)^((k))|,
      |a_(k k)^((k))|
    ), $

a pivot that is very small relative to the entry being eliminated
can produce

$ |m_(i k)| >> 1. $

The multiplier determines how much of the pivot row is subtracted
from another row. Therefore, a large multiplier can also enlarge
rounding errors already present in the pivot row.

Pivoting consequently serves two related purposes:

- avoiding unusable zero pivots, and
- reducing the numerical problems associated with very small
  pivots.


==== General Pivoting Framework

#definition(title: [Pivoting])[
  Pivoting is the process of rearranging rows and, for some
  strategies, columns during Gaussian elimination so that a more
  suitable element occupies the current pivot position.
]

The main pivoting strategies considered here differ in where they
search for the pivot and how they compare the available candidates:

- *Partial pivoting:* chooses the largest-magnitude entry in the
  current pivot column.

- *Complete (full) pivoting:* chooses the largest-magnitude entry
  in the entire remaining submatrix.

- *Scaled partial pivoting:* chooses the entry with the largest
  magnitude relative to its row scale.


// ============================================================
// PARTIAL PIVOTING
// ============================================================

=== Gaussian Elimination with Partial Pivoting

==== Pivot Selection Criterion

At elimination stage $k$, partial pivoting searches the entries in
column $k$ from rows $k$ through $n$.

The pivot row $p$ is chosen as

$ p
  = arg max_(k <= i <= n)
    |a_(i k)^((k))|. $

Equivalently,

$ |a_(p k)^((k))|
  = max_(k <= i <= n)
    |a_(i k)^((k))|. $

If $p != k$, rows $p$ and $k$ are interchanged so that the selected
entry occupies the pivot position $(k, k)$.

Since only rows are exchanged, partial pivoting changes the order
of the equations but does not change the order of the unknowns.


==== Bound on the Elimination Multipliers

After the row interchange, the selected pivot has the largest
absolute value among the eligible entries in the current pivot
column.

Therefore, for every $i > k$,

$ |a_(i k)^((k))|
  <= |a_(k k)^((k))|. $

The elimination multiplier is

$ m_(i k)
  = frac(
      a_(i k)^((k)),
      a_(k k)^((k))
    ). $

Taking absolute values gives

$ |m_(i k)|
  = frac(
      |a_(i k)^((k))|,
      |a_(k k)^((k))|
    )
  <= 1. $

Hence,

$ |m_(i k)| <= 1. $

Thus, partial pivoting prevents the large multipliers that can
occur when a very small entry is used as the pivot. This helps
reduce the amplification of rounding errors during elimination.


==== Computational Procedure

For each elimination stage $k = 1, 2, ..., n - 1$:

+ *Pivot selection:* Find the row

  $ p
    = arg max_(k <= i <= n)
      |a_(i k)^((k))|. $

+ *Row interchange:* If $p != k$, interchange

  $ R_p <-> R_k. $

  The corresponding entries of the right-hand side vector $b$
  must also be interchanged.

+ *Multiplier:* For each $i = k + 1, ..., n$, compute

  $ m_(i k)
    = frac(
        a_(i k)^((k)),
        a_(k k)^((k))
      ). $

+ *Elimination:* Perform

  $ R_i arrow.r.double R_i - m_(i k) R_k. $

+ Continue to the next elimination stage.

After all elimination stages have been completed, solve the
resulting upper-triangular system using back substitution.


==== Matrix Factorization with Row Permutations

The row interchanges introduced by partial pivoting can be
represented by a permutation matrix $P$.

With the row permutations included, the factorization is written
as

$ P A = L U, $

where:

- $P$ records the row permutations,
- $L$ contains the elimination multipliers, and
- $U$ is the resulting upper-triangular matrix.

#remark[
  Without row interchanges, ordinary LU factorization is written
  $ A = L U $. Partial pivoting introduces the permutation matrix
  $P$ because the rows of $A$ may be reordered during
  elimination.
]


==== Limitations of the Partial Pivoting Criterion

Partial pivoting compares candidates only according to their
absolute values in the current pivot column.

It does not consider whether a candidate is large or small
relative to the other entries in its row.

#example[
  Consider the two rows

  $
  R_1 = [8, 10000, 20000],
  quad
  R_2 = [7, 8, 9].
  $

  Partial pivoting compares only the entries in the current pivot
  column and therefore chooses $R_1$, since

  $ 8 > 7. $

  However, relative to the largest entry in each row,

  $ frac(8, 20000) = 0.0004 $

  while

  $ frac(7, 9) approx 0.7778. $

  Although $8$ is larger than $7$ in absolute value, it is much
  smaller relative to the overall scale of its row.

  This motivates the use of scaled partial pivoting.
]


// ============================================================
// COMPLETE PIVOTING
// ============================================================

=== Gaussian Elimination with Complete Pivoting

==== Pivot Selection Criterion

Partial pivoting restricts its search to the current pivot column.
Complete pivoting instead searches the entire remaining, or
*active*, submatrix.

At elimination stage $k$, this active submatrix consists of rows
and columns $k$ through $n$.

The pivot position $(p, q)$ is chosen as

$ (p, q)
  = arg max_(k <= i, j <= n)
    |a_(i j)^((k))|. $

Equivalently,

$ |a_(p q)^((k))|
  = max_(k <= i, j <= n)
    |a_(i j)^((k))|. $

The selected entry is then moved into position $(k, k)$ using
row and/or column interchanges.


==== Row and Column Permutations

If $p != k$, interchange

$ R_p <-> R_k. $

A row interchange changes the order of the equations but does not
change the order of the unknowns.

If $q != k$, interchange

$ C_q <-> C_k. $

Unlike a row interchange, a column interchange changes the order
in which the unknowns are represented.

#example[
  Suppose columns $1$ and $3$ are interchanged.

  The original variable order is

  $
  mat(
    x_1;
    x_2;
    x_3
  ).
  $

  After the column interchange, the working variable order becomes

  $
  mat(
    x_3;
    x_2;
    x_1
  ).
  $

  The column permutation must therefore be recorded so that the
  computed solution can be restored to the original variable
  order after solving.
]


==== Bound on the Elimination Multipliers

Complete pivoting chooses the largest-magnitude entry in the
entire active submatrix.

After the necessary row and column interchanges, this entry becomes
the pivot $a_(k k)^((k))$.

Because it was the largest entry in the active submatrix,

$ |a_(i k)^((k))|
  <= |a_(k k)^((k))|,
  quad i > k. $

The elimination multiplier is

$ m_(i k)
  = frac(
      a_(i k)^((k)),
      a_(k k)^((k))
    ). $

Therefore,

$ |m_(i k)|
  = frac(
      |a_(i k)^((k))|,
      |a_(k k)^((k))|
    )
  <= 1. $

Hence,

$ |m_(i k)| <= 1. $

Complete pivoting therefore also prevents elimination multipliers
from exceeding $1$ in magnitude.


==== Computational Procedure

For each elimination stage $k = 1, 2, ..., n - 1$:

+ *Pivot selection:* Search the entire active submatrix and find

  $ (p, q)
    = arg max_(k <= i, j <= n)
      |a_(i j)^((k))|. $

+ *Row interchange:* If $p != k$, interchange

  $ R_p <-> R_k. $

  The corresponding entries of the right-hand side vector $b$
  must also be interchanged.

+ *Column interchange:* If $q != k$, interchange

  $ C_q <-> C_k. $

  Record the column permutation because it changes the working
  order of the unknowns.

+ *Multiplier:* For each $i = k + 1, ..., n$, compute

  $ m_(i k)
    = frac(
        a_(i k)^((k)),
        a_(k k)^((k))
      ). $

+ *Elimination:* Perform

  $ R_i arrow.r.double R_i - m_(i k) R_k. $

+ Continue to the next elimination stage.

After back substitution, use the recorded column permutations to
restore the unknowns to their original order.


==== Matrix Factorization with Row and Column Permutations

The row and column permutations introduced by complete pivoting
can be represented using permutation matrices $P$ and $Q$.

The resulting factorization is written as

$ P A Q = L U, $

where:

- $P$ records the row permutations,
- $Q$ records the column permutations,
- $L$ contains the elimination multipliers, and
- $U$ is upper triangular.

The additional column-permutation matrix $Q$ distinguishes
complete pivoting from partial pivoting.


==== Computational Cost of Pivot Selection

Complete pivoting searches a larger set of candidate entries than
partial pivoting.

At elimination stage $k$, partial pivoting examines at most

$ n - k + 1 $

entries in the current pivot column.

Complete pivoting may examine all

$ (n - k + 1)^2 $

entries in the active submatrix.

Thus, complete pivoting performs a more extensive search for a
pivot, but it requires additional comparisons, possible column
interchanges, and bookkeeping to track the reordered unknowns.


// ============================================================
// SCALED PARTIAL PIVOTING
// ============================================================

=== Gaussian Elimination with Scaled Partial Pivoting

==== Scaled Pivot Selection Criterion

Scaled partial pivoting accounts for the size of the entries in
each row.

For each row, define a scale factor $s_i$ as the largest absolute
entry in that row:

$ s_i = max_(1 <= j <= n) |a_(i j)|. $

The pivot row is then selected using the scaled magnitude:

$ p = arg max_(k <= i <= n)
    frac(|a_(i k)^((k))|, s_i). $

Thus, the pivot is selected based on its size relative to the
other entries in its row.


==== Computational Procedure

For each elimination stage $k = 1, 2, ..., n - 1$:

+ *Scale factors:* Before elimination begins, determine $s_i$ for
  every row:

  $ s_i = max_(1 <= j <= n) |a_(i j)|. $
  - _Take the largest absolute value per row $i$ as $s_i$_

+ *Pivot selection:* Find the row

  $ p
    = arg max_(k <= i <= n)
      frac(|a_(i k)^((k))|, s_i). $
  - _Find the row whose candidate pivot is largest compared to the size of that row_

+ *Row interchange:* If $p != k$, interchange

  $ R_p <-> R_k, quad s_p <-> s_k. $

  The scale factors must be interchanged along with the rows so
  that each scale factor stays matched with its row.
  - _Put the selected row in the pivot position and its scale factor with it_

+ *Multiplier:* For each $i = k + 1, ..., n$, compute

  $ m_(i k)
    = frac(
        a_(i k)^((k)),
        a_(k k)^((k))
      ). $
  - _Determine how much of the pivot row to use to eliminate each entry below the pivot_

+ *Elimination:* Perform

  $ R_i arrow.r.double R_i - m_(i k) R_k. $
  - _Take the pivot row and use the multipliers to eliminate their respective entries below the pivot point_

+ Continue to the next elimination stage.

After all elimination stages have been completed, solve the
resulting upper-triangular system using back substitution.
#footnote[Burden & Faires, _Numerical Analysis_, 9th ed., Sec. 6.2, pp. 375–376.]


==== Effect of Row Scaling on Pivot Selection

Partial pivoting compares candidate pivots using their absolute
magnitudes. Its weakness is that this can favor an entry that is
large in absolute terms but small compared with the other entries
in its row.

Scaled partial pivoting instead divides each candidate pivot by
its row scale factor $s_i$.

The largest entry in every row has scaled magnitude

$ frac(s_i, s_i) = 1. $

#example[
  Recall the two rows from the partial pivoting example:

  $
  R_1 = [8, 10000, 20000],
  quad
  R_2 = [7, 8, 9].
  $

  The scale factors are the largest absolute entry in each row:

  $ s_1 = 20000, quad s_2 = 9. $

  For the first pivot column, the candidate entries are $a_(11) = 8$
  and $a_(21) = 7$. Scaled partial pivoting compares these relative
  to their row scales:

  $ frac(|a_(11)|, s_1) = frac(8, 20000) = 0.0004, $

  $ frac(|a_(21)|, s_2) = frac(7, 9) approx 0.7778. $

  Since

  $ 0.7778 > 0.0004, $

  scaled partial pivoting selects $R_2$ as the pivot row, whereas
  ordinary partial pivoting would have selected $R_1$ based on
  absolute value alone. This shows how scaling corrects for a row
  whose entries are uniformly large but not well suited to serve
  as a pivot.
]

#remark[
  This makes scaled partial pivoting useful when the rows of a
  matrix have vastly different magnitudes, since it prevents a
  row's overall scale from unfairly dominating the pivot choice.
]


// ============================================================
// COMPARISON
// ============================================================

=== Comparative Analysis of Pivoting Strategies

The three pivoting strategies differ primarily in the region in
which they search for a pivot and the criterion used to compare
candidate entries.

#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    align: (left, left),

    table.header(
      [*Strategy*], [*Search Region*],
      [*Selection Criteria*],
      [*Interchanges*],
    ),

    [Partial pivoting],
    [Current pivot column],
    [Largest $|a_(i k)|$],
    [Rows only],

    [Complete pivoting],
    [Entire active submatrix],
    [Largest $|a_(i j)|$],
    [Rows and columns],

    [Scaled partial pivoting],
    [Current pivot column],
    [Largest $frac(|a_(i k)|, s_i)$],
    [Rows only],
  )
]

Partial pivoting requires a relatively small search because it
examines only the current pivot column. Complete pivoting expands
the search to the entire active submatrix, providing more
candidate pivots at the cost of additional comparisons and column
bookkeeping.

Scaled partial pivoting retains the column-based structure of
partial pivoting but modifies the selection criterion by comparing
each candidate with the scale of its corresponding row.

#remark[
  Pivoting changes the numerical behavior of the elimination
  procedure but does not change the underlying solution of the
  linear system. Any row or column permutations introduced during
  elimination must be accounted for when interpreting the final
  solution.
]
// ============================================================
// 5. INDIVIDUAL CONTRIBUTION LOG
// ============================================================
= Contribution Log

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  [*Name*], [*Contribution*],
  [Cruz, Kim], [Lecture 0, Systems of Algebraic Linear Equations],
  [Cruz, Lozano], [Lecture 0, Matrix Conditioning and Error Analysis],
  [Pagatpatan, Kevin], [Lecture 0, Matrix Norms],
  [Santos, Chloe], [Lecture 1, Pivoting Techniques],
  [Sison, Russ], [Lecture 1, Gauss-Jordan Elimination],
  [Tolentino, Sean], [Lecture 1, Gaussian Elimination],
  [Zuñiga, Nate], [Lecture 1, Pivoting Techniques],
)

#pagebreak()
// ============================================================
// REFERENCES
// ============================================================
= References

+ Burden and Faires. _Numerical Analysis_.
+ Edwards, Penney, and Calvis. _Differential Equations and Boundary Value Problems_.
+ Oxford Robotics Institute._Engineering Computation: Iterative Solution of Simultaneous Equations Ax=b_. Lecture Notes, University of Oxford, 2026, www.robots.ox.ac.uk/~sjrob/Teaching/EngComp/linAlg34.pdf.
+ Chapra and Canale. _Numerical Methods for Engineers_.
+ Lay, Lay, and McDonald. _Linear Algebra and Its Applications_. Pearson, 2021.
+ Kiusalaas. _Numerical Methods in Engineering with Python_. Cambridge University Press, 2013.