#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")


= Reference Problems

== Compendium Problem 1

#qa(auth: "ALBANO, ELLIOT XANDER")[
  *Source:* Burden and Faires, _Numerical Analysis_,
  Section 11.1, Exercise Set 11.1, Item 9.

  Consider the boundary-value problem
  
$ y'' + y = 0, 0 <= x <= b, y(0) = 0, y(b) = beta $.

Find choices for b and beta so that the boundary-value problem has 

a. No Solution

b. Exactly one solution

c. Infinitely many solutions.
][Solution:
  We solve this using the linear shooting method:

  IVP 1: $y_1(x)$

  $ y'' + y = 0, 0 <= x <= b, y(0) = 0, y'(0) = 0 $

  Note that this has auxiliary equation:

  $m^2 + 1 = 0$
  
  $m = plus.minus i$

  So, this has solution:
  
  $y_1 = A cos(x) + B sin (x)$

  $y_1(0) = A cos (0) + B sin(0) = A(1) + B(0) = A$

  $y_1'(x) = - A sin x + B cos x$

  $y_1'(0) = - A sin 0 + B cos 0 = A(0) + B cos 0 = B$

  So,

  $A = 0, B = 0$

  So, $y_1(x) = 0$

  IVP 2: $y_2(x)$

  $ y'' + y = 0, 0 <= x <= b, y(0) = 0, y'(0) = 1 $

  Note that this has auxiliary equation:

  $m^2 + 1 = 0$
  
  $m = plus.minus i$

  So, this has solution:
  
  $y_2 = A cos(x) + B sin (x)$

  $y_2(0) = A cos 0 + B sin 0 = A(1) + B(0) = A$

  $y_2' = - A sin x + B cos x$

  $y_2'(0) = - A sin 0 + B cos 0 = -A(0) + B(1) = B$

  So,

  $A = 0, B = 1$

  So, $y_2(x) = sin x$

  So, by linear shooting method, we have

  $y(x) = 0 + (beta - y_1(b)) / (y_2(b)) sin (x)$

  $y(x) = 0 + (beta - 0) / (sin b) sin (x)$

  $y(x) = (beta) / (sin b) sin (x)$

  By, this we can establish the ff. conditions for our solutions

  We break this down into two cases

  $b = 0$, $b != 0$

  Case 1: $b = 0$

  If $y(0) = 0$

  The shooting method here would be completely invalid since this is not a two point anymore but this is just 1 point.

  If $y(0) != 0$,

  The shooting method is not only invalid but the IVP is also inconsistent since $y(0)$ has two different values.

  Case 2: $b != 0$ (i.e. $b > 0$)

  If $sin b = 0$, then 
  
  If $beta = 0$, then  since the solution is in the form of $B sin x$ by the first boundary condition, this has infinitely many solutions

  If $beta != 0$, then since the solution is in the form of $B sin x$ but $sin b = 0$, then the IVP will have no solutions.

  If $sin b != 0$ then any real number of $beta$ works creating the only solution.

  So, we have our answer:

  a. No Solution: $b = i pi, i in NN_0, beta != 0, beta in RR$,

  b. One Solution: $b != i pi, i in NN_0, beta in RR$,

  c. Infinitely Many Solutions: $b = i pi, i in ZZ, beta = 0$
]

#pagebreak()

== Compendium Problem 2:

#qa(auth: "ALBANO, ELLIOT XANDER")[
  *Source:* Kiuslaas, _Numerical Methods in Engineering with MATLAB_,
  Section 8.2, Problem Set 8.1, Item 1.

  Numerical integration of the initial value problem 

  $ y'' + y' - y = 0, y(0) = 0, y'(0) = 1 $

  yielded $y(1) = 0.741028$. What is the value of $y'(0)$ that would result in $y(1) = 1$ assuming $y(0)$ is unchanged?
][Solution:

We solve this using the linear shooting method:

We first need $y_1(x)$

$y_1$: $ y'' + y' - y = 0, y_1(0) = 0, y_1 '(0) = 0 $

This has auxiliary equation

$m^2 + m - 1 = 0$, and

$m = (-1 plus.minus sqrt(1^2 - (4)(-1)))/ 2$

$m = (-1 plus.minus sqrt(1 + 4))/ 2$

$m = (-1 plus.minus sqrt(5))/ 2$

And so this is in the form of 

$y_1(x) = A e^((-1 + sqrt(5)) / 2 x) + B e^((-1 - sqrt(5)) / 2 x)$

Now, we take $y_1(0) = 0$, $y_1 '(0) = 0$

$y_1(0) = A e^((-1 + sqrt(5)) / 2 (0)) + B e^((-1 - sqrt(5)) / 2 (0))$

$y_1(0) = A(1) + B(1)$

$y_1(0) = A + B$

Now, we consider $y_1'(0)$

$y_1 '(x) = ((-1 + sqrt(5)) / 2) A e^((-1 + sqrt(5)) / 2 x) + ((-1 - sqrt(5)) / 2) B e^((-1 - sqrt(5)) / 2 x)$

$y_1 '(x) = ((-1 + sqrt(5)) / 2) A e^((-1 + sqrt(5)) / 2 (0)) + ((-1 - sqrt(5)) / 2) B e^((-1 - sqrt(5)) / 2 (0))$

$y_1 '(x) = ((-1 + sqrt(5)) / 2) A (1) + ((-1 - sqrt(5)) / 2) B (1)$

$y_1 '(x) = ((-1 + sqrt(5)) / 2) A + ((-1 - sqrt(5)) / 2) B$

Now, we set them as 0:

$0 = A + B$ (1)

$0 = ((-1 + sqrt(5)) / 2) A + ((-1 - sqrt(5)) / 2) B$ (2)

Now, note by (1)

$0 = ((-1 + sqrt(5)) / 2) A + ((-1 + sqrt(5)) / 2) B$ (1)'

So, (1)' - (2):

$0 = sqrt(5) B$

$B = 0$

$A + 0 = 0$

$A = 0$

So. now $y_1(x) = 0$

So, by linear shooting method:

$y(x) = 0 + (y(1) - y_1(b))/ (y_2(b)) y_2(x)$

$y(x) = (1 - 0) / (0.741028) y_2(x)$

$y(x) = 1 / (0.741028) y_2(x)$

So,

$y'(x) = 1 / (0.741028) y_2'(x)$

$y'(0) = 1 / (0.741028) y_2'(0)$

But note that the second IVP is already enough for $y_2$, so $y_2 '(0) = 1$

$y'(0) = 1 / (0.741028) (1)$

$y'(0) = 1 / (0.741028) $

$y'(0) approx 1.349476673$

$y'(0) approx 1.3495$

]

#pagebreak()

= Remix Problem

#qa(auth: "ALBANO, ELLIOT XANDER")[
  
  Let's deal with function polynomial $P(x)$ where $P''(x) = 0$ and function

  $ y'' + 4 y = P(x), y(0) = alpha, y(b) = beta $

  This guy is nefarious, so he refuses to give you $alpha, beta, P(b), P(0)$.

  He's giving you the first move, you first need to know what to avoid.

  You need to pick $beta$ in terms of $alpha, P(b), P(0), P'(0), and b$

  If you give him an opportunity to make 0 or infinite solutions, he wins because with 0 you have no moves, and with infinite solutions, your puny cramming brain cannot process this.

  This is done depending on the $beta$ you pick.

  In your move, you can also call out certain values for $b$ that your nefarious opponent cannot choose. You can call out infinitely many.

  Now, your final concern is the $y'(0)$ move that he plans on doing if he cannot pick $b$ nefariously. Once again your brain can somehow handle solving this, but not a function that's not constant. So, You need to pick $beta$ in terms of $alpha, P(b), P(0), b$ so that $y'(0)$ is independent of $b$ other than those callouts.

  
  You may be overwhelmed but I believe you have more than enough brain power to solve this. Solve it and beat the nefarious guy.

  Pick the right $b's$ and their respective $beta's$ to call out, and then pick a nice $beta$.

][Solution:

We solve this using the linear shooting method:

We first need $y_1(x)$

$y_1$: $ y'' + 4y = P(x), y_1(0) = alpha, y_1 '(0) = 0 $

Let's solve for the homogenous part:

This has auxiliary equation

$m^2 + 4 = 0$, and

$m = plus.minus 2i$

And so this is in the form of 

$y_1_h (x) = A cos 2x + B cos 2x$

Now, we solve for $y_1_p (x)$, but this is just MUC

$D^2 (y'' + 4y) = D^2 (P(x))$

$D^2 (y'' + 4y) = 0$

So, this gives us auxiliary equation

$m^2 (m^2 + 4) = 0$

But since $m^2 + 4$ is in the homogenous solution, we only care about $m^2$

So, $m^2 = 0$ gives us solution $A x + B$

So,

$(A x + B)'' + 4 (A x + B) = P(x)$

$0 + 4 (A x + B) = P(x)$

$(A x + B) = (P(x)) / 4$

So $y_1_p (x) = (P(x)) / 4$

So, 

$y_1 = (P(x)) / 4 + A cos 2x + B sin 2x$

$y_1 ' = (P'(x)) / 4 - 2 A sin 2x + 2B cos 2x$

