#set page("a4")
#set text(size: 12pt)



= Matrix Factorization
// should we also discuss the forward and backward substitution?
// if we do, briefly discuss why we do this instead of GE

Solving a system of linear equations $A x = b$ is one of the most common tasks in numerical computing. In practice, we often need to solve the *same* system $A x  = b$ for many different right-hand sides $b$. Applying Gaussian Elimination (GE) from scratch for each new $b$ is expensive, particularly reducing $A$ repeatedly when it does not depend on $b$. 

#h(10pt)

= Motivating Problem: 
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
a_21x_1 + a_22x_2 + ... a_(2 n) x_n = b_1
$

$
(...)
$

$
a_(n 1)x_1 + a_(n 2)x_2 + ... a_(n n) x_n = b_1
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
  a_21, a_22, ..., a_(2 n), | b_2;
)
$

\
#h(10pt) *Let A be the coefficient matrix:*

$
A = mat(delim: "[",
  a_11, a_12, ..., a_(1 n);
  a_21, a_22, ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_21, a_22, ..., a_(2 n);
)
$

\

#h(10pt) *Let $b$ be the constant vector on the Right Hand Side (RHS).*

$
b = mat(delim: "[", 
  b_1, b_2, ..., b_n;
)^T
$
\ \
\
#pagebreak()
= Motivating Ideas:
\
What if we can factor A? Instead of solving it for an inverse?

But, how do we want to factor A in the first place?

Let $A = C D$ where $C, D$ are also $n times n$ matrices:

$
A x = b
$

$
C D x = b
$

$
C (D x) = b
$

Note: Matrix multiplication is associative.

Let 
$
D x = y
$

$
C y = b
$

Now, what if we can make it such that $C y = b$ and $D y = x$ can only be solved using forward or backward substitution.

*Matrix factorization* addresses this by separating the work into two stages:

 + *Factor* the coefficient matrix $A$ into a product of simpler matrices, doing only once with cost of $O(n^3)$.
 + *Solve* the resulting matrices for each right-hand side $b$. Because these are triangular, this costs only $O(n^2)$ operations, and can be repeated as needed.

The most fundamental example of this idea is *LU decomposition*, which gives $A = L U$, where $L$ is lower triangular and $U$ is upper triangular. Given these, solving $A x = b$ becomes:

$
L U x = b
$

which we solve in two more cheap steps using vector $y = U x$:

+ *Forward substitution:* Solve $L y = b$ for $y$ from top to bottom since $L$ is lower triangular.

+ *Backward substitution:* Solve $U x = y$ for $x$ from bottom to top since $U$ is upper triangular.

Each of these costs only $O(n^2)$ operations, cheaper than $O(n^3)$.

There are 3 methods that we can do this: 

- Method 1: *Doolittle* Decomposition
- Method 2: *Crout* Decomposition
- Method 3: *Cholesky* Decomposition

== Warning

This only works if $A$ is a non-singular matrix. Otherwise, if $A$ is singular (i. e. has no inverse) then there will exist a 0 row in $A$ after sufficient ERO operations.

#pagebreak()
= Doolittle Decomposition

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
  0,u_12, ..., u_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  0, 0,..., u_(n n);
) = L U
$

One of obvious way to get $U$ would be to perform Gaussian elimination so that $E_n ... E_2 E_1 A = U$. Notice that we can rearrange this into $A = E_1^(-1) E_2^(-1) ... E_n^(-1) U = L  U$. So, to get $L$, we only need to perform the opposite operation we applied to $A$ on $I$. That is, $L = E_1^(-1) E_2^(-1) ... E_n^(-1) I$

Here is an example on
$mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4)$

#[ // scope  
#let lub(x) = text(fill: blue)[$#x$]
#let lur(x) = text(fill: red)[$#x$]
#let luv(x) = text(fill: purple)[$#x$]
#table(
  columns: (auto, auto, auto),
  align: (center, left, center),
  stroke: none,
