#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#set math.mat(delim: "[")

#show: notes.with(
  title: [Power Method],
  subtitle: [ Arc 4  · Reyes Remix Problem],
)

= Problem 1

*Exercise Set 9.3, No. 1(c) — Burden & Faires*. Find the first three iterations obtained by the Power Method applied to 
$A = mat(1, -1, 0; -2, 4, -2; 0, -1, 2)$ using $x^((0)) = mat(-1; 2; 1)$.

== Solution

Using the Power Method, we first normalize the initial vector using the component with the largest absolute value of $x^((0))$ is $max(|-1|, |2|, |1|) = 2$.

Therefore, $ x^((0)) = frac(1, 2) mat(-1; 2; 1) = mat(-1/2; 1; 1/2) $

The second component will now be used as the pivot component.

#underline[=== Iteration 1
]

We first compute for $y^((1)) = A x^((0))$.

Thus, $ y^((1)) = mat(1, -1, 0; -2, 4, -2; 0, -1, 2) mat(-1/2; 1; 1/2) = mat(-3/2; 4; 0) $

The eigenvalue approximation is obtained from the pivot component: $lambda^((1)) = 4$.

Since the largest absolute component of $y^((1))$ is $4$, we normalize the vector by means of dividing by $4$.

$ x^((1)) = frac(1, 4) mat(-3/2; 4; 0) = mat(-3/8; 1; 0) $

Thus, we note that $lambda^((1)) = 4$ and $x^((1)) = mat(-0.375; 1; 0)$.

#underline[=== Iteration 2
]
Now we compute for $y^((2)) = A x^((1))$ where:

 $ y^((2)) = mat(1, -1, 0; -2, 4, -2; 0, -1, 2) mat(-3/8; 1; 0) = mat(-11/8; 19/4; -1) $

The largest absolute component here is $19/4$, so we let $lambda^((2)) = frac(19, 4) = 4.75$.

Next, we normalize the vector:

$ x^((2)) = frac(4, 19) mat(-11/8; 19/4; -1) = mat(-11/38; 1; -4/19) $

Thus, we note from here that $lambda^((2)) = 4.75$ and $x^((2)) approx mat(-0.2894737; 1; -0.2105263)$.

#underline[=== Iteration 3
]
Now we compute for $y^((3)) = A x^((2))$ where:

$ y^((3)) = mat(1, -1, 0; -2, 4, -2; 0, -1, 2) mat(-11/38; 1; -4/19) = mat(-49/38; 5; -27/19) $

The largest absolute component of $y^((3))$ is $5$. Thus, we let $lambda^((3)) = 5$. Then we normalize the vector again:

$ x^((3)) = frac(1, 5) mat(-49/38; 5; -27/19) = mat(-49/190; 1; -27/95) $

Therefore, after three iterations, we get $lambda^((3)) = 5$ and $x^((3)) approx mat(-0.2578947; 1; -0.2842105)$.

== Final Answer
Overall, after three iterations, the Power Method gives the approximate dominant eigenvalue $lambda approx 5$, with corresponding approximate eigenvector $x approx mat(-0.2578947; 1; -0.2842105)$. The successive eigenvalue estimates $4, 4.75, 5$ show that the iteration is gradually converging toward the dominant eigenvalue.


#pagebreak()
= Problem 2

*Exercise Set 9.3, No. 3(a) — Burden & Faires*. Answer Exercise 1(a) using the Inverse Power Method. Thus, apply the first three iterations of the Inverse Power Method to
$A = mat(2, 1, 1; 1, 2, 1; 1, 1, 2)$ using $x^((0)) = mat(1; -1; 2)$.

== Solution

Using the Inverse Power Method, we first get an initial eigenvalue approximation using the Rayleigh quotient, following the notation used in the lecture:

$
lambda^* = frac((x^((0)))^T A x^((0)), (x^((0)))^T x^((0))).
$

We then compute for:

$
A x^((0)) = mat(2, 1, 1; 1, 2, 1; 1, 1, 2) mat(1; -1; 2) = mat(3; 1; 4).
$

This gives us:

$
lambda^* = frac(mat(1, -1, 2) mat(3; 1; 4), mat(1, -1, 2) mat(1; -1; 2)) = frac(10, 6) = frac(5, 3).
$

We use the Rayleigh quotient approximation as the shift for the Inverse Power Method: $q = lambda^* = frac(5, 3).$

