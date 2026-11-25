= Problem 13, Problem Set 2.3, Numerical Methods in Engineering with MATLAB (Kiusalaas), p. 95

#set math.mat(delim: "[")

#let xv = $bold(upright(x))$
#let cv = $bold(upright(c))$
#let bv = $bold(upright(b))$
#let zerov = $bold(upright(0))$
#let ii = $i i$
#let ww = $omega$

Use the Gauss-Seidel method with relaxation to solve $A xv = bv$,
where:
$
A = mat(4, -1, 0, 0 ; -1, 4, -1, 0 ; 0, -1, 4, -1; 0, 0, -1, 3),
quad
bv = mat(15 ; 10; 10 ; 10)
$
Take $x_i = b_i / a_ii$ as the starting vector and use $omega = 1.1$
for the relaxation factor.

Ensure your answer's relative forward error in the 
$l_2$ norm is 
$< "TOL" = 10^(-4)$.

_Editor's note:_ This problem appears in a textbook about
MATLAB, thus, you are expected to be able to use computer
programs to help solve it. However, please *do not simply
invert the matrix*; this will not help you learn anything.

== Answer
We first decompose $A$ into $D$, $L$, and $U$ such that
$A = D + L + U$.

It can easily be shown that:
#let DD = $mat(
  4, 0, 0, 0;
  0, 4, 0, 0;
  0, 0, 4, 0;
  0, 0, 0, 3
)$
#let LL = $mat(
  0, 0, 0, 0;
  -1, 0, 0, 0;
  0, -1, 0, 0;
  0, 0, -1, 0
)
$
#let UU = $mat(
  0, -1, 0, 0;
  0, 0, -1, 0;
  0, 0, 0, -1;
  0, 0, 0, 0
)
$

$ D = DD, quad L = LL, quad U = UU $

We will skip over finding inverses and other arithmetic for
purposes of brevity. There are available computer functions
for this, in any case.

Now, inputting these into our formula for Sucessive
Over-relaxation, our iteration matrix becomes:

#let DLinv = $mat(
  4.0, 0.0, 0.0, 0.0;
  -1.1, 4.0, 0.0, 0.0;
  0.0, -1.1, 4.0, 0.0;
  0.0, 0.0, -1.1, 3.0
)$

#let Tw = $mat(
  -0.1, 0.275, 0.0, 0.0;
  -0.0275, -0.02437, 0.275, 0.0;
  -0.00756, -0.0067, -0.02437, 0.275;
  -0.00277, -0.00246, -0.00894, 0.00083
)$

#let cw = $mat(4.1250; 3.88438; 3.81820; 5.06667)$

$
T_ww &= (D + ww L)^(-1)[(1 - ww)D - ww U]
\    &= (DD + 1.1 LL)^(-1)((-0.1)DD - 1.1 UU)
\    &= DLinv^(-1) mat(
  -0.4, 1.1, 0.0, 0.0;
  0.0, -0.4, 1.1, 0.0;
  0.0, 0.0, -0.4, 1.1;
  0.0, 0.0, 0.0, -0.3
)
\ &= mat(
  -1/10, 11/40, 0/1, 0/1;
  -11/400, -39/1600, 11/40, 0/1;
  -121/16000, -429/64000, -39/1600, 11/40;
  -1331/480000, -1573/640000, -143/16000, 1/1200
) approx Tw
$
rounded to 5 decimal places.

and our constant vector becomes:
$
cv_ww &= (D + ww L)^(-1) [ww bv]
       =  (D + 1.1 L)^(-1) [1.1 dot bv]
\     &= DLinv^(-1) mat(16.5; 11.0; 11.0; 11.0)
\     &= mat(33/8; 1243/320; 48873/12800; 1945603/384000)
      approx cw
$

such that the final iteration form looks like:
$
xv^((k)) &= T_ww x^((k-1)) + cv_w
\        &= Tw x^((k-1)) + cw
$

Now, we iterate and continually compare the output.

#table(
  columns: 4,
  align: center,

// This was programatically generated.
[$k$], [$xv^((k))$], [$A xv^((k))$], [$||A xv^((k)) - bv||_2$],
[0], [$mat(3.75000, 2.50000, 2.50000, 3.33333)^top$], [$mat(12.50000, 3.75000, 4.16667, 7.50000)^top$], [$9.25150$],
[1], [$mat(4.43750, 4.40781, 4.62882, 5.03057)^top$], [$mat(13.34219, 8.56493, 9.07688, 10.46288)^top$], [$2.42367$],
[2], [$mat(4.89340, 4.92783, 5.02568, 5.00636)^top$], [$mat(14.64577, 9.79223, 10.16852, 9.99340)^top$], [$0.44395$],
[3], [$mat(4.99081, 5.01175, 5.00241, 5.00025)^top$], [$mat(14.95150, 10.05378, 9.99765, 9.99833)^top$], [$0.07248$],
[4], [$mat(5.00415, 5.00063, 5.00000, 4.99998)^top$], [$mat(15.01597, 9.99837, 9.99940, 9.99993)^top$], [$0.01607$],
[5], [$mat(4.99976, 4.99987, 4.99996, 4.99999)^top$], [$mat(14.99916, 9.99977, 9.99997, 10.00000)^top$], [$0.00087$],
[6], [$mat(4.99999, 5.00000, 5.00000, 5.00000)^top$], [$mat(14.99996, 10.00000, 10.00000, 10.00000)^top$], [$0.00004$],
[7], [$mat(5.00000, 5.00000, 5.00000, 5.00000)^top$], [$mat(15.00000, 10.00000, 10.00000, 10.00000)^top$], [$0.00000$],
)

