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
  title: [Taylor Series],
  subtitle: [Arc 8 · Sarmiento, Luis Antonio]
)


// SECTION SUBHEADER1
== Idea
#h(2em) // fix indent for 1st paragraph
Suppose you are given a set of discrete data points and want to find their derivative. However, because you only have these points rather than an explicit function or a continuous graph, you can't differentiate analytically. 

Instead, you need a way to approximate the derivative directly from the given data.

#definition(name: "Taylor Series Recall")[
  A smooth function $f$ can be written as a power series centered at $x_0$: \ \
  $ f(x) =  f(x_0) + f'(x_0)(x - x_0) + (f''(x_0))/2! (x - x_0)^2 + dots.c $ \
]

#h(2em)
In our problem, $x_0$ is the data point that we want to find the derivative for, and the given data provides values a small distance $h$ away. So evaluating at $x = x_0 + h$, the Taylor series becomes
$ f(x_0 + h) = f(x_0) + h f'(x_0) + h^2/2! f''(x_0) + h^3/3! f'''(x_0) + dots.c $
For nodes on the other side, we can evaluate the series at $x=x_0-h$ instead, and so on.
\ 

// SECTION SUBHEADER2
== Truncation Error
#h(2em) // fix indent for 1st paragraph
However, we cannot sum infinitely many terms, so we have to decide how accurate the derivative should be by truncating the series to a certain point. For three neighboring nodes $x - h$, $x$, and $x + h$ we have
$ f(x + h) &= f(x) + h f'(x) + h^2/2 f''(xi_1) \
  f(x) &= f(x) \
  f(x - h) &= f(x) - h f'(x) + h^2/2 f''(xi_2) $
\
where $xi_1 in [x, x + h]$ and $xi_2 in [x - h, x]$ are unknown points.
What we want to solve for is the $f'(x)$ term, and the $h^2/2 f''(xi)$ term is known as our *truncation error*. We ignore the terms after our truncation error term, because they are smaller.

#pagebreak()

// SECTION HEADER
#show: notes.with(
  title: [First Order Difference Formulas],
  subtitle: [ Arc 8 · Matias, Gabriel Ian Carl], 
)
// SECTION SUBHEADER1
== Idea
#definition[The limit definition of the derivative of the function $f$ at $x$ is given by: \ \
  #align(center)[$ f'(x) = lim_(h->0) (f(x + h) - f(x)) / h  $] 
]

#h(2em)
We know this definition from Math 21.  This gets more accurate as $h->0$.  However, this is very problematic to a computer as it introduces a potential division by zero which makes it highly unstable.  

To approximate the first order derivative, we can simply drop the limit and set $h$ to a relatively small value such that:
  $  f'(x) approx (f(x + h) - f(x)) / h $
  
Note however, as mentioned in the earlier section, that there are potential rounding errors that can occur by doing this.  In particular we get the truncation error: 

$ cal(O)(h) = -h/2 f''(xi) $

By taking this error into account for our approximation, we obtain the formula for forward difference.
== Forward and Backward Difference

#definition[*Forward Difference Formula* \ \
  #align(center)[$ f'(x) approx (f(x + h) - f(x)) / h -h/2 f''(xi) $] 
]

We can also obtain the backward difference formula by negating $h$.  Note that in this case: $ cal(O)(h) = h/2 f''(xi) $

#definition[*Backward Difference Formula* \ \
  #align(center)[$ f'(x) approx (f(x) - f(x - h) )/ h + h/2 f''(xi) $] 
]

#pagebreak()

#show: notes.with(
  title: [Central Difference],
  subtitle: [ Arc 8 · Reyes, Samantha Mikaylah],
)

== Idea

Central difference is a method of numerical differentiation which is usually used to approximate the first derivative of a function. This is different from forward and backward differences because instead of evaluating the derivative using a limit of $h arrow 0$, we evaluate by approximating the derivative using function values at 2 distinct points that are spaced around $x$. 

