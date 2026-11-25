// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
// #set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

  // I really hate how this is not the default
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis, qa

/// END STYLING PREAMBLE
// SECTION HEADER
#show: notes.with(
  title: [Compendium Problems 1 & 2],
  subtitle: [ Arc 8 · Matias, Gabriel Ian Carl], 
)

#qa(auth: "MATIAS, Gabriel Ian Carl")[
  *Source:* Burden and Faires, _Numerical Analysis_, 10th Edition,
  Chapter 9, Exercise Set 9.5, Items 8(a) and 8(b).
#let dotline(w) = box(baseline: -0.25em, line(length: w, stroke: (dash: "dotted", thickness: 1.2pt)))

The (m — 1) x (m — 1) tridiagonal matrix 
$ A = mat(
  delim: "[",
  row-gap: #0.5em,
  1 - 2alpha, alpha, 0, #dotline(3.5em), 0;
  alpha, 1 - 2alpha, alpha, dots.down, dots.v;
  0, dots.down, dots.down, dots.down, 0;
  dots.v, dots.down, dots.down, dots.down, alpha;
  0, #dotline(2.5em), 0, alpha, 1 - 2alpha;
) $
  is involved in the Forward Difference method to solve the heat equation (see Section 12.2). For the stability of the method, we need p(A) < 1. With m = 11, approximate the eigenvalues of A for each of the following. 
#grid(
  columns: (1fr, 1fr),
  [*a.* $space alpha = 1/4$],
  [*b.* $space alpha = 1/2$],
)
][
  *Solution:* (*a.* $alpha = 1/4$.)
  
  With m = 11 and $alpha = 1/4$, A is a 10 x 10 matrix.
  $ A = mat(
    delim: "[",
    row-gap: #0.5em,
    1/2, 1/4, 0, dots.h, 0;
    1/4, 1/2, 1/4, dots.down, dots.v;
    0, dots.down, dots.down, dots.down, 0;
    dots.v, dots.down, dots.down, dots.down, 1/4;
    0, dots.h, 0, 1/4, 1/2,;
  ) $
  Note that equation in Section 12.2 pertains to _"the numerical solution to a problem involving a parabolic partial differential equation:"_ $ (partial u ) / (partial t )(x, t) - alpha ^2 (partial^2 u) / (partial x^2)(x, t) = 0 $  
  which are the first order partial derivative with respect to time _t_ and the second order partial derivative with respect to space _x_ respectively ($u(x, 0) = f(x))$.
  
  We can substitute the partial derivatves with the first order forward difference and second order central difference formulas respectively such that:

  $ 
  (f_(i, j+1) - f_(i, j))/(k) - alpha^2((f_(i+1,j) - 2f_(i,j) + f_(i-1,j))/(h^2)) = 0 \
  (f_(i, j+1) - f_(i, j))/(k) = alpha^2((f_(i+1,j) - 2f_(i,j) + f_(i-1,j))/(h^2)) \
  f_(i, j+1) - f_(i, j) = (k alpha^2)/(h^2) (f_(i+1,j) - 2f_(i,j) + f_(i-1,j)) \
  $

In this case, we let the mesh radio parameter $alpha = (k alpha^2)/(h^2).$
  $
  f_(i, j+1) - f_(i, j) = alpha(f_(i+1,j) - 2f_(i,j) + f_(i-1,j)) \
  $

  $
  f_(i, j+1) = alpha(f_(i+1,j) - 2f_(i,j) + f_(i-1,j))- f_(i, j) \
  $

$ f_(i, j+1) = alpha f_(i-1, j) + (1 - 2alpha)f_(i, j) + alpha f_(i+1, j) $

Substituting $alpha = 1/4$:

$ f_(i, j+1) = 1/4 f_(i-1, j) + 1/2 f_(i, j) + 1/4 f_(i+1, j) $

In Burden and Faires, it specifies that the heat equation uses *Dirichlet* boundary conditions which implies $f_(0, j) = 0$ and $f_(11, j) = 0$.

As such, for every interior point $i = 1, 2, dots, 10$:


*$i = 1$:* 
  $ 
    f_(1, j+1) &= 1/4 f_(0, j) + 1/2 f_(1, j) + 1/4 f_(2, j)\ 
               &= 0 + 1/2 f_(1, j) + 1/4 f_(2, j)
  $

*$i = 2$:*
  $ f_(2, j+1) = 1/4 f_(1, j) + 1/2 f_(2, j) + 1/4 f_(3, j) $

*$i = 3, dots space 9$:*
  $ f_(i, j+1) = 1/4 f_(i-1, j) + 1/2 f_(i, j) + 1/4 f_(i+1, j) $

*$i = 10$:*
  $ f_(10, j+1) &= 1/4 f_(9, j) + 1/2 f_(10, j) + 1/4 f_(11, j) \
                &= 1/4 f_(9, j) + 1/2 f_(10, j) + 0
  $

Notice that writing this in matrix form results in the same matrix A defined above.
\
\
=== Eigenvalues and Stability Analysis
\
To approximate the eigenvalues, we must find $lambda$ such that $A v = lambda v$ wherein:
$
  alpha v_(i-1) + (1 - 2alpha) v_i + alpha v_(i+1) = lambda v_i\
  alpha v_(i-1) + (1 - 2alpha - lambda) v_i + alpha v_(i+1) = 0 
$

with boundary conditions $v_0 = 0$ and $v_m = 0$.

Since the boundaries are set to 0, we can set the initial guess $v_i = sin(i theta)$ where $i$ is the $i$_th_ row.  

At $i=0: v_0 = sin(0 theta) = sin(0) = 0$

At $i=11: v_11 = sin(11 theta) = 0$

Note that $sin (11 theta) = 0$ whenever $11 theta = k pi => theta = (k pi)/11, k > 0$.  As such:

$ sin (i theta) = sin ((i k pi)/11) = v_i $

When we plug this in to the stencil:

$ alpha sin (((i-1) k pi)/11) + (1 - 2alpha) sin ((i k pi)/11) + alpha sin (((i+1) k pi)/11) = lambda_k sin ((i k pi)/11)  $
By the sum-to-product identity: 
$  (1 - 2alpha) sin ((i k pi)/11) + 2 alpha cos((k pi)/11)sin((k pi)/11) = lambda_k sin ((i k pi)/11)  $
Dividing both sides by $sin ((i k pi)/11)$, we obtain the closed form formula for $lambda_k:$
$
  (1 - 2alpha) + 2 alpha cos((k pi)/11) = lambda_k
$
Let $alpha = 1/4:$
$  
 lambda_k &= 1- 2(1/4) + 2 (1/4) cos((k pi)/11)\
          &= 1/2 + 1/2 cos((k pi)/11)
$

#align(center, table(
  columns: (auto, auto),
  align: center,
  table.header([$k$], [Eigenvalue $lambda_k$]),
  [$1$], [$0.9797464868$],
  [$2$], [$0.9206267664$],
  [$3$], [$0.827430367$],
  [$4$], [$0.7077075065$],
  [$5$], [$0.5711574191$],
  [$6$], [$0.4288425809$],
  [$7$], [$0.2922924935$],
  [$8$], [$0.172569633$],
  [$9$], [$0.07937323358$],
  [$10$], [$0.02025351319$],
))

