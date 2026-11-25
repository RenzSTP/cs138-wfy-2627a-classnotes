// STYLING

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")


#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")



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
  #v(3em)
  #title[CLASS NOTES]
  #align(center)[
    #set text(size: 20pt) 
    #v(-1em)
    *- Matrix Factorization and LU Decomposition -*
  ]
  
  #v(-0.5em)
  #align(center)[
    #set text(size: 12pt)
  
    Elliot Xander Albano, Leo Celestino, Geron Warren Domondon, \
    Georiza Esma, Lance Tyler Lei, Renz Sergio Pactolin, Klex Felouise Padilla \ 
    Ambernie Green Salting, John Michael Tibay, Rohan Miguel Zabala \
  ]
  #align(center)[
    #set text(size: 10pt)
    September 23, 2026]
  
  #v(4em)
  
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
  #v(-0.25em)
  #text(weight: "bold")[I. Introduction]
  #table_of_contents-subitem[Motivation][28]
  
  
  #text(weight: "bold")[II. Types of Matrix Factorization]
  #table_of_contents-subitem[Doolittle and Crout Matrix LU Decomposition][31]
  #table_of_contents-subitem[In-Place LU Decomposition][33]
  #table_of_contents-subitem[LDU Decomposition][36]
  #table_of_contents-subitem[Cholesky LU Decomposition][39]
  #text(weight: "bold")[III. Miscellaneous]
  #table_of_contents-subitem[Contributions][56]
  #table_of_contents-subitem[References][57]
  
  
  // #pagebreak()
]
// END TITLE PAGE

= SECTION I
== Matrix Factorization
// should we also discuss the forward and backward substitution?
// if we do, briefly discuss why we do this instead of GE

Solving a system of linear equations $A x = b$ is one of the most common tasks in numerical computing. In practice, we often need to solve the *same* system $A x  = b$ for many different right-hand sides $b$. Applying Gaussian Elimination (GE) from scratch for each new $b$ is expensive, particularly reducing $A$ repeatedly when it does not depend on $b$. 

#h(10pt)

== Motivating Problem: 
Here, we start with a motivating problem before delving in deeper.

 #h(10pt)*Given*:
 
a) $x_1, x_2, ..., x_n in RR$

b) $b_1, b_2, ..., b_n in RR$

c) $a_11, a_12, ..., a_(1n), a_21, a_22, ..., a_(2n), ..., a_(n 1), a_(n 2), ..., a_(n n) in RR$

\ #h(10pt)*And a system of equations*:
\

$
a_11x_1 + a_12x_2 + ... a_(1 n) x_n = b_1
$

$
a_21x_1 + a_22x_2 + ... a_(2 n) x_n = b_2
$

$
(...)
$

$
a_(n 1)x_1 + a_(n 2)x_2 + ... a_(n n) x_n = b_n
$

Solve for $[x_1, x_2, ..., x_n]^T$
\ \

#h(10pt) *Notice, that we have augmented matrix:*

$
mat( 
  delim: "[",
  a_11, a_12, ..., a_(1 n), | b_1;
  a_21, a_22, ..., a_(2 n), | b_2;
  dots.v, dots.v, dots.down, dots.v, dots.v;
  a_(n 1), a_(n 2), ..., a_(n n), | b_n;  
)
$

\
#h(10pt) *Let A be the coefficient matrix:*

$
A = mat(delim: "[",
  a_11, a_12, ..., a_(1 n);
  a_21, a_22, ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), ..., a_(n n);
)
$


#h(10pt) *Let $b$ be the constant vector on the Right Hand Side (RHS).*

$
b = mat(delim: "[", 
  b_1, b_2, ..., b_n;
)^T
$

== Motivating Ideas:
What if there was a way to simplify the process of finding the unknown vector $x$, such that we minimize the number of arithmetic operations we perform and even minimize human error, instead of naively finding its inverse? But, how do we want to factor A in the first place?

 (1) Let $A = C D$ where $C, D$ have the same dimensions as $A$:

$
A x = b
$

$
C D x = b
$

$
C (D x) = b 
$
*NOTE:* Matrices are associative.

(2) Now, let $y$ be a vector, such that:
$
D x = y
$
And $ C (D x) = C y = b $

(3) Given our definitions, we have:
$
C (D x) = C y
$
$ 
D x = y 
$


Now, what if we can make it such that $C y = b$ and $D x = y$ can only be solved using forward or backward substitution?

*Matrix factorization* addresses this by separating the work into two stages:

 + *Factor* the coefficient matrix $A$ into a product of simpler matrices, doing only once with cost of $O(n^3)$.
 + *Solve* the resulting matrices for each right-hand side $b$. Because these are triangular, this costs only $O(n^2)$ operations, and can be repeated as needed.

The most fundamental example of this idea is *LU decomposition* #footnote[Warning:
This only works if $A$ is a non-singular matrix. Otherwise, if $A$ is singular (i. e. has no inverse) then there will exist a 0 row in $A$ after sufficient ERO operations.
],
 which gives $A = L U$, where $L$ is lower triangular and $U$ is upper triangular. Given these, solving $A x = b$ becomes:

$
L U x = b
$

which we solve in two more cheap steps using vector $y = U x$:

+ *Forward substitution:* Solve $L y = b$ for $y$ from top to bottom since $L$ is lower triangular.

+ *Backward substitution:* Solve $U x = y$ for $x$ from bottom to top since $U$ is upper triangular.

