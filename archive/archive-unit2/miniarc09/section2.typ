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
  title: [Linear Collocation],
)

// SECTION SUBHEADER1

#section-subheading("1", "Solution")
#h(2em) // fix indent for 1st paragraph
Given a BVP, the solution can be approximated as $ f(x) approx sum_(j=0)^(n) a_j Phi_j (x) $ 

#h(2em)
A number of collocation points and a basis function must be determined, then the coefficients $a_j$ must be solved such that the ODE is satisfied at all collocation points.  
The solution can be modeled as the following SLE in order to derive the values of $a_j$:

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

#h(2em)
The coefficient matrix is constructed by first determining
the values for the collocation points $x$. Then, from the
given BVP, obtain the differential operator $cal(L)$ applied
to $y$, and apply the differential operator to the basis
functions.

Each row in the coefficient matrix corresponds to
the evaluation of the basis functions at a certain
collocation point. 

Let the _i-th_ row correspond to the _i-th_ collocation
point, and let the _j-th_ column correspond to the _j-th_
basis function. Entry $(i,j)$ is the evaluation of basis
function $Phi_j$ at collocation (BC or internal) point
$x_i$. At the boundary conditions $i=0$ and $i=n$, they are
evaluated directly using the basis functions. At
the interior collocation points, they are evaluated with the
linear differential operator applied to the basis
functions in order to ensure that the ODE is satisfied at
these points.

Symbolically, the left-hand side matrix becomes:
$ 
mat(
  (text("BC1")), Phi_0 (x_0), Phi_1 (x_0), ..., Phi_4 (x_0);
  ...;
  (text("Coll")), cal(L)[Phi_0 (x_i)], cal(L)[Phi_1 (x_i)], ..., cal(L)[Phi_4 (x_i)];
  ...;
  (text("BC2")), Phi_0 (x_n), Phi_1 (x_n), ..., Phi_4 (x_n);
) 
$

#h(2em)
With this, the SLE can be solved to produce the vector $a$, which can be substituted back into the original approximation, giving the final solution.
  
#example(number: 4)[
  Solve the BVP
$ y′′ − 2y′ − y = 0 $
 on $x in [0,1]$
 with BC $y(0) = 0, space y(1) = 1$

 using 3 uniform collocation points interpolated via the Monomial basis functions.

*Solution*. First, the three collocation points must be equidistant with each other and the boundary points, so they must occur at intervals of 0.25:
$ x_0=0, x_1=0.25, x_2=0.5, x_3=0.75, x_4=1 $

With the interior collocation points and the boundary points, there are a total of five points, thus five monomial basis functions must also be used. These monomial basis functions will be the various $Phi(x)$:
$ Phi_0(x)=1, Phi_1(x)=x, Phi_2(x)=x^2, Phi_3(x)=x^3, Phi_4(x)=x^4 $
Thus, the approximation can be represented as $ f(x) approx sum_(j=0)^(n) a_j Phi_j (x) approx a_0(1)+a_1x+a_2x^2+a_3x^3+a_4x^4 $ 

The given BVP can be expressed as the linear differential operator applied to $y$ $  y′′ − 2y′ − y = 0  => cal(L)[y]= frac(d^2y, d x^2) -2 frac(d y, d x)-1 $ $ cal(L)= frac(d^2, d x^2) -2 frac(d, d x)-1 $

So the BVP can be approximated by applying the linear differential operator $cal(L)$ to each monomial basis function, which yields the following:

$ cal(L)[1] &= 0 -2 (0)-1 = -1 \
 cal(L)[x] &= 0 -2 -x = -2-x \
 cal(L)[x^2] &= 2 -2(2x) -x^2 = 2 -4x -x^2\
 cal(L)[x^3] &= 6x-2(3x^2)-x^3 = 6x-6x^2-x^3 \
 cal(L)[x^4] &= 12x^2 -2(4x^3) -x^4 = 12x^2-8x^3-x^4 $

 To construct the coefficient matrix of the SLE, the first row and the _nth_ row will be computed by directly evaluating the the basis functions with the first and second boundary conditions, respectively. The inner matrix rows will be computed by evaluating the basis functions with the differential operator applied using the inner collocation points. This results in:
$ 
mat(
  x_i \\ Phi_j, j=0, j=1, j=2, j=3, j=4;
  (i=0, B C)space 0, (x_0)^0=1, (x_0)^1=0, (x_0)^2=0, (x_0)^3=0, (x_0)^4=0;
  (i=1)space 0.25, cal(L)[(x_1)]=-1, frac(-9, 4), frac(15, 16), frac(71, 64), frac(159, 256);
  (i=2)space 0.5, cal(L)[(x_2)]=-1, frac(-5, 2), frac(-1, 4), frac(11, 8), frac(31, 16);
  (i=3)space 0.75, cal(L)[(x_3)]=-1, frac(-11, 4), frac(-25, 16), frac(45, 64), frac(783, 256);
  (i=4, B C)space 1, (x_4)^0=1, 1, 1, 1, 1;
) 
$
The resulting system of linear equations is:
$ 
mat(
  1, 0, 0, 0, 0;
  -1, frac(-9, 4), frac(15, 16), frac(71, 64), frac(159, 256);
  -1, frac(-5, 2), frac(-1, 4), frac(11, 8), frac(31, 16);
  -1, frac(-11, 4), frac(-25, 16), frac(45, 64), frac(783, 256);
  1, 1, 1, 1, 1;
) 
mat(
  a_0; a_1; a_2; a_3; a_4
)
=
mat(
  0; 0; 0; 0; 1
)
$
  Note that the RHS of the inner collocation points is equal to 0 from the original ODE - it is homogenous. The system can then be solved in order to derive the coefficient vector of $a$, and returning this to the approximation $y(x) approx sum_(j=0)^(n) a_j Phi_j (x)$, the final solution is $ y(x) approx 0.238219x + 0.443222x^2 - 0.158479x^3 + 0.477039x^4 $
]
\ \

// SECTION SUBHEADER2
#section-subheading("2", "Choice of Points")
#h(2em) // fix indent for 1st paragraph

Common choices of collocation points include uniform (equally-spaced) points and Chebyshev points.

#section-emphasis("Uniform")
Simple, but prone to overfitting via oscillations.
$
x_i = x_0 + i h
$

#section-emphasis("Chebyshev")
Minimized oscillations because points are equidistant on the unit circle.
$
x_i = (a+b)/2 - (b-a)/2 cos((i pi)/ n), 0 <= i <= n
$

#section-subheading("3", "Examples")

#example(number: 5)[
From Heath

Solve the BVP
$ u''(t) = 6 t, quad 0 < t < 1, quad u(0) = 0, quad u(1) = 1 $
using 3 uniform collocation points, interpolated via the monomial basis functions.

*Solution.* \
$ L = d^2 / (d t^2), quad L[u] = u'' = 6 t $

The three uniform points on $[0, 1]$ ($h = 0.5$) are
$ t_0 = 0, quad t_1 = 0.5, quad t_2 = 1 $

Approximating the solution using the monomial basis function,
$ u(t) approx sum_(j=0)^(2) a_j Phi_j (t), quad u'(t) approx sum_(j=0)^(2) a_j Phi'_j (t) $
$ u''(t) approx sum_(j=0)^(2) a_j Phi''_j (t)  $

Where
$ Phi_j (t) = t^j, quad Phi'_j (t) = j t^(j-1) $
$ Phi''_j (t) = j(j-1) t^(j-2) $
\
$ Phi_0 = t^0 = 1, quad Phi_1 = t, quad Phi_2 = t^2 $

Applying $L$ to each $Phi_j$:
$ L[Phi_j (t)] = Phi''_j (t) = j (j-1) t^(j-2) $

$ =>L[Phi_0] = 0, quad L[Phi_1] = 0, quad L[Phi_2] = 2 $

Building the equations, one per unknown\
*(BC1)* at $t_0 = 0$:
$ a_0 Phi_0 (0) + a_1 Phi_1 (0) + a_2 Phi_2 (0) = a_0 = 0 $

*(Coll)* at the interior point $t_1 = 0.5$:
$ a_0 L[Phi_0 (t_1)] + a_1 L[Phi_1 (t_1)] + a_2 L[Phi_2 (t_1)] = 6 t_1 = 3 $ 
$ => quad 0 dot a_0 + 0 dot a_1 + 2 a_2 = 3 $

*(BC2)* at $t_2 = 1$:
$ a_0 Phi_0 (1) + a_1 Phi_1 (1) + a_2 Phi_2 (1) = a_0 + a_1 + a_2 = 1 $

Our final SLE would then be,

#align(center)[
  #table(
    columns: 5,
    align: center,
    [], [$j = 0$], [$j = 1$], [$j = 2$], [RHS],
    [(BC1) $t_0 = 0$], [$(t_0)^0 = 1$], [$(t_0)^1 = 0$], [$(t_0)^2 = 0$], [$alpha = 0$],
    [(Coll) $t_1 = 0.5$], [$L[(t_1)^0] = 0$], [$L[(t_1)^1] = 0$], [$L[(t_1)^2] = 2$], [$6 t_1 = 3$],
    [(BC2) $t_2 = 1$], [$(t_2)^0 = 1$], [$(t_2)^1 = 1$], [$(t_2)^2 = 1$], [$beta = 1$],
  )
]

$ mat(1, 0, 0; 0, 0, 2; 1, 1, 1) mat(a_0; a_1; a_2) = mat(0; 3; 1) $

Solving for $a_0, a_1, a_2,$
$ a_0=0 $
$ 2 a_2=3 => a_2 = 3 slash 2 =1.5 $
$ a_1 = 1 - a_0 - a_2 =1-0-1.5 = -0.5 $

Therefore the approximate solution is
$ u(t) approx 0 + (-0.5) t + 1.5 t^2 = -0.5 t +1.5t^2 $

And at the interior collocation point $t_1=0.5$
$ u(0.5) = -0.5(0.5) + 1.5 (0.5)^2 = -0.25 + 0.375 = 0.125 $

]