The spectral radius $rho(A)$ is the maximum magnitude of the eigenvalues:

$ rho(A) = max_(1 <= k <= 10) |lambda_k| = lambda_1 approx 0.02025351319 $

Since $rho(A) approx 0.02025351319 < 1$, the Forward Difference method is *stable* for $alpha = 1/4$.

For *b. *$alpha = 1/2$:
$  
 lambda_k &= 1- 2(1/2) + 2 (1/2) cos((k pi)/11)\
          &= cos((k pi)/11)
$

#align(center, table(
  columns: (auto, auto),
  align: center,
  table.header([$k$], [Eigenvalue $lambda_k$]),
  [$1$], [$0.9594929736$],
  [$2$], [$0.8412535328$],
  [$3$], [$0.6548607339$],
  [$4$], [$0.415415013$],
  [$5$], [$0.1423148383$],
  [$6$], [$-0.1423148383$],
  [$7$], [$-0.415415013$],
  [$8$], [$-0.6548607339$],
  [$9$], [$-0.8412535328$],
  [$10$], [$-0.9594929736$],
))

The spectral radius $rho(A)$ is the maximum magnitude of the eigenvalues:

$ rho(A) = max_(1 <= k <= 10) |lambda_k| = lambda_1 approx 0.9594929736 $

Since $rho(A) approx 0.9594929736 < 1$, the Forward Difference method is *stable* for $alpha = 1/2$.
\
\
]

#pagebreak()
#show: notes.with(
  title: [Remixed Problem],
  subtitle: [ Arc 8 · Matias, Gabriel Ian Carl], 
)

#qa(auth: "MATIAS, Gabriel Ian Carl")[
  *Original Source:* Burden and Faires, _Numerical Analysis_, 10th Edition,
  Chapter 9, Exercise Set 9.5, Items 8(a) and 8(b).
#let dotline(w) = box(baseline: -0.25em, line(length: w, stroke: (dash: "dotted", thickness: 1.2pt)))