We now normalize the initial vector using the component with the largest absolute value. Since the largest absolute component of $x^((0))$ is $2$, we divide it by 2:

$
x^((0)) = frac(1, 2) mat(1; -1; 2) = mat(1/2; -1/2; 1).
$

We will then use the third component as the pivot component.
For each iteration, we solve the system $(A - q I)y^((k)) = x^((k-1))$.

#underline[=== Iteration 1
]

We first form the shifted matrix as:

$
A - q I = mat(2, 1, 1; 1, 2, 1; 1, 1, 2) - frac(5, 3) I.
$


$
A - q I = mat(1/3, 1, 1; 1, 1/3, 1; 1, 1, 1/3).
$

We then solve $(A - q I)y^((1)) = x^((0))$ which gives us:

$
mat(1/3, 1, 1; 1, 1/3, 1; 1, 1, 1/3) y^((1)) = mat(1/2; -1/2; 1).
$


$
y^((1)) = mat(-3/28; 39/28; -6/7).
$

Using the third pivot component, the eigenvalue approximation becomes $lambda^((1)) = q + frac(1, -6/7).$

Thus,

$
lambda^((1)) = frac(5, 3) - frac(7, 6) = frac(1, 2) = 0.5.
$

Since the largest absolute component of $y^((1))$ is $39/28$, we let the second component become the new pivot component. We normalize the vector now by dividing it by $39/28$:

$
x^((1)) = frac(28, 39) mat(-3/28; 39/28; -6/7) = mat(-1/13; 1; -8/13).
$

Therefore, after the first iteration, we get $lambda^((1)) = 0.5$ and $x^((1)) = mat(-1/13; 1; -8/13)$.

#underline[=== Iteration 2
]

We now solve for $y^((2))$ using $(A - q I)y^((2)) = x^((1)):$

$
mat(1/3, 1, 1; 1, 1/3, 1; 1, 1, 1/3) y^((2)) = mat(-1/13; 1; -8/13).
$


$
y^((2)) = mat(57/182; -237/182; 102/91).
$

Using the second pivot component, the eigenvalue approximation becomes $lambda^((2)) = q + frac(1, -237/182).$

Thus,

$
lambda^((2)) = frac(5, 3) - frac(182, 237) = frac(71, 79) approx 0.8987342.
$

Since the largest absolute component of $y^((2))$ is $237/182$, we let the second component remain as the pivot component. Now we normalize the vector:

$
x^((2)) = frac(-182, 237) mat(57/182; -237/182; 102/91) = mat(-19/79; 1; -68/79).
$

Therefore, after the second iteration, we get $lambda^((2)) approx 0.8987342$ and $x^((2)) = mat(-19/79; 1; -68/79)$.

#underline[=== Iteration 3
]

Now we solve for $y^((3))$ using $(A - q I)y^((3)) = x^((2)):$

$
mat(1/3, 1, 1; 1, 1/3, 1; 1, 1, 1/3) y^((3)) = mat(-19/79; 1; -68/79).
$

$
y^((3)) = mat(327/1106; -1731/1106; 678/553).
$

Using the second pivot component, the eigenvalue approximation becomes
$lambda^((3)) = q + frac(1, -1731/1106).$

Thus,

$
lambda^((3)) = frac(5, 3) - frac(1106, 1731) = frac(593, 577) approx 1.027730.
$

Since the largest absolute component of $y^((3))$ is $1731/1106$, we let the second component remain as the pivot component. We now normalize the vector again:

$
x^((3)) = frac(-1106, 1731) mat(327/1106; -1731/1106; 678/553) = mat(-109/577; 1; -452/577).
$
$
x^((3)) approx mat(-0.1889082; 1; -0.7833622).
$

Therefore, after three iterations, we get $lambda^((3)) approx 1.027730$ and $x^((3)) approx mat(-0.1889082; 1; -0.7833622)$.

== Final Answer

Overall, the initial Rayleigh quotient gives $lambda^* = frac(5, 3)$, which is used as the shift in the Inverse Power Method. After three iterations, the method gives the approximate eigenvalue $lambda approx 1.027730$, with corresponding approximate eigenvector $x approx mat(-0.1889082; 1; -0.7833622)$.

As a result, we can conclude that the  eigenvalue estimates $0.5, 0.8987342, 1.027730$ show that the iterations are gradually approaching the eigenvalue targeted by the Inverse Power Method.


#pagebreak()
= Remix Problem

