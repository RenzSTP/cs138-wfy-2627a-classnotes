// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
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
  title: [Collocation method],
)
#set par(
  justify: true,
  first-line-indent: (amount: 2.0em, all: true)
)

// SECTION SUBHEADER1

#section-subheading("1", "Introduction")
#v(0.5em)

// Utility functions
#let Coll = $op("Coll")$
#let indent = h(2em)


In the world of linguistics, collocation refers to a group of
words that form a _set phrase_, where the meaning can be
inferred from its parts. Examples include to _take a seat_,
to _make your bed_, or to _catch a cold_.

In the world of mathematics, _collocation_ refers to
approximating a function using its parts. Specifically, we
approximate a function as a linear combination of particular
basis functions such that it passes through certain
collocation points.

More formally, we have:
#definition(name: "Collocation")[
#set par(first-line-indent: 0pt)

To approximate a function $f(x)$ via _collocation_, we want to construct an interpolating function $Coll(x)$:
$
f(x) approx Coll(x) = sum_(j=0)^(n) a_j Phi_j (x)
$
where $Phi_j (x)$ denotes the *basis functions* to be used.

The coefficients $a_j$ are obtained by solving the system
$
mat(
  Phi_0 (x_0), ...,       Phi_n (x_0);
  Phi_0 (x_1), ...,       Phi_n (x_1);
  dots.v,      dots.down, dots       ;
  Phi_0 (x_n), ...,       Phi_n (x_n);
)
mat(a_0 ; a_1; dots.v ; a_n)
= mat(y_0 ; y_1; dots.v ; y_n)
$
satisfying the $n + 1$ collocation points
${(x_0, y_0), (x_1, y_1), ..., (x_n,  y_n)}$ 
where $y_i = f(x_i)$.

\
Each row
$
mat(Phi_0 (x_i), ..., Phi_n (x_i))
$
consists of the different _basis functions_ at each collocation point $(x_i, y_i)$.

\
Each column 
$
mat(Phi_j (x_0), ..., Phi_j (x_n))^top
$
consists of different _points_ of the same basis function
$Phi_j (x)$.
]
 
The number of collocation points as well as the choice of basis
function $Phi_j (x)$ affect the accuracy of the approximate
solution. Increasing the number of collocation points allows
the approximate solution to be fitted more closely to the
true solution.


// SECTION SUBHEADER2
#section-subheading("2", "Basis functions")

Different types of functions can be used as the basis
functions for the collocation method. For example, one could
choose monomial, radial, orthogonal polynomial, splines, or
trigonometric basis functions.

In choosing a basis, factors that must be considered include
the _numerical stability_ of the basis function (as this
determines the behavior of the interpolated curve) and how
easy it is to evaluate and differentiate the basis
functions. 


#section-emphasis("Monomial basis")
One of the simplest choices for basis functions are
*monomials* of the form:
$
Phi_j (x) = x^j
$
such that the collocation SLE becomes:
$
mat(
  1,      x_0,    ...,       (x_0)^n;
  1,      x_1,    ...,       (x_1)^n;
  dots.v, dots.v, dots.down, dots.v;
  1,      x_n,    ...,       (x_n)^n;
)
mat(a_0 ; a_1; dots.v ; a_n)
= mat(y_0 ; y_1; dots.v ; y_n)
$
To solve the system of equations, one should use _Gaussian
elimination_ with _partial pivoting_, since the
interpolation matrix is actually _ill-conditioned_.

==== Behavior
Although accurate with a discrete set of points, using the
monomial basis for interpolation may lead to a case of
severe *overfitting*. As the degree of the interpolating
function increases, it is likely to become more and more
unstable, causing numerical failures.

#align(center)[#image("overfitting.png", width: 50%)]

The above diagram illustrates an example of overfitting. The
linear graph (in green) represents a generally more accurate
approximation of the function despite not intersecting exactly with the specified collocation points (in blue).

Meanwhile, inspecting points outside the defined collocation
points, the polynomial function (in red) shows significantly
more variance. Thus, it is less accurate in general.

#section-emphasis("Radial basis")

The monomial basis function, as mentioned earlier, is prone
to overfitting. This means that inserting additional nodes
or data points will drastically change the behavior of the
interpolated curve.

*Radial basis functions* address this issue by controlling
the weight of the interpolating function as it moves away
from specific nodes.

These functions depend on the Euclidean distance from a
center point ($|x - x_j|$), reducing the function's
influence as its distance grows from any node $x_j$. Thus,
radial basis functions are more suitable to create smoother
interpolations and avoid overfitting.

We will discuss two examples of radial basis functions.

#section-emphasis[Gaussian]
The value of the Gaussian basis depends on the distance
$abs(x - x_j)$ from the center $x_j$. As the distance
increases, the exponent of $e$ decreases, resulting in a
smaller value. This means that the influence of $x_j$ on
some point $x$ is reduced the further away you get from $x_j$.