Each of these costs only $O(n^2)$ operations, cheaper than $O(n^3)$.
\
\
\
There are 3 methods that we can do this: 
- Method 1: *Doolittle* Decomposition
- Method 2: *Crout* Decomposition
- Method 3: *Cholesky* Decomposition

Throughout the notes, we will be treating the matrix as a sandwich
with toppings. You will see why soon.


#pagebreak()
= SECTION II

*Note*: The algorithms we discuss assume no row swapping needs to happen. This is important because, as you might remember, we sometimes need to swap rows when doing Gaussian Elimination. The same can be said for finding the LU/LDU decomposition (so for using the Doolittle and Crout algorithms). 

If a matrix is non-singular (so that the corresponding linear system is indeed solvable) then *if we allow row swapping*, there is *always* an LU decomposition, but we have to account for the permutations (so the factorization is technically $P A = L U$ with permutation matrix $P$) @Burden_Faires_2011. 

*If we do not allow row swapping*, which is an implicit assumption in the following algorithms, then there is an LU decomposition iff. *every leading principal submatrix* is invertible i.e. each leading principal matrix *has a nonzero determinant*. The $k$-th leading principal submatrix is just the square submatrix formed by the first $k$ rows and columns. Note how similar this is to the test for checking if a matrix is positive definite/has a Cholesky factorization. Source for both of these facts is @Meyer_2023.


  
== Doolittle Decomposition

$
A = mat(delim: "[",
  a_11, a_12, ..., a_(1 n);
  a_21, a_22, ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), ..., a_(n n);
) = 
mat(delim: "[",
  1, 0, ..., 0;
  l_21, 1, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  l_(n 1), l_(n 2), ..., 1;
)
mat(delim: "[",
  u_11, u_12, ..., u_(1 n);
  0,u_22, ..., u_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., u_(n n);
) = L U
$

One  way to get $U$ would be to perform Gaussian elimination so that $E_n ... E_2 E_1 A = U$. Notice that:

1. We can rearrange this into $A = E_1^(-1) E_2^(-1) ... E_n^(-1) U = L  U$. 
2. So, to get $L$, we only need to perform the opposite operation we applied to $A$ on $I$. 
3. This is, $L = E_1^(-1) E_2^(-1) ... E_n^(-1) I$
\
Here is an example on matrix



#example(number: "")[
  #[ // scope  
  
  $M = mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4)$
  
  #let lub(x) = text(fill: blue)[$#x$]
  #let lur(x) = text(fill: red)[$#x$]
  #let luv(x) = text(fill: purple)[$#x$]
  
  #table(
    columns: (7em, 10em, 7em),
    align: (center, center, center),
    stroke: none,
    table.cell(
      colspan: 1,
      [*Upper Matrix*],
    ),
    table.cell(
      colspan: 1,
      [*Row Operation*],
    ),
    table.cell(
      colspan: 1,
      [*Lower Matrix*],
    ),
    
    // ROW 1
    [$mat(delim: "[",2, 1, 2; lur(0), lur(3), lur(1); 4, -4, 4)$], 
    [$R_2 - (-4/2)R_1$], 
    [$mat(delim: "[", 1, 0, 0; lub(-2), 1, 0; 0, 0, 1)$ ],
    
    // ROW 2    
    [$mat(delim: "[",2, 1, 2; 0, 3, 1; lur(0), lur(-6), lur(0))$ ], 
    [$R_3 - 4/2R_1$], 
    [$mat(delim: "[", 1, 0, 0; -2, 1, 0; lub(2), 0, 1)$ ],
    
    // ROW 3
    [$mat(delim: "[",2, 1, 2; 0, 3, 1; lur(0), lur(0), lur(2))$], 
    [$R_3 - (-6/3)R_2$], 
    [$mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, lub(-2), 1)$],
  )
  
    So,
  $mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4) = 
  mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1)
  mat(delim: "[",2, 1, 2; 0, 3, 1; 0, 0, 2)  =
  L U $

]
]
\ 

For Doolittle Decomposition:
- Think of L as the plain lower bread, and it has no filling because the diagonal entries are equal to 1.

- Think of U as the upper bread, and it has filling because the diagonal entries are equal to 1.

// #pagebreak()
== Crout Decomposition

Similar to Doolittle, Crout decomposition also factors our matrix $A$ into a product of two matrices: an upper $U$ and lower $L$ triangular matrix such that $A = L U$. This time, however, the matrix $U$ has $1$'s in its diagonal instead of $L$.

\

$A = mat(delim: "[",
  a_11, a_12, ..., a_(1 n);
  a_21, a_22, ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), ..., a_(n n);
) = 
mat(delim: "[",
  l_11, 0, ..., 0;
  l_21, l_22, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  l_(n 1), l_(n 2), ..., l_(n n);
)
mat(delim: "[",
  1, u_12, ..., u_(1 n);
  0,1, ..., u_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., 1;
) = L U
$

\
We can also solve this the same way as in Doolittle using Gaussian elimination but with additional normalization of the diagonals.

