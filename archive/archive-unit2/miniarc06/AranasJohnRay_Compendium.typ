#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
= Boundary Value Problems

== Compendium Problem 1
#qa(auth: "ARANAS, JOHN RAY B.")[*Source: Exercise 13.2.16 William Trench. Elementary Differential Equations with BVPs * 
$ y'' + lambda y = 0, quad y(0) + y'(0) = 0, quad y(2) + 2 y'(2) = 0 $

+ Determine whether $lambda = 0$ is an eigenvalue. If it is, find an associated eigenfunction.
+ Compute the negative eigenvalues with errors not greater than $5 times 10^(-8)$. State the form of the associated eigenfunctions.


][

$ y'' + lambda y = 0, quad y(0) + y'(0) = 0, quad y(2) + 2 y'(2) = 0 $



== (a) Is $lambda = 0$ an eigenvalue?

Here $y = c_1 + c_2 x$. The conditions give

$ c_1 + c_2 = 0, quad c_1 + 2 c_2 + 2 c_2 = c_1 + 4 c_2 = 0. $

Subtracting gives $3 c_2 = 0$, so $c_1 = c_2 = 0$. Only the trivial solution exists, so *$lambda = 0$ is not an eigenvalue*.

== (b) Negative eigenvalues

Let $lambda = -mu^2$ with $mu > 0$, so

$ y = c_1 e^(mu x) + c_2 e^(-mu x), quad y' = mu (c_1 e^(mu x) - c_2 e^(-mu x)). $

*Left condition.* $y(0) + y'(0) = (1 + mu) c_1 + (1 - mu) c_2 = 0$. Taking $c_1 = mu - 1$ and $c_2 = mu + 1$ gives

$ y = (mu - 1) e^(mu x) + (mu + 1) e^(-mu x). $

*Right condition.* Here $y(2) = (mu-1) e^(2mu) + (mu+1) e^(-2mu)$ and $y'(2) = mu [(mu-1) e^(2mu) - (mu+1) e^(-2mu)]$. So $y(2) + 2 y'(2) = 0$ becomes

$ (2mu + 1)(mu - 1) e^(2mu) - (2mu - 1)(mu + 1) e^(-2mu) = 0. $


$ H(mu) := (2mu + 1)(mu - 1) e^(4mu) - (2mu - 1)(mu + 1) = 0. $

Since $H(1) = -2 != 0$, we may divide and write this as $e^(4mu) = R(mu)$, where

$ R(mu) = ((2mu - 1)(mu + 1)) / ((2mu + 1)(mu - 1)) = (2 mu^2 + mu - 1) / (2 mu^2 - mu - 1). $



$ R'(mu) = -(4 mu^2 + 2) / (2 mu^2 - mu - 1)^2 < 0, $

so $R$ is decreasing on each interval where it is defined.

*Exactly one root.*
- For $0 < mu < 1/2$: $R$ decreases from $R(0) = 1$ to $R(1/2) = 0$, so $0 < R(mu) < 1 < e^(4mu)$ and there is no root.
- For $1/2 <= mu < 1$: the numerator is $>= 0$ and the denominator is $< 0$, so $R(mu) <= 0 < e^(4mu)$ and there is no root.
- For $mu > 1$: $R$ is positive and decreases from $+infinity$ (as $mu -> 1^+$) toward $1$, while $e^(4mu)$ is increasing and larger than $e^4$. So $e^(4mu) - R(mu)$ is strictly increasing from $-infinity$ to $+infinity$, giving exactly one root.

*Locating it.*

$ H(1.0) = -2 < 0 $ and $ H(1.1) approx 23.5 > 0 $  root lies in $(1.0, 1.1) $

*Computing it (secant method).* We solve $H(mu) = 0$ with

$ H(mu) = (2mu + 1)(mu - 1) e^(4mu) - (2mu - 1)(mu + 1). $



$ mu_(n+1) = mu_n - H(mu_n) (mu_n - mu_(n-1)) / (H(mu_n) - H(mu_(n-1))). $

Two starting values: $H(1.0) = -2$ and $H(1.01) = 0.0302 e^(4.04) - 2.0502 approx -0.33404$.

_Step 1._

$ mu_2 = 1.01 - ((-0.33404)(0.01)) / (-0.33404 + 2) = 1.01 + 0.0020051 = 1.0120051. $

The table becomes...

#align(center)[
  #table(
    columns: 4,
    align: center,
    inset: 5pt,
    [$n$], [$mu_n$], [$H(mu_n)$], [$-mu_n^2$],
    [0], [1.0000000000], [$-2$], [$-1.0000000$],
    [1], [1.0100000000], [$-0.3340444$], [$-1.0201000$],
    [2], [1.0120051222], [$+0.01930049$], [$-1.0241544$],
    [3], [1.0118955980], [$-1.710 times 10^(-4)$], [$-1.0239327$],
    [4], [1.0118965598], [$-8.64 times 10^(-8)$], [$-1.0239346478$],
    [5], [1.0118965603], [$+3.9 times 10^(-13)$], [$-1.0239346488$],
  )
]

