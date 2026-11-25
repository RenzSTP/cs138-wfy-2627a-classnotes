#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1
#qa(auth:"CRUZ, KIM GEOFFREY")[
  *Source:* Burden and Faires, _Numerical Analysis_,
  Section 11.4, Exercise Set 11.4, Item 2.

  Use the Nonlinear Finite-Difference method with $h = 0.25$ to approximate the solution to the boundary-value problem:
  $ y''= 2y^3, "   " −1 ≤ x ≤ 0, "   " y(−1) = 1/2, "   " y(0) = 1/3
  $

  Compare your results to the actual solution $y(x) = 1/(x+3)$.
][*Solution* \
With $h = 0.25$, the grid consists of five nodes:
- $x_0 = -1.00$ (Boundary: $y_0 = 0.5$)
- $x_1 = -0.75$
- $x_2 = -0.50$ 
- $x_3 = -0.25$
- $x_4 = 0.00$ (Boundary: $y_4 = 1/3$)

We replace $y''$ with the second-order central difference approximation:
$ (y_(i-1) - 2y_i + y_(i+1)) / h^2 = 2y_i^3 $

Multiplying by $h^2$ and shifting all terms to one side gives the root-finding equation $F_i = 0$:
$ F_i (y_(i-1), y_i, y_(i+1)) = y_(i-1) - 2y_i + y_(i+1) - 2h^2 y_i^3 = 0 $

Since $h = 0.25$, the constant $2h^2 = 2(0.0625) = 0.125$. The master function becomes:
$ F_i = y_(i-1) - 2y_i + y_(i+1) - 0.125y_i^3 = 0 $


Evaluating the master function at the interior nodes ($i = 1, 2, 3$):
$ F_1 &= 0.5 - 2y_1 + y_2 - 0.125y_1^3 \
  F_2 &= y_1 - 2y_2 + y_3 - 0.125y_2^3 \
  F_3 &= y_2 - 2y_3 + 1/3 - 0.125y_3^3 $

Moving on, the non-zero partial derivatives for the Jacobian matrix are:
- $(partial F_i) / (partial y_(i-1)) = 1$
- $(partial F_i) / (partial y_i) = -2 - 0.375y_i^2$
- $(partial F_i) / (partial y_(i+1)) = 1$

The resulting $3 times 3$ Jacobian matrix is:
$ J(bold(y)) = mat(
  -2 - 0.375y_1^2, 1, 0;
  1, -2 - 0.375y_2^2, 1;
  0, 1, -2 - 0.375y_3^2
) $


We generate the initial guess $bold(y)^((0))$ using linear interpolation between the two boundary conditions:
$ y_"line" (x) = y(a) + (y(b) - y(a)) / (b - a) (x - a) = 0.5 - 1/6 (x + 1) $

Evaluating this line at the interior nodes yields:
$ y_1^((0)) &= y_"line" (-0.75) = 11/24 approx 0.458333 \
  y_2^((0)) &= y_"line" (-0.50) = 5/12 approx 0.416667 \
  y_3^((0)) &= y_"line" (-0.25) = 3/8 = 0.375000 $

Now, solving the Newton system $J(bold(y)^((k))) Delta bold(y) = -F(bold(y)^((k)))$ iteratively until convergence yields our approximated solutions. We then compare these to the exact analytical solution $y(x) = 1/(x+3)$. Applying Newton's Method iteratively until the step correction $||Delta y|| < 10^(-4)$ (achieved at 5 iterations), we obtain the following stabilized approximations:

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    [*Node ($x_i$)*], [*Initial Guess $y_i^((0))$*], [*Converged FDA $y_i$*], [*Exact $y(x_i)$*], [*Absolute Error*],
    [$-0.75$], [$0.458333$], [$0.444586$], [$0.444444$], [$1.42 times 10^(-4)$],
    [$-0.50$], [$0.416667$], [$0.400157$], [$0.400000$], [$1.57 times 10^(-4)$],
    [$-0.25$], [$0.375000$], [$0.363738$], [$0.363636$], [$1.01 times 10^(-4)$],
  )
]]

