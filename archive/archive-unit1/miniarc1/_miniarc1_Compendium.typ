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

= Lecture 0: Introduction to Systems of Linear Equations (SLEs)
=== Systems of Linear Equations: Existence and Uniqueness - Kim Cruz

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
#pagebreak()
=== Matrix norms - Kevin Pagtapatan

==== Solved Problem #1
Source: Burden & Faires, Exercise Set 7.1, Exercise 4c

#problem[
  Consider the tridiagonal symmetric matrix:

  $A = mat(2, -1, 0; -1, 2, -1; 0, -1, 2)$
  
- Compute the $l_oo$ norm $||A||_oo$ (Maximum Row Sum Norm).
-  Compute the $l_1$ norm $||A||_1$ (Maximum Column Sum Norm).
- Compute the Frobenius norm $||A||_F$.
- Compute the $l_2$ spectral norm $||A||_2$.
]

1. * $l_oo$ Norm (Maximum Row Sum):*
   $
   "Row 1: " |2| + |-1| + |0| = 3 \
   "Row 2: " |-1| + |2| + |-1| = 4 \
   "Row 3: " |0| + |-1| + |2| = 3
   $
   #rect(
   $ ||A||_oo = max(3, 4, 3) = 4 $)

2. * $l_1$ Norm (Maximum Column Sum):*
   The column sums = row sums since $A$ is symmetric:
   #rect(
   $ ||A||_1 = max(3, 4, 3) = 4 $)

3. * Frobenius Norm $||A||_F$:*
   $
   ||A||_F &= sqrt(sum_(i=1)^3 sum_(j=1)^3 |a_(i j)|^2) \
           &= sqrt(2^2 + (-1)^2 + 0^2 + (-1)^2 + 2^2 + (-1)^2 + 0^2 + (-1)^2 + 2^2) \
           &= sqrt(4 + 1 + 0 + 1 + 4 + 1 + 0 + 1 + 4) = sqrt(12) \
           &=
           #rect($2 sqrt(3) approx 3.4641$)
   $

4. * $l_2$ Spectral Norm $||A||_2$:*
   Since $A$ is symmetric, $||A||_2 = rho(A)$. Solving $det(A - lambda I) = (2 - lambda)[(2 - lambda)^2 - 2] = 0$ yields eigenvalues:
   $ lambda_1 = 2, quad lambda_2 = 2 - sqrt(2), quad lambda_3 = 2 + sqrt(2) $

   #rect(
   $ ||A||_2 = rho(A) = 2 + sqrt(2) approx 3.4142$)


=== Solved Problem 2
Source: Burden & Faires, Exercise Set 7.1, Exercise 12

#problem[
  Let $S$ be a real and nonsingular matrix, and let $||.||$ be any norm on $RR^n$. Define $||.||'$ by $||bold(x)||' = ||S bold(x)||$. Show that $||.||'$ is also a norm on $RR^n$.
]


- $||A|| > 0$ if $A != 0$:
  For any $x != 0$, since S is nonsingular, $S x != 0$. Applying this property to $A = S x$ gives us $||x||' = ||S x|| > 0$. If $x = 0$, $S x = 0$, so $||0||' = ||S 0|| = 0$.

- $||alpha A|| = |alpha| . ||A||$ $forall alpha in RR$:
  For any scalar $alpha in RR$ and $x in RR^n$:
  $||alpha x||' = ||S(alpha x)|| = ||alpha (S x)|| = |alpha| . ||S x|| = |alpha| . ||x||'$

- $||A + B|| <= ||A|| + ||B||$:
  For any vectors $x, y in RR^n$:
  $||x + y||' = ||S(x + y)|| = ||S x + S y|| <= ||S x|| + ||S y|| = ||x||' + ||y||'$

- $||A B|| <= ||A|| . ||B||$:
  holds for matrix products under $||.||'$, since $||A B||' = ||S A B|| <= ||S A|| . ||B||$.

- $||A x|| <= ||A|| . ||x||$ $forall x in RR^n$:
  holds for matrix-vector products, since $||A x||' = ||S A x|| <= ||S A|| . ||x||$.

Therefore, $||.||'$ satisfies all required norm properties and is a valid norm on $RR^n$.

=== Remixed Problem

#problem[
  Let A be the symmetric tridiagonal matrix:
$ A = mat(2, -1, 0; -1, 2, -1; 0, -1, 2) $

and let S be the diagonal nonsingular scaling matrix:
$ S = mat(1, 0, 0; 0, 2, 0; 0, 0, 1) $

1. Norm Verification: Show that$ ||x||' = ||S x||_oo$ defines a valid vector norm on $RR^3$.
2. Original Matrix Norms: Compute the Frobenius norm $||A||_F$ and the $l_2$ spectral norm $||A||_2$.
]

1. Properties:

- $||A|| > 0$ if $A != 0$:
  For any $x != 0$, since $S$ is nonsingular, $S x != 0$. Applying this property gives us $||x||' = ||S x||_oo > 0$. If $x = 0$, $S x = 0$, so $||0||' = ||S 0||_oo = 0$.

- $||alpha A|| = |alpha| . ||A|| forall alpha in RR$:
  For any scalar $alpha in RR$ and $x in RR^3$:
  $ ||alpha x||' = ||S(alpha x)||_oo = ||alpha (S x)||_oo = |alpha| . ||S x||_oo = |alpha| . ||x||' $

- $||A + B|| <= ||A|| + ||B||$:
  For any vectors $x, y in RR^3$:
  $ ||x + y||' = ||S(x + y)||_oo = ||S x + S y||_oo <= ||S x||_oo + ||S y||_oo = ||x||' + ||y||' $

- $||A B|| <= ||A|| . ||B||$:
  Holds for matrix products under $||.||'$, since $||A B||' = ||S A B||_oo <= ||S A||_oo . ||B||_oo$.

- $||A x|| <= ||A|| . ||x|| forall x in RR^n$:
  Holds for matrix-vector products, since $||A x||' = ||S A x||_oo <= ||S A||_oo . ||x||$.

Therefore, $||.||'$ satisfies all required norm properties and is a valid norm on $RR^3$.

#pagebreak()

== Condition Number and Error Analysis - Lozano Cruz

== Solved Problem 1
Source: "Burden and Faires, Numerical Analysis", Exercise Set 9.6, Item 15
#problem(number: "1")[
  Show that if $A$ is an $n times n$ nonsingular matrix with singular values $s_1, s_2, ..., s_n$ written in descending order, then the $l_2$ condition number is $K_2(A) = s_1/s_n$
]
=== Solution
Recall that the 2-norm of a matrix is $sqrt(rho(A^T A))$ where $rho$ is the function that returns the largest absolute value among the matrix's eigenvalues. Also, a singluar value refers to the square root of one of the eigenvalues of $A^T A$. In short, the 2-norm of a matrix is the largest singular value of a matrix. So, $||A||_2 = s_1$. The 2-norm of $A^(-1)$, on the other hand is equal, to $1/norm(A)$, so the value must be equal to $1/s_n$. Thus, $K_2(A)=s_1/s_n$

#pagebreak()

= Lecture 1: Gaussian Elimination, Gauss-Jordan Reduction, Pivoting Strategies
=== Gaussian Elimination - Sean Tolentino

==== Solved Problem #1
Exercise Set 6.1, item 4b from Chapter 6: Direct Methods for Solving Linear Equiations in Burden and Faires, Numerical Analysis.

#problem[
  Use Gaussian elimination with backward substitution and two-digit rounding arithmetic to solve the following linear systems.Do not reorder theequations. (The exact solution to each system is $x_1=−1$,$x_2=1$,$x_3=3$.)

  $ cases(4x_1 + 2x_2 - x_3 = 5,
          1/9 x_1 + 1/9 x_2 - 1/3 x_3 = -1,
          x_1 + 4x_2 + 2x_3 = 9) $
]

Solution:\
We view our system of linear equations in the form $A x=b$, with the augmented matrix $bold([A | b])$ given by:

$ bold([A | b]) = mat(delim: "[", augment: #3,
  4, 2, -1, 5;
  1/9, 1/9, -1/3, -1;
  1, 4, 2, 9;
) $

We first perform the elimination phase to eliminate the entries below the diagonal of $A$:

$ mat(delim: "[", augment: #3,
    4, 2, -1, 5;
    1/9, 1/9, -1/3, -1;
    1, 4, 2, 9;
  )
$
  *$ R_2 <- R_2 - (1/36) R_1 $*
  *$ R_3 <- R_3 - (1/4) R_1 $*

$ = mat(delim: "[", augment: #3,
    4, 2, -1, 5;
    0, 1/18, -11/36, -41/36;
    0, 7/2, 9/4, 31/4;
  )
$
  *$ R_3 <- R_3 - 63 R_2 $*

$ = mat(delim: "[", augment: #3,
    4, 2, -1, 5;
    0, 1/18, -11/36, -41/36;
    0, 0, 43/2, 159/2;
  )
$

After converting the matrix into its upper triangular form, we proceed to do backward substitution to obtain all values of $x$. The upper triangular matrix system is represented as:

#align(center)[
  $ cases(
    4x_1 + 2x_2 - x_3 = 5,
    1/18 x_2 - 11/36 x_3 = -41/36,
    43/2 x_3 = 159/2
  ) $

  $ bold(x_3): x_3 = (159/2) / (43/2) = 159/43 approx 3.7 $

  $ bold(x_2): x_2 = 18[-41/36 + 11/36(159/43)] = -7/43 approx -0.16 $

  $ bold(x_1): x_1 = 1/4 [5 - 2(-7/43) + (159/43)] = 1/4 [5 + 173/43] = 97/43 approx 2.3 $
]

