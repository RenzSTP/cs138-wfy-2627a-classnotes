#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

= Reference Problems

== Compendium Problem 1

#qa(auth: "TIBAY, JOHN MICHAEL")[
  *Source:* Burden and Faires, _Numerical Analysis_,
  Section 11.2, Exercise Set 11.3, Item 3.a.

Use the Nonlinear Shooting method with $T O L = 10^(-4)$ to approximate the solution to the following boundary-value problems. The actual solution is given for comparison to your results.

$y'' = -e^(-2y), quad 1 <= x <= 2, y(1) = 0, y(2) = ln 2$; use $N = 10$; actual solution $y(x) = ln x$.
][Solution:

*Setting up the matrix* \
For $f(x, u_1, u_2) = -e^(-2u_1)$, the partial derivatives evaluate to $f_y = 2e^(-2u_1)$ and $f_y' = 0$. The Matrix IVP is set up as:
$ bold(w)' = d/(d x) mat(u_1; u_2; v_1; v_2) = mat(u_2; f(x, u_1, u_2); v_2; f_y(x, u_1, u_2)v_1 + f_y'(x, u_1, u_2)v_2) = mat(u_2; -e^(-2u_1); v_2; 2e^(-2u_1)v_1) = bold(g)(x, bold(w)) $
with $bold(w)(a) = mat(alpha, t_k, 0, 1)^top$ evaluating at the initial point $x = 1$ to:
$ bold(w)(1) = mat(0, t_k, 0, 1)^top $

*RK4 Iteration Scheme* \
$ bold(k)_1 &= bold(g)(x_i, bold(w)_i) \
  bold(k)_2 &= bold(g)(x_i + h/2, bold(w)_i + h/2 bold(k)_1) \
  bold(k)_3 &= bold(g)(x_i + h/2, bold(w)_i + h/2 bold(k)_2) \
  bold(k)_4 &= bold(g)(x_i + h, bold(w)_i + h bold(k)_3) \
  bold(w)_(i+1) &= bold(w)_i + h/6 (bold(k)_1 + 2bold(k)_2 + 2bold(k)_3 + bold(k)_4) $

*Newton Iteration Scheme* \
The starting guess $t_0$ is defined using the boundary conditions $alpha = 0$, $beta = ln 2$, $a = 1$, and $L = 2$:
$ t_0 = m = (Delta y) / (Delta x) = (beta - alpha) / (L - a) = (ln 2 - 0) / (2 - 1) approx 0.693147 $
The Newton iteration scheme refines $t_k$ according to the equivalence:
$ y'' = f(x, y(x, t_k), y'(x, t_k)) arrow.l.r t_(k+1) = t_k - (y(L, t_k) - beta) / ((partial) / (partial t) [y(L, t)](t_k)) $
Because $u_1(x, t_k) = y(x, t_k)$ and $v_1(x, t_k) = (partial) / (partial t) [y(x, t)](t_k)$, this evaluates to:
$ t_(k+1) = t_k - (u_1(2, t_k) - ln 2) / (v_1(2, t_k)) $

*Iterations* \
- $k = 0$: $t_0 = 0.693147$. Integrating yields $u_1(2, t_0) = 0.335345$ and $v_1(2, t_0) = 1.166667$.
  $t_1 = 0.693147 - (0.335345 - 0.693147) / 1.166667 = 0.999834$.
- $k = 1$: $t_1 = 0.999834$. Integrating yields $u_1(2, t_1) = 0.693005$ and $v_1(2, t_1) = 1.166667$.
  $t_2 = 0.999834 - (0.693005 - 0.693147) / 1.166667 = 1.000000$.
- $k = 2$: $t_2 = 1.000000$. Integrating yields $u_1(2, t_2) = 0.693147$ and $v_1(2, t_2) = 1.166667$.
  $t_3 = 1.000000 - (0.693147 - 0.693147) / 1.166667 = 1.000000$.


*Approximating the soln.* \
#align(center)[
  #table(
    columns: 4,
    align: center,
    [$i$], [$x_i$], [$u_1(x_i)$ Approximation], [Actual solution $y(x_i)$],
    [0], [1.0], [0.000000], [0.000000],
    [1], [1.1], [0.095310], [0.095310],
    [2], [1.2], [0.182322], [0.182322],
    [3], [1.3], [0.262364], [0.262364],
    [4], [1.4], [0.336472], [0.336472],
    [5], [1.5], [0.405465], [0.405465],
    [6], [1.6], [0.470004], [0.470004],
    [7], [1.7], [0.530628], [0.530628],
    [8], [1.8], [0.587787], [0.587787],
    [9], [1.9], [0.641854], [0.641854],
    [10], [2.0], [0.693147], [0.693147]
  )
]
]

