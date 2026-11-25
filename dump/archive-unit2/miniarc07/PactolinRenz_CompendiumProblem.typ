#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
= Compendium Problem 1
#qa(auth:"Renz Sergio T. Pactolin")[
  Burden and Faires, 9th ed, Exercise 11.1 Item 5

  5.  *Use the Linear Shooting Algorithm to approximate the solution $y = e^(-10x)$ to the boundary-value problem*

$ y'' = 100y, quad 0 <= x <= 1, quad y(0) = 1, quad y(1) = e^(-10). $

Use $h = 0.1$ and $0.05$.
  
][
= Given:

$
y'' = 100y, quad 0 <= x <= 1
$

Subject to the boundary conditions:

$
y(0) = 1, quad y(1) = e^(-10)
$

The exact solution is:

$
y(x) = e^(-10x)
$

We will use the Linear Shooting Algorithm with Explicit Euler's Method for $h = 0.1$ and $h = 0.05$.


Let:

$
y_1 = y, quad y_2 = y'
$

Therefore:

$
y_1' = y_2
$

$
y_2' = 100y_1
$

== Formulation

*I. Non-homogeneous Part*

$
y_"non-homo"' = y'_"non-homo"
$

$
y'_"non-homo"' = 100y_"non-homo"
$

With initial conditions:

$
y_"non-homo"(0) = 1, quad
y'_"non-homo"(0) = 0
$

*II. Homogeneous Part*

$
y_"homo"' = y'_"homo"
$

$
y'_"homo"' = 100y_"homo"
$

With initial conditions:

$
y_"homo"(0) = 0, quad
y'_"homo"(0) = 1
$

== Using Euler's Method

The Euler formulas are:

$
y_(i+1) = y_i + h y_i'
$

$
-> y'_(i+1) = y_i' + h f(x_i, y_i)
$

For the non-homogeneous part:

$
y_"non-homo"(x_(i+1)) =
y_"non-homo"(x_i) +
h y'_"non-homo"(x_i)
$

$
y'_"non-homo"(x_(i+1)) =
y'_"non-homo"(x_i) +
100h y_"non-homo"(x_i)
$

For the homogeneous part:

$
y_"homo"(x_(i+1)) =
y_"homo"(x_i) +
h y'_"homo"(x_i)
$

$
y'_"homo"(x_(i+1)) =
y'_"homo"(x_i) +
100h y_"homo"(x_i)
$

== Solution 1 : Numerical Solution Using h = 0.1

Using $h = 0.1$, the initial values are:

$
y_"non-homo"(0) = 1, quad
y'_"non-homo"(0) = 0
$

$
y_"homo"(0) = 0, quad
y'_"homo"(0) = 1
$

Repeating the Euler calculations until $x = 1$, we obtain the following values:
#figure(
  table(
  columns: 5,
  align: center,
  inset: 5pt,
  stroke: 0.5pt,
  table.header(
    [$x_i$],
    [$y_"non-homo"$],
    [$y'_"non-homo"$],
    [$y_"homo"$],
    [$y'_"homo"$],
  ),
  [0.00], [1.000000], [0.000000], [0.000000], [1.000000],
  [0.10], [1.000000], [10.000000], [0.100000], [1.000000],
  [0.20], [2.000000], [20.000000], [0.200000], [2.000000],
  [0.30], [4.000000], [40.000000], [0.400000], [4.000000],
  [0.40], [8.000000], [80.000000], [0.800000], [8.000000],
  [0.50], [16.000000], [160.000000], [1.600000], [16.000000],
  [0.60], [32.000000], [320.000000], [3.200000], [32.000000],
  [0.70], [64.000000], [640.000000], [6.400000], [64.000000],
  [0.80], [128.000000], [1280.000000], [12.800000], [128.000000],
  [0.90], [256.000000], [2560.000000], [25.600000], [256.000000],
  [1.00], [512.000000], [5120.000000], [51.200000], [512.000000],
  ),
  caption: "Table of values using h = 0.1."
)




The shooting parameter is calculated using:

$
s = (beta - y_"non-homo"(b)) /
y_"homo"(b)
$

*With the given:* $alpha = 1, quad beta = e^(-10) $

Substituting the values obtained from the table:

$
s = (e^(-10) - 512) / 51.2
$

$
s approx -9.9999991133
$

The approximate solution is given by:

$
y(x) = y_"non-homo"(x) +
s y_"homo"(x)
$

Therefore:

$
y(x) approx y_"non-homo"(x)
- 9.9999991133 y_"homo"(x)
$

#v(1.5em)

== Part 2: Numerical Solution Using h = 0.05

Repeating the same process using $h = 0.05$, we obtain the following values:

#figure(
  table(
  columns: 5,
  align: center,
  inset: 4pt,
  stroke: 0.5pt,
  table.header(
    [$x_i$],
    [$y_"non-homo"$],
    [$y'_"non-homo"$],
    [$y_"homo"$],
    [$y'_"homo"$],
  ),
  [0.00], [1.000000], [0.000000], [0.000000], [1.000000],
  [0.05], [1.000000], [5.000000], [0.050000], [1.000000],
  [0.10], [1.250000], [10.000000], [0.100000], [1.250000],
  [0.15], [1.750000], [16.250000], [0.162500], [1.750000],
  [0.20], [2.562500], [25.000000], [0.250000], [2.562500],
  [0.25], [3.812500], [37.812500], [0.378125], [3.812500],
  [0.30], [5.703125], [56.875000], [0.568750], [5.703125],
  [0.35], [8.546875], [85.390625], [0.853906], [8.546875],
  [0.40], [12.816406], [128.125000], [1.281250], [12.816406],
  [0.45], [19.222656], [192.207031], [1.922070], [19.222656],
  [0.50], [28.833008], [288.320312], [2.883203], [28.833008],
  [0.55], [43.249023], [432.485352], [4.324854], [43.249023],
  [0.60], [64.873291], [648.730469], [6.487305], [64.873291],
  [0.65], [97.309814], [973.096924], [9.730969], [97.309814],
  [0.70], [145.964661], [1459.645996], [14.596460], [145.964661],
  [0.75], [218.946960], [2189.469299], [21.894693], [218.946960],
  [0.80], [328.420425], [3284.204102], [32.842041], [328.420425],
  [0.85], [492.630630], [4926.306229], [49.263062], [492.630630],
  [0.90], [738.945942], [7389.459381], [73.894594], [738.945942],
  [0.95], [1108.418911], [11084.189091], [110.841891], [1108.418911],
  [1.00], [1662.628366], [16626.283646], [166.262836], [1662.628366],
  ),
  caption: "Table of values using h = 0.05"

)


Using the same formula:

$
s = (beta - y_"non-homo"(b)) /
y_"homo"(b)
$

Substituting the values obtained from the table:

$
s = (e^(-10) - 1662.6283655167) /
166.2628364563
$

$
s approx -9.9999998199
$

The approximate solution is:

$
y(x) approx y_"non-homo"(x)
- 9.9999998199 y_"homo"(x)
$

== Final Answers

The Linear Shooting Algorithm was applied to the given boundary-value problem using Explicit Euler's Method with step sizes of $h = 0.1$ and $h = 0.05$.

The calculated shooting parameters were:

- For $h = 0.1$: $s approx -9.9999991133$
- For $h = 0.05$: $s approx -9.9999998199$

Both calculations produce a shooting parameter close to the exact initial slope of the analytical solution, which is $y'(0) = -10$, the smaller step size producing a more accurate approximation of the solution.  
]





#pagebreak()

= Compendium Problem 2 
#qa(auth:"Renz Sergio T. Pactolin")[
  *Burden and Faires, 9th ed, Exercise 11.1 Item 7*
  7. Let $u$ represent the electrostatic potential between two concentric metal spheres of radii $R_1$ and $R_2$ ($R_1 < R_2$). The potential of the inner sphere is kept constant at $V_1$ volts, and the potential of the outer sphere is 0 volts. The potential in the region between the two spheres is governed by Laplace's equation, which, in this particular application, reduces to

$ (d^2 u)/(d r^2) + 2/r (d u)/(d r) = 0, quad R_1 <= r <= R_2, quad u(R_1) = V_1, quad u(R_2) = 0. $

Suppose $R_1 = 2 "in."$, $R_2 = 4 "in."$, and $V_1 = 110 "volts"$.

a. Approximate $u(3)$ using the Linear Shooting Algorithm.

b. Compare the results of part (a) with the actual potential $u(3)$, where

$ u(r) = (V_1 R_1)/r ((R_2 - r)/(R_2 - R_1)). $
][ = Given:

$
u'' + 2/r u' = 0, quad 2 <= r <= 4
$

Subject to the boundary conditions:

$
u(2) = 110, quad u(4) = 0
$

The exact solution is:

$
u(r) = (V_1 R_1)/r ((R_2-r)/(R_2-R_1))
$

Given:

$
R_1 = 2 "in.", quad R_2 = 4 "in.", quad V_1 = 110 "volts"
$

We will use the Linear Shooting Algorithm with the Fourth-Order Runge-Kutta Method (RK4) for $h = 0.5$.

Let:

$
y_1 = u, quad y_2 = u'
$

Therefore:

$
y_1' = y_2
$

$
y_2' = -2/r y_2
$

== Formulation

*I. Non-homogeneous Part*

$
y_"non-homo"' = y'_"non-homo"
$

$
y'_"non-homo"' = -2/r y'_"non-homo"
$

With initial conditions:

$
y_"non-homo"(2) = 110, quad
y'_"non-homo"(2) = 0
$

*II. Homogeneous Part*

$
y_"homo"' = y'_"homo"
$

$
y'_"homo"' = -2/r y'_"homo"
$

With initial conditions:

$
y_"homo"(2) = 0, quad
y'_"homo"(2) = 1
$

== Using the Fourth-Order Runge-Kutta Method (RK4)

The RK4 formulas for a system of first-order differential equations are:

$
k_1 = h f(r_i, y_i)
$

$
k_2 = h f(r_i + h/2, y_i + k_1/2)
$

$
k_3 = h f(r_i + h/2, y_i + k_2/2)
$

$
k_4 = h f(r_i + h, y_i + k_3)
$

$
y_(i+1) = y_i + (k_1 + 2k_2 + 2k_3 + k_4)/6
$

For the given system:

$
f(r, y_1, y_2) =
[
  y_2,
  -2/r y_2
]
$

The RK4 calculations are performed separately for the non-homogeneous and homogeneous parts.

== Part A: Numerical Solution Using h = 0.5

Using $h = 0.5$, the number of steps is:

$
N = (4-2)/0.5 = 4
$

The initial values are:

$
y_"non-homo"(2) = 110, quad
y'_"non-homo"(2) = 0
$

$
y_"homo"(2) = 0, quad
y'_"homo"(2) = 1
$

Repeating the RK4 calculations until $r = 4$, we obtain the following values:

#figure(
  table(
    columns: 5,
    align: center,
    inset: 5pt,
    stroke: 0.5pt,
    table.header(
      [$r_i$],
      [$y_"non-homo"$],
      [$y'_"non-homo"$],
      [$y_"homo"$],
      [$y'_"homo"$],
    ),
    [2.0], [110.000000], [0.000000], [0.000000], [1.000000],
    [2.5], [110.000000], [0.000000], [0.399691], [0.640123],
    [3.0], [110.000000], [0.000000], [0.666321], [0.444560],
    [3.5], [110.000000], [0.000000], [0.856816], [0.326624],
    [4.0], [110.000000], [0.000000], [0.999701], [0.250075],
  ),
  caption: "Table of values using RK4 with h = 0.5."
)

The shooting parameter is calculated using:

$
s = (beta - y_"non-homo"(b)) /
y_"homo"(b)
$

*With the given:* $alpha = 110, quad beta = 0$

Substituting the values obtained from the table:

$
s = (0 - 110) / 0.9997006077
$

$
s approx -110.0329430181
$

The approximate solution is given by:

$
u(r) = y_"non-homo"(r) +
s y_"homo"(r)
$

Therefore:

$
u(r) approx y_"non-homo"(r)
- 110.0329430181 y_"homo"(r)
$

Approximating u(3)

Since $r = 3$ is one of the grid points, we can directly obtain the corresponding values from the table.

$
y_"non-homo"(3) = 110
$

$
y_"homo"(3) = 0.6663212937
$

Substituting into the linear combination:

$
u(3) = 110 +
(-110.0329430181)(0.6663212937)
$

#rect([$
u(3) approx 36.682707 "V"
$])

== Part B: Comparison with the Actual Potential

The actual potential is given by:

$
u(r) = (V_1 R_1)/r ((R_2-r)/(R_2-R_1))
$

Substituting the given values:

$
u(3) = (110(2))/3 ((4-3)/(4-2))
$

$
u(3) = 220/3 (1/2)
$

$
u(3) approx 36.666667
$

The percentage error is calculated using:

$
"Percentage Error" =
abs(("Actual" - "Approximate")/"Actual") times 100%
$

Substituting the values:

$
"Percentage Error" =
abs((36.666667 - 36.682707)/36.666667)
times 100%
$

$
"Percentage Error" approx 0.04375%
$

== Final Answers

The approximate potential at $r = 3$ is:


#box([$ u(3) approx 36.682707 "V" $])


The actual potential is:


#box([$ u(3) approx 36.666667 "V" $])


The resulting percentage error is:

#box([$ "Percentage Error" approx 0.04375% $])


The numerical approximation is very close to the actual potential, with a percentage error of approximately 0.04375%.]