This gives us the solution:

$ #box(stroke: 0.5pt, inset: 8pt)[
  $bold(x approx [2.3, -0.16, 3.7]^T)$.
] $

==== Solved Problem #2
Exercise Set 6.1, item 6a from Chapter 6: Direct Methods for Solving Linear Equiations in Burden and Faires, Numerical Analysis.

#problem[
  Use the Gaussian Elimination Algorithm to solve the following linear systems, if possible , and determine whether row interchanges are necessary:

  $ cases(x_2 - 2x_3 = 4,
          x_1 - x_2 + x_3 = 6,
          x_1 - x_3 = 2) $
]
Solution:\
We view our system of linear equations in the form $A x=b$, with the augmented matrix $bold([A | b])$ given by:

$ bold([A | b]) = mat(delim: "[", augment: #3,
  0, 1, -2, 4;
  1, -1, 1, 6;
  1, 0, -1, 2;
) $

We first perform the elimination phase to eliminate the entries below the diagonal of $A$. However, we notice that our first pivot at entry $a_11$ is zero. Due to this, row swapping is done to the nearest non-zero row, $R_2$, since we cannot procede further.

  *$ R_1 <-> R_2 $*

$ = mat(delim: "[", augment: #3,
  1, -1, 1, 6;
  0, 1, -2, 4;
  1, 0, -1, 2;
) $

Proceeding with the elimination phase, we have:

  *$ R_3 <- R_3 - R_1 $*

$ = mat(delim: "[", augment: #3,
  1, -1, 1, 6;
  0, 1, -2, 4;
  0, 1, -2, -4;
) $

  $ R_3 <- R_3 - R_2 $

$ = mat(delim: "[", augment: #3,
  1, -1, 1, 6;
  0, 1, -2, 4;
  0, 0, 0, -8;
) $

#block(
  fill: white,
  inset: 10pt,
  width: 100%,
  stroke: 1pt + ink,
)[
  Looking at the third row of our reduced augmented matrix, the corresponding equation results in $0 = -8$, which is a contradiction. 

  Therefore, this system has *no solution* and a row interchange was necessary ($R_1 <-> R_2$).
]

==== Original Remix

#problem(
  number: [Remix],
)[

]

#pagebreak()
=== Gaussian Jordan Elimination - Russ Sison

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

#pagebreak()
=== Gaussian Elimination with Partial and Full Pivoting - Chloe Santos

==== Solved Problem #1
Example 2 from 6.2 Pivoting Strategies of Burden and Faires. Numerical Analysis.

#problem(
  number: 1,
  )[
  Apply Gaussian elimination to the system

  $
  E_1 : 0.003000 x_1 + 59.14 x_2 = 59.17
  $

  $
  E_2 : 5.291 x_1 - 6.130 x_2 = 46.78,
  $

  using partial pivoting and four-digit arithmetic with rounding, and compare the results
  to the exact solution $x_1 = 10.00$ and $x_2 = 1.000$.
]

===== Solution

The given system can be represented by the augmented matrix

$
mat(
  0.003000, 59.14, 59.17;
  5.291, -6.130, 46.78;
  delim: "[",
  augment: #2
)
$

At the first elimination stage, partial pivoting searches for the
largest absolute value in the current pivot column. Thus, we compare
the entries in the first column:

$
max(abs(0.003000), abs(5.291))
= abs(5.291).
$

Since the largest entry is in the second row, interchange $R_1$ and
$R_2$:

$
R_1 arrow.l.r R_2.
$

The reordered system becomes

$
5.291 x_1 - 6.130 x_2 &= 46.78, \
0.003000 x_1 + 59.14 x_2 &= 59.17.
$

$
mat(
  5.291, -6.130, 46.78;
  0.003000, 59.14, 59.17;
  delim: "[",
  augment: #2
)
$

The elimination multiplier is

$
m_21
= 0.003000 / 5.291
= 0.0005670.
$

Using the row operation

$
R_2 arrow.r R_2 - m_21 R_1
$

and applying four-digit arithmetic with rounding, the system reduces to


$
mat(
  5.291, -6.130, 46.78;
  ,59.14, 59.14;
  delim: "[",
  augment: #2
)
$
$
5.291 x_1 - 6.130 x_2 &approx 46.78, \
59.14 x_2 &approx 59.14.
$

We then apply back substitution. From the second equation,

$
x_2 = 59.14 / 59.14 = 1.000.
$

Substituting $x_2 = 1.000$ into the first equation gives

$
x_1
= (46.78 + 6.130(1.000)) / 5.291
= 52.91 / 5.291
= 10.00.
$

Therefore,

