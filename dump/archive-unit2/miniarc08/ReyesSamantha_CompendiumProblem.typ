#import "../assets.typ": notes, definition, theorem, algorithm, example, note
#set math.mat(delim: "[")

#show: notes.with(
  title: [Central Difference],
  subtitle: [ Arc 8 · Reyes, Samantha Mikaylah],
)

= Problem 1
*Example 5.1 — Kiusalaas* Given the evenly spaced data points:

#table(
  columns: 6,
  align: center,
  stroke: 0.5pt,
  inset: 7pt,
  [$x$], [$0$], [$0.1$], [$0.2$], [$0.3$], [$0.4$],
  [$f(x)$], [$0.0000$], [$0.0819$], [$0.1341$], [$0.1646$], [$0.1797$],
)

Compute $f'(x)$ and $f''(x)$ at x = 0.2 using central difference approximations of $O(h^2)$.

== Solution
As we can observe, the given points are said to be evenly spaced so we can get the step size $h$ by subtracting two consecutive values of $x$ which gives us: $ h = 0.1 - 0 = 0.1.$ To compute for $f'(x)$ and $f''(x)$ at $x = 0.2$, we can just use central differences since $x = 0.2$ is an interior point.

\

#underline[=== Computing for the First Derivative]
The central difference approximation for the first derivative of this problem is:
$ f'(x) approx frac(f(x+h) - f(x-h), 2h). $
Using $x = 0.2$ and $h = 0.1$, we get:
$ f'(x) approx frac(f(0.2+0.1) - f(0.2-0.1), 2(0.1)). $
$ f'(0.2) approx frac(f(0.3) - f(0.1), 2(0.1)). $
We then substitute their values from the given table:
$ f'(0.2) approx frac(0.1646 - 0.0819, 0.2) $
$ f'(0.2) approx frac(0.0827, 0.2) $
$ f'(0.2) approx 0.4135. $

\

#underline[=== Computing for the Second Derivative]
The central difference approximation for the second derivative of this problem is:
$ f''(x) approx frac(f(x-h) - 2f(x) + f(x+h), h^2). $
Using $x = 0.2$ and $h = 0.1$, we get:
$ f''(x) approx frac(f(0.2-0.1) - 2f(0.2) + f(0.2+0.1), (0.1)^2). $
$ f''(0.2) approx frac(f(0.1) - 2f(0.2) + f(0.3), (0.1)^2). $

We then substitute their values from the given table:
$ f''(0.2) approx frac(0.0819 - 2(0.1341) + 0.1646, 0.01). $
$ f''(0.2) approx frac(0.0819 - 0.2682 + 0.1646, 0.01) $
$ f''(0.2) approx frac(-0.0217, 0.01) $
$ f''(0.2) approx -2.17. $

== Final Answer
Using the central difference method with a step size of $h = 0.1$ at $x = 0.2 $, we were able to get the values:
$ f'(0.2) approx 0.4135 "and" f''(0.2) approx -2.17. $

They both have a truncation error of $O(h^2)$ since we used the central difference method to approximate the first and second derivatives at $x=0.2$.


#pagebreak()
= Problem 2

*Problem Set 5.1, No. 3 — Kiusalaas*. Derive the central difference approximation for $f''(x)$ accurate to $O(h^4)$ by applying Richardson extrapolation to the central difference approximation of $O(h^2)$.

== Solution
We will be using the three-point central difference approximation for the second derivative $f''(x)$ which we know has a truncation error of $O(h^2)$:
$ f''_h(x) = frac(f(x-h) - 2f(x) + f(x+h), h^2). $
$f''_h(x)$ here represents the numerical approximation of $f''(x)$ with $h$ as the step size.

\

#underline[=== Understanding the Original Truncation Error
]
Using the Taylor series expansions of $f(x+h)$ and $f(x-h)$ around $x$, we have:
$ f(x+h) = f(x) + h f'(x) + frac(h^2, 2) f''(x) + frac(h^3, 6) f'''(x) + frac(h^4, 24) f^((4))(x) + frac(h^5, 120) f^((5))(x) + frac(h^6, 720) f^((6))(x) + dots $
$ f(x-h) = f(x) - h f'(x) + frac(h^2, 2) f''(x) - frac(h^3, 6) f'''(x) + frac(h^4, 24) f^((4))(x) - frac(h^5, 120) f^((5))(x) + frac(h^6, 720) f^((6))(x) + dots $
Adding $f(x+h) "and" f(x-h)$ and also subtracting $2f(x)$ removes the derivative terms that are raised to odd numbers:
$ f(x-h) - 2f(x) + f(x+h)= h^2 f''(x) + frac(h^4, 12) f^((4))(x) + frac(h^6, 360) f^((6))(x) + dots $
If we divide it by $h^2$, we then get:
$ f''_h(x) = f''(x) + frac(h^2, 12) f^((4))(x) + frac(h^4, 360) f^((6))(x) + dots $
The leading error term here is proportional to $h^2$ which is why the original central difference approximation has a second-order accuracy $O(h^2)$.

