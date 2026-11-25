// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE

// SECTION HEADER
#show: notes.with(
  title: [Richardson Extrapolation],
  subtitle: [Arc 8 · Felix, Raphael Anton]
)

#section-subheading("1", "Central Difference and Truncation Error")
#h(2em)
The central difference method estimates $f'(x)$ from the function values at
$x+h$ and $x-h$. Its leading truncation error is proportional to $h^2$.
Richardson extrapolation uses how that error changes with the step size to
improve the estimate.

#definition[
  *Richardson Extrapolation.* Combine two approximations of the same quantity,
  computed with different step sizes, to eliminate the leading term in their
  error expansion.
]

For a sufficiently smooth function, expand both neighboring values about $x$.

$ f(x+h) = f(x) + h f'(x) + frac(h^2, 2!) f''(x) + frac(h^3, 3!) f'''(x)
  + frac(h^4, 4!) f^((4))(x) + cal(O)(h^5). $

$ f(x-h) = f(x) - h f'(x) + frac(h^2, 2!) f''(x) - frac(h^3, 3!) f'''(x)
  + frac(h^4, 4!) f^((4))(x) + cal(O)(h^5). $

Subtract the second expansion from the first. The constant and even-power
terms cancel, while the displayed odd-power terms double. Dividing by $2h$
gives the centered difference and its leading error term.

$ D(h) = (f(x+h) - f(x-h))/(2h)
  = f'(x) + c_2 h^2 + cal(O)(h^4), quad c_2 = frac(f'''(x), 3!). $

Taking the exact derivative minus its approximation gives the signed error
$ E(h) = f'(x) - D(h) = -c_2 h^2 + cal(O)(h^4). $

#section-subheading("2", "Effect of Step Size and Error Cancellation")
#h(2em)
Keep the evaluation point $x$ fixed and use half the step size. The
denominator becomes $2(h/2) = h$.

$ D(h/2) = (f(x+h/2) - f(x-h/2))/h
  = f'(x) + (c_2 h^2)/4 + cal(O)(h^4). $

Since $(h/2)^2 = h^2/4$, the leading term in $E(h/2)$ is one-fourth of
the leading term in $E(h)$. Multiplying the finer estimate by $4$ and
subtracting the coarser estimate cancels this term.

$ 4D(h/2) - D(h) = (4-1)f'(x) + (4/4-1)c_2 h^2 + cal(O)(h^4)
  = 3f'(x) + cal(O)(h^4). $

#theorem[
  *Fourth-Order Approximation.* If the centered difference has the error
  expansion above, then
  $ R(h) = (4D(h/2)-D(h))/3 = f'(x) + cal(O)(h^4). $
  The two centered differences use four function values in total, at
  $x-h$, $x-h/2$, $x+h/2$, and $x+h$.
]

#section-subheading("3", "Generalized Richardson Extrapolation")
#h(2em)
If the leading error is proportional to $h^m$, halving $h$ scales that
term by $1/2^m$. Let $L$ be the exact quantity, $A_(k)(h)$ the approximation
after $k$ extrapolation steps, and $E_(k)(h) = L - A_(k)(h)$ its signed
error. For a constant $c$ independent of $h$ and $q > m$, write

$ E_(k)(h) = c h^m + cal(O)(h^q), quad
  E_(k)(h/2) = c (h/2)^m + cal(O)(h^q). $

Subtract the coarser estimate from the finer estimate. The exact quantity
$L$ cancels, leaving the difference between their signed errors.

$ A_(k)(h/2) - A_(k)(h) &= E_(k)(h) - E_(k)(h/2) \
  &= (2^m - 1)c (h/2)^m + cal(O)(h^q). $

Dividing by $2^m - 1$ gives the leading error of the finer estimate, up to
terms of order $h^q$. Since the error is the exact quantity minus the
approximation, add this correction to $A_(k)(h/2)$.

#theorem[
  *Richardson Recurrence.*
  $ A_(k+1)(h) = A_(k)(h/2) + frac(1, 2^m - 1) [A_(k)(h/2) - A_(k)(h)]. $
  The corrected approximation has error $cal(O)(h^q)$.
]

With $A_(0)(h) = D(h)$, the first application uses $m = 2$ and gives
$A_(1)(h) = R(h)$. For a sufficiently smooth function, the centered-difference
error expansion has even powers. The next step uses $m = 4$ to cancel the
$h^4$ term and leaves an $cal(O)(h^6)$ error.