#align(center)[#rect(inset: 5pt, stroke: 0.5pt)[ 
$
(x_1, x_2) = (10.00, 1.000).
$]]

#remark[
  *The importance of pivoting.* Without pivoting, the very small value
  $0.003000$ would be used as the first pivot, producing a very large
  multiplier and making the computation more susceptible to round-off
  error. Partial pivoting avoids this by interchanging the rows and
  using $5.291$ as the first pivot instead. As a result, the system
  produces the correct solution even when four-digit arithmetic with
  rounding is used.
]


==== Solved Problem #2
Exercise 27(a) from 6.2 Pivoting Strategies of Burden and Faires. Numerical Analysis.

#problem(
  number: 2,

)[
  Use Gaussian elimination and three-digit chopping arithmetic with full pivoting to solve the following
  linear system, and compare the approximations to the actual solution.

  $
  0.003 x_1 + 58.9 x_2 = 59.2,\
   5.31 x_1 - 6.10 x_2 = 47.0.
  $
  Actual solution $[10, 1]$.
]
===== Solution

The given system can be represented by the augmented matrix

$
mat(
  0.003, 58.9, 59.2;
  5.31, -6.10, 47.0;
  delim: "[",
  augment: #2
)
$

Under full pivoting, we search the entire remaining coefficient matrix
for the entry with the largest absolute value.

The largest absolute entry is $58.9$, located in row 1, column 2.
Since $58.9$ is already in the first row, no row interchange is
necessary. However, it must be moved into the first pivot position by
interchanging columns 1 and 2:

$
C_1 arrow.l.r C_2.
$

Because the columns correspond to the variables, this also changes
the working variable order from

$
[x_1, x_2] quad "to" quad [x_2, x_1].
$

The reordered system is therefore

$
58.9 x_2 + 0.003 x_1 &= 59.2, \
-6.10 x_2 + 5.31 x_1 &= 47.0.
$

$
mat(
  58.9, 0.003, 59.2;
  -6.10,5.31, 47.0;
  delim: "[",
  augment: #2
)
$

The elimination multiplier is

$
m_21
= (-6.10) / 58.9
= -0.103,
$

using three-digit chopping arithmetic.

We then perform

$
R_2 arrow.r R_2 - m_21 R_1.
$

Using three-digit chopping,

$
m_21(0.003)
= (-0.103)(0.003)
= -0.000309.
$

Thus, the new coefficient of $x_1$ is

$
5.31 - (-0.000309)
= 5.31.
$

For the right-hand side,

$
m_21(59.2)
= (-0.103)(59.2)
= -6.09.
$

This gives

$
47.0 - (-6.09)
= 53.09
arrow.r 53.0.
$

Therefore, the reduced system is

$
58.9 x_2 + 0.003 x_1 &= 59.2, \
5.31 x_1 &= 53.0.
$

$
mat(
  58.9, 0.003, 59.2;
  ,5.31, 53.0;
  delim: "[",
  augment: #2
)
$


We then solve through back substitution. From the second equation,

$
x_1
= 53.0 / 5.31
= 9.98.
$

Substituting this into the first equation,

$
0.003(9.98)
= 0.0299
$

and

$
59.2 - 0.0299
= 59.1.
$

Therefore,

$
x_2
= 59.1 / 58.9
= 1.00.
$

Hence,

#align(center)[#rect(inset: 5pt, stroke: 0.5pt)[ 
$
(x_1, x_2) approx (9.98, 1.00).
$]]

Compared with the given solution

$
(x_1, x_2) = (10, 1),
$

the full-pivoting approximation is close despite the use of
three-digit chopping arithmetic.

#remark[
  *The importance of full pivoting.* Unlike partial pivoting, which
  searches only the current pivot column, full pivoting searches the
  entire remaining coefficient matrix for the largest available
  pivot. In this example, this causes a column interchange, so the
  corresponding change in variable order must also be tracked.
  After solving, the variables are reported in their original order.
]


==== Original Remix

#problem(
  number: [Remix],
)[
  Suppose you are testing a Gaussian elimination program that supports both partial and
  complete pivoting. Rather than applying the methods to a given matrix, your goal is to
  construct a $3 times 3$ coefficient matrix whose entries cause the two pivoting strategies to behave
  differently during the first elimination stage.

  Construct a matrix $A$ satisfying the following conditions:

  1. Under partial pivoting, the first pivot is selected from row 2.
  2. Under complete pivoting, a different first pivot is selected from column 2.
  3. After the column interchange required by complete pivoting, the magnitudes of both
     first-stage elimination multipliers must be less than $0.1$.

  Determine suitable conditions on the entries of $A$, construct one matrix satisfying them, and
  verify that your matrix produces the required behavior.
]

===== Solution

Since the matrix is not given, we first determine what conditions its
entries must satisfy. Let

