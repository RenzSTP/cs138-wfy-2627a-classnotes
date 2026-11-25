// Made by Klex Felouise G. Padilla :DD

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

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


== Cholesky Algorithm

Given a symmetric positive definite matrix $A= [a_(i j)]$,
compute a lower triangular matrix $L=[l_(i j)]$ such that
$A=L L^T$.

For $j=1,2,...,n$:

1. Compute the diagonal entry

$
l_(j j) =
sqrt(
  a_(j j) - sum_(k=1)^(j-1) l_(j k)^2
).
$

2. For $i=j+1,...,n$, compute

$
l_(i j) =
frac(
  a_(i j) - sum_(k=1)^(j-1) l_(i k) l_(j k),
  l_(j j)
).
$

3. Set $l_(i j)=0$ for $i<j$.

== Worked Example

#example(number: "")[
  
  Consider the symmetric positive definite matrix
  
  $
  A = mat(
    4, 2, 2;
    2, 5, 3;
    2, 3, 6;
    delim: "["
  )
  $
  
  and the right-hand-side vector
  
  $
  b = mat(
    14; 21; 26;
    delim: "["
  )
  $.
  We first find a lower triangular matrix $L$ such that $A = L L^T$.
  
  Write
  $
  L = mat(
    l_(11), 0, 0;
    l_(21), l_(22), 0;
    l_(31), l_(32), l_(33);
    delim: "["
  )
  $
  
  We compute the entries of $L$ column by column using the Cholesky algorithm.
  
  *Step 1: Compute the first column*
  
  For $j = 1$, the diagonal entry is
  
  $
  l_(11)
  = sqrt(a_(11))
  = sqrt(4)
  = 2.
  $
  
  For $i=2$,
  
  $
  frac(2,2)
  =1.
  $
  
  For $i=3$,
  
  $
  frac(2,2)
  =1.
  $
  
  Thus, after the first column,
  
  $
  L =
  mat(
  2, 0, 0;
  1, ?, 0;
  1, ?, ?;
  delim: "["
  ).
  $
  
  *Step 2: Compute the second column*
  
  For $j = 2$, compute the diagonal entry:
  
  $
  sqrt(
    a_(22) - sum_(k = 1)^1 l_(2k)^2
  )
  $
  
  $
  = sqrt(
    5 - l_(21)^2
  )
  = sqrt(
    5 - 1^2
  )
  = sqrt(4)
  = 2.
  $
  
  Next, compute $l_(32)$:
  
  $
  frac(
    a_(32) - sum_(k = 1)^1 l_(3k) l_(2k),
    l_(22)
  )
  $
  
  $
  frac(
    3 - (1)(1),
    2
  ) = 1.
  $
  
  Thus, 
  
  $
  L = mat(
    2, 0, 0;
    1, 2, 0;
    1, 1, ?;
    delim: "["
  )
  $
  
  *Step 3: Compute the third column*
  
  For $j = 3$, compute the final diagonal entry:
  
  $
  sqrt(
    a_(33) - sum_(k = 1)^2 l_(3k)^2
  )
  $
  
  $
  sqrt(
    6 - l_(31)^2 - l_(32)^2
  )
  $
  
  $
  sqrt(
    6 - 1^2 - 1^2
  )
  = sqrt(4)
  = 2.
  $
  
  Therefore,
  
  $ 
  L = mat(
    delim: "[",
    2, 0, 0;
    1, 2, 0;
    1, 1, 2;
  ).
  $

We can verify the factorization:

$ L L^T =
mat(
2, 0, 0;
1, 2, 0;
1, 1, 2;
)

mat(
2, 1, 1;
0, 2, 1;
0, 0, 2;
)
=
mat(
4, 2, 2;
2, 5, 3;
2, 3, 6;
)
= A.
$

=== Solving $A x = b$ using Cholesky

Once the Cholesky factorization

$
A = L L^T
$

has been computed, we can solve the system

$
A x = b
$

without directly computing $A^(-1)$.

Substituting $A=L L^T$ gives

$
L L^T x = b.
$

Because matrix multiplication is associative, we can first solve

$
L y = b,
$

and then solve

$
L^T x = y.
$

Thus, solving $A x=b$ using Cholesky requires two triangular
systems:

Solve $L y=b$ using forward substitution.
Solve $L^T x=y$ using backward substitution.

*Step 1: Forward substitution*

For our example,

$
L y = b
$

becomes

$
mat(
14;
21;
26;
delim: "["
).
$

From the first row,

$
2y_1 &= 14, \
y_1 &= 7.
$

From the second row,

$
y_1+2y_2=21.
$

Substituting $y_1=7$,

$
7+2y_2 &= 21, \
2y_2 &= 14 \
y_2 &= 7.
$

From the third row,
$
y_1 + y_2 + 2y_3 = 26.
$

Substituting $y_1 = 7$ and $y_2 = 7$,

$
7 + 7 + 2y_3 &= 26, \
2y_3 &= 12 \
y_3 &= 6.
$

Therefore,
$
y = mat(
  7;
  7;
  6;
  delim: "["
)
$

We can verify the result directly:

$
L y = mat(
2, 0, 0;
1, 2, 0;
1, 1, 2;
delim:"[")
mat(
  7;
  7;
  6;
  delim: "["
)
=
mat(14; 21; 26; delim: "[") = b.
$
*Step 2: Backward substitution*

Next, we solve

$
L^T x=y.
$

Since

$
L^T =
mat(
2, 1, 1;
0, 2, 1;
0, 0, 2;
delim: "["),
$

we obtain

$
mat(
2, 1, 1, |, 7;
0, 2, 1, |, 7;
0, 0, 2, |, 6;
delim: "["
).
$

Starting from the third row,

$
2x_3 &= 6, \
x_3 &= 3.
$

From the second row,

$
2x_2+x_3=7.
$

Substituting $x_3=3$,

$
2x_2+3 &= 7, \
2x_2 &= 4 \
x_2 &= 2.
$

Finally, from the first row,

$
2x_1 + x_2 + x_3 = 7.
$

Substituting $x_2=2$ and $x_3=3$,

$
2x_1+2+3 &= 7, \
2x_1 &= 2 \
x_1 &= 1.
$

Verifying,

$
L^T x =
mat(
2, 1, 1;
0, 2, 1;
0, 0, 2;
delim: "[")mat(1;2;3; delim: "[") = 
y = mat(
  7;
  7;
  6;
  delim: "["
)
.
$



Therefore, the solution is

$
x = mat( 1; 2; 3; delim:"[").
$
]
The important computational advantage is that after computing the Cholesky factorization $A=L L^T$, each system with the same matrix $A$ can be solved using two triangular substitutions rather than recomputing a factorization or explicitly computing $A^(-1)$.