#note[
  *Why the order improves by different amounts.* For standard forward and
  backward differences, the error expansion can contain consecutive powers
  of $h$. The first extrapolation cancels the $h$ term and leaves an
  $cal(O)(h^2)$ error. For standard centered differences, the error expansion
  contains even powers. Canceling the $h^2$ term leaves an $cal(O)(h^4)$ error.
  The same idea also appears in numerical integration as Romberg integration.
]

#section-subheading("4", "Worked Example: Approximating a Derivative")
#h(2em)
Consider $f(x) = e^x$. We approximate $f'(0)$ with $h = 0.20$ and $h/2 = 0.10$,
then compare each approximation with the exact value $f'(0) = 1$.

#example(number: "1")[
  *Compute the two centered differences.*
  $ D(0.20) = (e^(0.20) - e^(-0.20))/0.40 approx 1.0066800127, $
  $ D(0.10) = (e^(0.10) - e^(-0.10))/0.20 approx 1.0016675002. $

  *Combine the two estimates.*
  $ R(0.20) = (4D(0.10) - D(0.20))/3 approx bold(0.9999966627). $

  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 6pt,
      stroke: 0.5pt + midgray,
      [*Method*], [*Approximation*], [*Absolute error*],
      [Centered, $h = 0.20$], [$1.0066800127$], [$6.6800 times 10^(-3)$],
      [Centered, $h = 0.10$], [$1.0016675002$], [$1.6675 times 10^(-3)$],
      [Richardson], [$0.9999966627$], [$3.3373 times 10^(-6)$],
    )
  ]
]

#note[
  *Connection to boundary value problems.* The same idea can combine
  finite-difference solutions computed on a coarse and a fine grid. Compare
  the two approximations at the same physical point and use the leading
  error order of the numerical solution to choose $m$.
]



// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE

// SECTION HEADER
#show: notes.with(
  title: [Finite Difference Method],
  subtitle: [Arc 8 · Tomista, Fatima Shine]
)


// SECTION SUBHEADER1
#section-subheading("1", "General Form of the FDA")
#h(2em) // fix indent for 1st paragraph
The Finite Difference Method solves boundary value problems (BVPs) by
replacing derivatives with finite difference approximations at a set of
discretized points, turning the differential equation into a system of
linear equations (SLE) that can be solved directly.

Consider the linear second-order BVP
$ y'' + P(x) y' + Q(x) y = R(x), quad a <= x <= b, quad y(a) = alpha, quad y(b) = beta. $

#definition[
  *Finite Difference Approximation (FDA).* Discretize $[a,b]$ into $n+1$
  points $x_0, x_1, dots, x_n$ with step size $h = (b-a)/(n+1)$, where
  $y_0 = alpha$ and $y_n = beta$ are the known boundary values and
  $y_1, dots, y_(n-1)$ are the unknown interior values to solve for.
]

#theorem[
  *Linear System for the General FDA.* Substituting the central difference
  approximations for $y'$ and $y''$ into the BVP and collecting terms at
  each interior point produces the tridiagonal system

  $ mat(
      B_1, C_1, dots.c, dots.c, 0;
      A_2, B_2, C_2, dots.down, dots.v;
      dots.v, dots.down, dots.down, dots.down, dots.v;
      dots.v, dots.down, A_(n-2), B_(n-2), C_(n-2);
      0, dots.c, dots.c, A_(n-1), B_(n-1)
    )
    mat(y_1; y_2; dots.v; y_(n-2); y_(n-1))
    =
    mat(R(x_1) - A_1 alpha; R(x_2); dots.v; R(x_(n-2)); R(x_(n-1)) - C_(n-1) beta), $

  where
  $ A_i = 1/h^2 - P(x_i)/(2h), quad B_i = -2/h^2 + Q(x_i), quad C_i = 1/h^2 + P(x_i)/(2h). $
]

#note[
  The coefficients above come from the *central* difference stencil. More
  generally, a derivative at $y_i$ can be approximated using points ahead
  of it (forward), behind it (backward), or straddling it (central):

  $ y_i' = underbrace((y_(i+1)-y_i)/h, "forward")
    = underbrace((y_(i+1)-y_(i-1))/(2h), "central")
    = underbrace((y_i-y_(i-1))/h, "backward") $

  $ y_i'' = underbrace((y_i - 2y_(i+1) + y_(i+2))/h^2, "forward")
    = underbrace((y_(i-1)-2y_i+y_(i+1))/h^2, "central")
    = underbrace((y_(i-2)-2y_(i-1)+y_i)/h^2, "backward") $

  Central differences are used by default since they are second-order
  accurate, $O(h^2)$, versus the first-order accuracy, $O(h)$, of forward
  or backward differences.
]

