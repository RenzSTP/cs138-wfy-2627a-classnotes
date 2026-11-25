#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

= Compendium Problem 1: Method of Fictitious Points

#qa(
  [
    *Source*: Gerald & Wheatly, _Applied Numerical Analysis_, Chapter 6, Example 6.7
    
    Solve $u'' = u$, $ u'(1) = 1.17520$, $ u'(3) = 10.01787$ with the finite-difference method. 
    
    _Hint_: Use the equivalences of $sinh(1)$ and $sinh(3)$ to check for the error values.
  ],
  [
    *Solution.*
    Given that $sinh(1) approx 1.17520$ and $sinh(3) approx 10.01787$, we can check for the error of the approximation. This also means that the true value of $u(x)$ follows the function $cosh(x)$.
    
    We can try using $h = 0.5$ to have four intervals or five total points giving $x_0 = 1, x_1 = 1.5, x_2 = 2, x_3 = 2.5, x_4 = 3$.

    To find the left boundary condition using method of fictitious points, we add a node $x_(-1) = 0.5$ and apply the central difference to $u'_0 = u'(1)$:
    $ (u_1 - u_(-1)) / (2h) = u'_0 quad => quad (u_1 - u_(-1)) / (2(0.5)) = 1.17520 quad => quad u_(-1) = u_1 - 1.17520. $
    Substituting into the equation at node 0:
    $ -2.25 u_0 + 2 u_1 = 1.17520. $

    To find the right boundary condition, we also add a node but to the rightmost point to have fictitious point $x_5 = 3.5.$ Then we can approximate by taking the central difference to $u'_5 = u'(3)$:
    $ (u_5 - u_3) / (2h) = u'_5 quad => quad (u_5 - u_3) / (2(0.5)) = 10.01787 quad => quad u_5 = u_3 + 10.01787. $
    Substituting into the equation at node 4:
    $ 2 u_3 - 2.25 u_4 = -10.01787. $

    For the interior points, we can apply second-order central differences.

    For $x_1,$
    $ (u_2 - 2u_1 + u_0) / (h^2) approx u_1 quad => quad (u_2 - 2u_1 + u_0) / (0.25^2) approx u_1 quad => quad 4u_2 - 8u_1 + 4u_0 approx u_1 $
    $ u_2 - 2.25u_1 + u_0 = 0 $

    For $x_2,$
    $ (u_3 - 2u_2 + u_1) / (h^2) approx u_2 quad => quad (u_3 - 2u_2 + u_1) / (0.25^2) approx u_2 quad => quad 4u_3 - 8u_2 + 4u_1 approx u_2 $
    $ u_3 - 2.25u_2 + u_1 = 0 $
    For $x_3,$
    $ (u_4 - 2u_3 + u_2) / (h^2) approx u_3 quad => quad (u_4 - 2u_3 + u_2) / (0.25^2) approx u_3 quad => quad 4u_4 - 8u_3 + 4u_2 approx u_3 $
    $ u_4 - 2.25u_3 + u_2 = 0 $
    
    Compiling the equations into one matrix,
    $
      mat(
        -2.25, 2, 0, 0, 0;
        1, -2.25, 1, 0, 0;
        0, 1, -2.25, 1, 0;
        0, 0, 1, -2.25, 1;
        0, 0, 0, 2, -2.25;
      )
      vec(u_0, u_1, u_2, u_3, u_4)
      =
      vec(1.17520, 0, 0, 0, -10.01787).
    $

    We can express every unknown in terms of $u_1$ to solve the matrix:
    $
      u_0 &= 0.88889 u_1 - 0.52231 \
      u_2 &= 1.36111 u_1 + 0.52231 \
      u_3 &= 2.25 u_2 - u_1 = 2.0625 u_1 + 1.17520 \
      u_4 &= 2.25 u_3 - u_2 = 3.27951 u_1 + 2.12189
    $

    Substitute $u_3$ and $u_4$ into the last equation:
    $
      2(2.0625 u_1 + 1.17520) - 2.25(3.27951 u_1 + 2.12189) &= -10.01787 \
      -3.25391 u_1 - 2.42385 &= -10.01787 \
      u_1 &= 2.3338
    $

    Back-substituting gives $u_0 = 1.5522$, $u_2 = 3.6989$, $u_3 = 5.9887$, $u_4 = 9.7757$.

    Therefore, the solutions to the problems are the following with their corresponding true values and errors:
    #align(center)[
      #table(
        columns: 4,
        align: center,
        table.header[*$x$*][*$u$*][*$u = cosh x$*][*Error*],
        [1.0], [1.5522], [1.5431], [0.0091],
        [1.5], [2.3338], [2.3524], [0.0186],
        [2.0], [3.6989], [3.7622], [0.0633],
        [2.5], [5.9887], [6.1323], [0.1436],
        [3.0], [9.7757], [10.0677], [0.2920],
      )
    ]

  ],
  auth: [ESQUILONA, LIANA ESTELLE],
)
#note([The "hint" given was directly used by the solution provided in the example without additional solutions included. These approximations were used in this compendium to further verify the correctness of the solutions and to also add the error values.])

