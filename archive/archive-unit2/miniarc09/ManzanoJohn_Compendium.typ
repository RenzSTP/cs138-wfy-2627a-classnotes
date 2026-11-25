#set page(paper: "a4")
#import "../assets.typ": qa, note, solution-box, question-box

#show link: set text(fill: blue, weight: 700)
#show link: underline
#set math.mat(delim: "[", gap: 0.8em)
#let solbox(body) = align(center)[#block(
  stroke: 0.5pt,
  inset: 20pt,
  width: 90%,

  )[
    #set text(size: 12pt)
    #set align(left)
  #body
]]

#let iterx = $upright(bold(x))$


= Burden and Faires, Numerical Analysis, Exercise Set 11.5, Problem 3(d)
#qa(auth:"MANZANO, John Anthony")[
*3.* Use the Piecewise Linear Algorithm to approximate the solutions to the following boundary-value problems and compare the results to the actual solution:

*d.* $-(x+1) y'' - y' + (x+2) y = [2 - (x+1)^2] e ln 2 - 2 e^x, quad 0 <= x <= 1, quad y(0) = y(1) = 0;$ use $h = 0.05$; actual solution $y(x) = e^x ln(x+1) - (e ln 2) x.$

== Using collocation instead][
  Use uniform nodes $x = 0, 1/2, 1$ (one interior collocation point) and the monomial basis:
  
  $ y = a_0 + a_1 x + a_2 x^2 $ 
  We also have $cal(L)[y] = -(x+1)y'' - y' + (x+2)y$,
  \
  $R(x) = [2 - (x+1)^2] e ln 2 - 2e^x$, $alpha = 0, beta = 0$

  #table(columns: 4,
    [$y$], [$y'$], [$y''$], [$cal(L)[y]$],
    [$1$], [$0$], [$0$], [$x+2$],
    [$x$], [$1$], [$0$], [$-1+(x+2)x = x^2 + 2x - 1$],
    [$x^2$], [$2x$], [$2$], [$-2(x+1) - 2x + (x+2)x^2 = x^3 + 2x^2 - 4x - 2$],
  )

  
  $
  cal(L)[y] = a_0 (x+2) + a_1 (x^2 + 2x - 1) + a_2 (x^3 + 2x^2 - 4x - 2).
  $

  #table(columns: 4,
    [$x$], [$y(x)$], [$cal(L)[y]$], [RHS],
    [$0$], [$a_0$], [—], [$alpha$],
    [$1/2$], [$a_0 + a_1/2 + a_2/4$], [$5/2 a_0 + 1/4 a_1 - 27/8 a_2$], [$R(1/2)$],
    [$1$], [$a_0 + a_1 + a_2$], [—], [$beta$],
  )

  The $x = 0$ and $x = 1$ rows are the boundary conditions and the interior point $x = 1/2$ enforces the ODE.

  $
  mat(
    1, 0, 0;
    5/2, 1/4, -27/8;
    1, 1, 1
  )
  mat(a_0; a_1; a_2) = mat(0; R(1/2); 0).
  $

  By solving the SLE, we get $y(x) approx -1.0396 (x - x^2)$, so $y(1/2) approx -0.2599$, compared to the actual value $y(1/2) approx -0.2736$.
]

#pagebreak()
= Heath, Scientific Computing, Revised 2nd ed., Ch. 10, Computer Exercises, p. 443
#qa(auth:"MANZANO, John Anthony")[
*10.4.* Suppose that the altitude of the trajectory of a projectile is described by the second-order ODE $u'' = -4$. Suppose that the projectile is fired from position $t = 0$ and height $u(0) = 1$ and is to strike a target at position $t = 1$, also of height $u(1) = 1$.

*(c)* Solve the same BVP once again, this time using collocation at the point $t = 0.5$, together with the boundary values, to determine a quadratic polynomial $u(t)$ approximating the solution. What is the resulting approximate height of the projectile at $t = 0.5$?][
  Using the monomial basis again $u = a_0 + a_1 t + a_2 t^2$.
  We also have $cal(L)[u] = u''$ and
  \
  $R(t) = -4$

  #table(columns: 4,
    [$u$], [$u'$], [$u''$], [$cal(L)[u]$],
    [$1$], [$0$], [$0$], [$0$],
    [$t$], [$1$], [$0$], [$0$],
    [$t^2$], [$2t$], [$2$], [$2$],
  )

 
  $
  cal(L)[u] = 2 a_2.
  $

  #table(columns: 4,
    [$t$], [$u(t)$], [$cal(L)[u]$], [RHS],
    [$0$], [$a_0$], [—], [$1$],
    [$1/2$], [$a_0 + a_1/2 + a_2/4$], [$2 a_2$], [$-4$],
    [$1$], [$a_0 + a_1 + a_2$], [—], [$1$],
  )

  The $t = 0$ and $t = 1$ rows are the boundary conditions, so the $cal(L)$ column is not used there. Only $t = 1/2$ enforces the ODE.

  $
  mat(
    1, 0, 0;
    0, 0, 2;
    1, 1, 1
  )
  mat(a_0; a_1; a_2) = mat(1; -4; 1).
  $

  By solving the SLE, we get $u(t) = 1 + 2t - 2t^2$, so $u(1/2) = 3/2$.
]


#pagebreak()

= Remixed Problem
#question-box()[
Use collocation with Gaussian basis instead: $Phi_j (x) = e^(-1/2 ((x - x_j)/sigma)^2)$ with $sigma = 1$, and applying Chebyshev points, to approximate the solution of the boundary-value problem
$
  y'' - y' + 2y = 2 sin x + 4 cos x - 16 sin 2x - 16 cos 2x, quad 0 <= x <= 2,
$
$
  y(0) = 3, quad y(2) = -sin 2 + 3 cos 2 + 8 sin 4 approx -8.2122;
$
use $n = 5$ subintervals. The actual solution is $y(x) = -sin x + 3 cos x + 8 sin 2x.$ Compare the approximation to the actual solution at the resulting interior points.
]