$
A =
mat(
  a, b, c;
  d, e, f;
  g, h, i,
  delim: "[",
).
$

We then impose each requirement on these entries until a suitable
matrix can be constructed.


===== 1. Condition Imposed by Partial Pivoting

At the first elimination stage, partial pivoting examines only the
first column. For it to select the entry in row 2, the magnitude of
$d$ must be larger than the other first-column entries:

$
abs(d) > abs(a)
quad "and" quad
abs(d) > abs(g).
$

We can choose

$
a = 4, quad d = 7, quad g = 5.
$

We now have the partially constructed matrix

$
A =
mat(
  4, b, c;
  7, e, f;
  5, h, i,
  delim: "[",
).
$

The first-column entries are therefore $4$, $7$, and $5$, so partial
pivoting will select $7$ from row 2.


===== 2. Condition Imposed by Full Pivoting

Full pivoting searches the entire active coefficient matrix. We want
it to choose an entry from column 2 rather than the $7$ selected by
partial pivoting.

Therefore, choose a column-2 entry whose magnitude is larger than
every other entry in the matrix. \
\ Let

$
b = 50.
$

We then keep all remaining entries smaller than $50$ in magnitude.
The matrix now has the form

$
A =
mat(
  4, 50, c;
  7, e, f;
  5, h, i,
  delim: "[",
).
$

Provided that the remaining entries have magnitude less than $50$,
full pivoting will select $50$ at position $(1, 2)$. Since it is
already in the first row, only a column interchange is necessary:

$
C_1 arrow.l.r C_2.
$


===== 3. Condition Imposed by the Elimination Multipliers

After full pivoting interchanges columns 1 and 2, the first column
becomes

$
mat(
  50;
  e;
  h,
  delim: "[",
).
$

Thus, the first-stage elimination multipliers are

$
m_21 = e / 50,
quad
m_31 = h / 50.
$

The problem requires both multiplier magnitudes to be less than
$0.1$. Therefore,

$
abs(m_21)
= abs(e / 50)
< 0.1
$

and

$
abs(m_31)
= abs(h / 50)
< 0.1.
$

This gives the conditions

$
abs(e) < 5,
quad
abs(h) < 5.
$

We can choose

$
e = 3
quad "and" quad
h = 2.
$

This gives the partially constructed matrix

$
A =
mat(
  4, 50, c;
  7, 3, f;
  5, 2, i,
  delim: "[",
).
$


===== 4. Constructing the Matrix

The entries $c$, $f$, and $i$ do not determine the first pivot under
either strategy and do not appear in the first-stage elimination
multipliers.

We only need to keep their magnitudes below $50$ so that $50$ remains
the full-pivoting choice.

One simple choice is

$
c = 2,
quad
f = 1,
quad
i = 20.
$

Therefore, one matrix satisfying all of the requirements is

#align(center)[#rect(inset: 7pt, stroke: 0.5pt)[ 
$

  A =
  mat(
    4, 50, 2;
    7, 3, 1;
    5, 2, 20,
    delim: "[",
  ).
$]]


===== Verification

*1. Partial pivoting*

The first-column candidates are

$
4, quad 7, quad 5.
$

Since $7$ has the largest magnitude, partial pivoting selects the
entry in row 2 and performs

$
R_1 arrow.l.r R_2.
$

Therefore, the first condition is satisfied.


*2. Full pivoting*

The largest absolute entry in the entire matrix is $50$, located at
position $(1, 2)$.

Thus, full pivoting selects $50$ and performs

$
C_1 arrow.l.r C_2.
$

After the column interchange, the matrix becomes

$
A' =
mat(
  50, 4, 2;
  3, 7, 1;
  2, 5, 20,
  delim: "[",
).
$

Therefore, the second condition is satisfied.


*3. Elimination multipliers*

Using $50$ as the first pivot,

$
m_21
= 3 / 50
= 0.06
< 0.1,
$

and

$
m_31
= 2 / 50
= 0.04
< 0.1.
$

Therefore, both first-stage elimination multipliers have magnitudes
less than $0.1$.

#align(center)[#rect(inset: 5pt, stroke: 0.5pt)[ 
$
therefore "All three conditions are satisfied."
$]]

#pagebreak()
=== Gaussian Elimination with Scaled Partial Pivoting - Nate Zuñiga

==== Solved Problem #1
Exercise 17, item 9b from Exercise Set 6.2 in Burden and Faires, Numerical Analysis.

#problem[
  Given the following linear system:

  $ cases(3.03x_1 − 12.1x_2 + 14x_3 =−119,
          −3.03x_1 + 12.1x_2 − 7x_3 = 120,
          6.11x_1 − 14.2x_2 + 21x_3 =−139) $

  $ "Actual Solution": x =[0, 10, 1/7]^T $

  Use Gaussian elimination and scaled partial pivoting on the linear system, and compare the approximations to the actual solution.
]

