Elliot Albano's Compendium

= Compendium Problems

1. [Burden and Faires, Exercise Set 6.6, page 425, Item 4a] 

Use LDL^t Factorization Algorithm to find a factorization of the form $A = L D L ^t$ for the following matrices: 

$A = 
mat(delim: "[", 2, -1, 0; -1, 2, -1; 0, -1, 2)$ is 

2. [POTW 0 Item 13]

Consider the function  

$  f(x) = a x^4 + b x + 1 $

Notice that $f(0) = 1$.

$   I = integral_0^4 f(x) d x $

is approximated using Simpson's $1/3$ rule with two subintervals,

$I approx I_S = 56/3$

When I is approximated using the Trapezoid rule with two subintervals,

$I approx I_T = 18$

If $I = p/q$, where $p$ and $q$ are relatively prime what is $p - q$?

#pagebreak()

= Compendium Solutions

1. [Burden and Faires, Exercise Set 6.6, page 425, Item 4a]

$L D L^t$ factorization is found in page 417 of Burden and Faires (2011)

$A = 
mat(delim: "[", 2, -1, 0; -1, 2, -1; 0, -1, 2)$ 

$d_1 = 2$

$l_21 = (-1) / d_1 = -1/2 $

$l_31 = (0) / d_1 = 0$

$d_2 = 2 - ((-1/2)^2 times 2) = 2 - 1/2 = 3/2$

$l_32 = (-1 - ((-1/2) times 2 times 0)) / (3/2)$

$l_32 = -2/3$

$d_33 = 2 - 2(0)^2 - 3/2(-2/3)(-2/3)$

$d_33 = 2 - 2/3 = 4/3$

So, our final factorization is 

$L D L^t = mat(delim: "[", 1, 0, 0; -1/2, 1, 0; 0, -2/3, 1) mat(delim: "[", 2, 0, 0; 0, 3/2, 0; 0, 0, 4/3) mat(delim: "[", 1, -1/2, 0; 0, 1, -2/3; 0, 0, 1)$


#pagebreak()

2. [POTW 0 Item 13]

Note $f(x) = a x^4 + b x + c$, a and b are specifically the coefficients of $x^4, x$ respectively.

Compendium Problem 2: POTW 0 Item 13

We first write the $f(0), f(2), f(4)$

$x"              "f$

$0"              " a(0^4) + b(0) + 1 = 1$

$2"              " a(2^4) + b(2) + 1 = 16a + 2b + 1$

$4"              " a(4^4) + b(4) + 1 = 256a + 4b + 1$

Simpson's $1/3$: $1/3(f(0) + f(2) + f(4))2$

$(1/3(1) + 4/3 (16a + 2b + 1) + 1/3 (256a + 4b + 1))2$

$= (1/3 + 64/3a + 8/3b + 4/3 + 256/3a + 4/3b + 1/3)2$

$= (320/3a + 4b + 2)2$

$= 640/3a + 8b + 4$

Trapezoid: 

$2/2 (f(0) + f(2)) + 2/2 (f(0) + f(2))$

(Closed parenthesis as my handwritten solution)

$=  (1 + 16a + 2b + 1) +  (16a + 2b + 1 + 256a + 4b + 1)$

$= 288a + 8b + 4$

We then set the equations

$640/3a + 8b + 4 = 56/3 => 640/3a + 8b = 44/3$ (1)

$288a + 8b + 4 = 18 => 288a + 8b = 14$ (2)

(1)-(2)

$-224/3 a = 2/3 => a = -1/112$

Then solving for b:

$640/3 (-1/112) + 8b = 44/3 => 8b = 116/7 => b = 29/14$

So, $f(x) = -1/112 x^4 + 29/14 x + 1$

$f(x) = -1/112 x^4 + 29/14 x + 1$

$integral_0^4 f(x) = integral_0^4 (-1/112 x^4 + 29/14 x + 1) d x = (-1/560x^5 + 29x^2 + x) |_0^4$

$(-1/560(4^5) + 29(4^2) + 4) - (-1/560(0^5) + 29(0^2) + 0) = 656/35 - 0 = 656/35$, $p - q = 656-35 = 621$



= Compendium Remixes

1. [Remix of Burden and Faires, Exercise Set 6.6, page 427, Item 16] 

Find all $a, b, c, d$ such that $B = mat(delim: "[", 2, a + b, 1; 2 c + 4, d, c; 2 b + a, 5+3 c + 3 b, 1)$ is positive definite

