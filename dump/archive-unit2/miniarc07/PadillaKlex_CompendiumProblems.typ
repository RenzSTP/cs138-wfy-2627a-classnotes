#import "../assets.typ": qa,solution-box, note

#set par(justify: true)
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

= Compendium Problem 1: Linear Shooting Method

#qa(auth: "PADILLA, KLEX FELOUISE")[
  *Source:* Burden and Faires, _Numerical Analysis_,
  Section 11.1, Exercise Set 11.1, Item 3(a).

  Use the Linear Shooting method to approximate the solution of
  $ y'' = -3y' + 2y + 2x + 3, quad 0 <= x <= 1, $
  subject to $y(0) = 2$ and $y(1) = 1$, using $h = 0.1$.
][
  *Solution.* We apply the linear shooting method, using the classical fourth-order Runge-Kutta (RK4) method to solve the two initial-value problems (IVPs).

  *Step 1: Identify the coefficient functions and construct the IVPs.*

  Comparing the given equation with the standard form
  $ y'' = p(x)y' + q(x)y + r(x), $
  we obtain
  $ p(x) = -3, quad q(x) = 2, quad r(x) = 2x + 3. $
  Set $a = 0$, $b = 1$, $alpha = 2$, and $beta = 1$. The two IVPs are

  $ y''_1 = -3y'_1 + 2y_1 + 2x + 3, quad
    y_1(0) = 2, quad y'_1(0) = 0, $

  $ y''_2 = -3y'_2 + 2y_2, quad
    y_2(0) = 0, quad y'_2(0) = 1. $

  Since $p$, $q$, and $r$ are continuous and $q(x)=2>0$ on $[0,1]$,
  the linear boundary-value problem has a unique solution. The linear
  shooting formula is

  $ y(x) = y_1(x) + (beta - y_1(b))/(y_2(b)) y_2(x). $

  *Step 2: Rewrite both IVPs as first-order systems.*

  Define $u_1 = y_1$, $u_2 = y'_1$, $v_1 = y_2$, and $v_2 = y'_2$.
  Then

  $ u'_1 = u_2, quad u'_2 = -3u_2 + 2u_1 + 2x + 3, $
  $ v'_1 = v_2, quad v'_2 = -3v_2 + 2v_1, $

  with initial vectors
  $ bold(u)(0) = mat(2; 0), quad bold(v)(0) = mat(0; 1). $

  *Step 3: Approximate both IVPs using RK4.*

  For $h = 0.1$, there are
  $ N = (b-a)/h = (1-0)/(0.1) = 10 $
  subintervals, with $x_i = 0.1i$ for $i = 0,1,dots,10$.
  Write the systems in vector form as

  $ bold(u)' = F(x,bold(u)), quad
    F(x,mat(u_1;u_2)) = mat(u_2; -3u_2+2u_1+2x+3), $
  $ bold(v)' = G(x,bold(v)), quad
    G(x,mat(v_1;v_2)) = mat(v_2; -3v_2+2v_1). $

  For either vector $bold(z)$ and its corresponding right-hand side
  $H$, one RK4 step is

  $ k_1 = h H(x_i,bold(z)_i), $
  $ k_2 = h H(x_i+h/2,bold(z)_i+k_1/2), $
  $ k_3 = h H(x_i+h/2,bold(z)_i+k_2/2), $
  $ k_4 = h H(x_i+h,bold(z)_i+k_3), $
  $ bold(z)_(i+1) = bold(z)_i + (k_1+2k_2+2k_3+k_4)/6. $

  Starting with $bold(u)_0 = [2,0]^T$ and $bold(v)_0 = [0,1]^T$,
  the first RK4 step gives

  $ bold(u)_1 approx mat(2.032129167; 0.615787500), quad
    bold(v)_1 approx mat(0.086670833; 0.749079167). $

  Continuing for all ten steps yields the following approximations.
  Values are displayed to six decimal places; unrounded values are used for the shooting correction.

  #figure(
    table(
      columns: (0.62fr, 1fr, 1fr, 1fr, 1fr),
      align: center,
      table.header(
        [$x_i$], [$u_(1,i)$], [$u_(2,i)$], [$v_(1,i)$], [$v_(2,i)$],
      ),
      [0.0], [2.000000], [0.000000], [0.000000], [1.000000],
      [0.1], [2.032129], [0.615788], [0.086671], [0.749079],
      [0.2], [2.118830], [1.099965], [0.152382], [0.576143],
      [0.3], [2.249193], [1.495015], [0.203702], [0.457991],
      [0.4], [2.415890], [1.830870], [0.245249], [0.378382],
      [0.5], [2.614120], [2.128682], [0.280273], [0.325950],
      [0.6], [2.840873], [2.403462], [0.311072], [0.292745],
      [0.7], [3.094412], [2.665934], [0.339272], [0.273211],
      [0.8], [3.373914], [2.923829], [0.366036], [0.263467],
      [0.9], [3.679218], [3.182797], [0.392199], [0.260807],
      [1.0], [4.010652], [3.447040], [0.418369], [0.263349],
    ),
    caption: [RK4 approximations for the nonhomogeneous and homogeneous IVPs.],
  )

  *Step 4: Form the linear shooting approximation.*

  At $b=1$, the approximations are
  $ y_1(1) approx 4.010652363, quad
    y_2(1) approx 0.418369109. $
  Therefore, the shooting coefficient is

  $ c = (beta-u_(1,10))/v_(1,10)
      approx (1-4.010652363)/0.418369109
      approx -7.196163135. $

  The approximation at each mesh point is consequently

  $ w_i = u_(1,i) + c v_(1,i), quad
      c approx -7.196163135. $

  #figure(
    table(
      columns: (0.75fr, 1.3fr, 1.3fr, 1.15fr),
      align: center,
      table.header([$x_i$], [$w_i$ (RK4 shooting)], [$y(x_i)$ (exact)], [$abs(w_i-y(x_i))$ (error)]),
      [0.0], [2.000000], [2.000000], [0.000000],
      [0.1], [1.408432], [1.408342], [0.000090],
      [0.2], [1.022264], [1.022140], [0.000123],
      [0.3], [0.783318], [0.783192], [0.000125],
      [0.4], [0.651039], [0.650927], [0.000112],
      [0.5], [0.597228], [0.597136], [0.000092],
      [0.6], [0.602350], [0.602280], [0.000070],
      [0.7], [0.652953], [0.652904], [0.000049],
      [0.8], [0.739857], [0.739827], [0.000030],
      [0.9], [0.856890], [0.856876], [0.000014],
      [1.0], [1.000000], [1.000000], [0.000000],
    ),
    caption: [Linear shooting approximation and independent exact-solution check.],
  )

  *Step 5: Verify the boundary conditions and check the accuracy.*

  At the left endpoint,
  $ w_0 = u_(1,0) + c v_(1,0) = 2 + c(0) = 2. $
  At the right endpoint,
  $ w_10 = u_(1,10) +
    (1-u_(1,10))/v_(1,10) v_(1,10) = 1. $
  Thus the approximate solution satisfies both prescribed boundary conditions (up to the displayed rounding).

]