\

// SECTION SUBHEADER2
#section-subheading("2", "Worked Example: Central vs. Mixed Schemes")
#h(2em) 
To see why central differences are preferred, consider the BVP

$ y'' - 2y' - y = 0, quad y(0) = 0, quad y(1) = 1, $

solved with 3 interior points ($n = 3$), so $h = (1-0)/(3+1) = 0.25$. We
solve it two ways: once using the central scheme throughout, and once
using a *mixed* scheme that applies forward and backward differences near
the boundaries.

#example(number: "1")[
  *Central Scheme.* Applying
  $ (y_(i-1)-2y_i+y_(i+1))/h^2 - 2 (y_(i+1)-y_(i-1))/(2h) - y_i = 0 $
  at $i = 1, 2, 3$ and simplifying gives the recurrence
  $ (1+h) y_(i-1) - (2+h^2) y_i + (1-h) y_(i+1) = 0. $

  Substituting $h = 0.25$, $y_0 = 0$, $y_4 = 1$ for $i = 1,2,3$ yields the
  SLE
  $ mat(-33/16, 3/4, 0; 5/4, -33/16, 3/4; 0, 5/4, -33/16)
    mat(y_1; y_2; y_3)
    = mat(0; 0; -3/4), $

  which solves to
  $ bold(y_1 = 192/2233 approx 0.0860), quad
    bold(y_2 = 48/203 approx 0.2365), quad
    bold(y_3 = 1132/2233 approx 0.5070). $
]

#example(number: "2")[
  *Mixed Scheme.* Instead, approximate $y'$ and $y''$ with a *forward*
  difference near the left boundary, a *central* difference in the
  middle, and a *backward* difference near the right boundary.

  *Eq. 1 (Forward), anchored at $y_0 = 0$:*
  $ (y_0-2y_1+y_2)/h^2 - 2(y_1-y_0)/h - y_0 = 0
    quad arrow.r.double quad
    -5/2 y_1 + y_2 = 0. $

  *Eq. 2 (Central), at $i=2$:*
  $ (y_1-2y_2+y_3)/h^2 - 2(y_3-y_1)/(2h) - y_2 = 0
    quad arrow.r.double quad
    5/4 y_1 - 33/16 y_2 + 3/4 y_3 = 0. $

  *Eq. 3 (Backward), anchored at $y_4 = 1$:*
  $ (y_2-2y_3+y_4)/h^2 - 2(y_4-y_3)/h - y_4 = 0
    quad arrow.r.double quad
    y_2 - 3/2 y_3 = -7/16. $

  Together,
  $ mat(-5/2, 1, 0; 5/4, -33/16, 3/4; 0, 1, -3/2)
    mat(y_1; y_2; y_3)
    = mat(0; 0; -7/16), $

  which solves to
  $ bold(y_1 = 7/85 approx 0.0824), quad
    bold(y_2 = 7/34 approx 0.2059), quad
    bold(y_3 = 175/408 approx 0.4289). $
]

#note[
  The exact solution, from the linear shooting method, is
  $ y(x) = e^(x-1) (sinh(sqrt(2) x))/(sinh(sqrt(2))), $
  giving $y(0.25) approx 0.0881$, $y(0.50) approx 0.2401$, and
  $y(0.75) approx 0.5117$.

  Comparing both schemes against this exact solution:

  #align(center)[
    #table(
      columns: (auto, auto, auto, auto),
      inset: 6pt,
      stroke: 0.5pt + midgray,
      [], [*Central error*], [*Mixed error*], [],
      [$y_1$], [$approx 0.0021$], [$approx 0.0058$], [],
      [$y_2$], [$approx 0.0036$], [$approx 0.0342$], [],
      [$y_3$], [$approx 0.0047$], [$approx 0.0828$], [],
    )
  ]

  The mixed scheme's error grows substantially larger toward the
  boundaries where forward/backward differences are used, reinforcing why
  the central difference formula from Theorem 1 is the standard choice.
  It is uniformly second-order accurate, while forward and backward
  differences are only first-order accurate.
]

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
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE


// SECTION HEADER
#show: notes.with(
  title: [Finite-Difference Approximation for Neumann Boundary Conditions],
  subtitle: [Arc 8 · Lim, Gabrielle Kyros]
)

#section-subheading("1", "General FDA for Neumann Boundary Conditions")

For the previous sections, we were given Dirichlet boundary conditions, where the exact values are given at the boundaries, i.e. $y_0 = alpha$ and $y_n = beta$. However, it is also possible that we only know the _derivatives_ at the boundaries. We define the Neumann boundary condition below:

#definition(name: "Neumann Boundary Condition")[
  A Neumann boundary condition for BVPs specifies the derivative at the boundary. Specifically,
  $
    y'(x_0) = alpha, y'(x_n) = beta.
  $
]

For NBCs, we are only given the slopes as defined above, meaning that $y(a = x_0)$ and $y(b = x_n)$ are unknowns alongside interior points, thus we now solve a $(n+1) times (n+1)$ system.

== One-Sided Approximation Approach
#v(1em)

Here, we pair central differences in the interior with first-order forward and backward differences at the endpoints, where:

- *$i = 0$ (Forward Difference).* 
  $
    y'(x_0) approx frac(y_1 - y_0, h) = alpha
  $
- *$i = n$ (Backward Difference).* 
  $
    y'(x_n) approx frac(y_n - y_(n-1), h) = beta
  $
- *$i = 1, ..., n - 1$ (Central Difference).*

From the derived linear system for general FDA:
  $
    A_i y_(i-1) + B_i y_i + C_i y_(i+1) = R(x_i)
  $
However, since $y(x_0)$ and $y(x_n)$ are also unknowns, we end up with the following system instead:

$
  mat(
    -frac(1, h), frac(1, h), 0, ..., 0;
    A_1, B_1, C_1, dots.down, dots.v;
    0, dots.down, dots.down, dots.down, 0;
    dots.v, dots.down, A_(n-1), B_(n-1), C_(n-1);
    0, ..., 0, -frac(1, h), frac(1, h)
  )
  mat(
    y_0; y_1; dots.v; y_(n-1); y_n
  )
  =
  mat(
    alpha; R(x_1); dots.v; R(x_(n-1)); beta
  )
$

#pagebreak()

#section-subheading("2", "Worked Example Using One-Sided Approximation")

#example(number: "1")[
  Consider the same BVP from the previous section:
  $
    y'' - 2y' - y = 0
  $
  We now impose the NBCs $y'(0) = alpha = 2$ and $y'(1) = beta = 1$ for three interior points, thus $h = 0.25$.

  For the boundaries $i in {0, 4}$:
  $
    y'(x_0) approx frac(y_1 - y_0, h) = -frac(1, h)y_0 + frac(1, h)y_1 = alpha = 2 \
    y'(x_4) approx frac(y_4 - y_(3), h) = -frac(1, h)y_3 + frac(1, h)y_4 = beta = 1
  $

  For the interior points $i in {1, 2, 3}$, we derive the same recurrence from the central scheme of the previous section:
  $ 
    (1+h) y_(i-1) - (2+h^2) y_i + (1-h) y_(i+1) = 0
  $

  With $1 + h = frac(5, 4)$, $-(2 + h^2) = -frac(33, 16)$, $1 - h = frac(3, 4)$, we substitute into our derived system:
  $
    mat(
      -frac(1, h), frac(1, h), 0, 0, 0;
      1 + h, -(2 + h^2), 1 - h, 0, 0;
      0, 1 + h, -(2 + h^2), 1 - h, 0;
      0, 0, 1 + h, -(2 + h^2), 1 - h;
      0, 0, 0, -frac(1, h), frac(1, h)
    )
    mat(
      y_0; y_1; y_2; y_3; y_4
    )
    =
    mat(
      alpha; 0; 0; 0; beta
    ) \
    arrow.double.long
    mat(
      -4, 4, 0, 0, 0;
      frac(5, 4), -frac(33, 16), frac(3, 4), 0, 0;
      0, frac(5, 4), -frac(33, 16), frac(3, 4), 0;
      0, 0, frac(5, 4), -frac(33, 16), frac(3, 4);
      0, 0, 0, -4, 4
    )
    mat(
      y_0; y_1; y_2; y_3; y_4
    )
    =
    mat(
      2; 0; 0; 0; 1
    )
    arrow.double.long
    bold(y_(F D A)) = mat(
      -5.327; -4.827; -4.396; -4.044; -3.764
    )
  $
]