You are required to solve the system by doing a Doolittle Decomposition once the equations are found.

A random twist has been added, turns out this is somewhat similar to what his friend is doing, so Elliot needed to modify this problem. Once you finish the matrix, $d$, the variable, has a specific value such that in its $L D L^t$ factorization, $d_22 = 25$, solve the system $B x = y$ where $y = [5, 26, 1]^T$ using the decomposition. 

2. [Remix of POTW 0 Item 13] For some reason, Elliot likes breaking the integrals and making Frankenstein ones. 

Today he now has,

$integral_0^3 (a x^2 + (2l + 1) b x + (k + 3) c) " "d x + integral_3^5 ((k + 1) c x^2 + (3l + 2) a x + b) " "d x$



The resulting piecewise function from integrating this is both continuous and differentiable. Note that the closed integrals both have constant terms of $0$.

Let $f(x)$ be $integral_0^3 (a x^2 + (2l + 1) b x + (k + 3) c)$ 

$g(x)$ be $integral_3^5 ((k + 1) c x^2 + (3l + 2) a x^2 + b) " "d x$

He is also crazy enough to estimate  $integral_0^3 f(x) d x$ using Simpson's $3/8$ rule and the integral of $integral_3^5  g(x) d x$ using the Simpson's $1/3$ rule and when adding both estimations, they get a total of 67.

First, solve for $k, l$ by solving the ff. matrix with $A mat(delim: "[", k; l) = mat(delim: "[", 54; 99)$, $A = L L^T = mat(delim: "[", 9, y; y, 25)$, $L = mat(delim: "[", w, 0; z, 3)$ where  $w, y, z > 0$ 

Second, then solve for $a, b, c$ using the Doolittle Decomposition.

Finally, solve for $integral_0^3 (a x^2 + (2l + 1) b x + (k + 3) c) " "d x + integral_3^5 ((k + 1) c x^2 + (3l + 2) a x^2 + b) " "d x$ and round your final answer to 4 decimal places.

#pagebreak()


= Remix Solutions

== Problem 1:

First, we must make sure that the matrix is symmetric,

For, $a_21 = a_12$, we have  $ 2 c + 4 = a + b$ (1)

For, $a_31 = a_13$, we have  $ 2 b + a = 1$ (2)

For, $a_32 = a_23$, we have  $ 5 + 3 c + 2 b= c$ (3)

We now have:

$ -a - b + 2c = -4 $

$ a + 2b = 1 $

$ 3b + 2c = -5 $

This gives us coefficient matrix

$A = mat(delim: "[", -1, -1, 2; 1, 2, 0; 0, 3, 2;)$

with solution $x^T = [a, b, c]$

We perform $L U$ decomposition.


$ U: mat(delim: "[", -1, -1, 2; 1, 2, 0; 0, 3, 2;), L: mat(delim: "[", 1, 0, 0; 0, 1, 0; 0, 0, 1;) $

$R_2 -> R_1 + R_2$

$ U: mat(delim: "[", -1, -1, 2; 0, 1, 2; 0, 3, 2;)

L: mat(delim: "[", 1, 0, 0; -1, 1, 0; 0, 0, 1;) $

$R_3 -> -3R_2 + R_3$

$ U: mat(delim: "[", -1, -1, 2; 0, 1, 2; 0, 0, -4;), L: mat(delim: "[", 1, 0, 0; -1, 1, 0; 0, 3, 1;) $

So

$mat(delim: "[", -1, -1, 2; 1, 2, 0; 0, 3, 2;) = (mat(delim: "[", 1, 0, 0; -1, 1, 0; 0, 3, 1;) ) (mat(delim: "[", -1, -1, 2; 0, 1, 2; 0, 0, -4;))$

Now, let's set $A x = b$ as $L U x = b$

$(mat(delim: "[", 1, 0, 0; -1, 1, 0; 0, 3, 1;) ) (mat(delim: "[", -1, -1, 2; 0, 1, 2; 0, 0, -4;)) x = mat(delim: "[", -4; 1; -5;)$

Start with $L y = b$

$mat(delim: "[", 1, 0, 0; -1, 1, 0; 0, 3, 1;) y = mat(delim: "[", -4; 1; -5;)$

$y_1 = -4$

$-y_1 + y_2 = 1$ $-> y_2 = 1 + y_1 = 1 - 4 = -3$