At $y_1(0) = alpha, y_1 ' (0) = 0$

$y_1 (0) = (P(0)) / 4 + A cos 2(0) + B sin 2(0)$


$alpha = (P(0)) / 4 + A$

$A = alpha - (P(0)) / 4$

$y_1 ' (0) = (P'(0)) / 4 - 2 A sin 2(0) + 2B cos 2(0)$

$0 = (P'(0)) / 4 + 2B$

$B = (-P'(0)) / 8$

So, 

$y_1 = (P(x)) / 4 + (alpha - (P(0)) / 4) cos 2x + (-(P'(0)) / 8) sin 2x$

Now, we solve $y_2(x)$

$ y'' + 4y = 0, y(0) = 0, y'(0) = 1 $

$m^2 + 4 = 0$, and

$m = plus.minus 2i$

And so this is in the form of 

$y_2 (x) = A cos 2x + B sin 2x$

$y_2 '(x) = -2A sin 2x + 2B cos 2x$

$y_2 (0) = A cos 2(0) + B sin 2(0)$

$0 = A cos 0 + B sin 0$

$0 = A$


$y_2 '(0) = -2A sin 2(0) + 2B cos 2(0)$

$1 = -2A sin 0 + 2B cos 0$

$1 = 2B$

$1/2 = B$

So, $y_2(x) = 1/2 sin 2x$

So, now we perform the shooting method:

$y = y_1(x) + y_2(x) ((beta - y_1(b)) / (y_2(b)))$

$y = (P(x)) / 4 + (alpha - (P(0)) / 4) cos 2x + (-(P'(0)) / 8) sin 2x +  1/2 sin 2b ((beta - y_1(b)) / (1/2 sin 2b))$

So, similarly to the previous exercise earlier,

this shooting method fails if $y_2(b) = 0$, so we want that

So, we want to find that 

$1/2 sin 2b = 0$

$sin 2b = 0$ or when $2b$ is an integer multiple of $pi$ or $b = k pi/2$ for some $k in ZZ^+$

We call these numbers out, and he cannot pick $b$ for those values regardless of $beta$ that we pick.

Now, if we want 0 solutions, we need to make $beta != y_1(b)$

But if we want infinite solutions, we need $beta = y_1(b)$

$beta = (P(b)) / 4 + (-1)^k (alpha - (P(0)) / 4)$, and we have our function for infinite solutions since in those values $cos(2b) = plus.minus 1$, $sin(2b) = 0$

Now, we want to ensure $y'(0) = 0$

For that note that remember 

$y = (P(x)) / 4 + (alpha - (P(0)) / 4) cos 2x + (-(P'(0)) / 8) sin 2x +  1/2 sin 2b ((beta - y_1(b)) / (1/2 sin 2b))$

Note that $y_1 '(0) = 0$, so we don't really need to care about that

And $y_2 ' (0) = 1$, so we only care about the other term which is 

So, $y'(0)$ is

$((beta - y_1(b)) / (1/2 sin 2b))$

$y_1(b) = (P(b)) / 4 + (alpha - (P(0)) / 4) cos 2b + (-(P'(0)) / 8) sin 2b$

Note, we cannot let him pick $b$, so 

So, we need to remove the dependences on $sin 2b$. From our callout $sin 2b != 0$, so we just need to leave terms with $sin 2b$ and we will get some nice constant.

$((beta - y_1(b)) / (1/2 sin 2b))$

$=beta / (1/2 sin 2b) - (P(b)) / 2 csc 2b + (2alpha - (P(0)) / 2) cot 2b + (-(P'(0)) / 4)$

And now, we see it, our only constant with respect to $b$ is $-(P'(0)) / 4$, we just set

$beta / (1/2 sin 2b) - (P(b)) / 2 csc 2b + (2alpha - (P(0)) / 2) cot 2b = 0$

Or

$beta = (P(b)) / 4 - (alpha - (P(0)) / 4) cos 2b$

You pick a $beta$ in this form, and using this logic, you win with $y'(0)$ being independent of $b$.

]