Solution:\
We have the form $bold(A x = b)$, or alternatively, the augmented matrix $bold([A | b])$ wherein

$ bold([A | b] = mat(delim: "[", augment: #3,
    3.03, -12.1, 14, -119;
    -3.03, 12.1, -7, 120;
    6.11, -14.2, 21, -139;
  )) $

Firstly, let us determine the scale factors $s_i$ for each row $r_i$. These are determined by $ bold(s_i = max_(1 <= j <= n) |a_(i j)|), "or the maximum absolute value entry in each row" r_i $

For this system, we take $s_i$ to be

$ s_1 = max_(1 <= j <= n) |a_(1 j)| = 14\
  s_2 = max_(1 <= j <= n) |a_(2 j)| = 12.1\
  s_3 = max_(1 <= j <= n) |a_(3 j)| = 21 $

Now, let us find the first pivot row $p$.
We do this by finding $ bold(p = arg max_(k <= i <= n)
    frac(|a_(i k)^((k))|, s_i)), "or the row "r_i" with the largest ratio between its candidate "a_(i k)" and "s_i $

We then have
$ (|a_(1 1)|)/s_1 = 3.03/14 approx 0.2164 \
  (|a_(2 1)|)/s_2 = 3.03/12.1 approx 0.2504 \
  (|a_(3 1)|)/s_3 = 6.11/21 approx #box[0.2910] \
  "wherein "r_3 "has the greatest ratio of the three."\
  "Thus, "r_3" is the pivot row and "a_(3 1) "is the selected pivot point." $

We then swap rows $r_1$ and $r_3$ for $a_(3 1) "to become the diagonal pivot of "c_1. $

$ mat(delim: "[", augment: #3,
    3.03, -12.1, 14, -119;
    -3.03, 12.1, -7, 120;
    6.11, -14.2, 21, -139;
  )
  attach(arrow.r, t: bold(r_1 <-> r_3))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    -3.03, 12.1, -7, 120;
    3.03, -12.1, 14, -119;
  )
$

After which we can zero out the remaining column entries in $c_1$ using $a_(1 1) "and row operations."$

$ mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    -3.03, 12.1, -7, 120;
    3.03, -12.1, 14, -119;
  )
  attach(arrow.r, t: bold(r_2 -> r_2 + 3.03/6.11 r_1))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    3.03, -12.1, 14, -119;
  )
$

$ mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    3.03, -12.1, 14, -119;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 - 3.03/6.11 r_1))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    0, -5.06, 3.59, -50.07;
  )
$

For the second pivot, we compare $r_2$ and $r_3$ in $c_2$. The original scale factors travel with their rows, so $s_2 = 12.1$ and $s_3 = 14$ (the current $r_3$ is the original $r_1$).

$ (|a_(2 2)|)/s_2 = 5.06/12.1 approx #box[0.4182] \
  (|a_(3 2)|)/s_3 = 5.06/14 approx 0.3614 \
  "Thus, "r_2" is already the pivot row and no swap is needed." $

We then zero out the remaining entry in $c_2$.

$ mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    0, -5.06, 3.59, -50.07;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 + r_2))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    0, 0, 7.00, 1.00;
  )
$

The system is now upper triangular, so we use back substitution.

$ x_3 = 1.00/7.00 $

$ x_2 = (51.07 - 3.41 x_3)/5.06 approx 9.9966 $

$ x_1 = (-139 + 14.2 x_2 - 21 x_3)/6.11 approx -0.0079 $

$ #box(stroke: 0.5pt, inset: 8pt)[
  $therefore$ We have $ bold(x_(G E) = [-0.0079, 9.9966, 1/7]^T) $ which is very close to the actual solution of $x = [0, 10, 1/7]^T$.
] $

\
==== Solved Problem #2
Exercise 31 from Exercise Set 6.2 in Burden and Faires, Numerical Analysis.

#problem[
  Suppose that

  $ cases(2x_1 + x_2 + 3x_3 = 1,
          4x_1 + 6x_2 + 8x_3 = 5,
          6x_1 + alpha x_2 + 10x_3 = 5) $

  with $|alpha| < 10.$ For which of the following values of $alpha$ will there be no row interchange required when solving this system using scaled partial pivoting?

  A. $alpha = 6$ \
  B. $alpha = 9$ \
  C. $alpha = -3$
]

Solution:\
We have the form $bold(A x = b)$, or alternatively, the augmented matrix $bold([A | b])$ wherein

$ bold([A | b] = mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    4, 6, 8, 5;
    6, alpha, 10, 5;
  )) $

We take $s_i$ for each row $r_i$ to be

