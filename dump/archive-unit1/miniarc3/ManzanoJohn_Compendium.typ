#set math.mat(delim: "[")
= \#1 Burden and Faires Exercise Set 7.3 \#11 (a, b) p466 

Given the linear system

$
  x_1      &         && -x_3       && = 0.2    \
  -1/2 x_1 &+ x_2    && -1/4 x_3   && = -1.425 \
  x_1      &-1/2 x_2 && +x_3       && = 2      \
$
=== a. Is the coefficient matrix 

$
mat(
  1, 0, -1;
  -1/2 , 1, -1/4;
  1, -1/2, 1
)
$

strictly diagonally dominant?

*Solution.* (Note using A matrix is strictly diagonally dominant (SDD) if the magnitude of the diagonal value is greater than the magnitude of the sum of the magnitudes of the other entries in the same row.

Looking the first row, 
$
mat(
  1, 0, -1
)
\
abs(1) > abs(0) + abs(-1)
\
1 > 1
$
This is false, therefore the coefficient matrix is not SDD.

=== b. Compute the spectral radius of the Gauss - Seidel matrix $T_("GS")$

We have the coefficient matrix $A$, let $A = L + D+ U$
$ mat(
  1, 0, -1;
  -1/2 , 1, -1/4;
  1, -1/2, 1
)
=
mat(
  0, 0, 0;
  -1/2 , 0, 0;
  1, -1/2, 0
)
+
mat(
  1, 0, 0;
  0, 1, 0;
  0, 0, 1
)
+
mat(
  0, 0, -1;
  0, 0, -1/4;
  0, 0, 0
)
$
Using the result that $T_("GS") = -(D+L)^(-1)U$. Solving the inverse via augmenting the identity matrix:

$
mat(
  1, 0, 0,    1, 0, 0;
  -1/2 ,1, 0, 0, 1, 0;
  1, -1/2,1,  0, 0, 1
  , augment: #3
)
R'_2 = R_2 + 1/2 R_1
mat(
  1, 0, 0,    1, 0, 0;
  0 ,1, 0,    1/2, 1, 0;
  1, -1/2,1,  0, 0, 1
  , augment: #3
)
R'_3 = R_3 - R_1
mat(
  1, 0, 0,    1, 0, 0;
  0 ,1, 0,    1/2, 1, 0;
  0, -1/2,1,  -1, 0, 1
  , augment: #3
)
=>
\
=>
R'_3 = R_3 + 1/2 R_2
mat(
  1, 0, 0,    1, 0, 0;
  0 ,1, 0,    1/2, 1, 0;
  0, 0,1,    -3/4, 1/2, 1
  , augment: #3
)
\
-(D+L)^(-1) U =- mat(
  1, 0, 0;
  1/2, 1, 0;
  -3/4, 1/2, 1
)
mat(
  0, 0, -1;
  0, 0, -1/4;
  0, 0, 0
) = mat(
  0, 0, 1;
  0, 0, 3/4;
  0, 0, -5/8
  
)
$
Computing now the $rho(T_("GS"))$, since the resulting matrix is upper triangular, the eigenvalues are just the diagonal entries.
$
lambda_1 = lambda_2= 0
\
lambda_3 = -5/8
$
The eigenvalue with the largest magnitude is $lambda_2$ therefore:
$
rho(T_("GS")) = 5/8
$

= \#2: Burden and Faires Exercise Set 7.4 \#13 p 476 

Prove Kahan’s Theorem 7.24. 

[Hint: If $lambda_1, . . . , lambda_n "are eigenvalues of" T_omega, "then" det T_ω = product^n_(i=1) lambda_i
$
Since $det D^(-1) = det(D − omega L)^(-1)$ and the determinant of a product of matrices is the product of the determinants of the factors, the result follows from Eq. (7.18).]

Eq. (7.18) : $
x^((k)) = (D - omega L)^(-1) [(1 - omega) D + omega U] x^((k-1)) + omega (D - omega L)^(-1) b.
$

*Note: Using $A = L+ D + U$ while textbook uses for the given equation $A= D - L - U$*

Kahan' Theorem:

If $a_(i i) != 0$, for each$ i = 1, 2, . . . , n,$ then $rho(T_omega) ≥ |omega − 1|$. This implies that the SOR method can converge only if $0 < omega < 2$

Proof:

We know that the iteration matrix $T_omega$ is:
$
T_omega = (D+ omega L)^(-1)[(1-omega)D-omega U]
$
Computing $det(T_omega)$ using the properties of the determinant $det(A B) = det(A) dot det(B) "and" det(A^(-1)) = 1/det(A)$:
$
det(T_omega) &= det((D+ omega L)^(-1)[(1-omega)D-omega U])
\
&= 
det((D+ omega L)^(-1)) dot det([(1-omega)D-omega U])
\
&=
1/(det(D+ omega L)) dot det([(1-omega)D-omega U])

$

We know that for triangular matrices, the determinant is given by the product of their diagonal entries.

Using the fact that $(D+omega L)$ is lower triangular, $(1-omega)D$ is a diagonal matrix, and lastly $omega U$ is upper triangular with a zero diagonal (implies no contribution to the diagonal therefore only depend on diagonal of $(1-omega)D$ for the determinant), we have:
$
det(D + omega L) &= product_(i=1)^n a_(i i) 
\
det((1-omega)D - omega U) &= det((1-omega)D) 
\
&= product_(i=1)^n (1-omega) a_(i i) 
\
&= (1-omega)^n product_(i=1)^n a_(i i)
$

Substituting both determinants into $det(T_omega)$:
$
det(T_omega) = 1/(product_(i=1)^n a_(i i)) dot (1-omega)^n product_(i=1)^n a_(i i)
$
Notice that the products cancel out leaving us with:
$
det(T_omega) = (1-omega)^n.
$



Since the determinant is the product of the eigenvalues, $product_(i=1)^n lambda_i = det(T_omega) = (1-omega)^n$. Taking absolute values:
$
product_(i=1)^n abs(lambda_i) = abs(1-omega)^n.
$

The expression above implies that the eigenvalue with largest magnitude is at least $abs(1-omega)$ for the equation to hold. All of the magnitudes cannot all be smaller than $abs(1-omega)$ else their product would be less than $abs(1-omega)^n$

Since spectral radius $rho$ is the largest magnitude eigenvalue, also $abs(1-omega) = abs(omega - 1)$:

$
rho(T_omega) = max_(1<=i<=n) 
\
abs(lambda_i) >= abs(omega-1)
$
Assume that SOR converges, i.e $rho(T_omega)<1$:
$
rho(T_omega) &>= abs(omega-1)
\
1 &> abs(omega-1)
\
1 &> omega - 1 > -1
\
2 &> omega > 0
$

$therefore$ The SOR method can converge only when $0 < omega < 2. wide  qed$


= Remix Problem

Given
$
A = mat(
  1, 0, -1; 
  -1/2, 1, -1/4; 
  1, -1/2, 1),
$

a. Show that $A$ is not SDD and find $rho(T_("GS"))$.

b. For $omega = 2$, compute $T_omega$ and $det(T_omega)$.

c. Explain why SOR with $omega = 2$ cannot converge, and compare with the spectral radius from (a).