*Stopping rule.* From step 4 to step 5, $lambda = -mu^2$ changes by only $1.0 times 10^(-9)$, far below the required $5 times 10^(-8)$. The sign change between $mu_4$ and $mu_5$ also shows the root lies between them, so $mu approx 1.0118965603$ and

$ lambda approx -1.0239346. $

*Check.* With $y = (mu - 1) e^(mu x) + (mu + 1) e^(-mu x)$, we get $y(0) approx 2.0238$, $y(0) + y'(0) = 0$ exactly, and $y(2) + 2 y'(2) approx 5 times 10^(-14)$.

#align(center, box(stroke: 0.6pt, inset: 8pt)[
  $ lambda approx -1.0239346, quad y = (mu - 1) e^(mu x) + (mu + 1) e^(-mu x), quad mu = sqrt(-lambda) $
])

This is the only negative eigenvalue.
]

== Compendium Problem 2 
#qa(auth: "ARANAS, JOHN RAY B.")[*Source: Exercise 13.2.27 William Trench. Elementary Differential Equations with BVPs *
$ y'' + lambda y = 0, quad y(0) + alpha y'(0) = 0, quad y(1) + (alpha - 1) y'(1) = 0, $

where $0 < alpha < 1$.

+ Show that $lambda = 0$ is an eigenvalue and find an associated eigenfunction.
+ Give a graphical argument to show that the problem has infinitely many positive eigenvalues $lambda_1 < lambda_2 < dots.c < lambda_n < dots.c$, and state the form of the associated eigenfunctions.

][

== (a) Show that $lambda = 0$ is an eigenvalue

When $lambda = 0$, the differential equation becomes

$ y'' = 0. $



$ y = c_1 + c_2 x. $

Applying the first boundary condition:

$ y(0) + alpha y'(0) = 0 $

$ c_1 + alpha c_2 = 0. $

Applying the second boundary condition:

$ y(1) + (alpha - 1) y'(1) = 0 $

$ c_1 + c_2 + (alpha - 1)c_2 = 0 $

$ c_1 + alpha c_2 = 0. $

Both boundary conditions give the same equation:

$ c_1 = -alpha c_2. $

Choosing $c_2 = 1$, we obtain

$ y(x) = x - alpha. $

Since this is a nontrivial solution satisfying both boundary conditions,

#align(center, box(stroke: 0.6pt, inset: 8pt)[
  $ lambda = 0 quad "is an eigenvalue, with" quad y(x) = x - alpha. $
])

== (b) Show that there are infinitely many positive eigenvalues

Let $lambda = mu^2$, where $mu > 0$.


$ y'' + mu^2 y = 0. $


$ y = c_1 cos(mu x) + c_2 sin(mu x). $


$ y' = -mu c_1 sin(mu x) + mu c_2 cos(mu x). $

*Applying the first boundary condition:*

$ y(0) + alpha y'(0) = 0 $

$ c_1 + alpha mu c_2 = 0. $



$ c_1 = -alpha mu c_2. $