#example(number: "")[
  
  Solving for matrix $ M = mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4)$.
  \
  
  #[ // scope  
  #let lub(x) = text(fill: blue)[$#x$]
  #let lur(x) = text(fill: red)[$#x$]
  #let luv(x) = text(fill: purple)[$#x$]
  #table(
  columns: (7em, 10em, 7em),
    align: (center, center, center),
    rows: (2em, auto),
    stroke: none,
    table.cell(
      colspan: 1,
      [*Upper Matrix*],
    ),
    table.cell(
      colspan: 1,
      [*Row Operation*],
    ),
    table.cell(
      colspan: 1,
      [*Lower Matrix*],
    ),
    
    // ROW 1
    [$mat(delim: "[",lur(1), lur(1/2), lur(1); -4, 1, -3; 4, -4, 4)$], [$luv(1/2R_1)$], 
    [$mat(delim: "[", lub(2), 0, 0; 0, 1, 0; 0, 0, 1)$],
  
    // ROW 2
    [ $mat(delim: "[",1, 1/2, 1; lur(0), lur(3), lur(1); lur(0), lur(-6), lur(0))$ ], 
    [$mat(delim: #none, R_2 + 4R_1; R_3 - 4R_1)$], 
    [ $mat(delim: "[", 2, 0, 0; lub(-4), 1, 0; lub(4), 0, 1)$],
    [
    $mat(delim: "[",1, 1/2, 1; lur(0), lur(1), lur(1/3); 0, -6, 0)$
      ], [$luv(1/3 R_2)$], [
      $mat(delim: "[", 2, 0, 0; -4, lub(3), 0; 4, 0, 1)$
      ],
    [
    $mat(delim: "[",1, 1/2, 1; 0, 1, 1/3; 0, lur(0), lur(2))$
      ], [$R_3 + 6R_2$], [
      $mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, lub(-6), 1)$
      ],
    [
    $mat(delim: "[",1, 1/2, 1; 0, 1, 1/3; 0, 0, lur(1))$
      ], [$luv(1/2R_3)$], [
      $mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, lub(-6), 2)$
      ],
    )
  
    So 
    $mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4) = 
    mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, -6, 2)
    mat(delim: "[",1, 1/2, 1; 0, 1, 1/3; 0, 0, 1) =
    L U $
  ]
]
Think of the sandwich now as the lower bread L with the filling because its diagonal entries are not 1, and the upper bread lost all its filling because its diagonal entries are now 1.

// #pagebreak()
= In-Place LU Decomposition
=== Crout Version

There is another method for solving this without performing Gaussian Elimination.

// this seems close enough to what sir had shown
// https://magedkamel.com/wp-content/uploads/2026/02/PDF-for-post-9-3x3-crout-option-1.pdf

#include "miniarc2/crout inplacealgo.typ"

=== Doolittle Version

We can also do the same thing as above for Doolittle.

#include "miniarc2/doolittle inplacealgo.typ"

// #pagebreak()
= LDU Decomposition

Now, what if we want $L$ and $U$ to have all diagonal entries as 1?

For clarity in this section, we will call the Doolittle Decomposition matrices to be $L_D$ and $U_D$, and the Crout Decomposition matrices as $L_C$ and $U_C$.

For clarity, the $L D U $ decomposition is

$A = L D U$ where

- $L$ is a lower triangular matrix with diagonal entries having value of all 1.

- $D$ is a diagonal matrix with nonzero entries.

- $U$ is an upper triangular matrix having diagonal entries of all 1.

To reach this form, we can actually start with either a Doolittle Decomposition or a Crout Decomposition.


== LDU with Doolittle as Starting Matrix

Notice, after performing the Doolittle Decomposition,
we have $A = L_D U_D$

Since $L_D$ only has diagonal entries of 1, then we already have $L$

However, $U_D$ does not satisfy the conditions for the LDU Decomposition.

Notice,

$
U_D = mat(delim: "[",
  u_11, u_12, ..., u_(1 n);
  0,u_12, ..., u_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., u_(n n);
) = mat(delim: "[", u_11, 0, ..., 0;
  0, u_22, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., u_(n n);) mat(delim: "[",
  1, u_12 / u_11, ..., u_(1 n) / u_11;
  0, 1, ..., u_(2 n) / u_22;
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., 1;
) 
$

So, in other terms, we can simply divide each row in $U_D$ by its respective diagonal entry.

$
A = (L_D) mat(delim: "[", u_11, 0, ..., 0;
  0, u_22, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., u_(n n);) mat(delim: "[",
  1, u_12 / u_11, ..., u_(1 n) / u_11;
  0, 1, ..., u_(2 n) / u_22;
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., 1;
)
$

Let's have an example from our previous exercise

#example(number: "")[

  $
  mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4) = 
  mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1)
  mat(delim: "[",2, 1, 2; 0, 3, 1; 0, 0, 2)  =
  L_D U_D 
  $

  $
  mat(delim: "[",2, 1, 2; 0, 3, 1; 0, 0, 2) = U_D
  $
  
  $
  mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2)  mat(delim: "[",2 / 2, 1 / 2, 2 / 2; 0, 3 / 3, 1 / 3; 0, 0, 2 / 2) = U_D
  $
  
  $
  mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2)  mat(delim: "[",1, 1 / 2, 1; 0, 1, 1 / 3; 0, 0, 1) = U_D
  $
  
  So, our $
  A = L_D U_D = (mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1) mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2)  mat(delim: "[",1, 1 / 2, 1; 0, 1, 1 / 3; 0, 0, 1) ) = L D U
  $
]
This can actually help us convert from Doolittle to Crout.

Notice,

$
A = L D U = (L D) U
$

Note that $U$ already satisfies the conditions for the upper triangular matrix of Crout.

So, we just need to get $L D$, but that is just $L_C(i j) = L_(i j) * D_(j j)$

Going back to our example, 
#example(number: "")[
$
A = L_D U_D = (mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1) mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2)  mat(delim: "[",1, 1 / 2, 1; 0, 1, 1 / 3; 0, 0, 1) ) 
$

$
L_C = mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1) mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2) = mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, -6, 3) 
$

