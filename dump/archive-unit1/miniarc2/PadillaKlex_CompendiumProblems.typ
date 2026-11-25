PADILLA, Klex

#let solution-box(body) = align(center)[
  #box(
    stroke: 1pt,
    inset: 5pt,
  )[
    #body
  ]
]

[Burden and Faires, Chapter 6, page 428, Item 31] Suppose that the positive definite matrix $A$ has the Cholesky factorization $A = L L^T$ and also the factorization $A = hat(L) D hat(L)^T$, where $D$ is the diagonal matrix with positive diagonal entries $d_(1 1), d_(2 2), ..., d_(n n)$. Let $D^(1/2)$ be the diagonal matrix with diagonal entries $sqrt(d_(1 1)), sqrt(d_(2 2)), ..., sqrt(d_(n n))$.

a. Show that $D = D^(1/2) D^(1/2)$.

Since $D^(1/2)$ is diagonal, this gives us the matrix:

== (a)

Show that

$
D = D^(1/2) D^(1/2).
$

=== Solution

Since

$
D =
mat(
  d_11, 0, dots.c, 0;
  0, d_22, dots.c, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots.c, d_(n n);
  delim: "["
)
$

we have

$
D^(1/2)
=
mat(
  sqrt(d_(1 1)), 0, dots.c, 0;
  0, sqrt(d_(2 2)), dots.c, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots.c, sqrt(d_(n n));

  delim: "["
).
$

Multiplying $D^(1/2)$ by itself,

$
D^(1/2) D^(1/2)
=
mat(
  sqrt(d_(1 1)), 0, dots.c, 0;
  0, sqrt(d_(2 2)), dots.c, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots.c, sqrt(d_(n n));

  delim: "["
)
mat(
  sqrt(d_(1 1)), 0, dots.c, 0;
  0, sqrt(d_(2 2)), dots.c, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots.c, sqrt(d_(n n));

  delim: "["
).
$


Because the product of two diagonal matrices is diagonal, with
diagonal entries equal to the products of the corresponding entries,

$
D^(1/2) D^(1/2)
=
mat(
  (sqrt(d_(1 1)))^2, 0, dots.c, 0;
  0, (sqrt(d_(2 2)))^2, dots.c, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots.c, (sqrt(d_(n n)))^2;

  delim: "["
).
$

#pagebreak()
Since each $d_(i i) > 0$, it follows that $(sqrt(d_(i i)))^2 = d_(i i).$

Therefore,

#solution-box($
D^(1/2) D^(1/2)
=
mat(
  d_(1 1), 0, dots.c, 0;
  0, d_(2 2), dots.c, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots.c, d_(n n);

  delim: "["
)
=
D.
$)

== (b)

Show that

$
L = hat(L) D^(1/2).
$

From part (a),

$
D = D^(1/2) D^(1/2).
$

Substituting into

$
A = hat(L) D hat(L)^T,
$

gives

$
A
=
hat(L)
(D^(1/2) D^(1/2))
hat(L)^T.
$

By associativity of matrix multiplication,

$
A
=
(hat(L) D^(1/2))
(D^(1/2) hat(L)^T).
$

Since $D^(1/2)$ is diagonal, it is symmetric. Hence

$
(D^(1/2))^T = D^(1/2).
$

By the transpose property $(A B)^T = B^T A^T$,

$
(hat(L) D^(1/2))^T
=
(D^(1/2))^T hat(L)^T
=
D^(1/2) hat(L)^T.
$

Therefore,

$
A
=
(hat(L) D^(1/2))
(hat(L) D^(1/2))^T.
$

Since $hat(L)$ is a unit lower triangular and $D^(1/2)$ is diagonal,
the matrix $hat(L) D^(1/2)$ is lower triangular with positive
diagonal entries.

But

$
A = L L^T
$

is the Cholesky factorization of $A$.

By uniqueness of the Cholesky factorization,

#solution-box($
L = hat(L) D^(1/2).
$)

#pagebreak()
== (c) Remix problem!
Without explicitly computing $L$, determine the diagonal entries of the Cholesky factor $L$ in terms of the diagonal entries of $D$.

From part (b), we have
$
L = hat(L) D^(1 / 2)
$

Since $hat(L)$ is unit lower triangular, 
$
(hat(L))_(i i) = 1
$
for $i = 1, 2, dots, n$.

Also, recall that:

$
D^(1 / 2) = mat(
  delim: "[",
  sqrt(d_11), 0, dots, 0;
  0, sqrt(d_22), dots, 0;
  dots.v, dots.v, dots.down, dots.v;
  0, 0, dots, sqrt(d_(n n));
)
$

The diagonal entries of a product of a lower triangular matrix and a diagonal matrix are obtained by multiplying the corresponding diagonal entries. Therefore,

$
l_(i i) = (hat(L))_(i i) (D^(1 / 2))_(i i)
$

Substituting the diagonal entries of $hat(L)$ and $D^(1 / 2)$,

$
l_(i i)
= 
(1)(sqrt(d_(i i)))
= 
sqrt(d_(i i))
$

Therefore, 

#solution-box(
  $l_(i i) = sqrt(d_(i i)) "for" i = 1, 2, dots, n$
)