== Compendium Problem 2 
#qa(auth:"CRUZ, KIM GEOFFREY")[
  *Source:* Burden and Faires, _Numerical Analysis_,
  Section 4.2, Exercise Set 4.2, Item 5.

  The following data give approximations to the integral $ M = integral_0^pi sin(x) d x $. \
  $N_1(h) = 1.570796$, $quad N_1(h/2) = 1.896119$, $quad N_1(h/4) = 1.974232$, $quad N_1(h/8) = 1.993570$ \ \
  Assuming $M = N_1(h) + K_1 h^2 + K_2 h^4 + K_3 h^6 + K_4 h^8 + O(h^(10))$, construct an extrapolation table to determine $N_4(h)$.
][*Solution* \
Because the error expansion increases by powers of 2 (starting at $h^2$), we use the standard Richardson Extrapolation formula to eliminate the lowest-order error term at each level $j$:
$ N_j (h) = N_(j-1)(h/2) + (N_(j-1)(h/2) - N_(j-1)(h)) / (4^(j-1) - 1) $

Using $j=2$, the denominator is $4^1 - 1 = 3$. We apply this to our base $N_1$ estimates:
$ N_2(h) &= N_1(h/2) + (N_1(h/2) - N_1(h)) / 3 = 1.896119 + (1.896119 - 1.570796) / 3 = 2.004560 \
  N_2(h/2) &= N_1(h/4) + (N_1(h/4) - N_1(h/2)) / 3 = 1.974232 + (1.974232 - 1.896119) / 3 = 2.000270 \
  N_2(h/4) &= N_1(h/8) + (N_1(h/8) - N_1(h/4)) / 3 = 1.993570 + (1.993570 - 1.974232) / 3 = 2.000016 $

Using $j=3$, the denominator is $4^2 - 1 = 15$. We apply this to our new $N_2$ estimates:
$ N_3(h) &= N_2(h/2) + (N_2(h/2) - N_2(h)) / 15 = 2.000270 + (2.000270 - 2.004560) / 15 = 1.999984 \
  N_3(h/2) &= N_2(h/4) + (N_2(h/4) - N_2(h/2)) / 15 = 2.000016 + (2.000016 - 2.000270) / 15 = 1.999999 $

Using $j=4$, the denominator is $4^3 - 1 = 63$. We apply this to our $N_3$ estimates to find the final target:
$ N_4(h) &= N_3(h/2) + (N_3(h/2) - N_3(h)) / 63 = 1.999999 + (1.999999 - 1.999984) / 63 = 1.999999 $

Note how rapidly the estimates converge toward the true analytical integral of $M = 2.000000$.

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto),
    align: center,
    [*Step Size*], [*$O(h^2)$*: $N_1$], [*$O(h^4)$*: $N_2$], [*$O(h^6)$*: $N_3$], [*$O(h^8)$*: $N_4$],
    [$h$], [$1.570796$], [$2.004560$], [$1.999984$], [$1.999999$],
    [$h/2$], [$1.896119$], [$2.000270$], [$1.999999$], [],
    [$h/4$], [$1.974232$], [$2.000016$], [], [],
    [$h/8$], [$1.993570$], [], [], []
  )
]]

== Remixed Problem
#qa(auth:"CRUZ, KIM GEOFFREY")[Consider the Nonlinear BVP:
$ y'' = 2y^3, quad -1 <= x <= 0, quad y(-1) = 1/2, quad y(0) = 1/3 $
The exact analytical solution is $y(x) = 1/(x+3)$. 

First, solve the BVP using a coarse nonlinear FDA grid with $h=0.5$ to find the estimate at $x = -0.5$. Then, extract the estimate at $x = -0.5$ from the fine $h=0.25$ grid (from Compendium Problem 1). Finally, apply Richardson Extrapolation to these two estimates to calculate an $O(h^4)$ accurate value for $y(-0.5)$. Compare the absolute errors of the three estimates.][*Solution* \
With $h = 0.5$, we have only one interior node at $x_1 = -0.5$. The boundaries are $y_0 = 0.5$ and $y_2 = 1/3$.
We apply the central difference approximation to $y'' = 2y^3$:
$ (y_0 - 2y_1 + y_2) / h^2 = 2y_1^3 $

Multiplying by $h^2 = 0.25$ and defining our single root-finding equation $F_1 = 0$:
$ F_1(y_1) &= y_0 - 2y_1 + y_2 - 2(0.25)y_1^3 \
  F_1(y_1) &= 0.5 - 2y_1 + 1/3 - 0.5y_1^3 = 5/6 - 2y_1 - 0.5y_1^3 $

The $1 times 1$ Jacobian (which is just the first derivative $F_1'(y_1)$) is:
$ J_1(y_1) = -2 - 1.5y_1^2 $

Using the same initial guess line $y_"line" (x) = 0.5 - 1/6(x+1)$, our starting value is $y_1^((0)) = 5/12 approx 0.416667$.
Applying the single-variable Newton iteration $y_1^((k+1)) = y_1^((k)) - F_1(y_1^((k))) / J_1(y_1^((k)))$ until convergence yields:
$ y_1 approx 0.400595 $
Let this coarse estimate be $N_1(0.5) = 0.400595$.

From Compendium Problem 1, the converged FDA approximation at $x = -0.5$ using $h=0.25$ is:
$ N_1(0.25) = 0.400157 $

Both FDA grids have $O(h^2)$ truncation error. We apply the first-level Richardson Extrapolation formula to eliminate the $h^2$ error term and achieve an $O(h^4)$ estimate $N_2$:
$ N_2(0.5) &= N_1(0.25) + (N_1(0.25) - N_1(0.5)) / (2^2 - 1) \
  N_2(0.5) &= 0.400157 + (0.400157 - 0.400595) / 3 \
  N_2(0.5) &= 0.400157 - 0.000146 = 0.400011 $

The true analytical solution at $x = -0.5$ is $y(-0.5) = 1/(-0.5 + 3) = 1/2.5 = 0.400000$. Comparing,

#align(center)[
  #table(
    columns: (auto, auto, auto),
    align: center,
    [*Method*], [*Estimate at $x = -0.5$*], [*Absolute Error*],
    [Coarse FDA ($h=0.5$)], [$0.400595$], [$5.95 times 10^(-4)$],
    [Fine FDA ($h=0.25$)], [$0.400157$], [$1.57 times 10^(-4)$],
    [Richardson Extrapolation], [$0.400011$], [$1.10 times 10^(-5)$],
  )
]
]