The Crout Decomposition is:
$
A = mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, -6, 2)  mat(delim: "[",1, 1 / 2, 1; 0, 1, 1 / 3; 0, 0, 1) = L_C U_C
$]


== LDU with Crout as Starting Matrix

Notice, after performing the Doolittle Decomposition,

we have 
$
A = L_C U_C
$

Since $U_C$ only has diagonal entries of 1, then we already have $L$

However, $L_C$ does not satisfy the conditions for the LDU Decomposition.

Notice,

$
L_C = mat(delim: "[",
  l_11, 0, ..., 0;
  l_21, l_22, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  l_(n 1), l_(n 2), ..., l_(n n);
) =  mat(delim: "[",
  1, 0, ..., 0;
  l_21 / l_11, 1, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  l_(n 1) / l_11, l_(n 2) / l_22, ..., 1;
)mat(delim: "[",
  l_11, 0, ..., 0;
  0, l_22, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, ..., l_(n n);
)
$

So, now what we can do is that we can basically divide each column by their corresponding diagonal entry in that column.

$
A = L_C U_C = mat(delim: "[",
  1, 0, ..., 0;
  l_21 / l_11, 1, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  l_(n 1) / l_11, l_(n 2) / l_22, ..., 1;
)mat(delim: "[",
  l_11, 0, ..., 0;
  0, l_22, ..., 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, ..., l_(n n);
) U_C
$

Now let's use this example,

#example(number: "")[
  
  $
  mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4) = 
    mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, -6, 2)
    mat(delim: "[",1, 1/2, 1; 0, 1, 1/3; 0, 0, 1) =
    L U 
  $
  
  $
  mat(delim: "[", 2, 0, 0; -4, 3, 0; 4, -6, 2) = 
    mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1)
    mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2) 
  $
  
  $
  A =  mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1)
    mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2)  mat(delim: "[",1, 1/2, 1; 0, 1, 1/3; 0, 0, 1) 
  = L D U
  $
]
This can actually help us convert from Crout to Doolittle,

Notice, $A = L D U = L (D U)$

We can actually figure out $D U$ easily from here, which is just multiplying the the row $i$ of $U$ by $D_(i i)$.

In other words, $U_D(i j) = D_(i i) * U_(i j)$

Going back to our example, 

#example(number: "")[
    $
  D U =  mat(delim: "[",2, 0, 0; 0, 3, 0; 0, 0, 2)  mat(delim: "[",1, 1/2, 1; 0, 1, 1/3; 0, 0, 1) = mat(delim: "[",2, 1, 2; 0, 3, 1; 0, 0, 2)
  $
  
  So our Doolittle Decomposition is:
  
  $
  A = mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1) mat(delim: "[",2, 1, 2; 0, 3, 1; 0, 0, 2)
  $
]

For the sandwich,

Now, the both the lower and the upper breads do not have any filling because their diagonals are all equal to 1, and the filling went to D.

// #pagebreak()
= Cholesky Decomposition
\
The goal of Cholesky decomposition is to factor a symmetric
positive definite matrix $A$ as

$ 
A = L L^T 
$

where $L$ is a lower triangular matrix with positive diagonal
entries.

=== Conditions for Cholesky Decomposition

A Cholesky factorization exists when $A$ is symmetric positive
definite. We define positive definiteness by

$ x^T A x > 0 $

for every nonzero vector $x$.

The positive-definiteness test is discussed in greater detail in a later section.

=== Derivation from LDU

Note that as stated previously, $A$ *must* be symmetric positive definite for this to work.

Starting from $A = L D U$, we can use the symmetry of $A$ to find that $U = L^T$.

Hence, 

#align(center)[
  $A = L D U = L D L^T$
]

From here, notice that if we rewrite the diagonal factor D as the square of some matrix S, we get

#align(center)[
  $L D L^T = L (S S) L^T  = (L S)(S L^T) = (L S)(L S)^T$
]

Then, by setting LS = G, we finally have:

#align(center)[
  A = $(L S)(L S)^T = G G^T$
]

which is what we are looking for. That leaves us with finding some S such that SS = D (in this sense, one could think of S being $sqrt(D)$). However, note that because D is a diagonal matrix, we can get S by simply taking the square root of each entry of D.

However, the previously described step may be a trap. What happens if some $d_(i i)$ element of D is less than zero? Thankfully, Corollary 6.27 in Burden and Faires (2011, p. 417) (9th ed.) gives us the following result:

#theorem()[
_"The matrix A is positive definite if and only if $ A$ can be factored in the form $L D L^T$ , where $L$
is lower triangular with 1s on its diagonal and $D$ is a diagonal matrix with positive diagonal
entries"._
	]


Since we know that $A$ is positive definite, we can conclude that D has positive entries!

As a sanity check, we can verify that $G = L S$ is indeed lower triangular. Recall that L is a lower triangular matrix, and S is diagonal. From Math 40, we know that the right multiplication of any diagonal matrix $D'$ to any square matrix M (with the same dimension) only scales each column of M by its corresponding diagonal entry in $D'$. Hence, $G = L S$ maintains the same position of nonzero entries as L, and is also lower triangular.


#include "miniarc2/cholesky_algorithm_and_example.typ"

= Breakdown of Doolittle Factorization and the Need for Pivoting

*Note*: Although this was not explicitly discussed in class, it is important for implementation, so we include it here.

Most of this section is adapted from Burden and Faires (2011, pp. 407--409).

== Motivating Problem:

Consider the following system of equations:

$
6x_1 + 7x_2 &= 67 \
6x_1 + 7x_2 + x_3 &= 676 \
6x_1 + 9x_2 &= 69
$

The coefficient matrix in this specific system is:

$
A = mat(
  delim: "[",
  6, 7, 0;
  6, 7, 1;
  6, 9, 0;
)
$


#pagebreak()
If we attempt a Doolittle Decomposition, we begin with:

$
mat(
  delim: "[",
  6, 7, 0;
  6, 7, 1;
  6, 9, 0;
)

mat(
  delim: "[",
  1, 0, 0;
  0, 1, 0;
  0, 0, 1;
)
$

and after the first elimination step obtain

$
mat(
  delim: "[",
  6, 7, 0;
  0, 0, 1;
  0, 2, 0;
)

mat(
  delim: "[",
  1, 0, 0;
  1, 1, 0;
  1, 0, 1;
)
$

Notice that the next pivot would be

$
U_(22) = 0.
$

Since Doolittle's method requires a nonzero pivot at each step, the algorithm breaks down.

To remedy this issue, we introduce a matrix that performs row interchanges. Let this matrix be denoted by $P$.

$ A x = b -> P A x = P b $

If $A$ is invertible, we may factor

$
P A = L U.
$

Substituting this factorization gives

$
P A x &= P b \
L U x &= P b \
(P^(-1) L U) x &= b.
$

By associativity of matrix multiplication,

$
(P^(-1) L) U x &= b \
(P^(-1) L)(U x) &= b.
$

Let $U x = y$, 

$ 
(P^(-1) L) y = b 
$

According to Burden and Faires (2011, p. 407), "$P^(-1) = P^T$".

*The following proof is not from Burden and Faires:*

We prove this by induction on the number of row-interchange operations used to construct $P$.

Let this number be $k$.
  
*Base Case*: $k = 0$

In this case,

$
P = I_n.
$

Since

$
(I_n)^(-1) = I_n
$

$
(I_n)^T = I_n,
$

it follows that

$
(I_n)^(-1) = (I_n)^T.
$

Thus, the statement holds for $k = 0$.
  
*Inductive Hypothesis:*

Assume that for some $l in NN_0$,

$
P_l^(-1) = P_l^T,
$

where $P_l$ is obtained after $l$ row-interchange operations.
  
*Induction Step:* $k = l + 1$

Let $E_(l+1)$ denote the elementary matrix corresponding to the $(l+1)$-st row interchange. Then

$
P_(l+1) = E_(l+1) P_l.
$

Taking transposes,

$
P_(l+1)^T
=
(E_(l+1) P_l)^T
=
P_l^T E_(l+1)^T.
$
  
By the induction hypothesis,

$
P_l^T = P_l^(-1).
$

Furthermore, a row interchange is its own inverse, so

$
E_(l+1)^(-1) = E_(l+1).
$

Since $E_(l+1)$ is symmetric,

$
E_(l + 1)^T = E_(l + 1).
$

Hence,

$
E_(l+1)^T = E_(l+1)^(-1).
$

Therefore,

$
P_(l+1)^T
=
P_l^(-1) E_(l+1)^(-1)
=
(E_(l+1) P_l)^(-1)
=
P_(l+1)^(-1).
$

$
P_(l+1)^T = P_(l+1)^(-1).
$

By induction,

$
P^T = P^(-1)
$

for every permutation matrix $P$.

Substituting this into the previous equation gives

$
(P^T L) y = b.
$

By associativity,

$
P^T (L y) = b.
$

Let $L y = z$.

Then, 
$
therefore P^T z = b
$.

Thus, instead of solving $A x = b$, we solve the following sequence of systems:

$
P^T z = b,
$

$
L y = z,
$

and

$
U x = y.
$

The first system is easy to solve because multiplying by a permutation matrix merely reorders the entries of a vector.

The second system can be solved using forward substitution since $L$ is lower triangular.

The third system can be solved using backward substitution since $U$ is upper triangular.

Therefore, once the factorization $P A = L U$ has been computed, solving the original system reduces to solving two triangular systems, together with a permutation of the right-hand side vector.
=== Continuing the Sandwich Analogy:

Think of P as some toppings. It's the finishing touches before or after we can perform the $L U$ decomposition.

Now, let's go back to the previous example, but with the additional $P$.

We should be able to solve everything from here now as long as A has an inverse.