#pagebreak()

== Remixed Problem
#qa(auth: "Renz Sergio T. Pactolin")[
== Remixed Problem: RK4 with higher step sizes vs Explicit Euler Method with shorter steps

Using the same boundary value problem from the previous problem, governed by:

$
frac(d^2 u, d r^2) + frac(2, r) frac(d u, d r) = 0,
quad 2 <= r <= 4
$

Subject to the boundary conditions:

$
u(2) = 110, quad u(4) = 0
$

Compare the numerical solutions obtained using the following approaches:

a. Apply the Linear Shooting Method with the fourth-order Runge-Kutta method (RK4), using a step size of $h = 1$.

b. Apply the Linear Shooting Method with the Explicit Euler method, using a step size of $h = 0.25$.

c. Compare the numerical approximations obtained using both methods, particularly their accuracy at the midpoint of the region, $u(3)$.

d. Discuss how the choice of numerical method and step size affects the accuracy of the approximated solution.
][

= Given:

$
u'' + 2/r u' = 0, quad 2 <= r <= 4
$

Subject to the boundary conditions:

$
u(2) = 110, quad u(4) = 0
$

The exact solution is:

$
u(r) = (V_1 R_1)/r ((R_2-r)/(R_2-R_1))
$

Given:

$
R_1 = 2 "in.", quad R_2 = 4 "in.", quad V_1 = 110 "volts"
$

We will compare the Linear Shooting Algorithm using the Fourth-Order Runge-Kutta Method (RK4) with $h = 1$ and the Explicit Euler Method with $h = 0.25$.

Let:

$
y_1 = u, quad y_2 = u'
$

Therefore:

$
y_1' = y_2
$

$
y_2' = -2/r y_2
$

== Formulation

*I. Non-homogeneous Part*

$
y_"non-homo"' = y'_"non-homo"
$

$
y'_"non-homo"' = -2/r y'_"non-homo"
$

With initial conditions:

$
y_"non-homo"(2) = 110, quad
y'_"non-homo"(2) = 0
$

*II. Homogeneous Part*

$
y_"homo"' = y'_"homo"
$

$
y'_"homo"' = -2/r y'_"homo"
$

With initial conditions:

$
y_"homo"(2) = 0, quad
y'_"homo"(2) = 1
$

The approximate solution is obtained using the linear combination:

$
u(r) = y_"non-homo"(r) + s y_"homo"(r)
$

where the shooting parameter is:

$
s = (beta-y_"non-homo"(b))/y_"homo"(b)
$

Using the given boundary conditions:

$
alpha = 110, quad beta = 0
$

== Part A: Numerical Solution Using RK4 with $h = 1$

The RK4 formulas for a system of first-order differential equations are:

$
k_1 = h f(r_i, y_i)
$

$
k_2 = h f(r_i + h/2, y_i + k_1/2)
$

$
k_3 = h f(r_i + h/2, y_i + k_2/2)
$

$
k_4 = h f(r_i + h, y_i + k_3)
$

$
y_(i+1) = y_i + (k_1 + 2k_2 + 2k_3 + k_4)/6
$

For the given system:

$
f(r, y_1, y_2) =
[
  y_2,
  -2/r y_2
]
$

The RK4 calculations are performed separately for the non-homogeneous and homogeneous parts.

The number of steps is:

$
N = (4-2)/1 = 2
$

The initial values are:

$
y_"non-homo"(2) = 110, quad
y'_"non-homo"(2) = 0
$

$
y_"homo"(2) = 0, quad
y'_"homo"(2) = 1
$

Repeating the RK4 calculations until $r = 4$, we obtain:

#figure(
  table(
    columns: 5,
    align: center,
    inset: 5pt,
    stroke: 0.5pt,
    table.header(
      [$r_i$],
      [$y_"non-homo"$],
      [$y'_"non-homo"$],
      [$y_"homo"$],
      [$y'_"homo"$],
    ),
    [2.0], [110.000000], [0.000000], [0.000000], [1.000000],
    [3.0], [110.000000], [0.000000], [0.660000], [0.446667],
    [4.0], [110.000000], [0.000000], [0.994240], [0.251440],
  ),
  caption: [Numerical values using RK4 with $h = 1$.]
)

The shooting parameter is calculated using:

$
s = (beta-y_"non-homo"(b))/y_"homo"(b)
$

Substituting the values obtained from the table:

$
s = (0-110)/0.9942403628
$

$
s approx -110.6372303061
$

The approximate solution is therefore:

$
u(r) approx y_"non-homo"(r)
-110.6372303061 y_"homo"(r)
$

*Approximating $u(3)$*

Since $r = 3$ is one of the grid points, we can directly obtain the corresponding values from the table.

$
y_"non-homo"(3) = 110
$

$
y_"homo"(3) = 0.660000
$

Substituting into the linear combination:

$
u(3) = 110 +
(-110.6372303061)(0.660000)
$

#rect([$u(3) approx 36.979428 "V"$])

== Part B: Numerical Solution Using Explicit Euler with $h = 0.25$

The Explicit Euler formula for a system of first-order differential equations is:

$
y_(i+1) = y_i + h f(r_i,y_i)
$

For the given system:

$
f(r,y_1,y_2) =
[
  y_2,
  -2/r y_2
]
$

Therefore, the update equations are:

$
y_(1,i+1) = y_(1,i) + h y_(2,i)
$

$
y_(2,i+1) = y_(2,i) - h (2/r_i)y_(2,i)
$

Using $h = 0.25$, the number of steps is:

$
N = (4-2)/0.25 = 8
$

The initial values remain:

$
y_"non-homo"(2) = 110, quad
y'_"non-homo"(2) = 0
$

$
y_"homo"(2) = 0, quad
y'_"homo"(2) = 1
$

Repeating the Explicit Euler calculations until $r = 4$, we obtain:

#figure(
  table(
    columns: 5,
    align: center,
    inset: 4pt,
    stroke: 0.5pt,
    table.header(
      [$r_i$],
      [$y_"non-homo"$],
      [$y'_"non-homo"$],
      [$y_"homo"$],
      [$y'_"homo"$],
    ),
    [2.00], [110.000000], [0.000000], [0.000000], [1.000000],
    [2.25], [110.000000], [0.000000], [0.250000], [0.750000],
    [2.50], [110.000000], [0.000000], [0.437500], [0.583333],
    [2.75], [110.000000], [0.000000], [0.583333], [0.466667],
    [3.00], [110.000000], [0.000000], [0.700000], [0.381818],
    [3.25], [110.000000], [0.000000], [0.795455], [0.318182],
    [3.50], [110.000000], [0.000000], [0.875000], [0.269231],
    [3.75], [110.000000], [0.000000], [0.942308], [0.230769],
    [4.00], [110.000000], [0.000000], [1.000000], [0.200000],
  ),
  caption: [Numerical values using Explicit Euler with $h = 0.25$.]
)

The shooting parameter is calculated using:

$
s = (beta-y_"non-homo"(b))/y_"homo"(b)
$

Substituting the values obtained from the table:

$
s = (0-110)/1
$

$
s = -110
$

The approximate solution is therefore:

$
u(r) = y_"non-homo"(r)-110y_"homo"(r)
$

*Approximating $u(3)$*

Since $r = 3$ is one of the grid points, we can directly obtain the corresponding values from the table.

$
y_"non-homo"(3) = 110
$

$
y_"homo"(3) = 0.700000
$

Substituting into the linear combination:

$
u(3) = 110 + (-110)(0.700000)
$

#rect([$u(3) approx 33.000000 "V"$])

== Part C: Comparison with the Actual Potential

The actual potential is given by:

$
u(r) = (V_1 R_1)/r ((R_2-r)/(R_2-R_1))
$

Substituting the given values at $r = 3$:

$
u(3) = (110(2))/3 ((4-3)/(4-2))
$

$
u(3) = 220/3 (1/2)
$

$
u(3) approx 36.666667 "V"
$

The percentage error is calculated using:

$
"Percentage Error" =
abs(("Actual" - "Approximate")/"Actual") times 100%
$

*I. RK4 with $h = 1$*

$
"Percentage Error" =
abs((36.666667-36.979428)/36.666667)
times 100%
$

$
"Percentage Error" approx 0.852986%
$

*II. Explicit Euler with $h = 0.25$*

$
"Percentage Error" =
abs((36.666667-33.000000)/36.666667)
times 100%
$

$
"Percentage Error" = 10%
$

== Part D: Discussion

The numerical results show that the Fourth-Order Runge-Kutta Method (RK4) with a step size of $h = 1$ produces a more accurate approximation than the Explicit Euler Method with a step size of $h = 0.25$.

Although the Explicit Euler Method uses a smaller step size and performs more integration steps, its approximation has a larger percentage error of 10%. In comparison, RK4 produces a percentage error of approximately 0.852986%.

This demonstrates that the accuracy of a numerical solution depends not only on the step size but also on the numerical method being used. RK4 generally provides higher accuracy because it evaluates the differential equation at four different points within each step, while Explicit Euler uses only the slope at the beginning of each step.

Therefore, for this particular boundary value problem, RK4 with $h = 1$ provides a considerably more accurate approximation of the potential at $r = 3$ than Explicit Euler with $h = 0.25$.

== Final Answers

The actual potential at $r = 3$ is:

#rect([$u(3) approx 36.666667 "V"$])

The numerical approximation using RK4 with $h = 1$ is:

#rect([$u(3) approx 36.979428 "V"$])

The resulting percentage error is:

#rect([$"Percentage Error" approx 0.852986%$])

The numerical approximation using Explicit Euler with $h = 0.25$ is:

#rect([$u(3) approx 33.000000 "V"$])

The resulting percentage error is:

#rect([$"Percentage Error" = 10%$])

RK4 with $h = 1$ provides the more accurate approximation, despite using a larger step size and fewer integration steps than Explicit Euler with $h = 0.25$.

]