$3y_2 + y_3 = 1$ $-> y_3 = -5 - 3y_2= -5 - 3(-3) = 4$

Now, we solve $U x = y$

$mat(delim: "[", -1, -1, 2; 0, 1, 2; 0, 0, -4;) x = mat(delim: "[", -4; -3; 4;)$

$-4x_3 = 4 -> x_3 = -1$

$x_2 + 2x_3 = -3 -> x_2 = -3 - 2x_3 = -3 - 2(-1) = -3 + 2 = -1$

$-x_1 - x_2 + 2x_3 = -4 -> -x_1 = -4 + x_2 - 2x_3 = -4 + (-1) - 2(-1) = -4 -1 + 2 = -3 -> x_1 = 3$

So, $x^T = [3, -1, -1] = [a, b, c]$

So, $a = 3, b = -1, c = -1$

So, now we substitute these results back into $B$

$B = mat(delim: "[", 2, 3 + (-1), 1; 2 (-1) + 4, d, -4; 2 (-1) + 3, 5+3 (-1) + 3 (-1), 1)$


$B = mat(delim: "[", 2, 3 + (-1), 1; 2 (-1) + 4, d, -1; 2 (-1) + 3, 5+3 (-1) + 3 (-1), 1)$

$B = mat(delim: "[", 2, 2, 1; 2, d, -1; 1, -1, 1)$

Now, we only need to figure out $d$

Now, we perform the Cholesky Decomposition for $B$

Cholesky Algorithm was found in Burden and Faires (2011) pp. 418-419

$l_11 = sqrt(2)$

$l_12 = 2 / sqrt(2) = sqrt(2)$

$l_13 = 1 / sqrt(2) = sqrt(2) / 2$

$l_22 = sqrt(d - (sqrt(2))^2) = sqrt(d - 2)$

$l_23 = (-1 - (1)(2))/ sqrt(d - 2) = (-1 -2)/ sqrt(d^2 - 2) = -3/ sqrt(d - 2)$

$l_33 = sqrt(1 - (sqrt(2) / 2)^2 - (-3 / sqrt(d - 2))^2)$

$l_33 = sqrt(1 / 2 - (9 / (d - 2)))$

So, now we have 2 inequalities:

$ d - 2 > 0 "(1)" $

$ 1 /2 - (9 / (d - 2)) > 0 "(2)" $

By $(1)$, $d > 2$

Now, we multiply both sides in $(2)$ by $2(d - 2)$ since $2 > 0$, $(d - 2) > 0$ so $2 (d - 2) > 0$

$d - 2 - 9(2) > 0$

$d - 2 - 18 > 0$

$d - 20 > 0$

$d > 20$

Therefore, by (2), $d > 20$.

$B = mat(delim: "[", 2, 2, 1; 2, d, -1; 1, -1, 1)$

Note that in the $L D L^t$ decomposition $d_22 = 25$

$d_11 = 2$

$l_21 = 2 / 2 = 1$

$l_31 = 1 / 2 = 1 / 2$

$d_22 = d - (2)(1)(1) = d - 2 = 25$

$d = 27$

$d_32 = (-1 - 2(1/2)(1)) / 25 = (-1 - 1) / 25 = -2/25$

$d_33 = 1 - 2 (1/2)^2 - 25(-2/25)^2 = 1 - 1/2 - 4/25 = 17/50$

So, now, our $L D L^t = mat(delim: "[", 1, 0, 0; 1, 1, 0; 1 / 2, -2/25, 1) mat(delim: "[", 2, 0, 0; 0, 25, 0; 0, 0, 17/50) mat(delim: "[", 1, 1, 1/2; 0, 1, -2/25; 0, 0, 1)$

So, now we solve the system using our $L D L^t$

Let $v = D L^t x$, $w = L^t x$

$L v =mat(delim: "[", 5;26;1)$

$v_1 = 5$

$v_1 + v_2 = 28 -> v_2 = 28 - v_1 = 28-5 = 23$

$1/2 v_1 -2/25 v_2 + v_3 = 1/2 (5) - 2/25(23) + v_3 = 1 -> v_3 = 17/50$

Now, we take $D w = v$

$2w_1 = 5 -> w_1 = 5/2$ 

$25w_2 = 23 -> w_2 = 23/25$

$17/50 w_3 = 17/50 -> w_3 = 1$