$ s_1 = max_(1 <= j <= n) |a_(1 j)| = 3\
  s_2 = max_(1 <= j <= n) |a_(2 j)| = 8\
  s_3 = max_(1 <= j <= n) |a_(3 j)| = 10\ "since" |alpha| < 10 "means" alpha "can never be the largest entry of" r_3. $

Then for the pivot on $c_1$, we have

$ (|a_(1 1)|)/s_1 = 2/3 approx 0.67 \
  (|a_(2 1)|)/s_2 = 4/8 = 0.5 \
  (|a_(3 1)|)/s_3 = 6/10 = 0.6 $

Thus, $a_(1 1)$ remains the pivot on $c_1$. No swap occurs.

Now, we zero out the remaining entries on $c_1$ using $a_(1 1)$ and row operations.

$ mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    4, 6, 8, 5;
    6, alpha, 10, 5;
  )
  attach(arrow.r, t: bold(r_2 -> r_2 - 2 r_1))
  mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    0, 4, 2, 3;
    6, alpha, 10, 5;
  )
$

$ mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    0, 4, 2, 3;
    6, alpha, 10, 5;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 - 3 r_1))
  mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    0, 4, 2, 3;
    0, alpha - 3, 1, 2;
  )
$

For the second pivot, we compare $r_2$ and $r_3$ in $c_2$.

$ (|a_(2 2)|)/s_2 = 4/8 = 0.5 $

We can restrict $alpha$ using the above ratio $0.5$. For there to be no row swapping, $alpha$ has to fulfill the following:

$ (|a_(3 2)|)/s_3 = (|alpha - 3|)/10 <= 0.5 $

We thus have

$ |alpha - 3| <= 5 \
  -5 <= alpha - 3 <= 5 \
  -2 <= alpha <= 8 $

Thus, no row interchange is required for $bold(-2 <= alpha <= 8)$. At $alpha = -2$ and $alpha = 8$, a tie between the ratios occurs, and the topmost row of those being compared, $r_2$, is chosen. Any other value of $alpha$ within the above range will ensure that $r_2$ has the largest ratio and $a_(2 2)$ remains the pivot for $c_2$.

From the given choices, $alpha = 6$ lies within $[-2, 8]$, while $alpha = 9$ and $alpha = -3$ do not.

$ #box(stroke: 0.5pt, inset: 8pt)[$bold(therefore " A. " alpha = 6)$] $

#pagebreak()
==== Remixed Problem

#problem[
  Given the following linear system, where $alpha$ is a real parameter:

  $ cases(0.5x_1 + 9x_2 + 2x_3 = 16.5,
          3x_1 + 4x_2 - x_3 = 12,
          alpha x_1 + 2x_2 + 5x_3 = alpha - 1) $

  $ "Actual Solution: "x =[1, 2, -1]^T ", " forall alpha $

  (a) For which values of $alpha$ does scaled partial pivoting select $r_3$ as the first pivot row? For which values does plain partial pivoting select $r_3$? For which $alpha$ do the two strategies disagree?

  (b) For $alpha = 3.5$, use Gaussian elimination and scaled partial pivoting with four-decimal-place rounding, and compare the approximation to the actual solution.
]

Solution:\
For this problem, we can take the augmented matrix $[A | b]$ to be

$ bold([A | b] = mat(delim: "[", augment: #3,
    0.5, 9, 2, 16.5;
    3, 4, -1, 12;
    alpha, 2, 5, alpha - 1;
  )) $

(a) For scaled partial pivoting on the system, we first take the scale factor $s_i$ per row $r_i$.

$ s_1 = max_(1 <= j <= n) |a_(1 j)| = 9\
  s_2 = max_(1 <= j <= n) |a_(2 j)| = 4 $

We can omit finding $s_3$ as we have yet to find a value for $alpha$ nor restrict it to a certain range; it is either $|alpha|$ or 5, whichever is larger. In the meantime, let's calculate the ratios needed to determine the first pivot row for the system.

We have

$ (|a_(1 1)|)/s_1 = 0.5/9 approx 0.0556 \
  (|a_(2 1)|)/s_2 = 3/4 = 0.75 $

Note that if $alpha$ is sufficiently large (in our case, $|alpha| >= 5$), it may itself be chosen as $s_3$, giving us

$ (|a_(3 1)|)/s_3 = (|alpha|)/(|alpha|) = 1 > 0.75, $

so $r_3$ is always selected.

On the other hand, if $|alpha| < 5$, then $s_3 = 5$, giving

$ (|a_(3 1)|)/s_3 = (|alpha|)/5 > 0.75 \
  |alpha| > 3.75 $

so $r_3$ is selected for $3.75 < |alpha| < 5$.

Since $r_1$ never has the largest ratio, and a tie at $|alpha| = 3.75$ is broken toward the first row ($r_2$), scaled partial pivoting selects $r_3$ as the first pivot row for