The two points are
$x-h "and" x+h.$

Moreover, this method is called *central difference* due to the fact that the evaluation point, which is $x$, lies at the center of those two points.

#block(
  inset: 12pt,
  stroke: 1pt + black,
  radius: 2pt,
  width: 100%,
)[
  *Definition: Central Difference*

  The central difference approximation for the first derivative is

  $ f'(x) approx (f(x+h)-f(x-h))/(2h). $

  where the step size is $h > 0$. Central difference has a truncation error of $O(h^2)$ which makes it a second order accurate approximation.
]


== Derivation

We begin deriving the central difference formula by using the forward Taylor series expansion $f(x+h)$ and backward Taylor
series expansion $f(x-h)$.

The forward Taylor series expansion is
$ f(x+h) = f(x) + h f'(x) + h^2/2 f''(x) + h^3/6 f'''(x) + h^4/24 f^''''(x) + O(h^5). $

While the backward Taylor series expansion is $ f(x-h) = f(x) - h f'(x) + h^2/2 f''(x)
- h^3/6 f'''(x) + h^4/24 f^''''(x) + O(h^5). $

Firstly, we subtract the backward Taylor series expansion
$f(x-h)$ from the forward Taylor series expansion $f(x+h)$. The terms raised to even powers of $h$ will cancel out, while the terms raised to odd powers remain such as: $ f(x)-f(x)=0, $
$ h^2/2 f''(x)-h^2/2 f''(x)=0, $
$ h^4/24 f^((4))(x)-h^4/24 f^((4))(x)=0. $

After subtracting them, we get:

$ f(x+h)-f(x-h) = 2h f'(x) + h^3/3 f'''(x) + O(h^5). $

$O(h^5)$ is the higher-order remainder
that's bounded in the derivation. Next, we divide both sides of the equation by $2h$: $ (f(x+h)-f(x-h))/(2h) = f'(x)+h^2/6 f'''(x)+O(h^4). $

Lastly, we isolate $f'(x)$: $ f'(x) = (f(x+h)-f(x-h))/(2h) - h^2/6 f'''(x)+O(h^4). $

$-h^2/6 f'''(x)$ is the leading error term,
while $O(h^4)$ is now the remaining higher-order error. Considering that $h^2$ is the lowest power of $h$ among the
error terms, we can then conclude that the overall truncation error will be $O(h^2)$. We ignore the error terms to get the central difference formula: $ f'(x) approx (f(x+h)-f(x-h))/(2h). $


== Truncation Error and Accuracy

From the Taylor expansion, we end up with the leading error of $ -h^2/6 f'''(x)+O(h^4) $