#pagebreak()

= Compendium Problem 2
#qa(
  [
    *Source*: Gerald & Wheatly, _Applied Numerical Analysis_, Chapter 6, Exercises, Section 6.7, Item 65
    
    Solve through finite differences with four subintervals:
    $ y'' + y = 0, quad y'(0) + y(0) = 2, quad y'(pi/2) + y(pi/2) = -1. $
  ],
  [
    *Solution.*

    The given provides that the boundary is between $x_0 = 0$ and $x_N = pi/2$ where $N$ is the number of points or nodes. Then $h = (pi/2)/4 = pi/8 approx 0.392699$.
    
    There are five points since there should be four subintervals. These are $x_0 = 0, x_1 = pi/8, x_2 = pi/4, x_3 = 3pi/8, x_4 = pi/2$. Since both boundary conditions involve a derivative, $y_0$ and $y_4$ are also unknown.

    Refer to the central difference at an interior node that it follows
    $ (y_(i+1) - 2y_i + y_(i-1)) / h^2 + y_i = 0 quad => quad y_(i+1) - 1.845787 y_i + y_(i-1) = 0, $ <fd>
    since $h^2 - 2 = pi^2/64 - 2 approx -1.845787$.

    To find the left boundary condition using the method of fictitious points, we add a node $x_(-1) = -h = -pi/8$ and apply the central difference to $y'_0 = y'(0)$ in $y'(0) + y(0) = 2$:
    $ (y_1 - y_(-1)) / (2h) + y_0 = 2 quad => quad y_(-1) = y_1 + 2h y_0 - 4h. $
    Substituting into @fd at node 0:
    $ -1.060389 y_0 + 2 y_1 = 1.570796. $

    To find the right boundary condition, we also add a node at the rightmost end, $x_5 = pi/2 + h$, and apply the central difference to $y'_4 = y'(pi/2)$ in $y'(pi/2) + y(pi/2) = -1$:
    $ (y_5 - y_3) / (2h) + y_4 = -1 quad => quad y_5 = y_3 - 2h y_4 - 2h. $
    Substituting into @fd at node 4:
    $ 2 y_3 - 2.631185 y_4 = 0.785398. $

    For the interior points, we apply @fd directly.

    For $x_1,$
    $ y_2 - 1.845787 y_1 + y_0 = 0 $
    For $x_2,$
    $ y_3 - 1.845787 y_2 + y_1 = 0 $
    For $x_3,$
    $ y_4 - 1.845787 y_3 + y_2 = 0 $

    Compiling the equations into one matrix,
    $
      mat(
        -1.060389, 2, 0, 0, 0;
        1, -1.845787, 1, 0, 0;
        0, 1, -1.845787, 1, 0;
        0, 0, 1, -1.845787, 1;
        0, 0, 0, 2, -2.631185;
      )
      vec(y_0, y_1, y_2, y_3, y_4)
      =
      vec(1.570796, 0, 0, 0, 0.785398).
    $

    We can express every unknown in terms of $y_0$ to solve the matrix:
    $
      y_1 &= 0.530195 y_0 + 0.785398 \
      y_2 &= 1.845787 y_1 - y_0 = -0.021373 y_0 + 1.449677 \
      y_3 &= 1.845787 y_2 - y_1 = -0.569645 y_0 + 1.890397 \
      y_4 &= 1.845787 y_3 - y_2 = -1.030071 y_0 + 2.039574
    $

    Substitute $y_3$ and $y_4$ into the last equation:
    $
      2(-0.569645 y_0 + 1.890397) - 2.631185(-1.030071 y_0 + 2.039574) &= 0.785398 \
      1.571017 y_0 - 1.585702 &= 0.785398 \
      y_0 &= 1.5093
    $

    Back-substituting gives $y_1 = 1.5856$, $y_2 = 1.4174$, $y_3 = 1.0306$, $y_4 = 0.4849$.

    Therefore, the solutions to the problem are the following with their corresponding true values and errors:
    #align(center)[
      #table(
        columns: 2,
        align: center,
        table.header[*$x$*][*$y$*],
        [$0$], [1.5093],
        [$pi/8$], [1.5856],
        [$pi/4$], [1.4174],
        [$3pi/8$], [1.0306],
        [$pi/2$], [0.4849],
      )
    ]

  ],
  auth: [ESQUILONA, LIANA ESTELLE],
)

#pagebreak()