[
  $mat(delim: "[",2, 1, 2; lur(0), lur(3), lur(1); 4, -4, 4)$
    ], [$R_2 - (-4/2)R_1$], [
    $mat(delim: "[", 1, 0, 0; lub(-2), 1, 0; 0, 0, 1)$
    ],
  [
  $mat(delim: "[",2, 1, 2; 0, 3, 1; lur(0), lur(-6), lur(0))$
    ], [$R_3 - 4/2R_1$], [
    $mat(delim: "[", 1, 0, 0; -2, 1, 0; lub(2), 0, 1)$
    ],
  [
  $mat(delim: "[",2, 1, 2; 0, 3, 1; lur(0), lur(0), lur(2))$
    ], [$R_3 - (-6/3)R_2$], [
    $mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, lub(-2), 1)$
    ],
  )

  So 
  $mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4) = 
  mat(delim: "[", 1, 0, 0; -2, 1, 0; 2, -2, 1)
  mat(delim: "[",2, 1, 2; 0, 3, 1; 0, 0, 2)  =
  L U $
]

= Crout Decomposition

Similar to Doolittle, Crout decomposition also factors our matrix $A$ into a product of two matrices: an upper $U$ and lower $L$ triangular matrix such that $A = L U$. This time, however, the matrix $U$ has $1$'s in its diagonal instead of $L$.

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

We can also solve this the same way as in Doolittle using Gaussian elimination but with additional normalization of the diagonals.


$mat(delim: "[",2, 1, 2; -4, 1, -3; 4, -4, 4)$

#[ // scope  
#let lub(x) = text(fill: blue)[$#x$]
#let lur(x) = text(fill: red)[$#x$]
#let luv(x) = text(fill: purple)[$#x$]
#table(
  columns: (auto, auto, auto),
  align: (center, left, center),
  stroke: none,
[
  $mat(delim: "[",lur(1), lur(1/2), lur(1); -4, 1, -3; 4, -4, 4)$
    ], [$luv(1/2R_1)$], [
    $mat(delim: "[", lub(2), 0, 0; 0, 1, 0; 0, 0, 1)$
    ],
  [
  $mat(delim: "[",1, 1/2, 1; lur(0), lur(3), lur(1); lur(0), lur(-6), lur(0))$
    ], [$mat(delim: #none, R_2 + 4R_1; R_3 - 4R_1)$], [
    $mat(delim: "[", 2, 0, 0; lub(-4), 1, 0; lub(4), 0, 1)$
    ],
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

== "In Place"  Algorithm

idk what it's called actually
=== Crout Version

There is another method for solving this.

// this seems close enough to what sir had shown
// https://magedkamel.com/wp-content/uploads/2026/02/PDF-for-post-9-3x3-crout-option-1.pdf

#include "miniarc2/crout inplacealgo.typ"

=== Doolittle Version

We can also do the same thing as above for Doolittle.

#include "miniarc2/doolittle inplacealgo.typ"



== Converting Doolittle to Crout and Vice-Versa 


=== The difference:

It's like a sandwich where in the Doolittle, the bottom has the non-1 diagonal entries so the bottom bread has the filling, but in Crout, it's like the bread on top has the filling

(insert image here)

= LDU Decomposition

=== Continuing the Sandwich Analogy:

This time, para siyang double decker, because both bottom and upper breads ($L, U$ in the LDU) have the bread

(insert stuff there)

=== Converting from Doolitle to LDU to Crout and Vice Versa 


= Cholesky Decomposition

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

From here, notice that if we rewrite the diagonal factor D into the square of some matrix S, we get

#align(center)[
  $L D L^T = L (S S) L^T  = (L S)(S L^T) = (L S)(L S)^T$
]

Then, by setting LS = G, we finally have:

#align(center)[
  A = $(L S)(L S)^T = G G^T$
]

which is what we are looking for. That leaves us with finding some S such that SS = D (in this sense, one could think of S being $sqrt(D)$). However, note that because D is a diagonal matrix, we can get S by simply taking the square root of each entry of D.

However, the previously described step may be a trap. What happens if some $d_(i i)$ element of D is less than zero? Thankfully, Corollary 6.27 in Burden and Faires (9th ed.) gives us the following result:

#block(
	inset: (left: 1em),
	[
_The matrix A is positive deﬁnite if and only if $ A$ can be factored in the form $L D L^T$ , where $L$
is lower triangular with 1s on its diagonal and $D$ is a diagonal matrix with positive diagonal
entries._
	]
)

Since we know that $A$ is positive definite, we can conclude that D has positive entries!

As a sanity check, we can verify that $G = L S$ is indeed lower triangular. Recall that L is a lower triangular matrix, and S is diagonal. From Math 40, we know that the right multiplication of any diagonal matrix $D'$ to any square matrix M (with the same dimension) only scales each column of M by its corresponding diagonal entry in $D'$. Hence, $G = L S$ maintains the same position of nonzero entries as L, and is also lower triangular.