#example(number: "")[  
  $
  "   P         U         L         EROs"$
  $
  mat(
    delim: "[",
    1, 0, 0;
    0, 1, 0;
    0, 0, 1;
  )
  
  mat(
    delim: "[",
    6, 7, 0;
    6, 7, 1;
    6, 9, 0;
  )
  
  mat(
    delim: "[",
    1, 0, 0;
    0, 1, 0;
    0, 0, 1;
  )
  
  "                                                                              "
  $
  
  $
  mat(
    delim: "[",
    1, 0, 0;
    0, 1, 0;
    0, 0, 1;
  )
  
  mat(
    delim: "[",
    6, 7, 0;
    0, 0, 1;
    0, 2, 0;
  )
  
  mat(
    delim: "[",
    1, 0, 0;
    1, 1, 0;
    1, 0, 1;
  )
  
  R_2 -> -R_1 + R_2, R_3 -> -R_1 + R_3
  
  "                                 "
  $
  
  $
  mat(
    delim: "[",
    1, 0, 0;
    0, 0, 1;
    0, 1, 0;
  )
  
  mat(
    delim: "[",
    6, 7, 0;
    0, 2, 0;
    0, 0, 1;
  )
  
  mat(
    delim: "[",
    1, 0, 0;
    1, 1, 0;
    1, 0, 1;
  )
  
  R_2 <-> R_3
  
  "                                                                 "
  $
  
  $
  P^T = mat(
    delim: "[",
    1, 0, 0;
    0, 0, 1;
    0, 1, 0;
  ),
  
  U = mat(
    delim: "[",
    6, 7, 0;
    0, 2, 0;
    0, 0, 1;
  ),
  
  L = mat(
    delim: "[",
    1, 0, 0;
    1, 1, 0;
    1, 0, 1;
  )
  $
  
  So,  $P^T L U x= b$ is now
  
  $ mat(
    delim: "[",
    1, 0, 0;
    0, 0, 1;
    0, 1, 0;
  ) mat(
    delim: "[",
    1, 0, 0;
    1, 1, 0;
    1, 0, 1;
  ) mat(
    delim: "[",
    6, 7, 0;
    0, 2, 0;
    0, 0, 1;
  ) x = mat(
    delim: "[",
    67;
    676;
    69;
  )$
  
  Now, let's start with
  
  $
  mat(
    delim: "[",
    1, 0, 0;
    0, 0, 1;
    0, 1, 0;
  ) z= mat(
    delim: "[",
    67;
    676;
    69;
  )
  $
  
  $
  z = mat(
    delim: "[",
    67;
    69;
    676;
  )
  $
  
  Then let's solve for $L y = z$ using forward substitution.
  
  $ mat(
    delim: "[",
    1, 0, 0;
    1, 1, 0;
    1, 0, 1;
  ) y = mat(
    delim: "[",
    67;
    69;
    676;
  ) $
  
  #table(
    stroke: none,
    columns: (30%, 30%, 30%)
  )[
    For $y_1$:
  
    $y_1 = 67$
  
  ][
      
    For $y_2$:
    
    $y_1 + y_2 = 69$
    
    $67 + y_2 = 69$
    
    $y_2 = 2$
      
  ][
    For $y_3$:
    
    $y_1 + y_3 = 676$
    
    $67 + y_3 = 676$
    
    $y_3 = 609$
  
  ]
  
  So, $y = mat(
    delim: "[",
    67;
    2;
    609;
  )$
  
  Now, let's solve $U x = y$ using back substitution.
  So, $ mat(
    delim: "[",
    6, 7, 0;
    0, 2, 0;
    0, 0, 1;
  ) x = mat(
    delim: "[",
    67;
    2;
    609;
  ) $
  #table(
    stroke: none,
    columns: (30%, 30%, 30%)
  )[
    For $x_3$,
    
    $x_3 = 609$
  ][
    For $x_2$,
    
    $2x_2 = 2 \
    x_2 = 1$
  ][
  For $x_1$,
  
  $6x_1 + 7x_2 = 67$
  
  $6x_1 + 7(1) = 67$
  
  $6x_1 + 7 = 67$
  
  $6x_1 = 60$
  
  $x_1 = 10$
  ]
  $
  x = mat(
    delim: "[",
    60;
    1;
    609;
  )
  $
]

// man, it would help to know tricks for factoring out scalars when doing matrix stuff

// (https://www.stat.uchicago.edu/~lekheng/courses/309/books/Trefethen-Bau.pdf) -> can i assume this is the trefethen source


= Using Block Matrices
These are recursive formulas for Doolittle, Crout, and Cholesky factorization. \
Idea from Trefethen and Bau, using original derivation.