= Compendium Problem Remix
#qa(
  [
    *Source*: Burden & Faires, _Numerical Analysis_, 9th ed., Exercise Set 11.3, Problem 1.

    Consider $y'' = 4(y - x)$, $0 < x < 1$, with $y'(0) = 0$ and $y'(1) = s$, where $s$ is an unknown constant. Using the finite-difference method with fictitious points and $h = 1/4$, determine the value of $s$ that makes $y(1/2) approx 1$. Also find the approximate solution at all grid points.
  ],
  [
    *Solution.*
    Solving analytically, the general solution is $y = x + C_1 cosh 2x + C_2 sinh 2x$. The condition $y'(0) = 0$ gives $C_2 = -1/2$, and $y(1/2) = 1$ gives $C_1 approx 0.70482$. This also gives the true slope $s = y'(1) approx 2.35040$. We use this to check the error of the approximation.

    We use $h = 0.25$ to have four intervals or five total points giving $x_0 = 0, x_1 = 0.25, x_2 = 0.5, x_3 = 0.75, x_4 = 1$. Since both boundary conditions involve derivatives, $y_0$ and $y_4$ are also unknowns, so we need an equation at all five nodes.

    To find the left boundary condition using the method of fictitious points, we add a node $x_(-1) = -0.25$ and apply the central difference to $y'_0 = y'(0)$:
    $ (y_1 - y_(-1)) / (2h) = 0 quad => quad (y_1 - y_(-1)) / (2(0.25)) = 0 quad => quad y_(-1) = y_1. $
    Substituting into the equation at node 0, $y_1 - 2.25 y_0 + y_(-1) = -x_0 / 4 = 0$:
    $ -2.25 y_0 + 2 y_1 = 0. $

    To find the right boundary condition, we also add a node at the rightmost end, $x_5 = 1.25$, and apply the central difference to $y'_4 = y'(1)$:
    $ (y_5 - y_3) / (2h) = s quad => quad (y_5 - y_3) / (2(0.25)) = s quad => quad y_5 = y_3 + 0.5 s. $
    Substituting into the equation at node 4, $y_3 - 2.25 y_4 + y_5 = -x_4 / 4 = -0.25$:
    $ 2 y_3 - 2.25 y_4 = -0.25 - 0.5 s. $

    For the interior points, we can apply second-order central differences.

    For $x_1,$
    $ (y_2 - 2y_1 + y_0) / (h^2) = 4(y_1 - 0.25) quad => quad 16 y_2 - 32 y_1 + 16 y_0 = 4 y_1 - 1 $
    $ y_2 - 2.25 y_1 + y_0 = -0.0625 $
    For $x_2,$
    $ (y_3 - 2y_2 + y_1) / (h^2) = 4(y_2 - 0.5) quad => quad 16 y_3 - 32 y_2 + 16 y_1 = 4 y_2 - 2 $
    $ y_3 - 2.25 y_2 + y_1 = -0.125 $
    For $x_3,$
    $ (y_4 - 2y_3 + y_2) / (h^2) = 4(y_3 - 0.75) quad => quad 16 y_4 - 32 y_3 + 16 y_2 = 4 y_3 - 3 $
    $ y_4 - 2.25 y_3 + y_2 = -0.1875 $

    Compiling the equations into one matrix,
    $
      mat(
        -2.25, 2, 0, 0, 0;
        1, -2.25, 1, 0, 0;
        0, 1, -2.25, 1, 0;
        0, 0, 1, -2.25, 1;
        0, 0, 0, 2, -2.25;
      )
      vec(y_0, y_1, y_2, y_3, y_4)
      =
      vec(0, -0.0625, -0.125, -0.1875, -0.25 - 0.5 s).
    $

    The unknown $s$ appears only in the last equation, so we impose the condition $y_2 = y(1/2) = 1$ and solve the first four equations for the remaining values. From the first equation, $y_0 = 0.88889 y_1$. Substituting into the equation at $x_1$:
    $
      1 - 2.25 y_1 + 0.88889 y_1 &= -0.0625 \
      -1.36111 y_1 &= -1.0625 \
      y_1 &= 0.78061
    $

    Back-substituting gives
    $
      y_0 &= 0.88889 y_1 = 0.69388 \
      y_3 &= 2.25 y_2 - y_1 - 0.125 = 1.34439 \
      y_4 &= 2.25 y_3 - y_2 - 0.1875 = 1.83737
    $

    Substitute $y_3$ and $y_4$ into the last equation to solve for $s$:
    $
      2(1.34439) - 2.25(1.83737) &= -0.25 - 0.5 s \
      -1.44530 &= -0.25 - 0.5 s \
      s &= 2.39063
    $

    Therefore, $s approx 2.3906$ (exactly, $s = 7497/3136 approx 2.39063$), and the solutions to the problem are the following with their corresponding true values and errors:
    #align(center)[
      #table(
        columns: 4,
        align: center,
        table.header[*$x$*][*$y$*][*$y$ (exact)*][*Error*],
        [0.00], [0.6939], [0.7048], [0.0109],
        [0.25], [0.7806], [0.7842], [0.0036],
        [0.50], [1.0000], [1.0000], [0.0000],
        [0.75], [1.3444], [1.3434], [0.0010],
        [1.00], [1.8374], [1.8383], [0.0009],
      )
    ]

  ],
  auth: [ESQUILONA, LIANA ESTELLE],
)
