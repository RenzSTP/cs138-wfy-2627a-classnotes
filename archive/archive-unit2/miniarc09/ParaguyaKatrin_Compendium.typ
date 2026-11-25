// STYLING PREAMBLE
#import "../assets.typ": qa, note, solution-box, question-box

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")


= Heath, Scientific Computing: an introductory survey, 2nd ed., Example 10.8, p.433
#qa(auth:"PARAGUYA, Katrin Lara")[
*Problem.* Solve the BVP
$ u''(t) = 6 t, quad 0 < t < 1, quad u(0) = 0, quad u(1) = 1 $
using 3 uniform collocation points, interpolated via the monomial basis functions. 
\
][
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

= Remixed Problem
#question-box()[
*Problem.* Suppose that we are modeling an object moving along a straight path over the course of an hour. Its acceleration increases linearly with time and can be represented by the equation:
$ a(t)=6t, quad 0<t<1 $
where time (t) is measured in hours and acceleration is measured in $m/h^2$.

The object's initial position is 0 meters and its position after 1 hour is 2 meters. Approximate its position function u(t) throughout the 1 hour interval using the collocation method with three uniformly spaced collocation points and monomial basis functions.
]



