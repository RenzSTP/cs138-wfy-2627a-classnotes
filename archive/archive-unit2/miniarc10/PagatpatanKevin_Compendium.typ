#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1
#qa(auth:"PAGATPATAN, TRANCE KEVIN")[
  *Source: Burden and Faires, _Numerical Analysis_,
  Section 11.4, Exercise Set 11.4, Item 1.*

  Use the Nonlinear Finite-Difference method with $h = 0.5$ to approximate the solution to the boundary-value problem:
  $ y'' = -(y')^2 - y + ln x, quad 1 <= x <= 2, quad y(1) = 0, quad y(2) = ln 2 $

  Compare your results to the actual solution $y = ln x$.
  
][*Solution*

  Let our interval be [1,2], with step size $g == 0.5$; we'll have points $x_0 = 1, x_1 = 1.5, "and" x_2 = 2$.

  Given the boundary conditions, $y_0 = 1 "and" y_2 = ln 2$.

  We now solve for the approximation at $x_1 = 1.5$.

  $
  y''(x_1) approx (y_2-2y_1+y_0)/(h^2) = (ln 2 - 2y_1 + 0)/(0.25) = 4 ln 2 - 8 y_1 \

  y'(x_1) approx (y_2 - y_0)/(2h) = (ln 2 - 0)/1 = ln 2
  $

  We then substitute these values to $ y'' = -(y')^2 - y + ln x$ at $x = 1.5$

  $
    &=> 4 ln 2 - 8y_1 = -(ln 2)^2 - y_1 + ln(1.5) \
    &=> 4 ln 2 + (ln 2)^2 - ln 1.5 = 7y_1 \
    &=> y_1 = (4 ln 2 + (ln 2)^2 - ln 1.5) / 7 \
    &=> y_1 = 0.4067966611
  $

  #rect(
    [  The actual value of $ln(1.5) = 0.4054651081$.
  
  Absolute error = $abs(0.4067966611 - 0.4054651081)$ = 0.001331553]
  )
  

  
  
]