== LDU Factorization 
If $A$ is any matrix then can write it in terms of block matrices as $ A = mat(delim: "[", a_11, w^T; v, A'). $ With this, we can factor $A$ as $ A = mat(delim: "[", 1, 0; v/a_11, I) mat(delim: "[", a_11, 0; 0, A -  v w^T \/ a_11) mat(delim: "[", 1, w^T/a_11; 0, I). $

If we recursively find the LDU factorization of $A -  v w^T \/ a_11$, i.e $ A -  v w^T \/ a_11 = L'D'U'$, then we have an actual formula for the LDU factorization of $A$, $ A = mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", a_11, 0; 0, D') mat(delim: "[", 1, w^T/a_11; 0, U'). $

== Expressions for Doolittle and Crout
We can then get the expression for Doolittle factorization with
$ A &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", a_11, 0; 0, D') mat(delim: "[", 1, w^T/a_11; 0, U') \
    &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", 1, 0; 0, D') mat(delim: "[", a_11, 0; 0, I) mat(delim: "[", 1, w^T/a_11; 0, U') \
    &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", 1, 0; 0, D') mat(delim: "[", a_11, w^T; 0, U') \
    &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", 1, 0; 0, I) mat(delim: "[", a_11, w^T; 0, U') \
    &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", a_11, w^T; 0, U') \
$
Where again $A' - (v w^T)/a_11 = L'D'U'$. The difference here is that $D'$ will actually just be the identity: the leading term will always be 1 and the terms to its right and below it will be 0.\
And getting Crout:
$ 
A &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", a_11, 0; 0, D') mat(delim: "[", 1, w^T/a_11; 0, U') \
    &= mat(delim: "[", 1, 0; v/a_11, L') mat(delim: "[", a_11, 0; 0, I)  mat(delim: "[", 1, 0; 0, D') mat(delim: "[", 1, w^T/a_11; 0, U') \
    &= mat(delim: "[", a_11, 0; v, L')mat(delim: "[", 1, 0; 0, I) mat(delim: "[", 1, w^T/a_11; 0, U') \
    &= mat(delim: "[", a_11, 0; v, L') mat(delim: "[", 1, w^T/a_11; 0, U') \
$

== Computational Example Doolittle    
#example(number: "")[
#include "miniarc2/computationalDoolittleEx.typ"
]
== LDL#super[T] Factorization
If $A$ is symmetric then we can write it as $A = mat(delim: "[", a_11, v^t; v, A')$, then we can further get
$ A = mat(delim: "[", 1, 0; v\/a_11, I) mat(delim: "[", a_11, 0; 0, A' - v v^T \/ a_11) mat(delim: "[", 1, v^T\/a_11; 0, I). $ 

So if we recursively find the LDU factorization of $A' - v v^T \/ a_11$ as $A' - v v^T \/ a_11 = L' (L')^T$, then we have $ A = mat(delim: "[", 1, 0; v\/a_11, L') D mat(delim: "[", 1, v^T\/a_11; 0, (L')^T). $

== Cholesky
Note: A Cholesky factorization exists iff. matrix is symmetric and positive definite. There's a test for checking if a matrix is positive definite, but actually we don't _need_ to check it because if the matrix is positive definite, this will get us a factorization, but if it isn't then we will find a negative pivot. \
We can get a recursive expression for Cholesky factorization in a similar way with Doolittle/Crout, except we factor 
$ mat(delim: "[", a_11, 0; 0, A' - v v^T \/ a_11) = mat(delim: "[", sqrt(a_11), 0; 0, I)  mat(delim: "[", 1, 0; 0, A' - v v^T \/ a_11)  mat(delim: "[", sqrt(a_11), 0; 0, I) $

So Cholesky factorization is
$ A = mat(delim: "[", sqrt(a_11), 0; v\/sqrt(a_11), L') mat(delim: "[", sqrt(a_11), v^T\/sqrt(a_11); 0, (L')^T). $ 
where $L' (L')^T = A' - v v^T \/ a_11$.

== Test for Positive Definite

We will be using positive definite to include the matrix being symmetric.

"A matrix $A$ is positive definite if it is symmetric and if $x^t A x > 0$ for every n-dimensional vector $x != 0$" (Burden & Faires, 2011, p. 414)

How do we test this?

*Step 1*: Test for Symmetry

Given $A "an" n times n$ matrix,

$A$ is symmetric iff $forall 1 <= i, j <= n, i, j in ZZ, A_(i j) = A_(j i)$ 

*Step 2*: Try getting the Cholesky Decomposition:

  Performing the Cholesky Algorithm is already available in the section above this. but this section will explain why if such decomposition without performing elementary row operation 1 does exist, then $A$ is positive definite.

First, we can show that if $A$ is positive definite then $A = L L^T$ for some lower triangular matrix $L$ by performing the algorithm as stated above. Alternatively, one could also perform an $L D U$ decomposition and then $L sqrt(D)$ and $sqrt(D) U$ can be applied as well.

Now, we only need to show that if $A = L L^t$ for some lower triangular matrix $L$, then $A$ is positive definite.

Notice that 

$ x^t A x = x^t (L L^t) x $

Since matrix multiplication is associative:

$ x^t (L L^t) x = (x^t L) (L^t x) $

But notice that $(x^t L)^t = (L^t x)$.
So, $ (x^t L) (L^t x) = (x^t L) (x^t L)^t $

which is another dot product.

However, note that $x^t$ is a $1 times n$ matrix and $L$ is an $n times n$ matrix, so letting $y = (x^t L)$

$y$ is a $1 times n$ matrix.

Let $y = [y_1, y_2, ..., y_n]$ for $y_1, y_2, ..., y_n in RR$.

$ (x^t L) (x^t L)^t = y (y^t) = (y_1 ^2 + y_2^2 + ... y_n^2 ) >= 0 $

The equality condition is only iff $y_1, y_2, ..., y_n$ are all 0. or $y$ is the 0 vector.

Suppose, all the entries of $y$ are 0, then $
L^t x = y^t = mat(delim: "[", 0; 0; dots.v; 0)
$

However, 

$
L(L^t x) = L (mat(delim: "[", 0; 0; dots.v; 0)) 
=> (L L^t) x = mat(delim: "[", 0; 0; dots.v; 0) 
=>A x = mat(delim: "[", 0; 0; dots.v; 0)
$

Since $A$ is non-singular,

$
A^(-1) A x = A^(-1) mat(delim: "[", 0; 0; dots.v; 0) => x = mat(delim: "[", 0; 0; dots.v; 0)
$

This indicates that if $y$ is 0 then $x$ is also the 0-vector, but the positive definite definition implies that $x$ cannot be the 0-vector. So, $y$'s entries are not all 0.

The equality condition is not met, so $x^t A x = (x^t L) (x^t L)^t = y (y^t) = (y_1 ^2 + y_2^2 + ... y_n^2 ) > 0$.

Therefore, $forall$ nonzero vectors $x$ $x^t A x > 0$, which means $A$ is positive definite.

Additional note: This proof also holds regardless if the matrix is lower triangular as long as $L$ and $L^t$ have an inverse.

*Sidenote*: 

"A symmetric matrix $A$ is positive definite if and only if all the eigenvalues of $A$ are positive" (Burden & Faires, 2011, p. 573).

The following proof's ideas are taken from Burden & Faires, 2011 page 573:

*First, the "if" direction, to show that a positive definite matrix has positive eigenvalues.
*
Let $lambda$ be an eigenvalue of $A$, and have associated eigenvalue $x$

Let $x = mat(delim: "[", x_1; x_2; dots.v; x_n)$

Because A is positive definite, then for any vector, including A's eigenvectors $x$,
$0 < x^t A x$.

But since $lambda x = A x$,
$0 < x^t A x = x^t lambda x$.

Note, $lambda$ is a scalar

$0 < x^t A x = x^t lambda x = lambda x^t x = lambda (x_1^2 + x_2^2 + ... + x_n^2)$

But note that $ (x_1^2 + x_2^2 + ... + x_n^2) >= underbrace(0 + 0 + 0 + ... + 0, n "times") = 0$

However, note that the 0 vector cannot be an eigenvalue, so $(x_1^2 + x_2^2 + ... + x_n^2) != underbrace(0 + 0 + 0 + ... + 0, n "times") = 0$,

So, $(x_1^2 + x_2^2 + ... + x_n^2) > 0$

Since $(x_1^2 + x_2^2 + ... + x_n^2) > 0$ and $lambda (x_1^2 + x_2^2 + ... + x_n^2) > 0$, so $lambda > 0$

*Second, we have the only if direction*

We, now, want to show that if $A$ has positive eigenvalues, then $A$ is positive definite.

Now, let's rewrite $A$, according to Burden and Faires (2011),  we can use Gram-Schmidt on the eigenvectors to make an orthonormal set of eigenvectors.

Because the eigenvectors are linearly independent and of size $n$, we express any nonzero vector $x$ as 

$ x = sum_(i = 1)^n beta_i v^(i) $

where $v^i$ are the eigenvectors such that their set is pairwise orthogonal, and their norms are all equal to 1

and $beta_1, beta_2, ..., beta_n in RR$ are not all 0

For any nonzero vector x,

$ x^t A x = x^t (sum_(i = 1)^n beta_i A v^(i)) = x^t (sum_(i = 1)^n beta_i lambda_i v^(i)) $

But notice

$x^t &= ((beta_1) v^1 + (beta_2) v^2 + ... + (beta_n) v^n)^t = ((beta_1) v^1)^t + ((beta_2) v^2)^t + ... + ((beta_n) v^n)^t \
&= beta_1 (v^1)^t + beta_2 (v^2)^t + ... + beta_n (v^n)^t$

So,

$ x^t (sum_(i = 1)^n beta_i lambda_i v^(i)) 

&= (beta_1 (v^1)^t + beta_2 (v^2)^t + ... + beta_n (v^n)^t) (sum_(i = 1)^n beta_i lambda_i v^(i)) \

&= (sum_(j = 1)^n beta_j (v^j)^t)((sum_(i = 1)^n beta_i lambda_i v^(i)) \ 

&= sum_(j = 1)^n sum_(i = 1)^n (beta_j (v^j)^t) (beta_i lambda_i v^(i)) \
&=  sum_(j = 1)^n sum_(i = 1)^n (beta_j beta_i lambda_i v^(i) (v^j)^t) $

However, because the set of eigenvectors is orthonormal,

If $i != j$, 
$
v^(i) (v^j)^t = 0
$

If $i = j$, 
$
v^(i) (v^j)^t = 1
$

So, 

$sum_(j = 1)^n sum_(i = 1)^n (beta_j beta_i lambda_i v^(i) (v^j)^t) = sum_(i = 1)^n beta_i^2 lambda_i >= underbrace((0^2 * 0) + (0^2 * 0) + ... + (0^2 * 0), n " times") = 0$

This is only equal to 0 if $beta_1, beta_2, ..., beta_n$ are all equal to 0 since the eigenvalues are already positive. 

But since $beta_1, beta_2, ..., beta_n$ was defined to be not all 0, then this does not meet the equality case so $x^t A x = sum_(i = 1)^n beta_i^2 lambda_i >= 0$

Getting the eigenvalues can be done using the cofactor method, which is extremely slow, but more methods will be available in the later section of the notes.

= Contribution Log

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt + midgray,
  [*Name*], [*Contribution*],
  [Albano, Elliot Xander], [- Initiated the task assignments for the mini-arcs, and miscellaneous tasks
- started the mini arc 2 document
- added the motivating problem, the full LDU Decomposition section , positive definite matrix proofs on eigenvalues and the full permutation section
- added the sandwich analogy
],
  [Celestino, Leo], [- Minor proofreading],
  [Domondon, Geron Warren], [- Cholesky Decomposition 
                              - Derivation from LDU Matrix
                            ],
  [Esma, Georiza], [
    - Brief description and examples for Doolittle and Crout; 
    - "In-place" algorithm part
    - Format to blend with other miniarcs],
  [Lei, Lance Tyler], [],
  [Pactolin, Renz Sergio], [- Typeset title pages and Table of Contents
                            - Polished proof details on Section I: Motivation 
                            - Polished tables on Section II: LU Decomposition
                          ],
  [Padilla, Klex Felouise ], [
    - Cholesky Decomposition, Algorithm + Worked Example
    - Assist on "Breakdown of Doolittle Decomposition"
    - Minor typesetting/formatting polish
    - Proofreading
  ],
  [Salting, Ambernie], [
    - Minor Proofreading
    - Fixed page numbering],
  [Tibay, John Michael], [Added alternative recursive expressions for Doolittle, Crout, LDU, LDL^T, Cholesky factorization, and added handwritten example of using the Doolittle expression. Also added a little note saying when the LU decomposition exists.],
  [Zabala, Rohan Miguel], [],
)

#bibliography("miniarc2/refs.bib", full: true, style: "apa") // idk which style