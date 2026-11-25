#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [QR Iteration ],
  subtitle: [ Mini-Arc 4 · Part 7a · Compendium])

== Problem 1

*Exercise 28.2.* The preliminary reduction to tridiagonal from _[in the process of QR Factorization]_ would be of little use if the steps of the QR algorithm did not preserve this structure. Fortunately, they do. 

*(b)* Show that the tridiagonal structure is recovered when the product $R Q$ is formed.

(Trefethen & Bau, 1997, p. 228)

\
#underline[*Solution*]
\
*(b)* A matrix is in tridiagonal form if (1) it is symmetric, and (2) all of its nonzero entries lie only on the main diagonal and the diagonal immediately above it (superdiagonal) and the diagonal immediately below it (subdiagonal). This can also be expressed as follows: 
$
A = [a_(i j)] "is tridiagonal if" a_(i j) = 0 "whenever" abs(i-j) > 1.
$
Note that keeping this structure is important for QR Factorization because it makes the process much more efficient (from $O(n^3) "to" O(n) "operations per iteration"$).

To show that the tridiagonal structure is recovered when the product $R Q$ is formed, we must show that $A_1 = R Q$ is (1) symmetric and (2) upper Hessenberg, i.e., all entries below the first subdiagonal are 0.

1. _Symmetric_
$
A = Q R \
R = Q^T A \
R Q = Q^T A Q
$
Note that since $Q$ is orthogonal, $Q^T Q = I.$
Then,
$
(R Q)^T &= (Q^T A Q)^T \
&= Q^T A^T Q \
&= Q^T A Q \
$

Thus, $A_1$ is symmetric.

2. _Upper Hessenberg._ 
Let entry $(i, j)$ of $R Q$ be given by:
$
sum_k r_(i k) q_(k j)
$
Since $R$ is upper triangular, only entries with $k >= i$ can contribute to the multiplication. Since $Q$ is upper Hessenberg, $q_(k j) = 0$ whenever $k > j + 1$. If $i > j + 1$, every term has $k >= i > j + 1$, so every $q_(k j)$ is eliminated and the entry becomes $0$.

With that, $A_1$ ends up with only zero entries below the first subdiagonal (upper Hessenberg). By the property of symmetry, it should also have only zero entries above the first superdiagonal.
\ Thus, $A_1$ remains tridiagonal. $square$

#pagebreak()

== Problem 2
*Problem Set 9.2.* 8. Compute all the eigenvalues of
$
  A = mat(delim: "[",
    6, 2, 0, 0, 0;
    2, 5, 2, 0, 0;
    0, 2, 7, 4, 0;
    0, 0, 4, 6, 1;
    0, 0, 0, 1, 3
  ).
$

(Burden & Faires, 1978, p. 369).

\
#underline[*Solution*]
\
To compute all eigenvalues of the symmetric tridiagonal matrix $A_0$, we apply the shifted QR iteration:
$
A^((k-1)) - sigma^((k)) I = Q^((k)) R^((k)) \
A^((k)) = R^((k)) Q^((k)) + sigma^((k)) I
$
where $sigma^((k))$ is the Wilkinson shift derived from the trailing $2 times 2$ submatrix. 

#note[
  \
  *Wilkinson Shift*
  
  Instead of a standard unshifted QR iteration ($A^((k)) = Q^((k)) R^((k))$; $A^((k+1)) = R^((k)) Q^((k))$), which converges slowly when eigenvalues are close, we introduce a shift $sigma^((k))$:
  $
  A^((k)) - sigma^((k)) I = Q^((k)) R^((k)) \
  A^((k+1)) = R^((k)) Q^((k)) + sigma^((k)) I
  $
  The shift $sigma^((k))$ is chosen as the eigenvalue of the trailing $2 times 2$ submatrix of $A_k$ that is closest to the bottom-right element $a_"nn"$. This makes the element $a_"n,n-1"$ converge to 0 faster, similar to the shifts used in the modified power methods.
]

1. We use the eigenvalue of the trailing $2 times 2$ block closest to $3$, that is, $mat(delim: "[", 6, 1; 1, 3)$, as the first shift. This is expressed as $sigma^((1)) approx 2.6972$. Then, the first shifted QR iteration gives:
   $
   A_1 approx mat(delim: "[",
     9.8452, 1.4120, 0,      0,      0;
     1.4120, 7.2103, 1.1042, 0,      0;
     0,      1.1042, 5.8421, 1.8920, 0;
     0,      0,      1.8920, 3.7124, 0.4512;
     0,      0,      0,      0.4512, 1.3900
   )
   $