#include "miniarc2/cholesky_algorithm_and_example.typ"

=== More sandwich

so it's like L, LT where the sandwiches both bread actually have the same amount of toppings

= A Possible Problem

*Note*: Although this technically was not discussed, this will be important for implementation, hence, we will also be including this.

Most of this section will be taken from Burden and Faires (specifically pages 407 - 409) 

== Motivating Problem:

Let's have the ff. system of equations:

$
6x_1 + 7x_2 = 67
$

$
6x_1 + 7x_2 + x_3 = 676
$

$
6x_1 + 9x_2 = 69
$

#pagebreak()
The coefficient matrix in this specific system is:

$
A = mat(
  delim: "[",
  6, 7, 0;
  6, 7, 1;
  6, 9, 0;
)
$


If we try doing our Doolittle Decomposition here:

$
"    U         L             EROs"
$

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
$
R_2 -> -R_1 + R_2, R_3 -> -R_1 + R_3
$

Now, there is a problem here, since in our hypothetical "U", $U_(22) = 0$, and we cannot decompose this to $L U$

So, what if we added a matrix for switching rows.

Let's call this matrix $P$.

$A x = b -> P A x = P b$.

Now, if A has an inverse, we can now try to factor factor $P A = L U$

But now, if we want $P A = L U$,

$P A x = P b$

$L U x = P b$

$(P^(-1) L U) x = b$

But now, remember matrix multiplication is associative.

$(P^(-1) L) U x = b$

$(P^(-1) L) (U x) = b$

Let $U x = y$, 

$(P^(-1) L) y = b$



According to Burden and Faires (2011), $P^(-1) = P^T$.

We can prove this using induction on the number of ERO 1 or row swap operations:

Let this number be $k$

*Base Case*: $k = 0$

$(I_n)^(-1) = I_n$

But note that $(I_n)^T = I_n$

So, $(I_n)^(-1) = (I_n)^T$

So, the base case is true.

*Inductive Hypothesis*: Suppose for some $l in NN_0$, for all $n times n$ matrices with $k = l$ ERO 1 operations performed, $P^(-1) = P^T$

*Induction Step*: $k = l + 1$

Let's call this matrix $P_(l + 1)$, the matrix after the $l$-th operation, $P_l$, and the $(l + 1)$-th row change be $E_(l + 1)$

$P_(l + 1) = E_(l + 1) P_l$

Notice that $(E_(l + 1) P_l)^T = (P_l)^T E_(l + 1)^T$

By induction hypothesis, $(P_l)^T = (P_l)^-1$

Now, notice that for any row swap, $E_(l + 1)^(-1) = E_(l + 1)$, but notice that $E_(l + 1) = E_(l + 1)^T$.

So, $E_(l + 1)^(-1) = E_(l + 1) = E_(l + 1)^T$

$(E_(l + 1) P_l)^T = (P_l)^T E_(l + 1)^T = (P_l)^(-1) (E_(l + 1))^(-1) = (E_(l + 1) (P_1))^(-1)$

So, $P^(-1) = P^T$

$(P^(T) L) y = b$

Since matrix multiplication is associative.

$P^(T) (L y) = b$

$P^(T) z = b$


=== Continuing the Sandwich Analogy:

Think of P as some toppings. It's the finishing touches before or after we can perform the $L U$ decomposition.

Now, let's go back to the previous example, but with the additional $P$

We should be able to solve everything from here now as long as A has an inverse.

$"    P         U         L             EROs"$

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

$P^T = mat(
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

$mat(
  delim: "[",
  1, 0, 0;
  0, 0, 1;
  0, 1, 0;
) z= mat(
  delim: "[",
  67;
  676;
  69;
)$

$z = mat(
  delim: "[",
  67;
  69;
  676;
)$

Then let's solve for $L y = z$

$mat(
  delim: "[",
  1, 0, 0;
  1, 1, 0;
  1, 0, 1;
) y = mat(
  delim: "[",
  67;
  69;
  676;
)$

For $y_1$:

$y_1 = 67$

For $y_2$:

$y_1 + y_2 = 69$

$67 + y_2 = 69$

$y_2 = 2$

For $y_3$:

$y_1 + y_3 = 676$

$67 + y_3 = 676$

$y_3 = 609$

So, $y = mat(
  delim: "[",
  67;
  2;
  609;
)$

Now, let's solve $U x = y$

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
)$