Consider the symmetric matrix
$A = mat(
  3, 2, 0;
  2, 3, 0;
  0, 0, 2
)
$ with an initial vector $x^((0)) = mat(
  1;
  1/2;
  1
).
$

First, perform one iteration of the Power Method to obtain a rough approximation of the dominant eigenvalue. Then, use this approximation as the shift $sigma$ for one iteration of the Inverse Power Method. Determine the improved eigenvalue approximation and its corresponding eigenvector.

== Solution

#underline[=== Step 1: One Iteration of the Power Method
]

\
Starting with the given $x^((0)) = mat(1; 1/2; 1)$, we compute for $y^((1))$:

$
y^((1)) = A x^((0)).
$

Substituting the given, we have:

$
y^((1)) = mat(3, 2, 0; 2, 3, 0; 0, 0, 2) mat(1; 1/2; 1) = mat(4; 7/2; 2).
$

The largest absolute component of $y^((1))$ is $4$, so we let $lambda^((1)) = 4$. With this, we normalize the vector by dividing it by $4$:

$
x^((1)) = frac(1, 4) mat(4; 7/2; 2) = mat(1; 7/8; 1/2).
$

From here, the first iteration of the Power Method gives us $lambda^((1)) = 4$ which we will use as the shift for the Inverse Power Method:

$
sigma = lambda^((1)) = 4.
$

#underline[=== Step 2: Inverse Power Method with a Shift
]

\
Using $sigma = 4$, we form the shifted matrix as
$A - sigma I = A - 4I$:

$
A - 4I = mat(
  -1, 2, 0;
  2, -1, 0;
  0, 0, -2
).
$

We solve one iteration of the Inverse Power Method using $(A - 4I) v^((1)) = x^((1))$:

$
mat(-1, 2, 0; 2, -1, 0; 0, 0, -2)
mat(v_1; v_2; v_3)
=
mat(1; 7/8; 1/2).
$

This gives us the following system of equations:

$
-v_1 + 2v_2 = 1,
$

$
2v_1 - v_2 = 7/8,
$

$
-2v_3 = 1/2.
$

From the third equation, we get $v_3 = -1/4$.

Solving the first two equations gives $v_2 = 23/24$ and $v_1 = 11/12$.

Therefore,

$
v^((1)) = mat(11/12; 23/24; -1/4).
$

#underline[=== Step 3: Normalizing the Vector
]

\
Using the 2-norm,

$
||v^((1))||_2 = sqrt((11/12)^2 + (23/24)^2 + (-1/4)^2).
$

Thus,

$
||v^((1))||_2 = frac(sqrt(1049), 24).
$

The normalized vector is then

$
z^((1)) = frac(v^((1)), ||v^((1))||_2).
$

which gives us:

$
z^((1)) = frac(1, sqrt(1049)) mat(22; 23; -6).
$

Approximately,

$
z^((1)) approx mat(0.6792; 0.7101; -0.1852).
$

#underline[=== Step 4: Determining the Improved Eigenvalue Approximation
]

\
To obtain an improved approximation of the eigenvalue, we use the Rayleigh quotient:

$
lambda approx frac((z^((1)))^T A z^((1)), (z^((1)))^T z^((1))).
$

Since $z^((1))$ is already normalized:

$
lambda approx (z^((1)))^T A z^((1)).
$

Substituting the resulting vector gives us the approximation:

$
lambda approx frac(5135, 1049) approx 4.8951.
$

Thus, using the Power Method estimate as the shift in the Inverse Power Method improves the initial estimate from $lambda^((1)) = 4$ to $lambda approx 4.8951$.

The corresponding approximate eigenvector is $x approx mat(0.6792; 0.7101; -0.1852)$.

== Final Answer

The Power Method was first used to obtain the rough eigenvalue approximation $lambda^((1)) = 4$. We then used this value as the shift $sigma = 4$ when applying the Inverse Power Method.

After one inverse iteration using this shift, the improved eigenvalue approximation becomes $lambda approx 4.8951$,

with the corresponding approximate eigenvector $x approx mat(0.6792; 0.7101; -0.1852)$.

Considering that the exact dominant eigenvalue of the matrix is $5$, the new estimate is much closer to the desired eigenvalue than the original Power Method estimate of $4$.

Ultimately, this remix connects the two original problems by using the eigenvalue approximation produced by the Power Method as the shift for the Inverse Power Method.
\
\
= References
1. Burden, R. L. & Faires, J. D. (1978). _Numerical Analysis_.