More formally, we define the basis function $Phi_j (x)$ as:
$
Phi_j (x) = e^(-1/2 ((x-x_j)/sigma)^2)
$
The following example illustrates how to use the Gaussian
basis.

#example(number:1)[ 
Given $f: (1, 1), (2, 4), (3, 1)$, interpolate it with $f(x)
approx sum^n _(j=0) a_j Phi_j (x)$.

*Solution.*
  
The curve must pass through every point $f(x_i) = y_i$. This
gives us 3 equations with 3 unknowns where
$A bold(a)=bold(y)$ with $A_(i j)=Phi_j (x_i)$.
\
\
For each entry of the SLE, take $x_i$ and $x_j$, compute the
distance $|x_i - x_j|$, then substitute d into the basis
formula $Phi_j (x_i) = e^(-1/2 ((x_i - x_j)/sigma)^2)$ with
$sigma = 1$ 
\
\
At $A_(1, 1)$, $x_0=1$, $|x_0 - x_0| = |1-1|=0$ and $Phi_0 (x_0) = e^0$.

Continuing for the other entries,

$
mat(
  e^0, e^(-1/2), e^(-2);
  e^(-1/2), e^0, e^(-1/2);
  e^(-2), e^(-1/2), e^0;
)
mat(a_0; a_1; a_2;) = mat(1; 4; -1;)
$

Simplifying,
$ 
mat(1, 0.6065, 0.1353; 0.6065, 1, 0.6065; 0.1353, 0.6065, 1) mat(a_0; a_1; a_2) = mat(1; 4; -1) 
$

After solving the SLE, we get
$ a_G approx mat(-4.9152; 11.3654; -7.2283) $

Recall the interpolating function $f(x) approx sum_(j=0)^(2) a_j Phi_j (x)$ 

Expanding the sum,
$ f(x) approx a_0 Phi_0 (x) + a_1 Phi_1 (x) + a_2 Phi_2 (x) $

Substituting $a_G$, we get
$ f_G (x) approx -4.9152 thin e^(-1/2 (x-1)^2) + 11.3654 thin e^(-1/2 (x-2)^2) - 7.2283 thin e^(-1/2 (x-3)^2). $

]

#example(number:2)[
  Given $f: (1, 1), (2, 4), (3, 1), (4, 8), (5, 6), (6, -3)$ interpolate it with $f(x) approx sum^n _(j=0) a_j Phi_j (x)$


  
$
mat(
  e^0, e^(-1/2), e^(-2), e^(-9/2), e^(-8), e^(-25/2);
  e^(-1/2), e^0, e^(-1/2), e^(-2), e^(-9/2), e^(-8);
  e^(-2), e^(-1/2), e^0, e^(-1/2), e^(-2), e^(-9/2);
  e^(-9/2), e^(-2), e^(-1/2), e^0, e^(-1/2), e^(-2);
  e^(-8), e^(-9/2), e^(-2), e^(-1/2), e^0, e^(-1/2);
  e^(-25/2), e^(-8), e^(-9/2), e^(-2), e^(-1/2), e^0
)

mat(a_0; a_1; a_2; a_3; a_4; a_5) = mat(1; 4; -1; 8; 6; -3)
$
  
]

#section-emphasis[Multiquadratic]

$
Phi_j(x) = sqrt((x - x_j)^2 + sigma^2)
$

#example(number: 3)[
  The problem in Example 1 can be solved using the exact same steps, but replacing the Gaussian basis function with the multiquadratic basis function
$ Phi_j (x) = sqrt((x - x_j)^2 + sigma^2), quad sigma = 1. $

Doing so results in the following SLE,
$
mat(
  sqrt(1), sqrt(2), sqrt(5);
  sqrt(2), sqrt(1), sqrt(2);
  sqrt(5), sqrt(2), sqrt(1);
)
mat(a_0; a_1; a_2;) = mat(1; 4; -1;)
$

After solving the SLE,
$ a_(M Q) approx mat(
  (12sqrt(2)+4sqrt(10)-1-sqrt(5))/4; 
  -8-4sqrt(5); 
  (12sqrt(2)+4sqrt(10)+1+sqrt(5))/4;) $

Substituting $a_(M Q)$ into the interpolating function shown in Example 1,
$ f(x) approx sum_(j=0)^(2) a_j Phi_j (x) approx a_0 Phi_0 (x) + a_1 Phi_1 (x) + a_2 Phi_2 (x) $ 
$ f_(M Q) (x) approx 6.5959 sqrt((x-1)^2+1) - 16.9443 sqrt((x-2)^2+1)\ + 8.2139 sqrt((x-3)^2+1) $

]

\ \