#note[
  The exact solution using the linear shooting method is
  $
    y(x) = e^x [c_2cosh(sqrt(2)x) + frac(2-c_2, sqrt(2))sinh(sqrt(2)x)]
  $
  with $c_2 = frac(sqrt(2), e sinh sqrt(2)) - 2sqrt(2)coth sqrt(2) - 2$, which evaluates to
  $
    bold(y_("LS")) = mat(-4.915, -4.444, -4.025, -3.673, -3.381)^top
  $
  yielding an error $sum_(i=0)^4|y_(F D A) - y_(L S)| = 1.92$. Similar to the mixed scheme in the previous section, the order of approximation around the boundary reduces due to the forward and backward approximations at the endpoints.
]

#pagebreak()

// SECTION HEADER3
#show: notes.with(
  title: [Method of Fictitious Points],
  subtitle: [Arc 8 · Esquilona, Liana Estelle]
)
#section-subheading("1", "General Form of FDA using Method of Fictitious Points")
Using forward difference for previous solutions of BVPs  can cause lower accuracy compared to using central difference. That is because forward difference has an error of $O(h)$ while central difference has an error of $O(h^2)$. Since it is not "possible" to do central difference on boundaries as they do not have values on both sides of the endpoints, we introduce fictitious points to fill-in the points temporarily. These are also called *ghost points* and must be eliminated using boundary conditions.

#section-emphasis("General Equation and Boundary Conditions")
From the general equation

$ y'' + P(x) y' + Q(x) y = R(x), quad a <= x <= b, quad y'(a) = alpha, quad y'(b) = beta. $

Divide the interval into $n$ equal subintervals, giving $n - 1$ interior points and $n + 1$ actual grid points:

$ h = (b - a)/n, quad quad x_i = a + i h, quad quad i = 0, 1, dots, n. $

Here $x_0 = a$, $x_n = b$, and $y_i approx y(x_i)$. The symbols $y_0$ and $y_n$ are unknown heights; $alpha$ and $beta$ are known slopes. A derivative condition does not directly tell us an endpoint height.

#definition(name: [Ghost points])[
  Introduce points $x_(-1) = a - h$ and $x_(n+1) = b + h$, with temporary values $y_(-1)$ and $y_(n+1)$.
]

#section-emphasis("Left Boundary Derivation")

At $x_0 = a$, the central slope uses the point one step to the left and the point one step to the right. Those points are $2h$ apart.

$ y'(a) approx (y_1 - y_(-1))/(2 h). $

We impose the known slope $y'(a) = alpha$:

$ (y_1 - y_(-1))/(2 h) = alpha, $

$ y_1 - y_(-1) = 2 h alpha, $

$ y_(-1) = y_1 - 2 h alpha. $

The slopes on the intervals immediately to the right and left of $a$ are approximately $"right slope" = (y_1 - y_0)/h " and left slope" = (y_0 - y_(-1))/h. $ Their interval centers are $h$ apart. The second derivative measures the change in slope per unit distance, thus

$ y''(a) approx ((y_1 - y_0)/h - (y_0 - y_(-1))/h)/h = (y_(-1) - 2 y_0 + y_1)/h^2. $

Apply the ODE at the left endpoint. The original ODE at $a$ is $y''(a) + P_0 y'(a) + Q_0 y(a) = R_0$. Replacing the second derivative and using the known slope $alpha$, we can write $y(a)$ as $y_0$.

$ (y_(-1) - 2 y_0 + y_1)/h^2 + P_0 alpha + Q_0 y_0 = R_0. $

Substituting $y_(-1) = y_1 - 2 h alpha$ and multiplying by $h^2$ returns $2 y_1 - 2 h alpha - 2 y_0 + h^2 P_0 alpha + h^2 Q_0 y_0 = h^2 R_0.$

Rearranging the equation:

$ (h^2 Q_0 - 2) y_0 + 2 y_1 = h^2 R_0 + 2 h alpha - h^2 P_0 alpha. $

#section-emphasis("Right Boundary Derivation")

At $x_n = b$, the central slope uses $y_(n-1)$ and $y_(n+1)$:

$ y'(b) approx (y_(n+1) - y_(n-1))/(2 h). $

We impose the boundary slope $beta$:

$ (y_(n+1) - y_(n-1))/(2 h) = beta, $
$ y_(n+1) - y_(n-1) = 2 h beta, $

$ y_(n+1) = y_(n-1) + 2 h beta. $

We apply the ODE to the right endpoint. First, we evaluate the original equation at $b$. Then,

$ y''(b) + P_n y'(b) + Q_n y(b) = R_n. $

Using the central second derivative and the known slope,

$ (y_(n-1) - 2 y_n + y_(n+1))/h^2 + P_n beta + Q_n y_n = R_n. $
If we replace the ghost value using the boundary equation,

$ (y_(n-1) - 2 y_n + (y_(n-1) + 2 h beta))/h^2 + P_n beta + Q_n y_n = R_n. $

Multiplying this by $h^2$ gets $2 y_(n-1) - 2 y_n + 2 h beta + h^2 P_n beta + h^2 Q_n y_n = h^2 R_n.$ Rearranging the equation:

$ 2 y_(n-1) + (h^2 Q_n - 2) y_n = h^2 R_n - 2 h beta - h^2 P_n beta. $

We now have two equations involving only actual grid values at one of each endpoint.

#section-emphasis("Central difference of interior points")

We can now apply central difference for all interior points.

At $x_i$, the ODE is

$ y''(x_i) + P_i y'(x_i) + Q_i y(x_i) = R_i. $

Then for every interior point, the central formulas are

$ y'(x_i) approx (y_(i+1) - y_(i-1))/(2 h), quad quad y''(x_i) approx (y_(i-1) - 2 y_i + y_(i+1))/h^2. $

Solve the SLE according to the central scheme of FDA.

#h(2em)
#section-subheading("2", "Worked Example for Method of Fictitious Points in Solving FDA with Neumann Boundary Conditions")
#h(2em)

Using FDA with 3 interior points, solve the BVP
$ y''-2y'-y=0, quad y'(0)=alpha=2, y'(1) = beta=1 $

#example(number: "1")[

Given that $a = 0 "and" b = 1 "with" 3$ interior points,
$ h = (1 - 0)/ (3+1) = 0.25 $

Introduce ghost points at $x_(-1) = x_0 - h = 0 - 0.25 = 0.25$ and $x_(5) = x_4 +h = 1+0.25 = 1.25$.

Finding the left boundary equation, apply $y_(-1) = y_1 - 2 h alpha$,
$ y_(-1) = y_1 - 2 (0.25) (2) = y_1 - 1 $

Determining the left boundary equation using $(h^2 Q_0 - 2) y_0 + 2 y_1 = h^2 R_0 + 2 h alpha - h^2 P_0 alpha => ((0.25^2)(-1)-2) y_0 + 2 y_1 = (0.25^2)(0) + 2(0.25)(2) - (0.25^2)(-2)(2)$. Then

$ -33/16y_0 + 2y_1 = 5/4 $

Finding the right boundary equation, apply $y_(n+1) = y_(n-1) + 2 h beta$. Since $n = 4$,
$ y_5 = y_3 + 2 (0.25) (1) = y_3 + 0.5 $

Determining the right boundary equation using $2 y_(n-1) + (h^2 Q_n - 2) y_n = h^2 R_n - 2 h beta - h^2 P_n beta => 2y_3 + ((0.25^2)(-1)-2)y_4 = (0.25^2)(0)-2(0.25)(1)-(0.25^2)(-2)(1)$. Then

$ 2y_3 + -33/16y_4 = -3/8 $

For the interior equations, refer to the central differences that is $(1+h)y_(i-1)-(2+h^2)y_i+(1-h)y_(i+1) = 0$. That is, for $i = 1, 2, 3$,
$ 5/4y_0-33/16y_1+3/4y_2 = 0 $
$ 5/4y_1-33/16y_2+3/4y_3 = 0 $
$ 5/4y_2-33/16y_3+3/4y_4 = 0 $

The complete matrix is

$ mat(
  -33/16, 2, 0, 0, 0;
  5/4, -33/16, 3/4, 0, 0;
  0, 5/4, -33/16, 3/4, 0;
  0, 0, 5/4, -33/16, 3/4;
  0, 0, 0, 2, -33/16
) mat(y_0; y_1; y_2; y_3; y_4) = mat(5/4; 0; 0; 0; -3/8). $

The solution of the system is approximately

$ bold(y) approx mat(-4.908443; -4.436832; -4.020550; -3.661791; -3.369010). $
]