#pagebreak()
= Compendium Problem 2: Non-Linear Shooting Method
#qa(auth: "PADILLA, KLEX FELOUISE")[
  *Source:* Burden and Faires, _Numerical Analysis_, Section 11.2,
  Exercise Set 11.2, Item 1 (p. 684).

  Use the Nonlinear Shooting Algorithm with $h = 0.5$ to approximate
  the solution of the boundary-value problem
  $ y'' = -(y')^2 - y + ln x, quad 1 <= x <= 2, $
  subject to $y(1) = 0$ and $y(2) = ln 2$.
  Compare the results with the exact solution $y(x) = ln x$.
][
  *Solution.* We apply nonlinear shooting with Newton's method for the unknown initial slope. At each Newton iteration, we solve the original initial-value problem and its sensitivity equation numerically using the RK4 method.

  *Step 1: Define the shooting parameter and the residual.*

  Let $s = y'(1)$ be the unknown slope at the left endpoint. For a fixed
  choice of $s$, consider the initial-value problem
  $ y'' = -(y')^2 - y + ln x, quad
    y(1,s) = 0, quad y'(1,s) = s. $

  Its solution depends on $s$. To satisfy the right boundary condition,
  we must find a zero of
  $ R(s) = y(2,s) - ln 2. $
  Newton's method updates the slope according to
  $ s_(k+1) = s_k - (R(s_k))/(R'(s_k))
           = s_k - (y(2,s_k) - ln 2)/(z(2,s_k)), $
  where $z(x,s) = (partial y(x,s)) / (partial s)$ is the *sensitivity* of the
  solution with respect to the initial slope.

  *Step 2: Derive the sensitivity initial-value problem.*

  Write the differential equation as
  $ y'' = f(x,y,y'), quad f(x,y,y') = -(y')^2-y+ln x. $
  Its partial derivatives are
  $ (partial f)/(partial y) = -1, quad
    (partial f)/(partial y') = -2y'. $
  Differentiating the original equation with respect to $s$ gives
  $ z'' = (partial f)/(partial y) z
          + (partial f)/(partial y') z'
        = -z - 2y'z'. $
  Also, since $y(1,s)=0$ and $y'(1,s)=s$ for every $s$,
  $ z(1,s)=0, quad z'(1,s)=1. $
  Hence the auxiliary IVP is
  $ z'' = -z - 2y'z', quad z(1)=0, quad z'(1)=1. $
  This system must be solved together with the IVP for $y$ at every trial slope because the coefficient $-2y'$ depends on its solution.

  *Step 3: Convert to a first-order system and specify RK4.*

  Let $u_1=y$, $u_2=y'$, $u_3=z$, and $u_4=z'$. Then
  $ u_1' = u_2, quad
    u_2' = -u_2^2-u_1+ln x, $
  $ u_3' = u_4, quad
    u_4' = -u_3-2u_2u_4, $
  with starting values
  $ bold(u)(1) = mat(0; s; 0; 1). $

  In vector form, define
  $ F(x,bold(u)) = mat(
      u_2;
      -u_2^2-u_1+ln x;
      u_4;
      -u_3-2u_2u_4
    ). $

  Since $a=1$, $b=2$, and $h=0.5$, the number of subintervals is
  $ N=(b-a)/h = (2-1)/0.5 = 2, $
  giving mesh points $x_0=1$, $x_1=1.5$, and $x_2=2$.

  Starting from $bold(u)_i$ at $x_i$, one RK4 step is
  $ K_1 = h F(x_i,bold(u)_i), $
  $ K_2 = h F(x_i+h/2,bold(u)_i+K_1/2), $
  $ K_3 = h F(x_i+h/2,bold(u)_i+K_2/2), $
  $ K_4 = h F(x_i+h,bold(u)_i+K_3), $
  $ bold(u)_(i+1) = bold(u)_i + (K_1+2K_2+2K_3+K_4)/6. $

  The four components are advanced *together* so that the sensitivity equation uses the same intermediate RK4 stages as the original IVP.

  *Step 4: Apply Newton's method to determine the initial slope.*

  Following the initial-slope choice in Burden and Faires' Algorithm 11.2, take the slope of the line joining the two boundary data:
  $ s_0 = (beta-alpha)/(b-a)
        = (ln 2-0)/(2-1) = ln 2 approx 0.693147181. $

  For each slope $s_k$, carry out two RK4 steps from $x=1$ to $x=2$, calculate $R(s_k)$ and $z(2,s_k)$, then update $s_k$ by Newton's formula. The intermediate results (computed before rounding) are:

  #figure(
    table(
      columns: (0.46fr, 1.1fr, 1.25fr, 1.05fr, 1.2fr),
      align: center,
      table.header(
        [$k$], [$s_k$], [$y(2,s_k)$], [$z(2,s_k)$], [$R(s_k)$],
      ),
      [0], [0.693147181], [0.553544457], [0.491528998], [-0.139602724],
      [1], [0.977164450], [0.682872418], [0.421849773], [-0.010274762],
      [2], [1.001520899], [0.693082280], [0.416534056], [-0.000064900],
      [3], [1.001676710], [0.693147178], [0.416500308], [-0.000000003],
    ),
    caption: [Successive Newton iterates for the nonlinear shooting slope.],
  )

  For instance, the first correction is
  $ s_1 = s_0 - (y(2,s_0)-ln 2)/(z(2,s_0)) $
  $ = 0.693147181 - (0.553544457-0.693147181)/0.491528998 $
  $ approx 0.977164450. $

  Continuing gives $s_2 approx 1.001520899$ and
  $s_3 approx 1.001676710$. At the final iteration,
  $ abs(R(s_3)) approx 2.63 times 10^(-9) < 10^(-5). $
  Thus the right boundary condition is met within the tolerance
  $10^(-5)$, and the numerical shooting slope is
  $ s approx 1.001676710. $

  *Step 5: Tabulate the numerical solution and compare with the exact solution.*

  With the converged slope $s_3$, the RK4 approximations are:

  #figure(
    table(
      columns: (0.75fr, 1.25fr, 1.25fr, 1.35fr),
      align: center,
      table.header(
        [$x_i$], [$w_(1,i) approx y(x_i)$], [$ln x_i$],
        [$abs(w_(1,i)-ln x_i)$],
      ),
      [1.0], [0.000000000], [0.000000000], [0.000000000],
      [1.5], [0.405499533], [0.405465108], [0.000034425],
      [2.0], [0.693147178], [0.693147181], [0.000000003],
    ),
    caption: [Nonlinear shooting approximations with $h=0.5$ and exact-solution errors.],
  )

#solution-box[
  At the interior point, the numerical solution gives
  $ y(1.5) approx 0.405499533, $
  whereas the exact value is
  $ ln(1.5) approx 0.405465108. $
  Therefore, its absolute error is
  $ abs(0.405499533-0.405465108)
    approx 3.44 times 10^(-5). $
]
]




#pagebreak()
= Remix Problem: Failure of the Nonlinear Shooting Method

#qa(auth: "PADILLA, KLEX FELOUISE")[
  Consider the nonlinear boundary-value problem
  $
    y'' = sqrt(y) - sqrt(x y'),
    quad 0 <= x <= 1,
  $
  subject to the Dirichlet boundary conditions
  $
    y(0) = 0, quad y(1) = 1.
  $

  Suppose we attempt to solve this problem using the nonlinear shooting method with Newton iteration. Explain why the failure of the algorithm does not necessarily imply that the BVP has no solution.
][
  *Step 1: Determine the partial derivatives $f_y$ and $f_(y')$.*

  Recall that a nonlinear boundary-value problem has the general form
  $
    y'' = f(x, y, y').
  $

  For the given BVP, we identify
  $
    f(x, y, y') = sqrt(y) - sqrt(x y').
  $

  Differentiating with respect to $y$, treating $x$ and $y'$ as constants, gives
  $
    f_y = 1 / (2 sqrt(y)).
  $

  Similarly, differentiating with respect to $y'$, treating $x$ and $y$ as constants, gives
  $
    f_(y') = -x / (2 sqrt(x y')).
  $

  These expressions are valid where their respective radicands are strictly positive.

  *Step 2: Formulate the sensitivity IVP.*

  In nonlinear shooting, we introduce an unknown initial slope $t = y'(0)$ and construct the IVP
  $
    y'' = sqrt(y) - sqrt(x y'),
    quad y(0) = 0, quad y'(0) = t.
  $

  The goal is to determine $t$ such that the solution
  satisfies $y(1, t) = 1$.

  Define the sensitivity function
  $
    z(x, t) = (partial y(x, t)) / (partial t).
  $

  Recall that the sensitivity equation is
  $
    z'' = f_y z + f_(y') z',
  $
  subject to the initial conditions
  $
    z(0) = 0, quad z'(0) = 1.
  $

  Substituting the partial derivatives obtained
  in Step 1 gives
  $
    z'' = z / (2 sqrt(y))
      - (x z') / (2 sqrt(x y')).
  $

  Thus, the sensitivity IVP is
  $
    cases(
      z'' = z / (2 sqrt(y))
        - (x z') / (2 sqrt(x y')),
      z(0) = 0,
      z'(0) = 1.
    )
  $

  *Step 3: Explain why the standard Newton-based nonlinear shooting algorithm cannot be applied directly.*

  Recall that Newton-based nonlinear shooting updates the initial slope using
  $
    t_(k+1) = t_k
      - (y(1, t_k) - 1) / z(1, t_k).
  $

  To evaluate $z(1, t_k)$, the algorithm must solve the sensitivity IVP alongside the original IVP.

  However, the given boundary condition is
  $
    y(0) = 0.
  $

  Evaluating the partial derivative $f_y$ at the initial point gives
  $
    f_y(0, 0, t) = 1 / (2 sqrt(0)),
  $
  which is undefined due to division by zero.

  Consequently, the standard sensitivity equation cannot be evaluated at the initial point as written.

  Since the usual RK4-based nonlinear shooting algorithm requires evaluating the system at this point, it cannot be applied directly without modifying how the singularity is handled.

  Note that this does not establish that every possible shooting approach must fail.

  *Step 4: Verify that $y(x) = x$ is an exact solution of the original BVP.*

  Consider the candidate solution
  $
    y(x) = x.
  $

  Differentiating gives
  $
    y'(x) = 1, quad y''(x) = 0.
  $

  Substituting into the original differential equation yields
  $
    y'' &= sqrt(y) - sqrt(x y') \
    0 &= sqrt(x) - sqrt(x dot 1) \
      &= sqrt(x) - sqrt(x) \
      &= 0.
  $

  Hence, the differential equation is satisfied for every $x in [0, 1]$.

  We now verify the Dirichlet boundary conditions.

  At $x = 0$,
  $
    y(0) = 0.
  $

  At $x = 1$,
  $
    y(1) = 1.
  $

  Both boundary conditions are satisfied.

  Therefore,
  $
    #solution-box[$y(x) = x$]
  $
  is an exact solution of the given BVP.

  *Step 5: Explain why the failure of the algorithm does not necessarily imply that the BVP has no solution.*

  From Step 3, the standard Newton-based nonlinear shooting formulation encounters an undefined partial derivative at the initial point. This prevents the usual sensitivity-based RK4 algorithm from being applied directly.

  However, Step 4 establishes that $y(x) = x$ satisfies both the differential equation and the prescribed boundary conditions.

  Therefore, the original BVP has at least one exact solution, despite the difficulty encountered by the numerical algorithm.

  We conclude that the failure of a numerical method does not necessarily imply the nonexistence of a mathematical solution. Rather, it may indicate that the assumptions or computational requirements of the method are not satisfied.

  In this example, the issue arises from the singular partial derivative $f_y$ at $y = 0$, which prevents direct application of the standard Newton-based shooting algorithm.
]
