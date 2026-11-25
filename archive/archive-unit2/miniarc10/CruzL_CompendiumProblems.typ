#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1
#qa(auth:"CRUZ, LOZANO")[
  *Source: Burden and Faires. Numerical Analysis*
  
  Use the Nonlinear Finite-Difference Algorithm with $"TOL" = 10^(-4)$ to approximate the solution to the following BVP:
$
y'' = -e^(-2y), \ 1<=x<=2, y(1)=0, y(2) = ln(2)
$
Use $N = 9$ interior points.
][*Solution* 
\
Let $F = y'' + e^(-2 y)$. We want this to be 0 for all $i = 1, 9$.

Applying finite difference approximation,
$
F_i = (y_(i-1)-2y_i+y_(i+1))/h^2+e^(-2 y_i)
$
or more preferably (avoids ill-conditioning due to a small divisor):
$
F_i = y_(i-1) - 2y_i + y_(i+1) = h^2 e^(2 y_i)
$

Upon obtaining the Jacobian, we have the following nonzero terms:
$
(partial F_i)/(partial y_(i-1)) = (partial F_i)/(partial y_(i+1)) = 1
 \
(partial F_i)/(partial y_i) = - 2 - h^2e^(-2 y_i)
$

$ bold(J) = mat(
  -2 - 2 h^2 e^(-2 y_1), 1, 0, dots, 0;
  1, -2 - 2 h^2 e^(-2 y_2), 1, dots, 0;
  0, 1, -2 - 2 h^2 e^(-2 y_3), dots, 0;
  dots.v, dots.v, dots.down, dots.down, 1;
  0, 0, dots, 1, -2 - 2 h^2 e^(-2 y_N)
) $
\ \ \ \ \ \ \ \ \ \ \  \ \ \
with the initial middle $y_i$ values set to 0, we reach the following approximate points after 2 iterations:
#align(center)[#table(columns: 5, [$i$],    [$x_i$],      [$y_i$],   [Exact $ln(x)$],        [Absolute Error],
[$0 $],   [$1.0$],      [$0.00000000$],         [$0.00000000$],         [$0.000000$],
[$1 $],   [$1.1$],      [$0.09521908$],         [$0.09531018$],         [$9.109824 dot 10^(-5)$],
[$2 $],   [$1.2$],      [$0.18217284$],         [$0.18232156$],         [$1.487146 dot 10^(-4)$],
[$3 $],   [$1.3$],      [$0.26218227$],         [$0.26236426$],         [$1.819922 dot 10^(-4)$],
[$4 $],   [$1.4$],      [$0.33627644$],         [$0.33647224$],         [$1.957983 dot 10^(-4)$],
[$5 $],   [$1.5$],      [$0.40527230$],         [$0.40546511$],         [$1.928122 dot 10^(-4)$],
[$6 $],   [$1.6$],      [$0.46982873$],         [$0.47000363$],         [$1.749008 dot 10^(-4)$],
[$7 $],   [$1.7$],      [$0.53048424$],         [$0.53062825$],         [$1.440082 dot 10^(-4)$],
[$8 $],   [$1.8$],      [$0.58768406$],         [$0.58778666$],         [$1.026039 dot 10^(-4)$],
[$9 $],   [$1.9$],      [$0.64180024$],         [$0.64185389$],         [$5.364742 dot 10^(-5)$],
[$10$],   [$2.0$],      [$0.69314718$],         [$0.69314718$],         [$0.000000$])
]
]

== Compendium Problem 2 
#qa(auth:"CRUZ, LOZANO")[
  *Source: Burden and Faires. Numerical Analysis* _(rephrased)_ 

  The respective section for this book indicates the following assumptions about the function defined in the BVP equation $y'' = f(x, y, y')$: 

  - $f$ and the partial derivatives $f_y$ and $f_(y')$ are all continuous on
  $ D = \{ (x, y, y') mid(|) a <= x <= b "with" -infinity < y < infinity "and" -infinity < y' < infinity \} $

- $f_y (x, y, y') >= delta$ on $D$, for some $delta > 0$

- Constants $k$ and $L$ exist, with
  $ k = max_((x, y, y') in D) |f_y (x, y, y')|  \ L = max_((x, y, y') in D) |f_(y') (x, y, y')|. $

Show that the assumptions listed at the beginning of the section ensure the nonsingularity of the Jacobian matrix $bold(J)$ for $h < 2/L$.

][*Solution*

We use the fact that a strictly diagonally dominant matrix is nonsingular. Recall the elements in the Jacobian matrix:
- Main diagonal elements:
  $ bold(J)_(i, i) = 2 h^2 f_y lr((x_i, y_i, frac(y_(i+1) - y_(i-1), 2h))) $

- Off-diagonal elements:
  $ bold(J)_(i, i+1) = -1 + frac(h, 2) f_(y') lr((x_i, y_i, frac(y_(i+1) - y_(i-1), 2h))) $

  $ bold(J)_(i, i-1) = -1 - frac(h, 2) f_(y') lr((x_i, y_i, frac(y_(i+1) - y_(i-1), 2h))) $

From definition of $L$, it follows that $(h f_(y'))/2<=(h L)/2 < 1$ if $h < 2/L$. This also means that the off-diagonal entries have the same sign, so 
$
|bold(J)_(i, i+1)|+|bold(J)_(i, i-1)|=2
$
From the assumption that $f_y >= delta > 0$, we have 
$
bold(J)_(i, i) = 2 + h^2 f_y >= 2 + h^2 delta > 2
\ 
-> bold(J)_(i, i) > 2 = |bold(J)_(i, i+1)|+|bold(J)_(i, i-1)|
$
Which means $bold(J)$ is strictly diagonally dominant for all matrices and is therefore nonsingular.
]
