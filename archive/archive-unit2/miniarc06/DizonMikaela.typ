#import "../assets.typ": qa, note, solution-box

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

= Eigenvalue BVPs
// Problems:
== Compendium Problem 1
#qa(auth:"DIZON, Mikaela S.")[
  *William Trench. Elementary Differential Equations with BVPs (Item 23, 11.1 Exercises)*

  Solve the eigenvalue problem

  #align(center)[$y'' + lambda y = 0, quad y(0) = 0, quad integral_0^L y(x) dif x = 0$]
][
Considering each sign of $lambda$,

  *Case 1: $lambda = 0$* \
  The equation is $y'' = 0$, so 
  #align(center)[$y = c_1 + c_2 x$]
  The first BC $y(0) = 0$ gives $c_1 = 0$, so $y = c_2 x$. \
  Then, applying the second BC,
  #align(center)[$integral_0^L c_2 x dif x = frac(c_2 L^2, 2) = 0$]

  so $c_2 = 0$. Only $y = 0$ works, so $lambda = 0$ is not an eigenvalue.

  *Case 2: $lambda < 0$* \
  Let $lambda = -k^2$ with $k > 0$. Then #align(center)[$y = c_1 cosh k x + c_2 sinh k x$.] The condition $y(0) = 0$ gives $c_1 = 0$, so $y = c_2 sinh k x$. \ Applying the other BC,
  #align(center)[$integral_0^L c_2 sinh k x dif x = c_2 frac(cosh k L - 1, k) = 0$]

  Since $cosh k L > 1$ for $k, L > 0$, we get $c_2 = 0$. Again, we get only the trivial solution $y = 0$, so there are no negative eigenvalues.

  *Case 3: $lambda > 0$* \
  Let $lambda = k^2$ with $k > 0$. We get the general solution
  #align(center)[$y = c_1 cos k x + c_2 sin k x$.] Applying the condition $y(0) = 0$ gives $c_1 = 0$, so $y = c_2 sin k x$. Then,

  #align(center)[$integral_0^L c_2 sin k x dif x = c_2 frac(1 - cos k L, k) = 0$]

  For a non-trivial solution, we need $c_2 != 0$, so $cos k L = 1$. This happens when
  #align(center)[$k L = 2 n pi$ \ $k = (2 n pi)/L$ for $n = 1, 2, 3, dots$]

  *Answer:*
  #solution-box[$
  lambda_n = (frac(2 n pi, L))^2, quad n = 1, 2, 3, dots$ \ $y_n = sin (frac(2 n pi x, L))$]
  Note that only the even multiples of $pi/L$ are considered. For example, $sin((pi x) / L)$ satisfies $y(0) = 0$, but its area on $[0, L]$ is $(2 L)/pi$, not $0$. So $lambda = (pi/L)^2$ is *not* an eigenvalue.
]

== Compendium Problem 2
#qa(auth:"DIZON, Mikaela S.")[
  *William Trench. Elementary Differential Equations with BVPs (Item 1, 11.1 Exercises)*

  Prove that $lambda = 0$ is an eigenvalue of the BVP

  #align(center)[$y'' + lambda y = 0, quad y(-L) = y(L), quad y'(-L) = y'(L)$]

  with associated eigenfunction $y_0 = 1$, and that any other eigenvalue must be positive.
][
  Considering each sign of $lambda$,

  *Case 1: $lambda = 0$* \ 
  The equation becomes $y'' = 0$, so
  #align(center)[$y = c_1 + c_2 x \ y' = c_2$]
  Applying BCs,

  - $y(-L) = y(L)$: 
  #align(center)[$c_1 - c_2 L &= c_1 + c_2 L \  => c_2 &= 0$]
  - $y'(-L) = y'(L)$:
  #align(center)[$c_2 = c_2$]

  So, we get $y = c_1$, for any $c_1$. Taking $c_1 = 1$, we get $y_0 = 1$, with $lambda = 0$ as its corresponding eigenvalue.

  *Case 2: $lambda < 0$* \
  Let $lambda = -k^2$ with $k > 0$. Then the equation becomes
  #align(center)[$y = c_1 cosh k x + c_2 sinh k x$ \ $y' = k c_1 sinh k x + k c_2 cosh k x$.]
  Applying BCs,
  - $y(-L) = y(L)$: 
  #align(center)[$c_1 cosh (-k L) + c_2 sinh (-k L) = c_1 cosh k L + c_2 sinh k L$ \ $c_1 cosh k L - c_2 sinh k L = c_1 cosh k L + c_2 sinh k L$ \ $c_2 sinh k L = 0$]
  
  - $y'(-L) = y'(L)$:
  #align(center)[$k c_1 sinh (-k L) + k c_2 cosh (-k L) = k c_1 sinh k L + k c_2 cosh k L$ \ $-k c_1 sinh k L + k c_2 cosh k L = k c_1 sinh k L + k c_2 cosh k L$ \ $c_1 sinh k L = 0$]

  Since $sinh k L != 0$ for $k, L > 0$, we get $c_1 = c_2 = 0$. From this, we can only get the trivial solution $y = 0$, so there are no negative eigenvalues.

  *Case 3: $lambda > 0$* \
  Let $lambda = k^2$ with $k > 0$. Then, we get
  #align(center)[$y = c_1 cos k x + c_2 sin k x$ \ $y' = -k c_1 sin k x + k c_2 cos k x$.]
  Applying BCs,
  - $y(-L) = y(L)$:
  #align(center)[$c_1 cos (-k L) + c_2 sin (-k L) = c_1 cos k L + c_2 sin k L$ \ $c_1 cos k L - c_2 sin k L = c_1 cos k L + c_2 sin k L$ \ $c_2 sin k L = 0$]
  - $y'(-L) = y'(L)$: 
  #align(center)[$-k c_1 sin (-k L) + k c_2 cos (-k L) = -k c_1 sin k L + k c_2 cos k L$ \ $k c_1 sin k L + k c_2 cos k L = -k c_1 sin k L + k c_2 cos k L$ \  $c_1 sin k L = 0$]

  To get a non-trivial solution, we need $sin k L = 0$, so 
  #align(center)[$k = (n pi)/L, quad n = 1, 2, 3, dots \ lambda = k^2 = ((n pi)/L)^2 , quad n = 1, 2, 3, dots$]
  
  Then $c_1$ and $c_2$ are both free.
  \ Thus, it is proven that in all three cases, all eigenvalues are positive.
]