Now, we take $L^t x = w$

$L^t x = w$

$x_3 = 1$

$-2/25 x_3 + x_2 = 23/25 -> x_2 = 23/25 + (2/25)(1) = 1$

$x_1 + x_2 + 1/2 x_3 = 5/2 -> x_1 = 5/2 - 1 - 1/2(1) = 1$

$x = [1, 1, 1]^T$

== Problem 2:


We first need to get the equations

$integral_0^3 (a x^2 + (2l + 1) b x + (k + 3) c) " "d x + integral_3^5 ((k + 1) c x^2 + (3l + 2) a x + b) " "d x$

*Continuity:*

We first, get the continuity condition.

$ (a x^3) / 3 +  (2l + 1) (b x^2) / 2 + (k + 3) c x $

$ ((k + 1) c x^3) / 3 +  ((3l + 2) a x^2) / 2 + b x  $

At $x = 3$ for both endpoints:

integral of f:

$ (a (3^3)) / 3 +  (2l + 1) (b (3^2)) / 2 + (k + 3) c (3) $

$ = 9 a +  9 (2l + 1) (b) / 2 + 3 (k + 3) c $

integral of g:

$ ((k + 1) c (3^3)) / 3 +  ((3l + 2) a (3^2)) / 2 + b (3)   $

$ 9(k + 1) c  +  (9(3l + 2) a) / 2 + 3b   $

*Differentiability:*

At $x = 3$ for both endpoints:

$f(3):$

$ a x^2 +  (2l + 1) (b x) + (k + 3) c $

$ = a (3^2) +  (2l + 1) (b (3)) + (k + 3) c $

$ = 9a +  (2l + 1) (3b) + (k + 3) c $

$g(3):$

$  (k + 1) c x^2 + (3l + 2) a x^2 + b $

$ = (k + 1) c (3^2) +  (3l + 2) a (3) + b  $

$ = 9(k + 1) c +  3(3l + 2) a + b  $


Integration

First, estimate the Simpson's $3/8$

Simpson's $3/8$ can be found in Burden and Faires (2011) p. 199.

The first one requires $h = 1$

$integral_0^3 (a x^2 + (2l + 1) b x + (k + 3) c) " "d x  $

$approx 3 / 8 (f(0) + 3f(1) + 3f(2) + f(3))$

$= 3 / 8 ((a (0)^2 + (2l + 1) b (0) + (k + 3)c) + 3(a (1)^2 + (2l + 1) b (1) + (k + 3)c) + 3 ((a (2)^2 + (2l + 1) b (2) + (k + 3)c)) + (a (3)^2 + (2l + 1) b (3) + (k + 3)c))$

$= 3 / 8 ((k + 3)c + 3(a + (2l + 1) b + (k + 3)c) + 3 ((4a + 2(2l + 1) b + (k + 3)c)) + (9 a + 3 (2l + 1) b + (k + 3)c))$

$= 3 / 8 ((k + 3)c + 3a + 3(2l + 1) b + 3(k + 3)c + 12a + 6(2l + 1) b + 3(k + 3)c + (9 a + 3 (2l + 1) b + (k + 3)c))$

$= 3 / 8 (24a + 12(2l + 1) b + 8(k + 3)c)$

$= 9a + 9/ 2(2l + 1) b + 3(k + 3)c$

Second, we estimate the Simpson's $1/3$.

$integral_3^5 ((k + 1) c x^2 + (3l + 2) a x^2 + b) " "d x$

$approx 1 / 3 (f(3) + 4f(4) + f(5))$

$= 1 / 3 (((k + 1) c (3^2) + (3l + 2) a (3) + b) + 4(((k + 1) c (4^2) + (3l + 2) a (4) + b)) + ((k + 1) c (5^2) + (3l + 2) a (5) + b))$

$= 1 / 3 (((k + 1) c (3^2) + (3l + 2) a (3) + b) + 4(((k + 1) c (4^2) + (3l + 2) a (4) + b)) + ((k + 1) c (5^2) + (3l + 2) a (5) + b))$

$= 1 / 3 ((9(k + 1) c  + 3(3l + 2) a + b) + 4((16(k + 1) c + 4(3l + 2) a + b)) + (25(k + 1) c + 5(3l + 2) a  + b))$

$= 1 / 3 ((9(k + 1) c  + 3(3l + 2) a + b) + ((64(k + 1) c + 16(3l + 2) a + 4b)) + (25(k + 1) c + 5(3l + 2) a  + b))$

