#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [Shifted Inverse Power Method],
  subtitle: [ Arc 4 · Sarmiento Remix Problems ])
  
== Problem 1
*Exercise 18.* Use the shifted inverse power method with $x_0$ = (1,0,0) to estimate the eigenvalue of A near $sigma = -1.4$, with an accuracy to four decimal places. (David Lay, Steven Lay, and Judi McDonald. Linear Algebra and its Applications, p. 327)


We will be doing this for two iterations. Finding the shifted matrix $B = A-sigma I$,
$
B = A - (-1.4) I =
mat(
  9.4, 0, 12;
  1, -0.6, 1;
  0, 3, 1.4;
)
$
=== First Iteration
Solving $B z^((1)) = x^((0))$, we have

$

mat(
  9.4, 0, 12;
  1, -0.6, 1;
  0, 3, 1.4;
) z^((1)) = 
mat(
  1;
  0;
  0;
)
$

Solving for $z^((1))$ gives us
$
z^((1)) =
mat(
  40;
  175/12;
  -125/4;
)
$
Normalizing this, we have
$
x^((1)) = 
z^((1))/(parallel z^((1))parallel_infinity)
= 
mat(
  1;
  35/96;
  -25/32
)
$

=== Second Iteration
Solving $B z^((2)) = x^((1))$, we have

$

mat(
  9.4, 0, 12;
  1, -0.6, 1;
  0, 3, 1.4;
) z^((1)) = 
mat(
  1;
  35/96;
  -25/32
)
$

Solving for $z^((2))$ gives us
$
z^((2)) =
mat(
  -305/8;
  -1025/72;
  2875/96;
)
$
Normalizing this, we have
$
x^((2)) = 
z^((2))/(parallel z^((2))parallel_infinity)
= 
mat(
  -1;
  -205/549;
  575/732
)
$
Calculating the corresponding eigenvalue, we have
$
lambda^((2)) = -1.4 + 1/(305/8) = -1.3738
$

== Problem 2
*Exercise 15.* $A x = lambda x$ with $x eq.not 0$. Let $alpha$ be a scalar different from the eigenvalues of $A$, and let $B = (A - alpha I)^(-1)$. Subtract $alpha x$ from both sides of the equation $A x = lambda x$, and use algebra to show that $1 / (lambda - alpha)$ is an eigenvalue of $B$, with $x$ a corresponding eigenvector. (David Lay, Steven Lay, and Judi McDonald. Linear Algebra and its Applications, p. 327)

Given:
$A x = lambda x, quad x eq.not 0 $

Subtract $alpha x$ from both sides:
$ A x - alpha x = lambda x - alpha x $

$ (A - alpha I) x = (lambda - alpha) x $

Since $alpha$ is not an eigenvalue of $A$, $lambda - alpha eq.not 0$, which implies that $(A - alpha I)$ is invertible. So, we have:
$ B (A - alpha I) x = B (lambda - alpha) x $
$ x = (lambda - alpha) B x $
$ 1 / (lambda - alpha) x = B x $

This gives us:
$ B x = 1 / (lambda - alpha) x $

Since $x eq.not 0$, this proves that $1 / (lambda - alpha)$ is an eigenvalue of $B$ with corresponding eigenvector $x$.

== Remixed Problem 1
For this remixed problem, we will be redoing the previous Problem 1 by using Rayleigh's Quotient to update the shift at each iteration.

We will be doing this for two iterations. The matrix is
$
A = mat(
  8, 0, 12;
  1, -2, 1;
  0, 3, 0;
)
$
with initial shift $sigma_0 = -1.4$.

=== First Iteration
Finding the shifted matrix $B_0 = A - sigma_0 I$,
$
B_0 = A - (-1.4) I =
mat(
  9.4, 0, 12;
  1, -0.6, 1;
  0, 3, 1.4;
)
$
Solving $B_0 z^((1)) = x^((0))$, we have
$
mat(
  9.4, 0, 12;
  1, -0.6, 1;
  0, 3, 1.4;
) z^((1)) =
mat(
  1;
  0;
  0;
)
$
Solving for $z^((1))$ gives us
$
z^((1)) =
mat(
  40;
  175/12;
  -125/4;
)
$
Normalizing this, we have
$
x^((1)) =
z^((1))/(norm(z^((1)))_oo)
=
mat(
  1;
  35/96;
  -25/32;
)
$
Calculating the Rayleigh quotient shift, we have
$
A x^((1)) =
mat(
  -11/8;
  -49/96;
  35/32;
)
$
$
alpha_1 =
((x^((1)))^T A x^((1)))/((x^((1)))^T x^((1)))
=
(-11131/4608)/(8033/4608)
= -11131/8033 approx -1.3859
$

=== Second Iteration
Finding the shifted matrix $B_1 = A - sigma_1 I$,
$
B_1 = A - (-11131/8033) I =
mat(
  75395/8033, 0, 12;
  1, -4935/8033, 1;
  0, 3, 11131/8033;
)
$
Solving $B_1 z^((2)) = x^((1))$, we have
$
mat(
  75395/8033, 0, 12;
  1, -4935/8033, 1;
  0, 3, 11131/8033;
) z^((2)) =
mat(
  1;
  35/96;
  -25/32;
)
$
Solving for $z^((2))$ gives us
$
z^((2)) approx
mat(
  -24.0280;
  -8.9816;
  18.8770;
)
$
Normalizing this, we have
$
x^((2)) =
z^((2))/(norm(z^((2)))_oo)
approx
mat(
  -1.2729;
  -0.4758;
  1.0000;
)
$
Calculating the Rayleigh quotient shift, we have
$
A x^((2)) approx
mat(
  1.8168;
  0.6787;
  -1.4274;
)
$
$
sigma_2 =
lambda^((2)) =
((x^((2)))^T A x^((2)))/((x^((2)))^T x^((2)))
= -1.4272
$