== Compendium Problem 2 
#qa(auth:"PAGATPATAN, TRANCE KEVIN")[
  *Source: Burden and Faires, _Numerical Analysis_,
  Section 11.4, Exercise Set 11.4, Item 3c.*

  Use the Nonlinear Finite-Difference Algorithm with $T O L = 10^(-4)$ to approximate the solution to the following boundary-value problem:

  $ y'' = -(2(y')^3 + y^2 y') sec x, quad pi/4 <= x <= pi/3 $
  
  with boundary conditions:
  
  $ y(pi/4) = 2^(-1/4), quad y(pi/3) = 1/2 root(4, 12) $
  
  Use $N = 4$.
  
  The actual solution is given for comparison to your results:
  
  $ y(x) = sqrt(sin x) $
  
][*Solution*
Let $F = y'' + (2(y')^3 + y^2 y') sec x$. We want this to be $0$ for all $i = 1, dots, 4$.
Applying finite difference approximation,
$
F_i = (y_(i-1)-2y_i+y_(i+1))/h^2 + (2 ((y_(i+1)-y_(i-1))/(2h))^3 + y_i^2 (y_(i+1)-y_(i-1))/(2h)) sec x_i
$
or more preferably (avoids ill-conditioning due to a small divisor):
$
F_i = y_(i-1) - 2y_i + y_(i+1) + h^2 (2 ((y_(i+1)-y_(i-1))/(2h))^3 + y_i^2 (y_(i+1)-y_(i-1))/(2h)) sec x_i
$

Upon obtaining the Jacobian, we have the following nonzero terms:
$
(partial F_i)/(partial y_(i-1)) = 1 - h/2 (6 ((y_(i+1)-y_(i-1))/(2h))^2 + y_i^2) sec x_i
\
(partial F_i)/(partial y_i) = - 2 + h y_i (y_(i+1)-y_(i-1)) sec x_i
\
(partial F_i)/(partial y_(i+1)) = 1 + h/2 (6 ((y_(i+1)-y_(i-1))/(2h))^2 + y_i^2) sec x_i
$

Let the nonzero terms of $bold(J)$ be defined for $i = 1, dots, 4$:
$
a_i = (partial F_i)/(partial y_(i-1)) = 1 - h/2 (6 ((y_(i+1)-y_(i-1))/(2h))^2 + y_i^2) sec x_i \
b_i = (partial F_i)/(partial y_i) = - 2 + h y_i (y_(i+1)-y_(i-1)) sec x_i \
c_i = (partial F_i)/(partial y_(i+1)) = 1 + h/2 (6 ((y_(i+1)-y_(i-1))/(2h))^2 + y_i^2) sec x_i
$

$ bold(J) = mat(
  b_1, c_1, 0, 0;
  a_2, b_2, c_2, 0;
  0, a_3, b_3, c_3;
  0, 0, a_4, b_4
) $

with the initial linear interpolation values for $y_i$, we reach the following approximate points after 3 iterations:

```
i    x_i       y_i (FDA Newton)   Exact sqrt(sin x)  Absolute Error
-----------------------------------------------------------------
0    0.785398  0.84089642         0.84089642         0.000000e+00
1    0.837758  0.86205907         0.86205848         5.898621e-07
2    0.890118  0.88155964         0.88155882         8.135513e-07
3    0.942478  0.89945447         0.89945372         7.507090e-07
4    0.994838  0.91579005         0.91578959         4.630878e-07
5    1.047198  0.93060486         0.93060486         0.000000e+00
```


]

== Remixed Problem
#qa(auth:"PAGATPATAN, TRANCE KEVIN")[
Use the Nonlinear Finite-Difference Algorithm with $T O L = 10^(-4)$ to approximate the solution to the following boundary-value problem:

$ y'' = -(y')^2 - y + ln x, quad 1 <= x <= 2 $

with boundary conditions:

$ y(1) = 0, quad y(2) = ln 2 $

Use $N = 3$.

Compare the results of this approximation at x = $1.5$ with Compendium Problem 1.


  
][*Solution*


  Let $F = y'' + (y')^2 + y - ln x$. We want this to be $0$ for all $i = 1, dots, 3$.

Applying finite difference approximation with $h = (2 - 1)/(3 + 1) = 0.25$,
$
F_i = (y_(i-1)-2y_i+y_(i+1))/h^2 + ((y_(i+1)-y_(i-1))/(2h))^2 + y_i - ln x_i
$
or more preferably (avoids ill-conditioning due to a small divisor):
$
F_i = y_(i-1) - 2y_i + y_(i+1) + h^2 (((y_(i+1)-y_(i-1))/(2h))^2 + y_i - ln x_i)
$

Upon obtaining the Jacobian, we have the following nonzero terms:
$
(partial F_i)/(partial y_(i-1)) = 1 - 1/2 (y_(i+1)-y_(i-1))
\
(partial F_i)/(partial y_i) = - 2 + h^2
\
(partial F_i)/(partial y_(i+1)) = 1 + 1/2 (y_(i+1)-y_(i-1))
$

Let the nonzero terms of $bold(J)$ be defined for $i = 1, dots, 3$:
$
a_i = (partial F_i)/(partial y_(i-1)) = 1 - 1/2 (y_(i+1)-y_(i-1)) \
b_i = (partial F_i)/(partial y_i) = - 2 + h^2 \
c_i = (partial F_i)/(partial y_(i+1)) = 1 + 1/2 (y_(i+1)-y_(i-1))
$

$ bold(J) = mat(
  b_1, c_1, 0;
  a_2, b_2, c_2;
  0, a_3, b_3
) $

with the initial linear interpolation values for $y_i$, we reach the following approximate points after 3 iterations:

```
i    x_i       y_i (FDA Newton)   Exact ln(x)        Absolute Error
-----------------------------------------------------------------
0    1.00      0.00000000         0.00000000         0.000000e+00
1    1.25      0.22348959         0.22314355         3.460390e-04
2    1.50      0.40579097         0.40546511         3.258664e-04
3    1.75      0.55979642         0.55961579         1.806330e-04
4    2.00      0.69314718         0.69314718         0.000000e+00
```

#rect[
    $ln(1.5) = $ 0.4054651081
    
  - Single point and iteration (Compendium Problem 1)
    - $ln(1.5) approx 0.4067966611$
    - Absolute Error: 0.001331553


  - 3 Interior points with 3 Newton iterations
    - $ln (1.5) approx 0.40579097$
    - Absolute Error: $ 3.258664 times 10^(-4)$


]

]