$= 1 / 3 (98(k + 1) c  + 24(3l + 2) a + 6b)$

$= (98/3(k + 1) c  + 8(3l + 2) a + 2b)$

$(98/3(k + 1) c  + 8(3l + 2) a + 2b) + 9a + 9/ 2(2l + 1) b + 3(k + 3)c = 457$

*Now, let's set all the equations*

Continuity: $9 a +  9 (2l + 1) (b) / 2 + 3 (k + 3) c = 9(k + 1) c  +  (9(3l + 2) a) / 2 + 3b$

Differentiability: $9a +  (2l + 1) (3b) + (k + 3) c  = 9(k + 1) c +  3(3l + 2) a + b$

Integral Condition: $(98/3(k + 1) c  + 8(3l + 2) a + 2b) + 9a + 9/ 2(2l + 1) b + 3(k + 3)c = 457$

*Now, we need to solve for $k, l$*

First, solve for $k, l$ by solving the ff. matrix with $A mat(delim: "[", k; l) = mat(delim: "[", 54; 99)$, $A = L L^T = mat(delim: "[", 9, y; y, 25)$, $L = mat(delim: "[", w, 0; z, 3)$ where  $w, y, z > 0$ 

By Cholesky Algorithm,

Cholesky Algorithm was found in Burden and Faires (2011) pp. 418-419

$l_11 = w = sqrt(a_11) = sqrt(9) = 3$

$l_22 = sqrt(a_22 - (l_21)^2) = sqrt(25 - z^2) = 3$

$25 - z^2 = 9$

$z^2 = 16$

$z = 4$

So, now we have $L = mat(delim: "[", 3, 0; 4, 3), L^T = mat(delim: "[", 3, 4; 0, 3)$

So, now we can solve using $L y = mat(delim: "[", 3, 0; 4, 3) y = mat(delim: "[", 54; 99)$

$3y_1 = 54$

$y_1 = 18$

$4y_1 + 3y_2 = 99 $

$ 3y_2 = 99 - 4y_2 = 99 - 4(18) = 99 - 72 = 27 $

$ y_2 = 9$

Then $L^T x = y$ or $mat(delim: "[", 3, 4; 0, 3) x = mat(delim: "[", 18; 9)$

$3l = 9 $

$ l = 3$

$3k + 4l = 18 $

$3k = 18 - 4l = 18 - 4(3) = 18 - 12 = 6 $

$3k = 6$

$k = 2$

$(k, l) = (2, 3)$

Now let's substitute $k, l$ back into the equation

Continuity: $9 a +  9 (2(3) + 1) (b) / 2 + 3 (2 + 3) c = 9(2 + 1) c  +  (9(3(3) + 2) a) / 2 + 3b$

Differentiability: $9a +  (2(3) + 1) (3b) + (2 + 3) c  = 9(2 + 1) c +  3(3(3) + 2) a + b$

Integral Condition: $(98/3(2 + 1) c  + 8(3(3) + 2) a + 2b) + 9a + 9/ 2(2(3) + 1) b + 3(2 + 3)c = 457$

*Now the equations become,*

Continuity: $9 a +  9 (6 + 1) (b) / 2 + 3 (2 + 3) c = 9(2 + 1) c  +  (9(9 + 2) a) / 2 + 3b$

Differentiability: $9a +  (6 + 1) (3b) + (2 + 3) c  = 9(2 + 1) c +  3(9 + 2) a + b$

Integral Condition: $(98/3(2 + 1) c  + 8(9 + 2) a + 2b) + 9a + 9/ 2(6 + 1) b + 3(2 + 3)c = 457$



