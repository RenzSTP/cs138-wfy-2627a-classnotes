#let numtable(cols, headers, rows) = table(
  columns: cols,
  stroke: 0.5pt,
  align: center,
  table.header(..headers),
  ..rows.flatten(),
)

#align(center)[
  #text(size: 20pt, weight: "bold")[COMPENDIUM PROBLEMS]\
  #text(size: 12pt)[Linear and Nonlinear Shooting Methods]\
  #text(size: 11pt)[ZABALA, ROHAN MIGUEL M.]
]

= 1. Linear Shooting Method - Burden and Faires 11.1, Item 2(a)

*Given:* 
$ y'' = y' + 2 y + cos(x), quad 0 <= x <= pi/2, $
$ y(0) = -0.3, quad y(pi/2) = -0.1, quad h = pi/4. $

with given exact textbook solution

$ y_("exact")(x) = -frac(1,10) (sin(x) + 3 cos(x)). $

*Goal:* Approximate the solution with the Linear Shooting Method and compare the midpoint and endpoint values with the exact solution.


== Solution

Comparing $y'' = y' + 2 y + cos(x)$ with $y'' = p y' + q y + r$ gives
$ p(x)=1, quad q(x)=2, quad r(x)=cos(x). $

The interval is $[0,pi/2]$, with $alpha = -0.3$ and $beta = -0.1$. There are two equal steps because
$ N = frac(pi/2 - 0, pi/4)=2. $

Let $u_1 = y_1$ and $u_2 = y_1'$. Then
$ u_1' = u_2, quad u_2' = u_2 + 2u_1 + cos(x), $
with $u_1(0) = -0.3$ and $u_2(0) = 0$.

Let $v_1 = y_2$ and $v_2 = y_2'$. Then
$ v_1' = v_2, quad v_2'=v_2+2v_1, $
with $v_1(0)=0$ and $v_2(0)=1$.


Therefore, the fourth-order Runge–Kutta method is
$ K_1 = h G(x_i,U_i), $
$ K_2 = h G(x_i + h/2, U_i + K_1/2), $
$ K_3 = h G(x_i + h/2, U_i + K_2/2), $
$ K_4 = h G(x_i + h,U_i + K_3), $
$ U_(i+1) = U_i + frac(K_1 + 2K_2 + 2K_3 + K_4, 6). $

Combining the two IVPs: $U = (u_1, u_2, v_1, v_2)^T$:
$ U' = (u_2, u_2 + 2 u_1 + cos(x), v_2, v_2 + 2 v_1)^T. $

At $x_0 = 0$, the initial vector is
$ U_0 = (-0.3, 0, 0, 1)^T $.

The first RK4 stage is
$ G(0, U_0) = (0, 0.4, 1, 1)^T $,

so, with $h = pi/4$,
$ K_1 = (0, pi/10, pi/4, pi/4)^T $.

Compute $K_2$, $K_3$, and $K_4$, then repeat at $x_1 = pi/4$.

The RK4 results are:

#numtable((1.05fr, 1.35fr, 1.35fr, 1.35fr, 1.35fr),
  ($x$, $u_1(x)$, $u_2(x)$, $v_1(x)$, $v_2(x)$),
  (("0", "-0.300000000", "0.000000000", "0.000000000", "1.000000000"),
   ("π/4", "-0.144031364", "0.463065184", "1.415331559", "3.288798924"),
   ("π/2", "0.614565316", "1.747586352", "7.306318393", "14.822525202")))

Using $y(x) = y_1(x) + C y_2(x)$ and $y(pi/2) = -0.1$,

$ C = frac(-0.1 - u_1(pi/2), v_1(pi/2)) $
$ = frac(-0.1 - 0.614565316, 7.306318393) $
$ approx -0.097801010. $

At $x = pi/4$,

$ w_1 = u_1(pi/4) + C v_1(pi/4) $
$ = -0.144031364 + (-0.097801010)(1.415331559) $
$ approx -0.282452219. $

The exact value is

$ y_("exact")(pi/4) = -frac(1,10)(sin(pi/4) + 3 cos(pi/4)) $
$ = -frac(sqrt(2),5) approx -0.282842712. $

The absolute error is

$ |w_1 - y_("exact")(pi/4)| approx 0.000390493. $

#numtable((1fr, 1.4fr, 1.4fr, 1.4fr),
  ($x$, "Linear shooting", "Exact", "Absolute error"),
  (("0", "-0.300000000", "-0.300000000", "0"),
   ("π/4", "-0.282452219", "-0.282842712", "0.000390493"),
   ("π/2", "-0.100000000", "-0.100000000", "0")))

Therefore, the linear shooting approximation at $x = pi/4$ is *$-0.282452219$*, with an absolute error of $0.000390493$. The shooting coefficient is $C approx -0.097801010$.


= 2. Nonlinear Shooting Method - Burden and Faires 11.2, Item 1