For $x_3$,

$x_3 = 609$

For $x_2$,

$2x_2 = 2$, so $x_2 = 1$

For $x_1$,

$6x_1 + 7x_2 = 67$

$6x_1 + 7(1) = 67$

$6x_1 + 7 = 67$

$6x_1 = 60$

$x_1 = 10$

So, $x = mat(
  delim: "[",
  60;
  1;
  609;
)$









man, it would help to know tricks for factoring out scalars when doing matrix stuff
= Using block matrices
These are recursive formulas for Doolittle, Crout, and Cholesky factorization. \
I got this idea from Trefethen. I actually started from the section on Cholesky decomposition(i copied the expression here, so i know its correct. the funny derivation tho is mine), and then I found another reference for LDU. 
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
These probably just become equivalent to the expressions sir Jus gave, when u actually do the computation.

== Computational Example Doolittle      
#include "miniarc2/computationalDoolittleEx.typ"

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

== Test for positive definite

We will be using positive definite to include the matrix being symmetric.

"A matrix $A$ is positive definite if it is symmetric and if $x^t A x > 0$ for every n-dimensional vector $x != 0$" (Burden & Faires, 2013, p. 414)

How do we test this?

*Step 1*: Test for Symmetry

This is relatively simple to do.

Given $A "an" n times n$ matrix,

$A$ is symmetric iff $forall 1 <= i, j <= n, i, j in ZZ, A_(i j) = A_(j i)$ 

*Step 2*: Try getting the Cholesky Decomposition:

Performing the Cholesky Algorithm is already available in the section above this. but this section will explain why if such decomposition without performing elementary row operation 1 does exist, then $A$ is positive definite.

First, we can show that if $A$ is positive definite then $A = L L^T$ for some lower triangular matrix $L$ by performing the algorithm as stated above. Alternatively, one could also perform an $L D U$ decomposition and then $L sqrt(D)$ and $sqrt(D) U$ can be applied as well.

Now, we only need to show that if $A = L L^t$ for some lower triangular matrix $L$, then $A$ is positive definite.

Notice that 

$x^t A x = x^t (L L^t) x$

Since matrix multiplication is associative:

$x^t (L L^t) x = (x^t L) (L^t x)$

But notice that $(x^t L)^t = (L^t x)$

So, $ (x^t L) (L^t x) = (x^t L) (x^t L)^t$

which is another dot product

However, note that $x^t$ is a $1 times n$ matrix and $L$ is an $n times n$ matrix, so letting $y = (x^t L)$

$y$ is a $1 times n$ matrix

Let $y = [y_1, y_2, ..., y_n]$ for $y_1, y_2, ..., y_n in RR$

$(x^t L) (x^t L)^t = y (y^t) = (y_1 ^2 + y_2^2 + ... y_n^2 ) >= 0$

The equality condition is only iff $y_1, y_2, ..., y_n$ are all 0. or $y$ is the 0 vector.

Suppose, all the entries of $y$ are 0

then $L^t x = y^t = mat(delim: "[", 0; 0; .;.;.; 0)$

However, 

$L(L^t x) = L (mat(delim: "[", 0; 0; .;.;.; 0))$

$(L L^t) x = mat(delim: "[", 0; 0; .;.;.; 0)$

$A x = mat(delim: "[", 0; 0; .;.;.; 0)$

Since $A$ is non-singular,

$A^(-1) A x = A^(-1) mat(delim: "[", 0; 0; .;.;.; 0)$

$ x = mat(delim: "[", 0; 0; .;.;.; 0)$

This indicates that if $y$ is 0 then $x$ is also the 0-vector, but the positive definite definition implies that $x$ cannot be the 0-vector.

So, y's entries are not all 0.

So, the equality condition is not met, so $x^t A x = (x^t L) (x^t L)^t = y (y^t) = (y_1 ^2 + y_2^2 + ... y_n^2 ) > 0$

Therefore, $forall$ nonzero vectors $x$ $x^t A x > 0$, which means $A$ is positive definite.

Additional note: This proof also holds regardless if the matrix is lower triangular as long as $L$ and $L^t$ have an inverse.

*Sidenote*: 

"A symmetric matrix $A$ is positive definite if and only if all the eigenvalues of $A$ are positive" (Burden & Faires, 2013, p. 573).

