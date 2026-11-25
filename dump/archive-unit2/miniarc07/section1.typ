// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

  // I really hate how this is not the default
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis, solution-box

/// END STYLING PREAMBLE


// SECTION HEADER
#show: notes.with(
  title: [Linear Shooting Method],
)

// SECTION SUBHEADER1

#section-subheading("1", "Problem")
#h(2em) // fix indent for 1st paragraph
Given your Dirichlet Boundary Condition (DBC) and an ODE, how do we find the solution to the ODE?

$ y'' = p(x)y' + q(x)y + r(x) $ for $y(a) = alpha$, $y(b) = beta$, $a <= x <= b$

What exactly can we do here? If we can guess $y'(a) = gamma$, then we can solve those IVPs using previous methods. But we also need to aim correctly, we do not have infinite time.

So, we need to make smart guesses for $y'(a)$.

\ 
// SECTION SUBHEADER2
#section-subheading("2", "Definition")
#h(2em) // fix indent for 1st paragraph

#definition(name: "Linear Shooting Method")[
  Given a Linear ODE, $ y'' = p(x)y' + q(x)y + r(x) $ with $p(x), q(x), r(x)$ continuous on $a <= x <= b$, and boundary conditions $y(a) = alpha$, $y(b) = beta$

  $ y(x) = y_1(x) + (beta - y_1(b)) / (y_2(b)) y_2(x), quad y_2(b) != 0  $

  where

  $y_1(x)$ is a solution to the $y'' = p(x)y' + q(x)y + r(x)$ with IVP constraints $y(a) = alpha, y'(a) = 0$

  $y_2(x)$ is a solution to the $y'' = p(x)y' + q(x)y$ with IVP constraints $y(a) = 0, y'(a) = 1$

  #align(right)[
    _(Burden & Faires, 2011)_
  ]
]
\
#theorem(name: "Existence and Uniqueness of the Linear Boundary-Value Problem")[
  Consider the linear boundary-value problem 
  $ 
    y'' = p(x)y' + q(x)y + r(x), quad y(a) = alpha, quad y(b) = beta.
  $

  If $p(x)$, $q(x)$, and $r(x)$ are continuous on $[a,b]$ and $q(x) > 0$ for all $x in [a,b]$, then the boundary-value problem has a unique solution.

  #align(right)[
    _Burden & Faires, 2011. (Corollary 11.2)_
  ]
] 

#pagebreak()
// SECTION SUBHEADER3
#section-subheading("3", "Linear Shooting Method Proof")

The following proof's ideas were taken from Burden and Faires (2011) pp. 673-674: 

\ *First, we show this satisfies the original ODE:*

\ We first get $y'(x) y''(x)$:

$ y(x) = y_1(x) + (beta - y_1(b)) / (y_2(b)) y_2(x) $

$ y'(x) = y_1 '(x) + (beta - y_1(b)) / (y_2(b)) y_2 '(x) $

$ y''(x) = y_1 ''(x) + (beta - y_1(b)) / (y_2(b)) y_2 ''(x) $

Continuing from $(6)$ by definition of $y_1, y_2$ $y_1(x), y_2(x)$ 

$= (p(x)y_1 '(x) + q(x)y_1(x) + r(x)) + (beta - y_1(b)) / (y_2(b)) (p(x)y_2 '(x) + q(x)y_2(x))$ 

\
Rearranging terms gives us:

$= (p(x)y_1 '(x) + (beta - y_1(b)) / (y_2(b))p(x)y_2 '(x)) + (q(x)y_1(x) + (beta - y_1(b)) / (y_2(b)) q(x)y_2(x)) + r(x)$

$= p(x)(y_1 '(x) + (beta - y_1(b)) / (y_2(b))y_2 '(x)) + q(x)(y_1(x) + (beta - y_1(b)) / (y_2(b)) y_2(x)) + r(x)$