*Given:* 
$ y'' = -(y')^2 - y + ln(x), quad 1 <= x <= 2, $
$ y(1) = 0, quad y(2) = ln(2), quad h = 0.5. $

with given exact textbook solution

$ y_("exact")(x) = ln(x). $

*Goal:* Apply the Nonlinear Shooting Algorithm using Newton's Method to adjust the unknown initial slope and compare against given solution $ln(x)$.

== Solution

Given
$ f(x,y,y') = -(y')^2 - y + ln(x), $

the partial derivatives are
$ f_y = -1, quad f_(y') = -2y'. $

Let $t = y'(1)$. The corresponding IVP is
$ y'' = -(y')^2 - y + ln(x), $
$ y(1) = 0, quad y'(1) = t. $

Let $z = partial y / partial t$. The variational equation is
$ z'' = -z - 2y'z', $
$ z(1) = 0, quad z'(1) = 1. $

Set $u_1 = y$, $u_2 = y'$, $v_1 = z$, and $v_2 = z'$. Then
$ U' = (u_2, -u_2^2-u_1+ln(x), v_2, -v_1 - 2u_2v_2)^T, $
$ U(1) = (0, t ,0,1)^T. $

The initial shooting slope is
$ t_0 = frac(ln(2) - 0, 2-1) = ln(2) approx 0.693147181. $

Using RK4 with $h = 0.5$, the initial vector is
$ U(1) = (0,ln(2),0,1)^T. $

The first RK4 stage is
$ K_1 = 0.5(ln(2), -(ln(2))^2, 1, -2ln(2))^T. $

The RK4 results are:

#numtable((0.85fr, 1.25fr, 1.25fr, 1.25fr, 1.25fr),
  ($x$, $u_1=y$, $u_2=y'$, $v_1=z$, $v_2=z'$),
  (("1", "0.000000000", "0.693147181", "0.000000000", "1.000000000"),
   ("1.5", "0.302079611", "0.538834522", "0.354826957", "0.463122539"),
   ("2", "0.553544457", "0.475060244", "0.491528998", "0.104710764")))

Using Newton's method,

$ t_(k+1) = t_k - frac(y(2,t_k)-ln(2),z(2,t_k)). $

For the first iteration,

$ t_1 = 0.693147181 - frac(0.553544457-ln(2),0.491528998) $
$ approx 0.977164450. $

Repeat RK4 using each updated slope:

#numtable((0.55fr, 1.20fr, 1.32fr, 1.32fr, 1.25fr),
  ("k", "tₖ", "y(2,tₖ)", "z(2,tₖ)", "tₖ₊₁"),
  (("0", "0.693147181", "0.553544457", "0.491528998", "0.977164450"),
   ("1", "0.977164450", "0.682872418", "0.421849773", "1.001520899"),
   ("2", "1.001520899", "0.693082280", "0.416534056", "1.001676710"),
   ("3", "1.001676710", "0.693147178", "0.416500308", "1.001676716")))

Therefore, the approximate initial slope using the nonlinear shooting method with RK4 and $h = 0.5$ is

$ t approx 1.001676716. $

= 3. Remixed Linear Shooting Method - Burden and Faires 11.1, Item 1

*Given:*

$ y'' = 4(y - x), quad 0 <= x <= 1, $
$ y(0) = 0, quad y(1) = 1, quad h = 0.5. $

The boundary condition $y(1) = 2$ is changed to $y(1) = 1$.

== Solution

For $y'' = p(x)y' + q(x)y + r(x)$,

$ p(x) = 0, quad q(x) = 4, quad r(x) = -4x. $

The two IVPs are

$ y_1'' = 4y_1 - 4x, quad y_1(0) = 0, quad y_1'(0) = 0, $

$ y_2'' = 4y_2, quad y_2(0) = 0, quad y_2'(0) = 1. $

Set $u_1 = y_1$, $u_2 = y_1'$, $v_1 = y_2$, and $v_2 = y_2'$. Then

$ U' = (u_2, 4u_1 - 4x, v_2, 4v_1)^T, $
$ U(0) = (0, 0, 0, 1)^T. $

Using RK4 with $h = 0.5$, the first stage is

$ K_1 = 0.5(0, 0, 1, 0)^T = (0, 0, 0.5, 0)^T. $

The RK4 results are:

#numtable((0.8fr, 1.35fr, 1.35fr, 1.35fr, 1.35fr),
($x$, $u_1(x)$, $u_2(x)$, $v_1(x)$, $v_2(x)$),
  (("0", "0.000000000", "0.000000000", "0.000000000", "1.000000000"),
   ("0.5", "-0.083333333", "-0.541666667", "0.583333333", "1.541666667"),
   ("1", "-0.798611111", "-2.737847222", "1.798611111", "3.737847222")))

Using $y(x) = y_1(x) + C y_2(x)$,

$ C = frac(1 - u_1(1), v_1(1)) $
$ = frac(1 - (-0.798611111), 1.798611111) $
$ = 1. $

At $x = 0.5$,

$ y(0.5) approx u_1(0.5) + C v_1(0.5) $
$ = -0.083333333 + (1)(0.583333333) $
$ = 0.5. $

The exact solution is $y(x) = x$, since

$ y' = 1, quad y'' = 0, $

$ 0 = 4(x - x) = 0. $

Hence, the boundary conditions $y(0) = 0$ and $y(1) = 1$ are also satisfied.

#numtable((1fr, 1.4fr, 1.4fr, 1.1fr),
  ("x", "Linear shooting", "Exact y = x", "Error"),
  (("0", "0", "0", "0"),
   ("0.5", "0.5", "0.5", "0"),
   ("1", "1", "1", "0")))

Therefore, the exact solution is $y(x) = x$. Using RK4 with $h = 0.5$, the shooting coefficient is $C = 1$, with zero error at all three grid points.