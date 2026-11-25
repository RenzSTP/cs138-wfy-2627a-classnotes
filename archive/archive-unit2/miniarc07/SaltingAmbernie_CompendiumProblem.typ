#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1
#qa(auth:"Salting, Ambernie Green L.")[
  *Source:* Burden and Faires, _Numerical Analysis_, Section 11.1, Exercise Set 11.1, Item 3c

  3. Use the Linear Shooting method to approximate the solution to the following boundary-value problems.
  
  #align(center)[(c) $y′′ = −(x + 1)y′ + 2y + (1 − x^2)e^(-x), 0 ≤ x ≤ 1, y(0) = −1, y(1) = 0; "use" h = 0.1$]
][*Solution.*
\

*Step 1: Construct the IVPs.*

We need to separate the equation into two: the homogenous ($y_1$) and non-homogenous ($y_2$) part.

#align(left)[$y_1 '' = -(x + 1)y_2 ' + 2y_2$,]

where our anchors would be *$y_2(0) = 0$* and *$y_2 '(0) = 1$*

#align(left)[$y_2 '' = -(x + 1)y_1 ' + 2y_1 + (1 - x^2)e^(-x)$, ]

where our anchors would be* $y_1(0) = alpha = -1$* and *$y_1 '(0) = 0$*

*Step 2: Rewrite both IVPs as first-order systems.* 

Convert to first order systems, using the $u$ and $v$ substitution.

For $y_1$,

- $u_1 = y_1$
- $u_2 = y_1 '$
- Since $u_1 ' = y_1 ' => u_1 ' = u_2$
- $u_2 ' = -(x + 1) u_2 + 2u_1$

Then for $y_2$,

- $v_1 = y_2$
- $v_2 = y_2 '$
- Since $v_1 ' = y_2 ' => v_1 ' = v_2$
- $v_2' = -(x + 1)v_2 + 2v_1 + (1 - x^2)e^(-x)$

Finally, we calculate for the starting vectors:
- $u_1 (0) = 0$
- $u_2 (0) = 1$
- $v_1 (0) = -1$
- $v_2 (0) = 0$

*Step 3: Approximate both IVPs using Euler's Method.* 

Executing the actual jumps with $h = 0.1$ (10 total jumps) using the explicit Euler method formula: *New = Old + $h times $ Derivative*

(a) So for the first jump from *$x = 0 -> x = 0.1$*

$
u_1' &= 1
\

u_2' &= -(0 + 1)(1) + 2(0) = -1
\

v_1' &= 0
\

v_2' &= -(0 + 1)(0) + 2(-1) + (1 - 0^2)e^0 = -2 + 1 = -1
$

Now, we multiply by $h = 0.1$ and add the starting value,

$
u_1(0.1) &= 0 + 0.1(1) = 0.1
\

u_2(0.1) &= 1 + 0.1(-1) = 0.9
\

v_1(0.1) &= -1 + 0.1(0) = -1
\
v_2(0.1) &= 0 + 0.1(-1) = -0.1
$

Then, we repeat this process (i.e. from $x = 0.1 -> x = 0.2$) until we reach $x = 1$.

*Step 4: Form the linear shooting approximations.* 

After the 10th jump, we should the final value for our $u_1 (1)$ and $v_2 (1)$.

But, we first need to solve for $C$, so it _hits_ our boundary target $beta = 0$ where,

#align(center)[$C = (beta - v_1 (1)) / (u_1 (1)) = (0 - v_1(1))/(u_1(1))$]

*Step 5: Final solution and checking of boundary.* 

Finally, we add our non-homogenous solution to the scaled homogenous part.

#align(center)[$y (x_i) = C dot y_1(x_i) + y_2(x_i)        space _square.filled$]
]



== Compendium Problem 2 
#qa(auth:"Salting, Ambernie Green L.")[
  *Source:* Burden and Faires, _Numerical Analysis_, Section 11.1, Exercise Set 11.1, Item 10

  10. Attempt to apply Exercise 9 to the boundary-value problem:
  #align(center)[$y′′ − y = 0, 0 ≤ x ≤ b, y(0) = 0, y(b) = B.$]
][*Solution.*
\

The characteristic equation for $y'' - y = 0$ is $r^2 - 1 = 0$, giving roots $r = plus minus 1$. 

Using hyperbolic functions, the general solution is:

#align(center)[$ y(x) = c_1 cosh x + c_2 sinh x $]

Then, we apply the BCs,

For $y(0) = 0,$
$ y(0) = c_1 (1) + c_2 (0) = 0 => c_1 = 0 $

For $y(b) = B,$
$ y(b) = c_2 sinh b = B $

Since $b > 0$, $sinh b$ should be positive, thus we can divie by $sinh b$ to find the constant,
\

#align(center)[$ c_2 = B / (sinh b)$]

So, for any interval $b > 0$ and any boundary value $B$, this problem always has *_exactly one_* solution.

Next, in relation to _Corollary 11.2_:

So, the corollary requires the ODE to be written in the form,

#align(center)[$y'' = p(x)y' + q(x)y + r(x)$]

For the previous exercise 9 ($y '' + y = 0$),

Since $q(x) = -1 < 0$, it failes the condition (ii). That's why there is no unique state for this one, it can either have zero, or one, or many solutions.

As for exercise 10 ($y '' - y = 0$),

Since $q(x) = 1 > 0$, it satisfies the condition (ii). Thus, by the theorem the problem is guaranteed to have *_exactly one_* solution (unique). $square.filled$
]

== Remixed Problem
// WIP 