The following proof's ideas are taken from Burden & Faires, 2013 page 573:

*First, the "if" direction, to show that a positive definite matrix has positive eigenvalues.
*
Let $lambda$ be an eigenvalue of $A$, and have associated eigenvalue $x$

Let $x = mat(delim: "[", x_1; x_2; .;.;.; x_n)$

Because A is positive definite, then for any vector, including A's eigenvectors $x$.

$0 < x^t A x$

But since $lambda x = A x$

$0 < x^t A x = x^t lambda x$

Note, $lambda$ is a scalar

$0 < x^t A x = x^t lambda x = lambda x^t x = lambda (x_1^2 + x_2^2 + ... + x_n^2)$

But note that $ (x_1^2 + x_2^2 + ... + x_n^2) >= underbrace(0 + 0 + 0 + ... + 0, n "times") = 0$

However, note that the 0 vector cannot be an eigenvalue, so $(x_1^2 + x_2^2 + ... + x_n^2) != underbrace(0 + 0 + 0 + ... + 0, n "times") = 0$,

So, $(x_1^2 + x_2^2 + ... + x_n^2) > 0$

Since $(x_1^2 + x_2^2 + ... + x_n^2) > 0$ and $lambda (x_1^2 + x_2^2 + ... + x_n^2) > 0$, so $lambda > 0$

*Second, we have the only if direction*

We, now, want to show that if $A$ has positive eigenvalues, then $A$ is positive definite.

Now, let's rewrite $A$, according to Burden and Faires (2013),  we can use Gram-Schmidt on the eigenvectors to make an orthonormal set of eigenvectors.

Because the eigenvectors are linearly independent and of size $n$, we express any nonzero vector $x$ as 

"$"                  "x = sum_(i = 1)^n beta_i v^(i)$" 

where $v^i$ represents the eigenvectors and $beta_i$ is some constant where the $beta_1, beta_2, ..., beta_n$ are not all 0 (Burden and Faires, 2013, p. 573).

For any nonzero vector x,

$x^t A x = x^t (sum_(i = 1)^n beta_i A v^(i)) = x^t (sum_(i = 1)^n beta_i lambda_i v^(i))$

But notice

$x^t = ((beta_1) v^1 + (beta_2) v^2 + ... + (beta_n) v^n)^t = ((beta_1) v^1)^t + ((beta_2) v^2)^t + ... + ((beta_n) v^n)^t = beta_1 (v^1)^t + beta_2 (v^2)^t + ... + beta_n (v^n)^t$

So,

$x^t (sum_(i = 1)^n beta_i lambda_i v^(i)) = (beta_1 (v^1)^t + beta_2 (v^2)^t + ... + beta_n (v^n)^t) (sum_(i = 1)^n beta_i lambda_i v^(i)) = (sum_(j = 1)^n beta_j (v^j)^t)((sum_(i = 1)^n beta_i lambda_i v^(i))$

So, this is equal to

$= sum_(j = 1)^n sum_(i = 1)^n (beta_j (v^j)^t) (beta_i lambda_i v^(i)) =  sum_(j = 1)^n sum_(i = 1)^n (beta_j beta_i lambda_i v^(i) (v^j)^t)$

However, because the set of eigenvectors is orthonormal

If $i != j$, $v^(i) (v^j)^t = 0$

If $i = j$, $v^(i) (v^j)^t = 1$

So, 

$sum_(j = 1)^n sum_(i = 1)^n (beta_j beta_i lambda_i v^(i) (v^j)^t) = sum_(i = 1)^n beta_i^2 lambda_i >= underbrace((0^2 * 0) + (0^2 * 0) + ... + (0^2 * 0), n " times") = 0$

This is only equal to 0 if $beta_1, beta_2, ..., beta_n$ are all equal to 0 since the eigenvalues are already positive. 

But since $beta_1, beta_2, ..., beta_n$ was defined to be not all 0, then this does not meet the equality case so $x^t A x = sum_(i = 1)^n beta_i^2 lambda_i >= 0$

Getting the eigenvalues can be done using the cofactor method, which is extremely slow, but more methods will be available in the later section of the notes.

#pagebreak()

Compend




TODO \ - no need na we have 2 equivalent working methods already
Apparently we need to check each _leading principal minor_. This is a determinant of a certain submatrix. 

#bibliography("miniarc2/refs.bib", full: true, style: "apa") // idk which style