== Remixed Problem
#qa(auth: "DIZON, Mikaela S.")[
  Find the eigenvalues $lambda$ and corresponding eigenfunctions for the BVP:

  #align(center)[$y'' + lambda y = 0, quad y(0) = -y(L), quad y'(0) = -y'(L), quad integral_0^L y(x) dif x = 0$]
][
  Considering each sign of $lambda$:

  *Case 1: $lambda = 0$* \
  The equation becomes $y'' = 0$, giving the general solution
  #align(center)[$y = c_1 + c_2 x \ quad y' = c_2$]
  Applying the BCs,
  - $y(0) = -y(L)$:
  #align(center)[$c_1 = -(c_1 + c_2 L) \ 2c_1 + c_2 L = 0$]
  - $y'(0) = -y'(L)$:
  #align(center)[$c_2 = -c_2 \ 2c_2 = 0 ==> c_2 = 0$]

  Substituting $c_2 = 0$ into the first condition gives $c_1 = 0$. Thus, we get $y = 0$, so $lambda = 0$ is not an eigenvalue.

  *Case 2: $lambda < 0$* \
  Let $lambda = -k^2$ with $k > 0$. Then
  #align(center)[$y = c_1 cosh k x + c_2 sinh k x$ \ $y' = k c_1 sinh k x + k c_2 cosh k x$]
  Applying the BCs,
  - $y(0) = -y(L)$:
  #align(center)[$c_1 = -(c_1 cosh k L + c_2 sinh k L) \ c_1(1 + cosh k L) + c_2 sinh k L = 0$]
  - $y'(0) = -y'(L)$:
  #align(center)[$k c_2 = -(k c_1 sinh k L + k c_2 cosh k L) \ c_1 sinh k L + c_2(1 + cosh k L) = 0$]

  This gives us the system
  #align(center)[$mat(1 + cosh k L, sinh k L; sinh k L, 1 + cosh k L) mat(c_1; c_2) = mat(0; 0)$]
  with the determinant 
  #align(center)[$(1 + cosh k L)^2 - sinh^2 k L = 2 + 2 cosh k L$] Since $cosh k L > 1$ for $k, L > 0$, the determinant is non-zero, so $c_1 = c_2 = 0$. Thus, there are no negative eigenvalues.

  *Case 3: $lambda > 0$* \
  Let $lambda = k^2$ with $k > 0$. The general solution is:
  #align(center)[$y = c_1 cos k x + c_2 sin k x$ \ $y' = -k c_1 sin k x + k c_2 cos k x$]
  Applying the BCs,
  - $y(0) = -y(L)$: 
  #align(center)[$c_1 = -(c_1 cos k L + c_2 sin k L) \ c_1(1 + cos k L) + c_2 sin k L = 0$]
  - $y'(0) = -y'(L)$: 
  #align(center)[$k c_2 = -(-k c_1 sin k L + k c_2 cos k L) \ c_1 sin k L + c_2(1 + cos k L) = 0$]
  This gives us the system
  #align(center)[$mat(1 + cos k L, sin k L; -sin k L, 1 + cos k L) mat(c_1; c_2) = mat(0; 0)$]

  Setting the determinant of the system to zero gives
  #align(center)[$(1 + cos k L)^2 - sin^2 k L = 2 cos k L (1 + cos k L) = 0$] This requires $cos k L = -1$ (which means $sin k L = 0$), yielding:
  #align(center)[$k_n = ((2n - 1) pi) / L, quad n = 1, 2, 3, dots$]
  At this stage, both $c_1$ and $c_2$ are free constants. 
  \ Now we apply the integral constraint:
  #align(center)[$integral_0^L (c_1 cos(((2n - 1) pi x) / L) + c_2 sin(((2n - 1) pi x) / L)) dif x = 0$]
  Evaluating the integrals over $[0, L]$:
  - $integral_0^L cos(((2n - 1) pi x) / L) dif x = 0$ \
  
  - $integral_0^L sin(((2n - 1) pi x) / L) dif x = (2L) / ((2n - 1) pi)$

  Thus, the constraint simplifies to $c_2 ((2L) / ((2n - 1) pi)) = 0$, which forces $c_2 = 0$, while $c_1$ remains free.

  *Answer:*
  #solution-box[$lambda_n = (((2n - 1) pi) / L)^2, quad n = 1, 2, 3, dots$ \
    $y_n = cos(((2n - 1) pi x) / L)$]]
\

== Links to Exercises
[1] Trench, W. (2013). Elementary Differential Equations with Boundary Value Problems. _Faculty Authored and Edited Books & CDs_.
https://digitalcommons.trinity.edu/mono/9