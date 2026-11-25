#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [Practice Problem],
  subtitle: [Asymmetric Five-Point Stencil · Ognita Daniel Dean],
)

= Problem

#block(
  width: 100%,
  inset: 12pt,
  fill: rgb("#ececec"),
  stroke: (left: 2.5pt + black),
  radius: (right: 2pt),
)[
  *Practice problem* (Exercise 24–25, Ch 4.1, p. 183).

  (a) Derive an $cal(O)(h^4)$ five-point formula to approximate $f'(x_0)$ that uses
  $ f(x_0 - h), quad f(x_0), quad f(x_0 + h), quad f(x_0 + 2h), quad f(x_0 + 3h). $

  (b) Use the formula with $h = 0.2$ and the data below to approximate $f'(0.4)$ and $f'(0.8)$.

  #align(center)[
    #table(
      columns: 6,
      align: center,
      inset: 4pt,
      stroke: 0.4pt + rgb("#8c8c8c"),
      table.header([$x$], [$0.2$], [$0.4$], [$0.6$], [$0.8$], [$1.0$]),
      [$f(x)$], [$0.9798652$], [$0.9177710$], [$0.8080348$], [$0.6386093$], [$0.3843735$],
    )
  ]
]

= Solution

== Solving for weights

Put points (by step size h) $S = {-1, 0, 1, 2, 3}$ and plug into the formula

$ f'(x_0) approx 1/h sum_(s in S) a_s f(x_0 + s h). $

Evaluate each point i Taylor series on $x_0$ to get the coffecients of $h$ to construct:

$ 1/h sum_(s in S) a_s f(x_0 + s h) = sum_(k=0)^oo (sum_(s in S) a_s s^k)/(k!) h^(k-1) f^((k))(x_0). $

Then matching the terms $f, f', dots, f^((4))$

$ sum_(s in S) a_s s^k = cases(1 & "if" k = 1, 0 & "otherwise") quad "for" k = 0, 1, 2, 3, 4. $

To get the following matrix:

$ mat(1,1,1,1,1; -1,0,1,2,3; 1,0,1,4,9; -1,0,1,8,27; 1,0,1,16,81) vec(a_(-1), a_0, a_1, a_2, a_3) = vec(0,1,0,0,0). $

With the following solution:

$ a_(-1) = -1/4, quad a_0 = -5/6, quad a_1 = 3/2, quad a_2 = -1/2, quad a_3 = 1/12, $

Move out fractional denominator using  $1/12$,

$ f'(x_0) = 1/(12h) [(-3 f(x_0-h)) - 10 f(x_0) + 18 f(x_0+h) - 6 f(x_0+2h) + f(x_0+3h)] - \ h^4/20 f^((5))(xi). $


== Application

For $x_0 = 0.4$ and $h = 0.2$ we get these 5 points:

$ f'(0.4) = 1/2.4 [-3 f(0.2) - 10 f(0.4) + 18 f(0.6) - 6 f(0.8) + f(1.0)] $

$ = 1/2.4 [-2.9395956 - 9.1777100 + 14.5446264 - 3.8316558 + 0.3843735] = (-1.0199615)/2.4 \
= -0.4249840. $

For $x_0 = 0.8$ use $h=-0.2$ to reuse same equation with the same points
$ f'(0.8) = 1/(12(-0.2)) [-3 f(1.0) - 10 f(0.8) + 18 f(0.6) - 6 f(0.4) + f(0.2)] $

$ = 1/(-2.4) [-1.1531205 - 6.3860930 + 14.5446264 - 5.5066260 + 0.9798652] = (2.4786521)/(-2.4) \
= -1.032772. $

#align(center)[
  #table(
    columns: 3,
    align: center,
    inset: 4pt,
    stroke: 0.4pt + rgb("#8c8c8c"),
    table.header([$x_0$], [$h$], [$f'(x_0)$]),
    [$0.4$], [$0.2$], [$-0.4249840$],
    [$0.8$], [$-0.2$],[$-1.032772$],
  )
]


= Remix

#block(
  width: 100%,
  inset: 12pt,
  fill: rgb("#ececec"),
  stroke: (left: 2.5pt + black),
  radius: (right: 2pt),
)[
  *Remixed problem.*

  (a) Derive an $cal(O)(h^4)$ five-point formula to approximate $f'(x_0)$ that uses
  $ f(x_0 - 2h), quad f(x_0 - h), quad f(x_0), quad f(x_0 + h), quad f(x_0 + 2h). $

  (b) Use the formula with $h = 0.2$ and the data table from the original problem
  to approximate $f'(0.6)$.
]

= Solution

== Solving for weights

Put points (by step size $h$) $S = {-2, -1, 0, 1, 2}$ and plug into the formula

$ f'(x_0) approx 1/h sum_(s in S) a_s f(x_0 + s h). $

Evaluate each point's Taylor series on $x_0$ to get the coefficients of $h$:

$ 1/h sum_(s in S) a_s f(x_0 + s h)
  = sum_(k=0)^oo (sum_(s in S) a_s s^k)/(k!) h^(k-1) f^((k))(x_0). $

Matching the terms $f, f', dots, f^((4))$ gives

$ sum_(s in S) a_s s^k = cases(1 & "if" k = 1, 0 & "otherwise")
  quad "for" k = 0, 1, 2, 3, 4. $

This gives the matrix system

$ mat(
    1,  1, 1, 1,  1;
   -2, -1, 0, 1,  2;
    4,  1, 0, 1,  4;
   -8, -1, 0, 1,  8;
   16,  1, 0, 1, 16
 ) vec(a_(-2), a_(-1), a_0, a_1, a_2)
 = vec(0, 1, 0, 0, 0). $

The solution is

$ a_(-2) = 1/12, quad a_(-1) = -2/3, quad a_0 = 0,
  quad a_1 = 2/3, quad a_2 = -1/12. $

Move out the common denominator $1/12$:

$ f'(x_0) = 1/(12h) [
  f(x_0 - 2h) - 8 f(x_0 - h) + 8 f(x_0 + h) - f(x_0 + 2h)
] - h^4/30 f^((5))(xi). $

== Application

For $x_0 = 0.6$ and $h = 0.2$ we get these five points:

$ f'(0.6) = 1/(12(0.2)) [
  f(0.2) - 8 f(0.4) + 8 f(0.8) - f(1.0)
] $

$ = 1/2.4 [
  0.9798652 - 8(0.9177710) + 8(0.6386093) - 0.3843735
] $

$ = (-1.6378019)/2.4 = -0.6824175. $

= References
  + Burden, Faires, and Burden, Numerical Analysis, 10th ed., Ch 4.1, Exercise 24–25, p. 183.
  + Numerical Analysis Instructor's Solutions Manual for the 9th edition, Exercise Set 4.1, Exercise 22–23, pp. 76–77.