$ bold({alpha | |alpha| > 3.75}), "or" {alpha < -3.75 "or" alpha > 3.75} $

For partial pivoting, however, we only compare the magnitudes $|a_(i 1)|$, with the largest value of these becoming the pivot. As such, we have

$ |a_(1 1)| = 0.5 \
  |a_(2 1)| = 3 \
  |a_(3 1)| = |alpha| $

wherein $r_3$ is selected when $|alpha| > 3$, and a tie at $|alpha| = 3$ is broken toward $r_2$. Thus, partial pivoting selects $r_3$ as the first pivot row for

$ bold({alpha | |alpha| > 3}), "or" {alpha < -3 "or" alpha > 3} $

$ #box(stroke: 0.5pt, inset: 8pt)[
  We now have ranges for the values of $alpha_S$ and $alpha_P$, for which scaled partial pivoting and regular partial pivoting select $r_3$ as the first pivot row, respectively: \
  $ alpha_S: {alpha | |alpha| > 3.75} \
    alpha_P: {alpha | |alpha| > 3.00} $
  wherein the two methods disagree if $bold(3 < |alpha| <= 3.75)$, where regular partial pivoting selects $r_3$ while scaled partial pivoting selects $r_2$.
] $

\
(b) At $alpha = 3.5$, we have the following augmented matrix:

$ bold([A | b] = mat(delim: "[", augment: #3,
    0.5, 9, 2, 16.5;
    3, 4, -1, 12;
    3.5, 2, 5, 2.5;
  )) $

The scale factor $s_i$ for every row $r_i$ is taken as:

$ s_1 = 9 \
  s_2 = 4 \
  s_3 = 5 $

Now, we select the first pivot row using $s_i$ and column $c_1$:

$ (|a_(1 1)|)/s_1 = 0.5/9 approx 0.0556 \
  (|a_(2 1)|)/s_2 = 3/4 = 0.75 \
  (|a_(3 1)|)/s_3 = 3.5/5 = 0.7 $

Thus, row $r_2$ is selected as the first pivot row and we swap with row $r_1$:

$ mat(delim: "[", augment: #3,
    0.5, 9, 2, 16.5;
    3, 4, -1, 12;
    3.5, 2, 5, 2.5;
  )
  attach(arrow.r, t: bold(r_1 <-> r_2))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0.5, 9, 2, 16.5;
    3.5, 2, 5, 2.5;
  )
$

Then we continue by zeroing out the remaining entries in $c_1$:

$ mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0.5, 9, 2, 16.5;
    3.5, 2, 5, 2.5;
  )
  attach(arrow.r, t: bold(r_2 -> r_2 - 1/6 r_1))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    3.5, 2, 5, 2.5;
  )
$

$ mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    3.5, 2, 5, 2.5;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 - 7/6 r_1))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    0, -2.6667, 6.1667, -11.5;
  )
$

For the second pivot, the scale factors travel with their rows: the current $r_2$ is the original $r_1$, so its scale factor is $9$, and the current $r_3$ is the original $r_3$, so its scale factor is $5$. We compare the two rows in $c_2$:

$ 8.3333/9 approx #box[0.9259] \
  2.6667/5 approx 0.5333 $

wherein the current $r_2$ has the greater ratio. Thus, $r_2$ is already the pivot row and no swap is needed. We then zero out the remaining entry in $c_2$.

$ mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    0, -2.6667, 6.1667, -11.5;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 + 2.667/8.333 r_2))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    0, 0, 6.8600, -6.8600;
  )
$

The system is now upper triangular, so we use back substitution.

$ x_3 = (-6.8600)/6.8600 = -1.0000 $

$ x_2 = (14.5 - 2.1667 x_3)/8.3333 = 16.6667/8.3333 approx 2.0000 $

$ x_1 = (12 - 4x_2 + x_3)/3 = (12 - 8.0000 - 1.0000)/3 = 1.0000 $

$ #box(stroke: 0.5pt, inset: 8pt)[
  $therefore$ We have $ bold(x_(G E) = [1.0000, 2.0000, -1.0000]^T) $ which matches the actual solution of $x = [1, 2, -1]^T$ to four decimal places.
] $
#pagebreak()
= Contribution Log

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  [*Name*], [*Contribution (Compendium Topic)*],
  [Cruz, Kim], [Lecture 0, Systems of Algebraic Linear Equations],
  [Cruz, Lozano], [Lecture 0, Matrix Conditioning and Error Analysis],
  [Pagatpatan, Kevin], [Lecture 0, Matrix Norms],
  [Santos, Chloe], [Lecture 1, Pivoting Techniques],
  [Sison, Russ], [Lecture 1, Gauss-Jordan Elimination],
  [Tolentino, Sean], [Lecture 1, Gaussian Elimination],
  [Zuñiga, Nate], [Lecture 1, Pivoting Techniques],
)