which is from the exact derivative minus its approximation. Using the Taylor remainder theorem, the error can also
be expressed as $ "error" = -h^2/6 f'''(xi) $

for some value of $xi$ that's between $x-h$ and $x+h$. Therefore, central difference method has $O(h^2)$ as its truncation error of which is why it is known as a second-order accurate approximation.

== Effect of Step Size

Considering that the leading error is proportional to $h^2$, we let E = error where:

$ E(h) approx C h^2. $

So if the step size gets halved, we have:

$ E(h/2) approx C(h/2)^2 $
$ C(h/2)^2= (C h^2)/4. $

Thus,

$ E(h/2) approx E(h)/4. $

Overall, by halving the step size, the truncation error gets approximately reduced by a factor of 4 if the leading error term is what dominates.


== Example

Consider $f(x) = -0.1x^4 - 0.15x^3 - 0.5x^2 - 0.25x + 1.2. $ We want to approximate $f'(0.5)$ using the central difference method with step size of $h = 0.5$.

Using central difference formula
$ f'(x) approx (f(x+h)-f(x-h))/(2h). $
We substitute $x = 0.5$ and $h = 0.5$ into the formula:
$ f'(0.5) approx (f(1)-f(0))/1. $
where $f(1) = 0.2 "and" f(0) = 1.2.$ As a result:
$ f'(0.5) approx (0.2-1.2)/1 $
$ f'(0.5) approx -1. $

For comparison, we know that the exact derivative is
$f'(x) = -0.4x^3 - 0.45x^2 - x - 0.25. $ So when $x = 0.5$ and we plug it into the exact derivative, we get $ f'(0.5) = -0.9125. $
The absolute error is:
$ "error" = abs(-0.9125-(-1)) = 0.0875. $

All in all, the central difference method gives an approximation of $-1$. This is close to the value of exact derivative which is $-0.9125$.


== Algorithm

#algorithm(name: "Central Difference Method")[
  *Inputs:* Function $f(x)$, evaluation point $x$, and positive step size $h$.

  + Choose a function $f(x)$ and evaluation point $x$.
  + Choose a step size $h$ that's greater than 0.
  + Evaluate the function at the 2 points:
    - $f(x-h)$.
    - $f(x+h)$.
  + Compute for the central difference approximation:
    $ f'(x) approx (f(x+h)-f(x-h))/(2h). $
  + If greater accuracy is needed, repeat by using a smaller step size like $h/2$.
]

== When Does It Fail?

+ *Large step size.* This is because a large step size $h$ may produce high truncation errors.
+ *Extremely small step size.* This is because having a small step size $h$ can lead to subtracting nearly equal function values which can cause cancellation and high rounding errors.
+ *Boundary points.* This is because central difference requires function values on both sides of $x$. Thus, one of the function values may be unavailable if given boundary points or endpoints.
+ *Insufficient smoothness.* The Taylor-based accuracy analysis requires sufficient differentiability near $x$.

= Reference

1. Kiusalaas. _Numerical Methods in Engineering with Python_. Cambridge University Press, 2013.

// Ognita Part

#pagebreak()

#show: notes.with(
  title: [Stencils and Undetermined Coefficients],
  subtitle: [Arc 8 · Ognita Daniel Dean],
)

// Keep each definition/example/algorithm box whole: v1 split a box across a page
// break, leaving the box header stranded at the bottom of the previous page.
#set block(breakable: false)


= From Taylor series to other methods

Recall how we built a difference formula for $f'(x)$: expand about $x$ in both
directions and subtract, so the $f(x)$ terms cancel and the $f'$ terms add.
Assume $f in C^4[a, b]$ and that $x plus.minus h$, $x plus.minus 2h$ lie in $[a, b]$.

Using the forward Taylor series
$ f(x+h) = f(x) + h f'(x) + h^2/2 f''(x) + h^3/6 f'''(x) + h^4/24 f^((4))(xi_+) $

and the backward Taylor series

$ f(x-h) = f(x) - h f'(x) + h^2/2 f''(x) - h^3/6 f'''(x) + h^4/24 f^((4))(xi_-) $

with $x - h < xi_- < x < xi_+ < x + h$, we get the same construction for $f''(x)$:

$ f(x+h) + f(x-h) = 2 f(x) + h^2 f''(x) + h^4/24 [f^((4))(xi_+) + f^((4))(xi_-)] $

$ f''(x) = (f(x-h) - 2 f(x) + f(x+h))/h^2 - h^2/24 [f^((4))(xi_+) + f^((4))(xi_-)] $

If $f^((4))$ is continuous, the bracket is $2 f^((4))(xi)$ for some $xi in (x-h, x+h)$
by the intermediate value theorem, so

$ f''(x) = (f(x-h) - 2 f(x) + f(x+h))/h^2 - h^2/12 f^((4))(xi). $

This is Eq. (4.9) in Burden & Faires with the two remainders merged (Burden et al., 2016, p. 178).

The same idea generalizes to the $p$-th derivative with any accuracy $m$, provided we
add more nodes:
- A 3-point forward approximation for $f'(x)$ from $f(x)$, $f(x+h)$ and $f(x+2h)$ is
  Eq. (4.4) (Burden et al., 2016, p. 175).