$= p(x)(y'(x)) + q(x)(y(x)) + r(x)$

\
So, $y''(x) = p(x)(y'(x)) + q(x)(y(x)) + r(x)$. Thus, satisfying the initial ODE condition.

\
*Second, we show the boundary conditions being satisfied:*

$
  y(a) &= y_1(a) + (beta - y_1(b)) / (y_2(b)) y_2(a) \
       &= alpha + (beta - y_1(b)) / (y_2(b)) 0 \
       &= alpha + 0 \
       &= alpha \
       \
  y(b) &= y_1(b) + (beta - y_1(b)) / (y_2(b)) y_2(b) \
       &= y_1(b) + (beta - y_1(b)) \
       &= beta
$


Therefore, this is a correct solution. This proof is once again from Burden and Faires (2011) pp. 673-674.

\
// SECTION SUBHEADER4
#section-subheading("4", "Process")
#h(2em)
The linear shooting method approximates the solution of a linear boundary value problem by constructing two initial value problems (IVPs), solving them numerically, and combining their solutions to satisfy the boundary conditions.


- *Step 1: Construct the two initial value problems.*

Given the linear BVP

$
  y'' = p(x)y' + q(x)y + r(x),
  quad y(a) = alpha,
  quad y(b) = beta,
$

construct the following IVPs:

- *IVP 1 (Non-homogeneous)*
  $ y''_1 = p(x)y'_1 + q(x)y_1 + r(x) $
  with $y_1(a) = alpha  $ and $y'_1(a) = 0$.

- *IVP 2 (Homogeneous)*
  $ y''_2 = p(x)y'_2 + q(x)y_2 $
  with $y_2(a) = 0$ and $y'_2(a) = 1$.

- *Step 2: Convert the IVPs into systems of FODEs.*

Introduce new variables for each function and its first derivative to obtain systems of FODEs suitable for numerical approximation.

- *Step 3: Approximate the solutions using a numerical method.*

Apply a numerical IVP method, such as Euler's method or the fourth-order Runge-Kutta method (RK4), to approximate $y_1(x_i)$ and $y_2(x_i)$ at the grid points.

In particular, obtain approximations to $y_1(b)$ and $y_2(b)$ at the right boundary.

- *Step 4: Apply the linear shooting formula.*

Recall that the solution of the linear BVP is given by

$
  y(x) = y_1(x) + c y_2(x).
$

where the correction coefficient is

$
  c = (beta - y_1(b)) / y_2(b).
$

provided that $y_2(b) != 0$.

Since $c$ is constant with respect to $x$, differentiating gives

$
  y'(x) = y'_1(x) + c y'_2(x).
$

Suppose a numerical IVP method to obtain the following approximations:

$
  u_(1,i) approx y_1(x_i), quad u_(2,i) approx y'_1(x_i),
$

$
  v_(1,i) approx y_2(x_i), quad v_(2,i) approx y'_2(x_i).
$

Using the computed values at the right boundary $x_N = b$, the numerical correction coefficient is

$
  c_h = (beta - u(1,N)) / v_(1,N),
$

provided that $v_(1,N) != 0$.


Therefore, the approximate solution and its first derivative at each grid point are computed as

$
  w_(1,i) = u_(1,i) + c_h v_(1,i)
$

and

$
  w_(2,i) = u_(2,i) + c_h v_(2,i)
$

where $w_(1,i)$ approximates $y(x_i)$, while $w_(2,i)$ approximates $y'(x_i)$.

// SECTION SUBHEADER5
\
#section-subheading("5", "Worked Example")
#section-emphasis("5.1 Linear Shooting Method Using Euler's Method")

#example(number: "1")[
  Use the *linear shooting method* with Euler's method and step size $h = 0.25$ to approximate the solution of the boundary value problem

  $ y'' = y + 1, quad 0 <= x <= 1 $

  subject to the boundary conditions

  $ y(0) = 0, quad y(1) = 1. $
]

*Solution.*

- *Step 1: Construct the two initial value problems.*

Recall that the general form of the linear ODE is

$ y'' = p(x)y' + q(x)y + r(x). $

Comparing this with the given equation $y'' = y + 1$, we obtain:

$ p(x) = 0, quad q(x) = 1, quad r(x) = 1. $

Following the linear shooting method, we construct two initial value problems (IVPs).

- *IVP 1 (Nonhomogeneous):*

$
  y''_1 = y_1 + 1,
  quad y_1(0) = 0,
  quad y'_1(0) = 0.
$

- *IVP 2 (Homogeneous):*

$
  y''_2 = y_2,
  quad y_2(0) = 0,
  quad y'_2(0) = 1.
$
\
- *Step 2: Convert the IVPs into systems of first-order ODEs.*

Since Euler's method is applied to first-order equations, we introduce new variables.

\
*Recall:* For a first-order IVP $y' = f(x, y)$ with initial condition $y(x_0) = y_0$, Euler's method is defined by
$
  y_(i+1) = y_i + h f(x_i, y_i)
  quad x_(i+1) = x_i + h
$

where $h$ is the step size, $x_i$ is the current point, and $y_i$ is the approximation of $y(x_i)$.

\
For a system of FODEs, Euler's method is applied to each equation separately.

\
For IVP 1, let $u_1 = y_1$ and $u_2 = y'_1$. Then,

$
  u'_1 = u_2, quad
  u'_2 = u_1 + 1.
$

Applying Euler's method gives the iteration formulas:

$
  u_(1, i+1) = u_(1, i) + h u_(2, i)
$

$
  u_(2, i+1) = u_(2, i) + h (u_(1, i) + 1)
$

with initial values $u_(1, 0) = 0$ and $u_(2, 0) = 0$.

\
For IVP 2, let $v_1 = y_2$ and $v_2 = y'_2$. Then,

$
  v'_1 = v_2, quad v_2' = v_1.
$

The corresponding Euler iteration formulas are

$
  v_(1, i+1) = v_(1, i) + h v_(2, i)
$

$
  v_(2, i+1) = v_(2, i) + h v_(1, i)
$

with initial values $v_(1, 0) = 0$ and $v_(2, 0) = 1$.
\
\
- *Step 3: Apply Euler's method.*

Given $a = 0$, $b = 1$, and $h = 0.25$, the number of steps is

$
  N = (b - a) / h = (1 - 0)/0.25 = 4.
$

We first demonstrate the iteration at $i = 0$.

\
For IVP 1,

$
  u_(1, 1) = 0 + 0.25(0) = 0
$

$
  u_(2, 1) = 0 + 0.25(0 + 1) = 0.25
$

For IVP 2,

$
  v_(1, 1) = 0 + 0.25(1) = 0.25
$

$
  v_(2, 1) = 1 + 0.25(0) = 1.
$

Repeating this process until $x = 1$, we obtain the following values:

#figure(
  table(
    columns: (1fr, 1.3fr, 1.3fr, 1.3fr, 1.3fr),
    align: center,
    inset: 5pt,
    table.header(
      [*$x_i$*], [*$u_(1, i)$*], [*$u_(2, i)$*], [*$v_(1, i)$*], [*$v_(2, i)$*],
    ),
    [0.00], [0.000000], [0.000000], [0.000000], [1.000000],
    [0.25], [0.000000], [0.250000], [0.250000], [1.000000],
    [0.50], [0.062500], [0.500000], [0.500000], [1.062500],
    [0.75], [0.187500], [0.765625], [0.765625], [1.187500],
    [1.00], [0.378906], [1.062500], [1.062500], [1.378906], 
  ),
  caption: [_Euler approximations for the two IVPs._]
)

