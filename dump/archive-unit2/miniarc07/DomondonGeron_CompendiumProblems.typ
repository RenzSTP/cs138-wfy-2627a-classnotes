#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1

#qa(auth:"DOMONDON, GERON WARREN")[
  // as of 4pm nov9, none of the other compendium files here contain this problem, nor has anyone claimed it on discord
  (LE2 reviewer Item 3a)
  
  Consider the BVP 
  
  $ y'' = y e^y + y', y(0) = 1, y'(1) = 2 $
  
  Show that the ODE yields a unique solution within its boundary conditions 
][
  *Solution.*

  Recall that an SODE $y'' = f(x, y, y') $ has a unique solution if the following conditions are met:

  - $f, f_y, f_y'$ are continuous over $[a, b]$
  - $f_y > 0$
  - $abs(f_y') <= M$ for some real number $M$

  We use these conditions to show that the given ODE yields a unique solution within its BCs.

  First, we compute $f_y$ and $f_y'$.


$ y'' = f(x, y, y') = y e^y + y' $




$ => f_y = partial/(partial y) (y e^y + y') = y e^y + e^y = e^y (y + 1) $

$ => f_(y') = 1 $

Now, notice $f, f_y, "and" f_y'$ are continuous for all real $y$, and  $[1, 0]$ is only a subset of $R$ // change to actual notation later
so the first condition is met. Also note that $f_y = 1 <= 1 = M$, so the third condition is met.

However, consider what happens to $f_y$ when we plug in $y = -1$:

$ f_y (-1) = e^(-1) (-1 + 1) = 0 $
That violates our second condition! 

Note also that any $y <= -1$ also results in a violation of the second condition. Hence, what if that case isn't possible in the first place?

We try to show that for any solution to the BVP, $y > -1$.

*Proof.*

Let $y$ be any solution to the BVP, and suppose that $y(x) <= -1$ somewhere in $[0, 1]$. Note that at $x=1$, $y'(1) = 2$, which means that $y$ is increasing there, and that $x=1$ is not a minimum. At the same time, $y(0) = 1 > -1$, so $x=0$ can not be a minimum. Hence, $y$ must be negative at some $x_0 in (0, 1)$.

Since $x_0$ is a minimum, $y'(x_0) = 0$. Since it is also an interior minimum, $y''(x_0) >= 0$

Now, we plug in $x_0$ to the ODE:

$ 
  y''(x_0) = y(x_0) e^y(x_0) + y'(x_0)

  = y(x_0) e^y(x_0)
$

Since $y(x_0) < 0$ and $e^y(x_0) > 0$, we get 

$  y''(x_0) < 0 $

This contradicts $y''(x_0) >= 0$ that stems from our assumption. $space _square.filled$ 

Hence, $y > -1$ for all $x in [0, 1]$. It then follows that along every BVP solution, $f_y > 0$.






]
== Compendium Problem 2 
#qa(auth:"DOMONDON, GERON WARREN")[
  (LE2 review Item 3b)
  
  Transform the BVP into an initial value problem. Derive the other initial value problem needed and write the simultaneous system of FODEs in the form $u′=f(x,u)$

][
  Let $f(x, y, y') = y e^y + y'$, and let $y(x, t)$ solve
$y'' = f(x, y, y')$ with $y(0) = 1$ and $y'(0) = t$.

Differentiate with respect to $t$. Note that $(partial x)/(partial t) = 0$:
$ (partial y'') / (partial t)
  = cancel((partial f) / (partial x) (partial x) / (partial t))
  + (partial f) / (partial y) (partial y) / (partial t)
  + (partial f) / (partial y') (partial y') / (partial t), $

where
$ f_y = y e^y + e^y = e^y (y + 1), quad f_(y') = 1. $

Set $v = (partial y) / (partial t)$. Then
$ v'' = e^y (y + 1) v + v', quad v(0) = 0, quad v'(0) = 1. $

Define $u_1 = y$, $u_2 = y'$, $v_1 = v$, $v_2 = v'$. The IVP system is

$ mat(delim: "[", u_1'; u_2'; v_1'; v_2')
  = mat(delim: "[",
      u_2;
      u_1 e^(u_1) + u_2;
      v_2;
      (1 + u_1) e^(u_1) v_1 + v_2
    ),
  quad
  mat(delim: "[", u_1 (0); u_2 (0); v_1 (0); v_2 (0))
  = mat(delim: "[", 1; t; 0; 1). $
]

== Remixed Problem
#qa(auth:"DOMONDON, GERON WARREN")[
  Continue solving the BVP presented in compendium problem 1. Use two methods: Euler's and RK4 in solving the IVPs per Newton iteration, and compare their errors.
][]


\
== Appendices
#image("Domondon_compendium_images/1.jpeg")
#image("Domondon_compendium_images/2.jpeg")
