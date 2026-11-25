#set page("a4", margin: 1cm, columns: 2)
#set par(spacing: 1em)

== Introduction to Systems of Linear Equations (SLEs)
 *Vector Norms Axioms*: $norm(bold(x)) >= 0$, and $norm(bold(x)) = 0 arrow.l.r.double bold(x) = bold(0)$; $norm(alpha bold(x)) = abs(alpha) norm(bold(x))$; $norm(bold(x) + bold(y)) <= norm(bold(x)) + norm(bold(y))$.

*$l_1$*: $norm(bold(x))_1 = sum_(i=1)^n |x_i|$.
;*$l_2$*: $norm(bold(x))_2 = (sum_(i=1)^n x_i^2)^(1/2)$

*$l_oo$*: $norm(bold(x))_oo = max_(1 <= i <= n) |x_i|$.


*Matrix Norms Axioms: *
$norm(A) >= 0$
;$norm(A) = 0 arrow.l.r.double A = 0$
;$norm(alpha A) = abs(alpha) norm(A)$ 
;$norm(A + B) <= norm(A) + norm(B)$ 
;$norm(A B) <= norm(A) norm(B)$
;$norm(A) = max_(norm(bold(x))=1) norm(A bold(x))$

*Cauchy-Schwarz Inequality*: $abs(bold(x)^T bold(y)) <= norm(bold(x))_2 norm(bold(y))_2$

$lim_(k -> oo) A^k = 0 arrow.r.l.double rho(a)<1$

Condition number: $norm(A)norm(A^(-1))$

$||arrow(x) - tilde(x)|| \/ ||arrow(x)|| <= kappa(A) ||arrow(r)|| \/ ||arrow(b)||$

$norm(delta bold(x)) \/ norm(bold(x)) <= (kappa(A))  ( (norm(delta bold(b))) / (norm(bold(b))) + (norm(delta A)) / (norm(A)) ) \/
(1 - kappa(A) (norm(delta A)) / (norm(A)))$

// if the above looks ugly the origs are here vvv
// $(||arrow(x) - tilde(x)||)/(||arrow(x)||) <= kappa(A) (||arrow(r)||)/(||arrow(b)||)$
// $(norm(delta bold(x))) / (norm(bold(x))) <= (kappa(A)) / (1 - kappa(A) (norm(delta A)) / (norm(A))) ( (norm(delta bold(b))) / (norm(bold(b))) + (norm(delta A)) / (norm(A)) )$

== Gaussian Elimination, Gauss-Jordan Reduction, Pivoting Strategies

*Gaussian Elimination:* 
- Elimination: $R_i <- R_i - gamma R_k,  gamma= a_(i k) / a_(k k), k=1,2, dots, n, i = k + 1, k + 2, dots, n $
- Back-substitution: $x_i = 1 / a_(i i) (c_i - sum_(j=i+1)^n a_(i j) x_j),  i = n - 1, n - 2, dots, 1 $
*Gauss-Jordan:* Eliminate below and above pivot; $[A|b] =>[I|x] $

*Pivoting Strategies:*
- *Partial:* Current pivot column; choose largest $|a_(i k)|$; rows only.
- *Complete:* Entire active submatrix; choose largest $|a_(i j)|$; rows and columns.
- *Scaled Partial:* Current pivot column; choose largest $frac(|a_(i k)|, s_i)$; rows only.

== Matrix Factorization (for nonsingular $A$)



*Doolittle Decomposition*: $L_D U_D$, diags of $L_D$ are all 1.

*Crout Decomposition*: $L_C U_C$, diags of $U_C$ are all 1.

*Cholesky Decomposition*: $A = L L^T = (L_D sqrt(D))(sqrt(D) U_C)$ where $sqrt(D)$ = the matrix containing the square root of all of D's entries.

*Symmetric Positive Definite Matrix*: $A = A^T$ and for all nonzero vectors $x$, $x^T A x > 0$.

*LDU Decomposition*: $A = L D U$, L & U have diags of 1.

*Doolittle to LDU*: Divide rows of $U_D$ by their diagonals.

*LDU to Doolittle*: Keep $L_D$. Multiply row $i$ of $U$ by $D_(i i)$.

*Crout to LDU*: Divide cols of $L_C$ by their diagonals.

*LDU to Crout*: Multiply column $i$ of $L$ by $D_(i i)$. Keep $U_C$.

*Permutation Matrix*: Obtained by row swaps to $I_n$.


== Iterative methods
#let xv = $bold(upright(x))$
#let bv = $bold(upright(b))$
#let cv = $bold(upright(c))$
#let zerov = $bold(upright(0))$