Continuity: $9 a +  9 (7)(b) / 2 + 3 (5) c = 9(3) c  +  (9((11) a) / 2 + 3b$

Differentiability: $9a +  (7)(3b) + (5) c  = 9(3) c +  3(11) a + b$

Integral Condition: $(98/3(3) c  + 8(11) a + 2b) + 9a + 9/ 2(7)b + 3(5)c = 457$


#pagebreak()

Continuity: $9 a +  (63b) / 2 + 15 c = 27 c  +  (99 a) / 2 + 3b$

Differentiability: $9a +  (21b) + 5c  = 27 c +  33 a + b$

Integral Condition: $(98 c  + 88 a + 2b) + 9a + (63)/ 2b + 15 c = 457$

Finally,

Continuity: $12 c  +  81 / 2 a- (57) / 2 b = 0$

Differentiability: $24a - 20b + 22c  = 0$

Integral Condition: $(113 c  + 97 a + 67/2 b) = 457$

Now, let's make the matrix:

$mat(delim: "[", 81/2, -57/2, 12; 24, -20, 22; 97, 67/2, 113)$

We now decompose it

$mat(delim: "[", 81/2, -57/2, 12; 24, -20, 22; 97, 67/2, 113), mat(delim: "[", 1, 0, 0; 0, 1, 0; 0, 0, 1)$

$R_2 -> (-16/27)R_1 + R_2$

$R_3 -> (-194/81)R_1 + R_3$

$mat(delim: "[", 81/2, -57/2, 12; 0, -28/9, 134/9; 0, 5495/54, 2275 / 27), mat(delim: "[", 1, 0, 0; 16/27, 1, 0; 194/81, 0, 1)$

$R_3 -> (785/24)R_2 + R_3$


$U = mat(delim: "[", 81/2, -57/2, 12; 0, -28/9, 134/9; 0, 0, 2285/4), L = mat(delim: "[", 1, 0, 0; 16/27, 1, 0; 194/81, -785/24, 1)$

Now, we solve $L y = mat(delim: "[", 0; 0; 457)$.

We have

$y_1 = 0$

$y_2 + 16/27 y_1 = 0$

$y_2 + (16/27)(0) = 0$

$y_2 = 0$

$y_3 + (785/24)y_2 + (194/81)(y_1) = 457$

$y_3 + (785/24)(0) + (194/81)(0) = 457$

$y_3 = 457$

Now, we solve for $U x = mat(delim: "[", 0; 0; 457)$

$U x = mat(delim: "[", 0; 0; 457)$

We have

$(2285/4)x_3 = 457$

$x_3 = 20$

$-28/9 x_2 + 134/9 x_3 = 0$

$-28/9 x_2 + 134/9 (20) = 0$

$x_2 = 2680/9$


$81/2 x_1 -57/2 x_2 + 12x_3 = 0$

$x_1 = 49480/243$

Note that $a, b, c = 49480/243, 2680/9, 20$

Now, that we have finally found $a, b, c, k, l$ we go back to solving the integral.

$integral_0^3 (a x^2 + (2l + 1) b x + (k + 3) c) " "d x + integral_3^5 ((k + 1) c x^2 + (3l + 2) a x + b) " "d x$

$integral_0^3 ((49480/243) x^2 + (2(3) + 1) (2680/9) x + (2 + 3) (20)) " "d x + integral_3^5 ((2 + 1) (20) x^2 + (3(3) + 2) (49480/243) x + 2680/9) " "d x$

$integral_0^3 ((49480/243) x^2 + 7 (2680/9) x + 5 (20)) " "d x + integral_3^5 (3 (20) x^2 + (11 (49480/243) x + 2680/9) " "d x$

$integral_0^3 ((49480/243) x^2 + 7 (2680/9) x + 5 (20)) " "d x + integral_3^5 (3 (20) x^2 + (11 (49480/243) x + 2680/9) " "d x$

We then perform the integration

$ ((49480/243) x^3/3 + 7 (2680/9) x^2/2 + 5 (20)x) _(x = 0)^(x = 3) + (3 (20) x^3/3 + 11 (49480/243) x^2/2 + 2680/9 x) _(x = 3)^(x = 5) $

$ ((49480/243) 3^3/3 + 7 (2680/9) 3^2/2 + 5 (20)3 ) - ((49480/243) 0^3/3 + 7 (2680/9) 0^2/2 + 5 (20)0) $

$ + (3 (20) 5^3/3 + 11 (49480/243) 5^2/2 + 2680/9 (5)) - (3 (20) 3^3/3 + 11 (49480/243) 3^2/2 + 2680/9 (3)) $

$142000/27 - 0 + 31986.8312757199 - 11512.5925925925925 = 25733.4979423866 approx 25733.4979$

Our final answer is $25733.4979$


#pagebreak()


*Reference:*

Burden, R. L., & Faires, J. D. (2011). Numerical analysis (9th ed.). Brooks/Cole, Cengage Learning.

*Appendix*

POTW 0 Item 13 Handwritten Solution

#image("POTW0 - Item 13 Albano.jpg")