\

#underline[=== Applying the Richardson extrapolation
]
We start by replacing $h$ with $h/2$ to the three-point central difference approximation for the second derivative:
$ f''_(h/2)(x) = frac(f(x-h/2) - 2f(x) + f(x+h/2), (h/2)^2). $
$ f''_(h/2)(x) = frac(4[f(x-h/2) - 2f(x) + f(x+h/2)], h^2). $

Substituting $h/2$ into the expansion we got which is equation (19) gives us:
$ f''_(h/2)(x) = f''(x) + frac(h^2, 48) f^((4))(x) + frac(h^4, 5760) f^((6))(x) + dots $

Since we know that the leading error is second-order accurate $O(h^2)$, we then use Richardson extrapolation with $p = 2$. The Richardson extrapolation formula then becomes:
$ f''_R(x) = frac(2^p f''_(h/2)(x) - f''_h(x), 2^p - 1). $
$ f''_R(x) = frac(4f''_(h/2)(x) - f''_h(x), 3). $

Substituting the expansions of $f''_(h/2)(x)$ and $f''_h(x)$ to it gives us:
$ f''_R(x) = frac(4[f''(x) + frac(h^2, 48) f^((4))(x) + frac(h^4, 5760) f^((6))(x) + dots] - [f''(x) + frac(h^2, 12) f^((4))(x) + frac(h^4, 360) f^((6))(x) + dots], 3). $

Combining like terms gives:
$ f''_R(x) = frac(3f''(x) + (frac(h^2, 12) - frac(h^2, 12))f^((4))(x) + (frac(h^4, 1440) - frac(h^4, 360))f^((6))(x) + dots, 3). $

We cancel out the $h^2$ terms which leaves us with:
$ f''_R(x) = f''(x) - frac(h^4, 1440) f^((6))(x) + dots $

Now the leading error term is proportional to $h^4$ which tells that we now have a fourth-order accuracy $O(h^4)$.

\

#underline[=== Deriving the Central Difference Formula
]
We substitute $f''_(h/2)(x)$ and $f''_h(x)$ into the Richardson extrapolation formula we got earlier which was
$ f''_R(x) = frac(4f''_(h/2)(x) - f''_h(x), 3) $
$ f''_R(x) = frac(1, 3) [frac(16[f(x-h/2) - 2f(x) + f(x+h/2)], h^2) - frac(f(x-h) - 2f(x) + f(x+h), h^2)] $

Simplifying it and combining the like terms gives us the fourth-order accurate central difference approximation for $f''(x)$:
$ f''_R(x) = frac(-f(x-h) + 16f(x-h/2) - 30f(x) + 16f(x+h/2) - f(x+h), 3h^2) $

== Final Answer
Applying Richardson extrapolation to the three-point central difference approximation of $O(h^2)$ gives us
$ f''(x) approx frac(-f(x-h) + 16f(x-h/2) - 30f(x) + 16f(x+h/2) - f(x+h), 3h^2) $
The final approximation has a truncation error of $O(h^4)$ considering that using the Richardson extrapolation removes the leading $O(h^2)$ error term. Therefore, our derived final formula gives us a fourth-order accurate central difference approximation for $f''(x)$.


#pagebreak()
= Remix Problem
Given the evenly spaced data points from $f(x) = e^x$:
#table(
  columns: 6,
  align: center,
  stroke: 0.5pt,
  inset: 7pt,
  [$x$], [$0.8$], [$0.9$], [$1.0$], [$1.1$], [$1.2$],
  [$f(x)$], [$2.225541$], [$2.459603$], [$2.718282$], [$3.004166$], [$3.320117$],
)
Approximate the first and second derivatives at $x = 1$ using the three-point central difference formulas of $O(h^2)$ and then Richardson extrapolation to obtain a more accurate approximation of the second derivative with an order of accuracy of $O(h^4)$.

== Solution
As we can observe, the given points are said to be evenly spaced so we can get the step size h by subtracting two consecutive values of $x$ which gives us: $h = 0.9 - 0.8 = 0.1.$ To compute for $f'(x) "and" f''(x)$ at $x = 1$, we can just use central differences since $x=1.0$ is an interior point.

\