General iteration scheme: $xv^((k)) = T xv^((k-1)) + cv$
\ With $A = D + L + U$,
- J :  $ T_("J") = -D^(-1)(L+U),
  cv_J = D^(-1) bv$
  - #box(inset: (top: 0.25em, bottom: 0.25em))[
    $  x_i^((k+1)) =
    1/a_(i i)
    (b_i - sum_(j=1, j != i)^n
    a_(i j) x_j^((k)))$
    ]
- GS : $ T_("GS") = -(D+L)^(-1)U$,
  $cv_("GS") = (D+L)^(-1) bv$
  - #box(inset: (top: 0.25em, bottom: 0.25em))[
    $  x_i^((k+1)) = 1/a_(i i) (
      b_i
      - sum_(j=1)^(i-1) a_(i j) x_j^((k+1))
      - sum_(j=i+1)^n a_(i j) x_j^((k))
    )$
    ]
- SOR : $ T_omega =
     (D + omega L)^(-1)[(1 - omega)D - omega U]$,
  \ $cv_omega = (D + omega L)^(-1) [omega bv]$
  - #box(inset: (top: 0.25em, bottom: 0.25em))[
    $   x_i^((k)) =
    (1 - omega) x_i^((k-1))
    + omega/a_(i i) (
      b_i
      - sum_(j=1)^(i-1) a_(i j) x_j^((k))
      - sum_(j=i+1)^n a_(i j) x_j^((k-1))
    )$
    ]

*Relaxation factor.* SOR converges
only if $0 < omega < 2$.
- If $A$ is positive definite, SOR converges
  for any $x^((0))$.
- If $A$ is positive definite and tridiagonal,
  then
  \ $rho(T_g) = [rho(T_j)]^2$ and the optimal
  $omega$ is given by
  \ $omega = 2 / (1 + sqrt(1 - [rho(T_j)]^2))$
  implying $rho(T_omega) = omega - 1$.


*Strictly diagonally dominant.* $A$ is SDD by rows
iff $|a_(i i)| > sum_(j=1,j!=i)^n |a_(i j)|$ for
every $i = 1, ..., n$.

== Iterative refinement

*Correction vector*. $Delta x = x - overline(x) = A^(-1) E$
where
\ $E = b - A overline(x)$ for approximate solution
$overline(x)$.

== Convergence conditions
$A$ is a convergent matrix iff $lim_(n -> infinity) A^n = 0$.
Equivalently,
+ $rho(T) < 1$
+ $lim_(n -> infinity) ||A^n|| = 0$ for some
  natural norm
+ $lim_(n -> infinity) A^n xv = zerov$ for all 
  $xv$

*Spectral radius.* $rho(T) = max{abs(lambda_1), abs(lambda_2), ... abs(lambda_n)}$
- Iteration converges to unique $xv$ _if and only if_ $rho(T) < 1$.

*Other convergence conditions.* Jacobi and Gauss-Seidel
converge when $A$ is *strictly diagonal*, or when $A$ is
*symmetric* and *positive definite*.

== Approximate Eigenvalues
 *Power Method* $A^k x^((0)) = c_1 lambda_1^k v_1 + sum_(i=2)^n c_i lambda_i^k v_i$
*Normalized Power Method*: $ x^((k+1)) = (A x^((k))) / norm(A x^((k)))$
*Inverse Power Method:* Solve $A y = x^((k))$, $m = max(abs(y))$, $x^((k+1)) = y slash m$. Then $lambda_n approx 1 slash m$.

*Shifted Inverse Power:* Solve $(A - sigma I) y = x^((k))$, $x^((k+1)) = y slash max(abs(y))$. Finds eigenvalue closest to shift $sigma$.
*Gershgorin Circle Theorem:* Disks $abs(z - a_(i i)) <= R_i$ where $R_i = sum_(j != i) abs(a_(i j))$ (row sum off-diagonal). All $lambda in union D_i$. $$

*Rayleigh's Quotient*: $lambda^*=frac(x^T A x,x^T x)$

*QR Iteration*
- Decomposition: _A = QR_,  
  

// *Misc facts.* Symmetric $arrow$ eigenvalues are real. SDD $arrow$ 0 not eigenvalue i.e. A invertible (by Gershgorin!). SDD + symmetric + diagonal entries are positive $arrow$ PD (again by Gershgorin). symmetric + PD $arrow$ eigenvalues are positive
// fuck its multiple lines already. just add it if theres space pa i guess, di naman to necessary (or helpful tbh)