Therefore, at the right boundary $b = 1$, we have

$
  y_1(1) approx 0.37890625
$

and

$
  y_2(1) approx 1.0625.
$
\
- *Step 4: Apply the linear shooting formula.*

Recall that the linear shooting method gives

$
  y(x) = y_1(x) + (beta - y_1(b)) / (y_2(b)) y_2(x).
$

Since $beta = 1$ and $b = 1$, the correction coefficient is:

$
  c = ((1 - 0.37890625)/1.0625) approx 0.58455882.
$

Thus, our numerical solution is:

#solution-box[*$y(x_i) approx u_(1, i) + 0.58455882 v_(1, i)$*]

\
Applying this formula to the Euler approximations yields:

#figure(
  table(
    columns: (1fr, 1.5fr),
    align: center,
    inset: 6pt,
    table.header(
      [*$x_i$*],
      [*Approximation $y(x_i)$*],
    ),
    [0.00], [0.000000],
    [0.25], [0.146140],
    [0.50], [0.354779],
    [0.75], [0.635053],
    [1.00], [1.000000],
  ),
  caption: [_Approximate solution using the linear shooting method with Euler's method._],
)
\
- *Step 5 (Optional): Verify the boundary conditions.*

At $x = 0$,

$
  y(0) approx 0 + 0.58455882(0) = 0.
$

At $x = 1$,

$
  y(1) approx 0.37890625 + 0.58455882(1.0625) approx 1.
$

Both boundary conditions are satisfied by the numerical approximation, up to rounding. Hence, the linear shooting method with Euler's method produces the approximate solution shown in the preceding table.

\
*Note:*
_Although the shooting correction enforces the boundary conditions, the numerical approximation is not necessarily the exact solution of the differential equation. Euler's method still introduces discretization error._

// using the same subheading for now, for consistency
#section-emphasis("5.2 Linear Shooting Method Using Fourth Order Runge-Kutta (RK4)")

