#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1
// WIP
#qa(auth: "CELESTINO, LEO")[Although $q(x) < 0$ in the following boundary-value problems, unique solutions exist and are given.

Use the Linear Shooting Algorithm to approximate the solution to the problem
$  y'' + y = 0, quad 0 ≤ x ≤ π/4 , quad y(0) = 1, y(π/4) = 1 $
using $h = π/20$, and compare the results to the actual solution 
$ y(x) = cos x + (sqrt(2) − 1) sin x. $

*Source:* Burden and Faires, _Numerical Analysis_, Section 11.1, Exercise Set 11.1, Item 4(a)][
// ANSWER
  The ODE is already homogenous, but in order to use linear shooting, we should still set the IVPs. 
  + $y''_1 = -y_1, quad y_1(0) = 1, y'_1(0) = 0$
  + $y''_2 = -y_2, quad y_2(0) = 0, y'_2(0) = 1$

  Since there was a specified $h$, we will use a numerical method to approximate. So we'll need to split these SODEs up into systems of FODEs, and turn the initial conditions into vectors. 

  For $y_1$: let $u_1 = y_1, u_2 = y'_1$, which makes 
  $ bold("u") = mat(u_1; u_2), quad 
  bold("u"') = mat(u_2; -u_1), quad 
  bold("u")(0) = mat(1; 0) $
  For $y_2$: let $v_1 = y_2, v_2 = y'_2$, which makes
  $ bold("v") = mat(v_1; v_2), quad 
  bold("v"') = mat(v_2; -v_1), quad 
  bold("v")(0) = mat(0; 1) $

  Given $h = pi/20$, we calculate 
  $ n = (b-a) / h = (pi/4 - 0) / (pi/20) = 5 $
  So our points are $x_i = pi/20 i$ for $i = 0, 1, 2, 3, 4, 5$.  
  
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
      [0], [1.000000], [0.000000], 
        [0.000000], [1.000000],  
      [$pi/20$], [0.987688], [-0.156434], 
        [0.156434], [0.987688],
      [$pi/10$], [0.951057], [-0.309015], 
        [0.309015], [0.951057],
      [$(3pi)/20$], [0.891007], [-0.453988], 
        [0.453988], [0.891007],
      [$pi/5$], [0.809018], [-0.587782], 
        [0.587782], [1.203970],
      [$pi/4$], [0.707109], [-0.707104], 
        [0.707104], [0.707109],
    ), 
    caption: [_RK4 approximations_]
  )

  Calculate $y$ from these approximations given the linear shooting formula: 
  $ y(x) = y_1(x) + (beta - y_1(b)) / (y_2(b)) y_2(x) $
  Calculate the constant first: 
  $ (beta - y_1(b)) / (y_2(b)) = (pi/4 - u_1(pi/4)) / (v_1(pi/4)) = (pi/4 - 0.707109) / 0.707104 = 0.110717799 $
  This gives us
  $ y(x) approx u_1(x) + 0.110717799v_1(x) $

  To compare this numerically attained solution to the actual, evaluate the function given as the actual solution at each of the points approximated.

  #figure(
    table(
      columns: (1fr, 1.5fr, 1.5fr),
      align: center,
      inset: 6pt,
      table.header(
        [*$x_i$*],
        [*Approximation $y(x_i)$*],
        [*Actual $y(x_i)$*]
      ),
      [0], [1.000000], [1.000000], 
      [$pi/20$], [1.005008], [1.052486], 
      [$pi/10$], [0.985270], [1.079056], 
      [$(3pi)/20$], [0.941272], [1.079056], 
      [$pi/5$], [0.874096], [1.052486], 
      [$pi/4$], [0.785398], [1.000000]
    ),
    caption: [_Approximate solution using the linear shooting method with RK4 method._],
  )
  
  ]

== Compendium Problem 2 
// WIP
#qa(auth: "CELESTINO, Leo")[Consider the two-point BVP
$ u′′ = u^3 + t, quad a < t < b $
with boundary conditions
$u(a) = α, u(b) = β$.

To use the shooting method to solve this problem, one needs a starting guess for the initial slope $u′(a)$. One way to obtain such a starting guess for the initial slope is, in effect, to do a “preliminary
shooting” in which we take a single step of Euler’s
method with $h = b − a$.

(a) Using this approach, write out the resulting
algebraic equation for the initial slope.

(b) What starting value for the initial slope results
from this approach?][
  The formula for Euler's method is: 
  $ y_(i+1) = y_i + h f(x_i, y_i) $
  Setting this up for the problem above: 
  $ u_(i+1) = u_i + h f(x_i, y_1) $
  $ u(h) = u(a) + (b - a) alpha $
  since the function we're using here to approximate is $u$ itself. 
  $ u(h) = alpha + (b - a) alpha $
  which answers question (a). 
  
  Take one step of Euler's method to approximate the starting slope $u'(a)$ by using the two-point slope formula. 
  $ u'(a) approx (u_2 - u_1) / (t_2 - t_1) = (u(a) + (b - a) alpha) / ((a + (b - a)) - a) $
  $ u'(a) approx alpha / (b - a) + alpha $
]

== Remixed Problem
// WIP 