Note that, while we only display 5 decimal digits here for
brevity, that all intermediate calculations are done to
machine precision.



== Remix
Notice the selected relaxation factor $w = 1.1$. What's so
special about it? Is it optimal? Why or why not?

For another challenge, try solving this simpler tridiagonal matrix
system of equations:
$
A = mat(3, -1, 0 ; -1, 3, 1 ; 0, 1, -3),
quad
bv = mat(6 ; 7 ; 9)
$

with the optimal relaxation factor.

It is up to you to provide the optimal relaxation factor, and
to prove why it is, indeed, optimal.

= Problem 10a-b, Exercise Set 7.3, Numerical analysis (Burden and Faires)
The linear system
$
   x_1 &+ &2x_2 &- &2x_3 &= &7,
\  x_1 &+ & x_2 &+ & x_3 &= &2,
\ 2x_1 &+ &2x_2 &+ & x_3 &= &5
$
has the solution $xv = mat(1, 2, -1)^top$.

Show that $rho(T_j) = 0$ and use the Jacobi method with
$xv^((0)) = zerov$ to approximate the linear system to within
$10^(-5)$ in the $l_infinity$ norm.

== Answer
We can write the system in matrix form $A xv = bv$, where:
#let AA = $mat(
  1, 2, -2;
  1, 1, 1;
  2, 2, 1;
)$
#let bb = $mat(
  7; 2; 5
)$
$
A = AA, quad bv = bb
$

We first find our Jacobi iteration matrices. Decomposing,
we have that:
#let DD = $mat(1, 0, 0; 0, 1, 0; 0, 0, 1)$
#let UU = $mat(0, 2, -2; 0, 0, 1; 0, 0, 0)$
#let LL = $mat(0, 0, 0; 1, 0, 0; 2, 2, 0)$
#let DDinv = $mat(1, 0, 0; 0, 1, 0; 0, 0, 1)$
$
D = DD, quad U = UU, quad L = LL
$

Applying our formulas, we have:
$
T_J &= -D^(-1)(L + U) 
\   &= -DD^(-1)(LL + UU )
\   &= -DDinv(mat(0, 2, -2; 1, 0, 1; 2, 2, 0))
\   &= mat(0, -2, 2; -1, 0, -1; -2, -2, 0)
$
and
$
c_J &= D^(-1) bv
\   &= DDinv bb
\   &= bb
$

#pagebreak()
such that our final iteration form is:
$
x^((k)) &= T_J dot x^((k-1)) + c_J
\       &= mat(0, -2, 2; -1, 0, -1; -2, -2, 0) x^((k-1))
           + bb
$

Now, we must show that $rho(T_j) = 0$. Attempting to get
the characteristic polynomial of $T_J$ results in:
$
det(T_J - lambda I) &= lr(|mat(
  -lambda, -2, 2;
  -1, -lambda, -1;
  -2, -2, -lambda;
)|)

\ &= -lambda det mat(
  -lambda, -1;
  -2, -lambda;
)
+ 2 det mat(
  -1, -1;
  -2, -lambda;
)
+ 2 det mat(
  -1, -lambda;
  -2, -2;
)

\ &= -lambda (lambda^2 - 2)
+ 2 (lambda - 2)
+ 2 (2 - 2lambda)

\ &= -lambda^3 + 2lambda
+ 2lambda - 4
+ 4 - 4lambda

\ &= -lambda^3.
$

Thus, we have that:
$
-lambda^3 &= 0
\  lambda &= 0
$

and since the only eigenvalue is $0$, then $rho(T_j) = 0$.

Now, using the Jacobi method to approximate the linear
system to within $10^(-5)$ in the $l_infinity$ norm:  

#table(
  columns: 4,
  align: center,

// This was programatically generated.
[$k$], [$xv^((k))$], [$A xv^((k))$], [$||A xv^((k)) - bv||_infinity$],
[0], [$mat(0.00000, 0.00000, 0.00000)^top$], [$mat(0.00000, 0.00000, 0.00000)^top$], [$7.00000$],
[1], [$mat(7.00000, 2.00000, 5.00000)^top$], [$mat(1.00000, 14.00000, 23.00000)^top$], [$18.00000$],
[2], [$mat(13.00000, -10.00000, -13.00000)^top$], [$mat(19.00000, -10.00000, -7.00000)^top$], [$12.00000$],
[3], [$mat(1.00000, 2.00000, -1.00000)^top$], [$mat(7.00000, 2.00000, 5.00000)^top$], [$0.00000$],
)

Once again, arithmetic steps here are omitted for brevity.


== Remix
Approximate the system using 1 iteration of Jacobi's
method, also with $xv^((0)) = zerov$. Then, iteratively
refine the solution using correction vectors until you also
get an answer within $10^(-5)$ in the $l_infinity$ norm.