Taking $c_2 = 1$, we obtain

$ y(x) = sin(mu x) - alpha mu cos(mu x). $

*Applying the second boundary condition:*

$ y(1) + (alpha - 1)y'(1) = 0. $



$ sin mu - alpha mu cos mu + (alpha - 1)(-alpha mu sin mu + mu cos mu) = 0. $



$ [1 - alpha(1 - alpha)mu^2] sin mu - mu cos mu = 0. $


#align(center)[
  $ [1 - alpha(1 - alpha)mu^2] sin mu = mu cos mu. $
]



$ tan mu = mu / (1 - alpha(1 - alpha)mu^2). $


*For the graph...*

Let

$ f(mu) = tan mu $



$ g(mu) = mu / (1 - alpha(1 - alpha)mu^2). $

We want to show that these two functions intersect infinitely many times.

Since $0 < alpha < 1$,

$ alpha(1 - alpha) > 0. $

For sufficiently large $mu$, the denominator of $g(mu)$ is negative. Therefore, $g(mu)$ is negative.

Consider the intervals

$ (pi/2 + n pi, (n + 1)pi), quad n = 0, 1, 2, dots $

For sufficiently large $n$:

- The graph of $f(mu) = tan mu$ increases from $-infinity$ to $0$.
- The graph of $g(mu)$ is continuous, negative, and finite throughout each interval.

At the left endpoint, $f(mu) -> -infinity$, while $g(mu)$ remains finite.

At the right endpoint, $f(mu) -> 0$, while $g(mu)$ remains negative.

Consequently, the two graphs must intersect at least once in every such interval.

Since there are infinitely many such intervals, there are infinitely many positive values of $mu$ satisfying the characteristic equation.

Because $lambda = mu^2$, there are infinitely many positive eigenvalues that can be ordered as

#align(center)[
  $ 0 < lambda_1 < lambda_2 < dots < lambda_n < dots $
]



Recall that

$ y(x) = sin(mu x) - alpha mu cos(mu x). $

For each positive eigenvalue $lambda_n = mu_n^2$, the associated eigenfunction is

#align(center, box(stroke: 0.6pt, inset: 8pt)[
  $ y_n(x) = sin(mu_n x) - alpha mu_n cos(mu_n x) $
])

where $mu_n = sqrt(lambda_n)$ satisfies

$ [1 - alpha(1 - alpha)mu_n^2] sin mu_n - mu_n cos mu_n = 0. $

  
]

== Remixed Problem
#qa(auth: "ARANAS, JOHN RAY B.")[
$ y'' + lambda y = 0, quad y(0) + y'(0) = 0, quad y(2) + delta y'(2) = 0, $

where $delta$ is a real constant.

+ Find the value of $delta$ for which $lambda = 0$ is an eigenvalue, and find an associated eigenfunction.
+ For that value of $delta$, compute the negative eigenvalues with errors not greater than $5 times 10^(-8)$. State the form of the associated eigenfunctions.


  
][

  == (a) Find the value of $delta$ for which $lambda = 0$ is an eigenvalue

When $lambda = 0$, the differential equation becomes

$ y'' = 0. $


$ y = c_1 + c_2 x. $

Applying the first boundary condition:

$ y(0) + y'(0) = 0 $

$ c_1 + c_2 = 0. $


$ c_1 = -c_2. $

Applying the second boundary condition:

$ y(2) + delta y'(2) = 0 $

$ c_1 + 2c_2 + delta c_2 = 0. $



$ -c_2 + 2c_2 + delta c_2 = 0 $

$ (1 + delta)c_2 = 0. $

For a nontrivial solution, $c_2 != 0$. Thus,

$ 1 + delta = 0 $

$ delta = -1. $

Taking $c_2 = 1$, we obtain $c_1 = -1$, 

#align(center, box(stroke: 0.6pt, inset: 8pt)[
  $ delta = -1, quad y(x) = x - 1 $
])

Therefore, $lambda = 0$ is an eigenvalue when $delta = -1$, with eigenfunction $y(x) = x - 1$.

