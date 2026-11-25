#import "../assets.typ": qa, note, solution-box, question-box
#set page("a4")
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")

= Collocation Lecture Example
#qa(auth:"ELIZARDE, Samantha Coleen")[
Solve the BVP
$ y′′ − 2y′ − y = 0 $
 on $x in [0,1]$
with BC $y(0) = 0, space y(1) = 1$

using 3 uniform collocation points interpolated via the Monomial basis functions.][
== Solution. 
First, the three collocation points must be equidistant with each other and the boundary points, so they must occur at intervals of 0.25:
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
= POTW 8 
#qa(auth:"ELIZARDE, Samantha Coleen")[
Consider the BVP $ y''+y=x $ with $y(a=−1)=−1$ and $y(b=1)=1$.

Using the monomial basis $ p_2(x) = sum _(j=0)^2 a_j x^j $ with 3 Chebyshev nodes (1 interior + 2 boundary),

$ x_i= frac(a+b, 2) − frac(b−a, 2) cos(frac(i pi, n)), space 0≤i≤2=n $

Write the SLE and solve for $p_2(x)$.][
== Solution
Getting the Chebyshev nodes with $a=-1$ and $b=1$,
$ x_i = frac(a+b, 2) − frac(b−a, 2) cos(frac(0 pi, n)) = frac(0, 2) − frac(2, 2) cos(frac(i pi, n)) = -cos(frac(i pi, n)) $
$ x_0 = -cos(frac(0 pi, n)) = -1 $
$ x_1 = -cos(frac(1 pi, n)) = 0  $
$ x_2 = -cos(frac(2 pi, n)) = 1  $

Expressing the given ODE $y''+y=x$ using the differential operator $cal(L)$ applied to $y$,
$ cal(L)[y] => frac(d^2, d x^2)y + frac(d, d x)y = x $
Therefore, the differential operator is 
$ cal(L) = frac(d^2, d x^2) + 1 $

Applying the differential operator to each function $Phi_j=x^j$ in the monomial basis $p_2(x)= sum^2_(j=0) a_j x^j$,
$ Phi_0 = 1, cal(L)[Phi_0] = 0 + 1 = 1 $
$ Phi_1 = x, cal(L)[Phi_1] = 0 + x = x $
$ Phi_2 = x^2, cal(L)[Phi_2] = frac(d, d x)2x + x^2 = 2 + x^2 $

To construct the matrix for the SLE, let the _j_-th column correspond to the _j_-th basis function $Phi_j$, the 0th and 2nd row correspond to the basis function evaluated at the boundary points x_0 and x_2, respectively, while the 1st row correspond to the basis function with the differential operator applied, evaluated at the interior point x_0,
$ mat(
  i\\j, j=0, j=1, j=2;
  i=0, 1, -1, (-1)^2;
  i=1, 1, 0, 2+(0)^2;
  i=2, 1, 1, 1^2
) $
The resulting SLE is
$ mat(
  1, -1, 1;
  1, 0, 2;
  1, 1, 1
) mat(
  a_0; a_1; a_2
) = mat(
  -1; 0; 1
) $

Solving this SLE yields $a=0, b=1, c=0$
Thus, the final solution is $ p_2(x)=0x^2+1x+0 $ $ p_2(x)=x $
With the approximated interior point $y(0)=0$.
]

= Remixed Problem. 

#question-box[Consider the BVP $ y''-y=-2 $ with $y(-1)=1$ and $y(1)=1$. Using the collocation method, approximate the solution using the monomial basis $ p_n(x) = sum _(j=0)^n a_j x^j $
Use Chebyshev nodes for the following cases:
- Case 1: 1 interior collocation point (3 points in total)
- Case 2: 2 interior collocation points (4 points in total)
- Case 3: 3 interior collocation points (5 points in total)

For each case, (1) determine the collocation points, (2) construct the collocation SLE in the form of a matrix, (3) solve the SLE to obtain the approximate solution.

Finally, compare the approximate solutions to the true solution: $ y(x)=2 - frac(cosh(x), cosh(1)) $

Investigate how the number of collocation points affects the accuracy of the approximate solution.]