#h(-2em)Solve the same problem as in 5.1, but use a different approximation. 

#example(number: "2")[
  Use the *linear shooting method* with RK4 method and step size $h = 0.25$ to approximate the solution of the boundary value problem

  $ y'' = y + 1, quad 0 <= x <= 1 $

  subject to the boundary conditions

  $ y(0) = 0, quad y(1) = 1. $
]

*Solution.*

Constructing the IVPs based on the linear shooting equations *(Step 1)* and setting up the first-order system *(Step 2) *should be the same; refer to the solution above for a walkthrough. We begin here with this system: 

$  u'_1 = u_2, quad u'_2 = u_1 + 1. $
$  v'_1 = v_2, quad v'_2 = v_1. $

where $u_1 = y_1$, $u_2 = y'_1$ and $v_1 = y_2$, $v_2 = y'_2$. Or, in matrix form: 

$ bold("u"') = mat(u_2; u_1 + 1), quad bold("v"') = mat(v_2; v_1) $

We also have initial vectors

// VECTORS HERE
$ bold("u")(0) = mat(0; 0), quad bold("v")(0) = mat(0; 1) $

We may now proceed with...

- *Step 3: Approximate using RK4.*

Given $h = 0.25$, we calculate 
$ n = (b-a) / h = (1 - 0) / 0.25 = 4 $
So our points are $x_i = 0.25i$ for $i = 0, 1, 2, 3, 4$.

\
One step of the fourth-order Runge-Kutta method for some $z = f(x, z)$ is 

$ k_1 = h F(x_i, z_i) $
$ k_2 = h F(x_i + h/2, z_i + k_1/2) $
$ k_3 = h F(x_i + h/2, z_i + k_2/2) $
$ k_4 = h F(x_i + h, z_i + k_3) $
$ z_(i + 1) = z_i + (k_1 + 2k_2 + 2k_3 + k_4) / 6 $

In this case, since each IVP is its own system, instead of using a function $z$ and its equation $f(x,z)$, we use the function vectors $bold("u")$ and $bold("v")$ and the corresponding matrices. 



#figure(
  table(
    columns: (0.6fr, 1fr, 1fr, 1fr, 1fr),
    align: center,
    inset: 6pt,
    table.header(
      [*$x_i$*], [*$u_(1, i)$*], [*$u_(2, i)$*], [*$v_(1, i)$*], [*$v_(2, i)$*]
    ),
    [0.00], [0.000000], [0.000000], [0.000000], [1.000000], 
    [0.25], [0.031413], [0.252604], [0.252604], [1.031413],
    [0.50], [0.127621], [0.521078], [0.521078], [1.127621],
    [0.75], [0.294669], [0.822289], [0.822289], [1.294669],
    [1.00], [0.543052], [1.175158], [1.175158], [1.543052],
  ),
  caption: [_RK4 approximations for the two IVPs._],
)

- *Step 4: Apply the linear shooting formula.*
The linear shooting method defines
$ y(x) = y_1(x) + (beta - y_1(b)) / (y_2(b)) y_2(x) $
Let 
$ c = (beta - y_1(b)) / (y_2(b)) =  (beta - u_1(b)) / (v_1(b)) = (1 - 0.5430520693) / 1.17515787 approx 0.388839612 $
Substituting c, $u_1$, and $v_1$ to the linear shooting equation and allowing for iterations, this gives us

#solution-box[*$y_i = u_(1,i) + 0.388839612 v_(1,i)$*]

Plugging in the RK4 approximations from Table 3 to this equation, we get the following: 

#figure(
  table(
    columns: (1fr, 1.5fr),
    align: center,
    inset: 6pt,
    table.header(
      [*$x_i$*],
      [*Approximation $y(x_i)$*],
    ),
    [0.00], [0.000000],
    [0.25], [0.129635],
    [0.50], [0.330237],
    [0.75], [0.614408],
    [1.00], [1.000000],
  ),
  caption: [_Approximate solution using the linear shooting method with RK4 method._],
)

- *Step 5: Verify the boundary conditions.*
At $x = 0$:
$ y(0) = 0.000000 + 0.388839612(0.000000) = 0 $
At $x = 1$ (approximating due to the fact that there was some truncation to about 10 decimal places): 
$ y(1) approx 0.5430520693 + 0.388839612(1.1751578699) = 0.999999999 approx 1 $

Thus, the boundary conditions hold (approximately). 