== (b) Compute the negative eigenvalues when $delta = -1$

Let $lambda = -mu^2$, where $mu > 0$.


$ y'' - mu^2 y = 0. $

$ y = c_1 e^(mu x) + c_2 e^(-mu x). $



$ y' = mu(c_1 e^(mu x) - c_2 e^(-mu x)). $

*Applying the first boundary condition:*

$ y(0) + y'(0) = 0 $

$ (1 + mu)c_1 + (1 - mu)c_2 = 0. $

Taking $c_1 = mu - 1$ and $c_2 = mu + 1$, we obtain

$ y = (mu - 1)e^(mu x) + (mu + 1)e^(-mu x). $

*Applying the second boundary condition:*

Since $delta = -1$,

$ y(2) - y'(2) = 0. $


$ (mu - 1)(1 - mu)e^(2mu) + (mu + 1)(1 + mu)e^(-2mu) = 0. $



$ -(mu - 1)^2 e^(2mu) + (mu + 1)^2 e^(-2mu) = 0. $



$ (mu + 1)^2 - (mu - 1)^2 e^(4mu) = 0. $



$ G(mu) := (mu + 1)^2 - (mu - 1)^2 e^(4mu) = 0. $



$ e^(4mu) = ((mu + 1)^2) / ((mu - 1)^2). $


$ e^(2mu) = (mu + 1) / abs(mu - 1). $

For $0 < mu < 1$, this becomes

$ e^(2mu) = (mu + 1) / (1 - mu). $

However, $e^(2mu) > (mu + 1)/(1 - mu)$ for all $0 < mu < 1$, so there is no root in this interval.

For $mu > 1$, the equation becomes

$ e^(2mu) = (mu + 1) / (mu - 1). $

The left-hand side is strictly increasing, while the right-hand side is strictly decreasing. Therefore, there is exactly one positive root for $mu > 1$.

*Locating the root.*

Numerically,

$ G(1.1) approx 0.1991959 > 0 $


$ G(1.2) approx -0.0009261 < 0. $

Hence, the root lies in $(1.1, 1.2)$.

*Computing the root (secant method).*

We solve $G(mu) = 0$, where

$ G(mu) = (mu + 1)^2 - (mu - 1)^2 e^(4mu). $

Starting with $mu_0 = 1.1$ and $mu_1 = 1.2$, iterate

$ mu_(n+1) = mu_n - (G(mu_n)(mu_n - mu_(n-1))) / (G(mu_n) - G(mu_(n-1))). $

The results are:

#align(center)[
  #table(
    columns: 4,
    align: center,
    inset: 5pt,
    [$n$], [$mu_n$], [$G(mu_n)$], [$-mu_n^2$],
    [0], [1.1000000000], [0.1991958967], [-1.2100000000],
    [1], [1.2000000000], [-0.0009260807], [-1.4400000000],
    [2], [1.1995372419], [0.0004068041], [-1.4388895947],
    [3], [1.1996784783], [0.0000004661], [-1.4392284514],
    [4], [1.1996786403], [-2.35 times 10^(-10)], [-1.4392288401],
    [5], [1.1996786403], [approx 0], [-1.4392288399],
  )
]

The change in the eigenvalue between the last iterations is less than $5 times 10^(-8)$.

Thus,

$ mu approx 1.1996786403 $



$ lambda = -mu^2 approx -1.4392288399. $


$ y = (mu - 1)e^(mu x) + (mu + 1)e^(-mu x), $

the Eigenfunction is...

#align(center, box(stroke: 0.6pt, inset: 8pt)[
  $ lambda approx -1.4392288399 $
  $ y(x) = (mu - 1)e^(mu x) + (mu + 1)e^(-mu x) $
  $ mu approx 1.1996786403 $
])

This is the only negative eigenvalue when $delta = -1$.

  
]

\

*Link to Exercises:* \

[1] Trench, W. (2013). Elementary Differential Equations with Boundary Value Problems. _Faculty Authored and Edited Books & CDs_.
https://digitalcommons.trinity.edu/mono/9