- Equivalently, interpolate $f$ by a polynomial $p$ with $p(x_i) = f(x_i)$, then
  evaluate $p'(x_0), p''(x_0), dots$

= Stencils

#definition(name: "Stencil")[
  A stencil for the $p$-th derivative is a formula

  $ f^((p))(x) approx 1/h^p sum_(k=1)^n a_k f(x + s_k h) $

  with $n$ distinct offsets $s_1, dots, s_n$ and weights $a_1, dots, a_n$. It has order
  of accuracy $m$ when the error is $cal(O)(h^m)$.

  - *Forward:* $s = (0, +1, +2, dots, +(m+p-1))$ and $n = m+p$
  - *Backward:* $s = (0, -1, -2, dots, -(m+p-1))$ and $n = m+p$.
    The weights are the forward weights in reverse order, and the sign flips
    exactly when $p$ is odd.
  - *Central:* exists only for even $m$; write $m = 2c$.
    - *Even $p$:* $s = (-beta, dots, -2, -1, 0, 1, 2, dots, beta)$,
      $beta = ceil((m+p-2)/2)$ and $n = 2 beta + 1$
    - *Odd $p$:* $s = (-beta, dots, -2, -1, 1, 2, dots, beta)$, with no node at $x$,
      $beta = ceil((m+p-1)/2)$ and $n = 2 beta$
    - Example: $p = 1$, $m = 2$ has $beta = 1$, so the stencil is $f(x-h)$ and $f(x+h)$.

]

#note[
  For a fixed number of nodes a central stencil is one order more accurate than a
  one-sided one, and for odd $p$ it does not use the node at $x$ at all: $(p, m) = (1, 2)$
  needs two nodes here, but three when it is one-sided.
]

There is a table of central difference coefficients. For example, a central
approximation of the second derivative with accuracy 4 is
$ f''(x) approx 1/h^2 [
    -1/12 f(x-2h) + 4/3 f(x-h) - 5/2 f(x) + 4/3 f(x+h) - 1/12 f(x+2h)
  ] $

#let diff-row(offs, coefs, lo, hi) = range(lo, hi + 1).map(k => {
  let i = offs.position(o => o == k)
  if i == none { [] } else { [#coefs.at(i)] }
})

#let central-rows = (
  (1, 2, (-1, 0, 1), ("−1/2", "0", "1/2")),
  (1, 4, (-2, -1, 0, 1, 2), ("1/12", "−2/3", "0", "2/3", "−1/12")),
  (1, 6, (-3, -2, -1, 0, 1, 2, 3), ("−1/60", "3/20", "−3/4", "0", "3/4", "−3/20", "1/60")),
  (1, 8, (-4, -3, -2, -1, 0, 1, 2, 3, 4), ("1/280", "−4/105", "1/5", "−4/5", "0", "4/5", "−1/5", "4/105", "−1/280")),
  (2, 2, (-1, 0, 1), ("1", "−2", "1")),
  (2, 4, (-2, -1, 0, 1, 2), ("−1/12", "4/3", "−5/2", "4/3", "−1/12")),
  (2, 6, (-3, -2, -1, 0, 1, 2, 3), ("1/90", "−3/20", "3/2", "−49/18", "3/2", "−3/20", "1/90")),
  (2, 8, (-4, -3, -2, -1, 0, 1, 2, 3, 4), ("−1/560", "8/315", "−1/5", "8/5", "−205/72", "8/5", "−1/5", "8/315", "−1/560")),
  (3, 2, (-2, -1, 0, 1, 2), ("−1/2", "1", "0", "−1", "1/2")),
  (3, 4, (-3, -2, -1, 0, 1, 2, 3), ("1/8", "−1", "13/8", "0", "−13/8", "1", "−1/8")),
  (3, 6, (-4, -3, -2, -1, 0, 1, 2, 3, 4), ("−7/240", "3/10", "−169/120", "61/30", "0", "−61/30", "169/120", "−3/10", "7/240")),
)