Given the (m — 1) x (m — 1) tridiagonal matrix 
$ A = mat(
  delim: "[",
  row-gap: #0.5em,
  1 - 2alpha, alpha, 0, #dotline(3.5em), 0;
  alpha, 1 - 2alpha, alpha, dots.down, dots.v;
  0, dots.down, dots.down, dots.down, 0;
  dots.v, dots.down, dots.down, dots.down, alpha;
  0, #dotline(2.5em), 0, alpha, 1 - 2alpha;
) $
find smallest positive value $alpha_("crit")$ that makes the Forward difference used to solve the heat equation unstable with $m=11$.
// #grid(
//   columns: (1fr, 1fr),
//   [*a.* $space alpha = 1/4$],
//   [*b.* $space alpha = 1/2$],
// )
][
  
  For the Forward Difference method to become unstable, the spectral radius $rho(A)$ should be greater than or equal to 1 such that: 
  
  $ max_(1 <= k <= 10) |lambda_k| >= 1 $

  To approximate the eigenvalues, we must find $lambda$ such that $A v = lambda v$ wherein:
$
  alpha v_(i-1) + (1 - 2alpha) v_i + alpha v_(i+1) = lambda v_i\
  alpha v_(i-1) + (1 - 2alpha - lambda) v_i + alpha v_(i+1) = 0 
$

with boundary conditions $v_0 = 0$ and $v_m = 0$.

Since the boundaries are set to 0, we can set the initial guess $v_i = sin(i theta)$ where $i$ is the $i$_th_ row.  

At $i=0: v_0 = sin(0 theta) = sin(0) = 0$

At $i=11: v_11 = sin(11 theta) = 0$

Note that $sin (11 theta) = 0$ whenever $11 theta = k pi => theta = (k pi)/11, k > 0$.  As such:

$ sin (i theta) = sin ((i k pi)/11) = v_i $

When we plug this in to the stencil:

$ alpha sin (((i-1) k pi)/11) + (1 - 2alpha) sin ((i k pi)/11) + alpha sin (((i+1) k pi)/11) = lambda_k sin ((i k pi)/11)  $
By the sum-to-product identity: 
$  (1 - 2alpha) sin ((i k pi)/11) + 2 alpha cos((k pi)/11)sin((k pi)/11) = lambda_k sin ((i k pi)/11)  $
Dividing both sides by $sin ((i k pi)/11)$, we obtain the closed form formula for $lambda_k:$
$
  lambda_k = (1 - 2alpha) + 2 alpha cos((k pi)/11)
$

$ 
  max_(1 <= k <= 10) |lambda_k| >= 1 \
  max_(1 <= k <= 10) |(1 - 2alpha) + 2 alpha cos((k pi)/11)| >= 1
$

Using the half-angle identity $1 - cos(theta) = 2 sin^2(theta / 2)$, we can rewrite $lambda_k$ as:
$
  lambda_k &= (1 - 2alpha) + 2alpha cos((k pi)/11) \
           &= 1 - 2alpha(1 - cos((k pi)/11)) \
           &= 1 - 4alpha sin^2((k pi)/22)
$

Note the absolute value, this implies that to trigger instability:
$ lambda_k = 1 - 4alpha sin^2((k pi)/22) >= 1 $ 
#align(center,[or])
$ lambda_k = 1 - 4alpha sin^2((k pi)/22) <= -1 $

For $lambda_k >= 1:$
$ 
  1 - 4alpha sin^2((k pi)/22) &>= 1 \
  -4alpha sin^2((k pi)/22) &>= 0 \
  -4alpha &>= 0 \
  alpha &<= 0 \
$

In the problem statement, we are specifically looking for a _positive_ value for $alpha$.

Note that although substituting a negative $alpha$ to the equation would make it unstable as $sin^2((k pi)/22)$ is always positive $forall k > 0$, in Forward Difference for the heat equation, $alpha$ is always assumed to be positive.  

For $lambda_k <= -1:$
$ 
  1 - 4alpha sin^2((k pi)/22) &<= -1 \
  -4alpha  &<= -2/(4sin^2((k pi)/22)) \
  alpha &>= 2/(4sin^2((k pi)/22)) \
  alpha &>= 1/(2sin^2((k pi)/22)) \
$

Since this $alpha$ is positive in this case, we can find the smallest possible value that satisfies the inequality.

$
  alpha_("crit") = min_(1 <= k <= 10) (1 / (2 sin^2((k pi)/22)))
$
To minimize the fraction, we must maximize the denominator $sin^2((k pi)/22)$. 

Because $(k pi)/22 in (0, pi/2)$ lies strictly in the first quadrant where the sine function is monotonically increasing, the maximum occurs at the highest discrete spatial frequency, $k = 10$:
$
  sin((10 pi)/22) = sin(pi/2 - pi/22) = cos(pi/22)
$
$
  sin^2((10 pi)/22) = cos^2(pi/22)
$

Substituting this back into the critical expression:
$
  alpha_("crit") = 1 / (2 cos^2(pi/22))
$

Evaluating numerically:
$
  cos(pi/22) &approx 0.98982 \
  cos^2(pi/22) &approx 0.97975 \
  alpha_("crit") &approx 1 / (2 dot 0.97975) = 1 / 1.95949 approx 0.51034
$
  \
  \
]
= Reference
#par(hanging-indent: 0.5in)[Burden, R. L., Faires,  J. D., and  Burden, A. M. (2016), _Numerical Analysis_ (10th ed., p. 605).  Cengage Learning.]