#pagebreak()

== Compendium Problem 2:

#qa(auth: "TIBAY, JOHN MICHAEL")[
  *Source:* Burden and Faires, _Numerical Analysis_,
  Section 11.2, Exercise Set 11.3, Item 3.b.

Use the Nonlinear Shooting method with $T O L = 10^(-4)$ to approximate the solution to the following boundary-value problems. The actual solution is given for comparison to your results.

$y'' = y' cos x - y ln y, quad 0 <= x <= pi/2, y(0) = 1, y(pi/2) = e$; use $N = 10$; actual solution $y(x) = e^(sin x)$
][Solution:

*Setting up the matrix* \
For $f(x, u_1, u_2) = u_2 cos x - u_1 ln u_1$, the partial derivatives are $f_y = -ln u_1 - 1$ and $f_y' = cos x$. The Matrix IVP is established as:
$ bold(w)' = d/(d x) mat(u_1; u_2; v_1; v_2) = mat(u_2; u_2 cos x - u_1 ln u_1; v_2; (-ln u_1 - 1)v_1 + (cos x)v_2) = bold(g)(x, bold(w)) $
with $bold(w)(a) = mat(alpha, t_k, 0, 1)^top$ evaluating at the initial point $x = 0$ to:
$ bold(w)(0) = mat(1, t_k, 0, 1)^top $

*RK4 Iteration Scheme* \
$ bold(k)_1 &= bold(g)(x_i, bold(w)_i) \
  bold(k)_2 &= bold(g)(x_i + h/2, bold(w)_i + h/2 bold(k)_1) \
  bold(k)_3 &= bold(g)(x_i + h/2, bold(w)_i + h/2 bold(k)_2) \
  bold(k)_4 &= bold(g)(x_i + h, bold(w)_i + h bold(k)_3) \
  bold(w)_(i+1) &= bold(w)_i + h/6 (bold(k)_1 + 2bold(k)_2 + 2bold(k)_3 + bold(k)_4) $

*Newton Iteration Scheme* \
The starting guess $t_0$ is defined using the boundary conditions $alpha = 1$, $beta = e$, $a = 0$, and $L = pi/2$:
$ t_0 = m = (Delta y) / (Delta x) = (beta - alpha) / (L - a) = (e - 1) / (pi/2 - 0) approx 1.093889 $
The Newton iteration scheme refines $t_k$ according to the equivalence:
$ y'' = f(x, y(x, t_k), y'(x, t_k)) arrow.l.r t_(k+1) = t_k - (y(L, t_k) - beta) / ((partial) / (partial t) [y(L, t)](t_k)) $
Because $u_1(x, t_k) = y(x, t_k)$ and $v_1(x, t_k) = (partial) / (partial t) [y(x, t)](t_k)$, this evaluates to:
$ t_(k+1) = t_k - (u_1(pi/2, t_k) - e) / (v_1(pi/2, t_k)) $

*Iterations* \
- $k = 0$: $t_0 = 1.093889$. Integrating yields $u_1(pi/2, t_0) = 2.973501$ and $v_1(pi/2, t_0) = 2.718282$.
  $t_1 = 1.093889 - (2.973501 - 2.718282) / 2.718282 = 1.000000$.
- $k = 1$: $t_1 = 1.000000$. Integrating yields $u_1(pi/2, t_1) = 2.718282$ and $v_1(pi/2, t_1) = 2.718282$.
  $t_2 = 1.000000 - (2.718282 - 2.718282) / 2.718282 = 1.000000$.

*Approximating the soln.* \

#align(center)[
  #table(
    columns: 4,
    align: center,
    [$i$], [$x_i$], [$u_1(x_i)$ Approximation], [Actual solution $y(x_i)$],
    [0], [0.000000], [1.000000], [1.000000],
    [1], [0.157080], [1.169333], [1.169333],
    [2], [0.314159], [1.362086], [1.362086],
    [3], [0.471239], [1.574581], [1.574581],
    [4], [0.628319], [1.800000], [1.800000],
    [5], [0.785398], [2.028115], [2.028115],
    [6], [0.942478], [2.245699], [2.245699],
    [7], [1.099557], [2.437578], [2.437578],
    [8], [1.256637], [2.588439], [2.588439],
    [9], [1.413717], [2.685025], [2.685025],
    [10], [1.570796], [2.718282], [2.718282]
  )
]
]

#pagebreak()

= Remix Problem

#qa(auth: "TIBAY, JOHN MICHAEL")[

][Solution:

]