#figure(
  text(size: 8.5pt, table(
    columns: 13,
    align: center,
    inset: 2.4pt,
    stroke: 0.4pt + rgb("#8c8c8c"),
    table.header([*Der.*], [*Acc.*], [−5], [−4], [−3], [−2], [−1], [0], [1], [2], [3], [4], [5]),
    ..central-rows.enumerate().map(((i, r)) => {
      let (p, m, offs, coefs) = r
      // A rowspan cell already occupies its grid slot in the rows below,
      // so the continuation rows carry no placeholder for it.
      let head = if i == 0 or central-rows.at(i - 1).at(0) != p {
        (table.cell(rowspan: 4)[#p],)
      } else {
        ()
      }
      (..head, [#m], ..diff-row(offs, coefs, -5, 5))
    }).flatten(),
  )),
  caption: [Central-difference weights $a_s$ for
    $f^((p))(x) approx h^(-p) sum_s a_s f(x + s h)$: column $s$ is the offset,
    row labels are the derivative order $p$ and the order of accuracy $m$.
    A $0$ in a row with odd $p$ is the unused node at $x$.],
)

#let forward-rows = (
  (1, 1, (0, 1), ("−1", "1")),
  (1, 2, (0, 1, 2), ("−3/2", "2", "−1/2")),
  (1, 3, (0, 1, 2, 3), ("−11/6", "3", "−3/2", "1/3")),
  (1, 4, (0, 1, 2, 3, 4), ("−25/12", "4", "−3", "4/3", "−1/4")),
  (1, 5, (0, 1, 2, 3, 4, 5), ("−137/60", "5", "−5", "10/3", "−5/4", "1/5")),
  (1, 6, (0, 1, 2, 3, 4, 5, 6), ("−49/20", "6", "−15/2", "20/3", "−15/4", "6/5", "−1/6")),
  (2, 1, (0, 1, 2), ("1", "−2", "1")),
  (2, 2, (0, 1, 2, 3), ("2", "−5", "4", "−1")),
  (2, 3, (0, 1, 2, 3, 4), ("35/12", "−26/3", "19/2", "−14/3", "11/12")),
  (2, 4, (0, 1, 2, 3, 4, 5), ("15/4", "−77/6", "107/6", "−13", "61/12", "−5/6")),
  (2, 5, (0, 1, 2, 3, 4, 5, 6), ("203/45", "−87/5", "117/4", "−254/9", "33/2", "−27/5", "137/180")),
  (2, 6, (0, 1, 2, 3, 4, 5, 6, 7), ("469/90", "−223/10", "879/20", "−949/18", "41", "−201/10", "1019/180", "−7/10")),
)

#figure(
  text(size: 8.5pt, table(
    columns: 10,
    align: center,
    inset: 2.4pt,
    stroke: 0.4pt + rgb("#8c8c8c"),
    table.header([*Der.*], [*Acc.*], [0], [1], [2], [3], [4], [5], [6], [7]),
    ..forward-rows.enumerate().map(((i, r)) => {
      let (p, m, offs, coefs) = r
      let head = if i == 0 or forward-rows.at(i - 1).at(0) != p {
        (table.cell(rowspan: 6)[#p],)
      } else {
        ()
      }
      (..head, [#m], ..diff-row(offs, coefs, 0, 7))
    }).flatten(),
  )),
  caption: [Forward-difference weights $a_s$ for
    $f^((p))(x) approx h^(-p) sum_s a_s f(x + s h)$ with $s >= 0$.
    Backward coefficients are these rows reversed, with the sign flipped for odd $p$.],
)

= Undetermined coefficients

In this method the accuracy is imposed as a condition and the weights are solved
for.

#block(breakable: false, above: 0.6em, below: 0.6em)[
#algorithm(name: "Method of undetermined coefficients")[
  + Choose the offsets $S$ and the derivative order $p$.
  + Write the formula with unknown weights $a_s$, normalized by $h^p$:
    $ f^((p))(x) approx 1/h^p sum_(s in S) a_s f(x + s h). $
  + Expand each $f(x + s h)$ about $x$ and collect the coefficients of
    $f, f', f'', dots$ into one expression.
  + Set the coefficient of $f^((p))(x)$ to $1$, set the coefficients of the next
    $m - 1$ orders to $0$, and for $p >= 2$ also set every order below $p$ to $0$.
  + Solve the system for $a_s$, then read the first remaining coefficient to
    obtain the truncation error.
]
]

Step 4 is the statement that the formula is exact on polynomials up to degree
$p + m - 1$. The system formed in step 4 has one row per condition and one column per
unknown, so a choice of $|S| = p + m$ offsets gives a square system; fewer offsets give
more conditions than unknowns, and the extra rows hold only by symmetry (see the
$f''$ example below).


== *Example 1: Central first derivative with 3 nodes* \
With $S = {-1, 0, 1}$ and unknown weights, expand the three samples and collect:

  $ a_(-1) f(x-h) + a_0 f(x) + a_1 f(x+h) = (a_(-1) + a_0 + a_1) f(x) + h (a_1 - a_(-1)) f'(x) \
    quad + h^2/2 (a_(-1) + a_1) f''(x) + h^3/6 (a_1 - a_(-1)) f'''(x) + dots $

  Dividing by $h$ and matching $f$, $f'$, $f''$ gives

  $ a_(-1) + a_0 + a_1 = 0, quad a_1 - a_(-1) = 1, quad a_(-1) + a_1 = 0, $

  so $a = (-1/2, 0, 1/2)$ and

  $ f'(x) = (f(x+h) - f(x-h))/(2h) - h^2/6 f'''(xi). $

  The first coefficient that remains after dividing by $h$ is
  $h^2/6 (a_1 - a_(-1)) = h^2/6$; merging the two remainders by the intermediate value
  theorem turns it into the single $-h^2/6 f'''(xi)$ above, which is Eq. (4.5) in
  Burden et al. (2016, p. 175).

== *Example 2: 4th-order one-sided row* \
  At a left boundary the points $x - h$ and $x - 2h$ are not available. Take five
  nodes to the right, $S = {0, 1, 2, 3, 4}$, and require order $m = 4$: five
  conditions, $M_0 = 0$, $M_1 = 1$, $M_2 = M_3 = M_4 = 0$:

  $ mat(1, 1, 1, 1, 1; 0, 1, 2, 3, 4; 0, 1, 4, 9, 16; 0, 1, 8, 27, 64; 0, 1, 16, 81, 256) vec(a_0, a_1, a_2, a_3, a_4) = vec(0, 1, 0, 0, 0) $

  The solution is $a = (-25/12, 4, -3, 4/3, -1/4)$, and the first moment that does not
  vanish is $M_5 = sum_s a_s s^5 = -24$, so the error is
  $h^4/5! dot (-24) f^((5))(xi) = -h^4/5 f^((5))(xi)$, i.e.
  $(h^4)/5 f^((5))$ on the other side. This is Eq. (4.7), printed with the remainder
  on the right (Burden et al., 2016, p. 176):
  #text(size: 0.82em)[$ f'(x) = 1/(12h)[-25 f(x) + 48 f(x+h) - 36 f(x+2h) + 16 f(x+3h) - 3 f(x+4h)] + h^4/5 f^((5))(xi). $]

== *Example 3: 2nd derivative w/ 4 conditions & 3 unknowns* \
  
  For $f''$ on $S = {-1, 0, 1}$ the conditions are $M_0 = 0$, $M_1 = 0$,
  $M_2 = 2$ and $M_3 = 0$: four equations for three weights. The placement is
  symmetric, so $M_1 = M_3 = 0$ holds identically and only two conditions determine
  the weights. The result is

  $ f''(x) = (f(x-h) - 2 f(x) + f(x+h))/h^2 - h^2/12 f^((4))(xi), $

  which is Eq. (4.9) in Burden et al. (2016, p. 178).

  With the same weights at $S = {0, 1, 2}$, $M_3 = 6 != 0$ and

  $ f''(x) = (f(x) - 2 f(x+h) + f(x+2h))/h^2 + h f'''(xi), $

  of order 1. The weights alone do not determine the order; the offsets do.
  
== *Example 4: 3 point forward difference by interpolation* \
  Approximate forward $f''(x)$ for $p = 2$, $m = 1$ with nodes $(x_0 = x, f_0 = f(x))$,
  $(x_1 = x+h, f_h = f(x+h))$ and $(x_2 = x+2h, f_(2h) = f(x+2h))$.

  #align(center)[
    #table(
      columns: 4,
      align: center,
      inset: 3pt,
      stroke: 0.4pt + rgb("#8c8c8c"),
      table.header([], [$f$], [$div h$], [$div 2h^2$]),
      [$0$], [$f_0$], [], [],
      [$h$], [$f_h$], [$(f_h - f_0)/h$], [],
      [$2h$], [$f_(2h)$], [$(f_(2h) - f_h)/h$], [$(f_(2h) - 2 f_h + f_0)/(2 h^2)$],
    )
  ]

  The divided differences give the Newton form with $X$ the running variable:

  $ P_2(X) = a_0 + (X - x_0) a_1 + a_2 (X - x_0)(X - x_1) $

  #text(size: 0.82em)[$ P_2(X) = f(x) + (X-x)/h [f(x+h) - f(x)] + ((X-x)(X-x-h))/(2 h^2) [f(x+2h) - 2 f(x+h) + f(x)] $]

  #text(size: 0.9em)[$ P_2'(X) = (f(x+h) - f(x))/h + (2X - 2x - h)/(2 h^2) [f(x+2h) - 2 f(x+h) + f(x)] $]

  $ P_2''(X) = 1/h^2 [f(x+2h) - 2 f(x+h) + f(x)] $

  At $X = x$,

  $ f''(x) approx P_2''(x) = (f(x) - 2 f(x+h) + f(x+2h))/h^2, $

  which is the $p = 2$, $m = 1$ row of the forward table above — the same weights the
  previous example reached from the moment system. The error is $+h f'''(xi)$, so the
  order is $1$.


= Stencil Generalization

In general, a Dirichlet boundary
condition in a stencil changes only the offsets. Get $M_k = sum_(i=1)^n a_i s_i^k$ and expand each
node about $x$:

$ 1/h^p sum_(i=1)^n a_i f(x + s_i h) = sum_(k=0)^oo h^(k-p)/k! M_k f^((k))(x). $

Matching coefficients against $f^((p))(x)$ requires

$ M_k = 0 quad (k < p), quad M_p = p!, quad M_k = 0 quad (p < k < p + m), $

that is

#align(center)[
  $ mat(1, 1, dots, 1; s_1, s_2, dots, s_n; s_1^2, s_2^2, dots, s_n^2; dots.v, dots.v, dots, dots.v; s_1^(n-1), s_2^(n-1), dots, s_n^(n-1)) vec(a_1, a_2, dots.v, a_n) = vec(0, dots.v, p!, dots.v, 0) $
]

This is a Vandermonde matrix, defined to be nonsingular exactly when the offsets are distinct.

= References

#set par(hanging-indent: 1.5em)
#set text(size: 0.95em)

+ Burden, R. L., Faires, J. D., & Burden, A. M. (2016). _Numerical analysis_ (10th ed.).Cengage Learning.

+ Chapra, S. C., & Canale, R. P. (2015). _Numerical methods for engineers_ (7th ed.).
McGraw-Hill Education.