#underline[=== Computing for the First Derivative]
The three-point central difference approximation for the first derivative of this problem is:
$ f'(x) approx frac(f(x+h) - f(x-h), 2h). $

Using $x = 1$ and $h = 0.1$, we get:
$ f'(1) approx frac(f(1 + 0.1) - f(1 - 0.1), 2(0.1)). $
$ f'(1) approx frac(f(1.1) - f(0.9), 2(0.1)). $
We then substitute their values from the given table:
$ f'(1) approx frac(3.004166 - 2.459603, 0.2) $
$ f'(1) approx frac(0.544563, 0.2) $
$ f'(1) approx 2.722815. $

\

#underline[=== Computing for the Second Derivative
]
The three-point central difference approximation for the second derivative of this problem is:
$ f''(x) approx frac(f(x-h) - 2f(x) + f(x+h), h^2). $
Plugging in x = 1 and $h = 0.1$:
$ f''(x) approx frac(f(1-0.1) - 2f(1) + f(1+0.1), h^2). $
$ f''(1) approx frac(f(0.9) - 2f(1) + f(1.1), (0.1)^2). $
We then substitute their values from the given table:
$ f''(1) approx frac(2.459603 - 2(2.718282) + 3.004166, 0.01) $
$ f''(1) approx frac(0.027205, 0.01) $
$ f''(1) approx 2.720500 $

\

#underline[=== Applying Richardson Extrapolation]
We will be needing two approximations of the second derivative using different step sizes so now we use $2h = 2(0.1) "which gives us "h =0.2$. Now, the formula for the central difference becomes:
$ f''_(0.2)(1) approx frac(f(1-0.2) - 2f(1) + f(1+0.2), (0.2)^2). $
Substituting the values from the table:
$ f''_(0.2)(1) approx frac(2.225541 - 2(2.718282) + 3.320117, 0.04). $
$ f''_(0.2)(1) approx frac(2.225541 - 5.436564 + 3.320117, 0.04) $
$ f''_(0.2)(1) approx frac(0.109094, 0.04) $
$ f''_(0.2)(1) approx 2.727350. $

At this point, we have two approximations of the second derivative:
$ f''_(0.1)(1) = 2.720500 "and" f''_(0.2)(1) = 2.727350. $

Since we know that the three-point central difference formula has a truncation error of $O(h^2)$, we then use Richardson extrapolation with $p = 2$ so the formula becomes:
$ f''_R(1) approx frac(2^p f''_h(1) - f''_(2h)(1), 2^p - 1) $
$ f''_R(1) approx frac(4f''_h(1) - f''_(2h)(1), 3) $

Substituting the values we got:
$ f''_R(1) approx frac(4f''_(0.1)(1) - f''_(2(0.1))(1), 3) $
$ f''_R(1) approx frac(4f''_(0.1)(1) - f''_(0.2)(1), 3) $
$ f''_R(1) approx frac(4(2.720500) - 2.727350, 3) $
$ f''_R(1) approx frac(10.882000 - 2.727350, 3) $
$ f''_R(1) approx frac(8.154650, 3) $
$ f''_R(1) approx 2.718216667 $

By applying Richardson extrapolation, the leading $O(h^2)$ error term is eliminated, giving a fourth-order approximation of the second derivative.

\

#underline[=== Comparing the Approximations]
Since the given data were from the function $f(x) = e^x$, then we can say that the first derivative will still be $f'(x) = e^x$ and that the second derivative is $f''(x) = e^x$.

The first derivative at $x = 1$ is: $ f'(1) = f''(1) = e approx 2.718281828 $

For the second derivative, the ordinary three-point central difference method gives us: $ f''(1) approx 2.720500 $
While the Richardson extrapolation gives us: $ f''(1) approx 2.718216667 $

As we can see, the result from the Richardson extrapolation is closer to the exact value. As a result, eliminating the leading truncation error improves the approximation for the given dataset.

== Final Answer
Using the three-point central difference method with a step size of $h = 0.1$ at $x=1$, we were able to get the values:
$ f'(1) approx 2.722815 "and" f''(1) approx 2.720500 $

After applying Richardson extrapolation to the second derivative, we were able to get an improved approximation that's closer to the exact value:
$ f''(1) approx 2.718216667 $

The ordinary central difference approximations have a truncation error of $O(h^2)$, while the Richardson extrapolation result has a truncation error of $O(h^4)$.

Therefore, this shows us that we can use the central difference method to approximate derivatives and then use Richardson extrapolation after to further improve the accuracy of the second derivative approximation.

= Reference
1. Kiusalaas. _Numerical Methods in Engineering with Python_. Cambridge University Press, 2013.