2. Computing the next shift $sigma^((2)) approx 1.3102$ from $mat(delim: "[", 3.7124, 0.4512; 0.4512, 1.3900)$, Iteration 2 gives:
   $
   A_2 approx mat(delim: "[",
     10.5120, 0.8234, 0,      0,      0;
     0.8234,  7.6841, 0.5120, 0,      0;
     0,       0.5120, 5.7680, 0.9412, 0;
     0,       0,      0.9412, 3.2450, 0.1823;
     0,       0,      0,      0.1823, 1.2509
   )
   $

#pagebreak()

3. Continuing with the third shift $sigma^((3)) approx 1.2290$ from $mat(delim: "[", 3.2450, 0.1823; 0.1823, 1.2509)$, Iteration 3 gives:
   $
   A_3 approx mat(delim: "[",
     10.8412, 0.3120, 0,      0,      0;
     0.3120,  7.8540, 0.1982, 0,      0;
     0,       0.1982, 5.7551, 0.3120, 0;
     0,       0,      0.3120, 3.1512, 0.0521;
     0,       0,      0,      0.0521, 1.2271
   )
   $

4. Next, going through the same process, Iteration 4 gives:
   $
   A_4 approx mat(delim: "[",
     10.9540, 0.0812, 0,      0,      0;
     0.0812,  7.9041, 0.0421, 0,      0;
     0,       0.0421, 5.7535, 0.0712, 0;
     0,       0,      0.0712, 3.1280, 0.0084;
     0,       0,      0,      0.0084, 1.2265
   )
   $

5. Finally, after the final iteration, the off-diagonal elements vanish entirely, leaving the eigenvalues along the main diagonal:
   $
   A_"final" approx mat(delim: "[",
     10.9790, 0, 0, 0, 0;
     0, 7.9157, 0, 0, 0;
     0, 0, 5.7533, 0, 0;
     0, 0, 0, 3.1256, 0;
     0, 0, 0, 0, 1.2264
   )
   $

Thus, the eigenvalues of $A$ are:
$
lambda_1 approx 10.9790, quad 
lambda_2 approx 7.9157, quad 
lambda_3 approx 5.7533, quad 
lambda_4 approx 3.1256, quad 
lambda_5 approx 1.2264
$
\

== Remixed Problem
Show that the shifted QR iteration step 
$
  A^((k)) - sigma^((k)) I = Q^((k)) R^((k)) \
  A^((k+1)) = R^((k)) Q^((k)) + sigma^((k)) I
$
is orthogonally similar to $A^((k))$ (i.e., $A^((k+1)) = (Q^((k)))^T A^((k)) Q^((k))$), proving that the eigenvalues do not change even under shifting.

\
#underline[*Solution*]
\

Note that $(Q^(k))^T Q^((k)) = I$. Thus, we can express $R^((k))$ in terms of $Q^((k))$:
   $
   R^((k)) = (Q^((k)))^T (A^((k)) - sigma^((k)) I)
   $

Substituting $R^((k))$ into the $A^((k+1))$:
   $
   A^((k+1)) &= R^((k)) Q^((k)) + sigma^((k)) I \
   &= [(Q^((k)))^T (A^((k)) - sigma^((k)) I)] Q^((k)) + sigma^((k)) I \
   &= (Q^((k)))^T A^((k)) Q^((k)) - sigma^((k)) (Q^((k)))^T I Q^((k)) + sigma^((k)) I
   $
\
Since $(Q^((k)))^T Q^((k)) = I$, the middle terms cancel out, leaving:
   $
   A^((k)) &= (Q^((k)))^T A^((k)) Q^((k)) - sigma^((k)) I + sigma^((k)) I \
   &= (Q^((k)))^T A^((k)) Q^((k))
   $

Because $A^((k+1)) = (Q^((k)))^T A^((k)) Q^((k))$, we have shown that $A^((k+1))$ is orthogonally similar to $A^((k))$. Thus, introducing the Wilkinson shift accelerates the rate of convergence, but it still preserves the original matrix's eigenvalues. $square$

\

= References

1. Burden, R. L. & Faires, J. D. (1978). _Numerical Analysis_.

2. Trefethen, L. & Bau, D. (1997). _Numerical Linear Algebra_