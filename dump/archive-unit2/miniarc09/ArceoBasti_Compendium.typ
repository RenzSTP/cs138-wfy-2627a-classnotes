#import "../assets.typ": qa, note, solution-box, question-box

#set page("a4")
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")

= LE 2 Reviewer, Item 5a & b
#qa(auth:"ARCEO, Jose Sebastian")[Solve the boundary value problem
$
(1+x^2)y'' - 2x y' + 2y = 1
$
with Dirichlet boundary conditions $y(0)=1$ and $y(1)=1$ using the Collocation Method with 2 collocation points. Setup the $4×4$ system and solve it using GE with partial pivoting.

=== a. Monomial basis, Chebyshev points][
Given we have 4 total points, we use a polynomial of degree 3:
$
p_3(x) = a_3x^3 + a_2x^2 + a_1x + a_0\
p_3 ' = 3a_3x^2 + 2a_2x + a_1\
p_3 '' = 6a_3x + 2a_2
$
Find the points using the Chebyshev formula:
$
x_i = 1/2 - 1/2(cos((i pi)/3))
$
$i = 0$:
$
1/2 - 1/2cos(0) &= 1/2 - 1/2\
&= 0\
$
$i = 1$:
$
1/2 - 1/2 cos(pi/3) &= 1/2 - 1/4\ &= 1/4\
$
$i = 2$:
$
1/2 - 1/2 cos((2pi)/3) &= 1/2 - (-1/4)\
&= 3/4
$
$i = 3$:
$
1/2 - 1/2 cos(pi) &= 1/2 - (-1/2)\
&= 1
$
We solve the polynomial at the boundary points.

Left boundary:
$
p_2(0) = 0 a_3 + 0a_2 + 0a_1 +1a_0 = 1
$
Right boundary: 
$
p_2(1) = 1a_3 + 1a_2 + 1a_1 + 1a_0 = 1
$
Then we solve at the interior points. Using the derivatives of the polynomial:
$
(1 + x^2)(6a_3x + 2a_2) - 2x(3a_3x^2 + 2a_2x + a_1) + 2(a_3x^3 + a_2x^2 + a_1x + a_0) = 1\
6a_3x + 2a_2 +2a_3x^3  + 2a_0 = 1\
$
at $i = 1, x = 1/4$:
$
6/4a_3 + 2a_2 + 1/32a_3 + 2a_0 = 1\
49/32a_3 + 2a_2 + 2a_0 = 1\
1.53125a_3 + 2a_2 + 0a_1 + 
$
at $i = 2, x = 3/4$:
$
18/4a_3 + 2a_2 + 27/32a_3 + 2a_0 = 1\
171/32a_3 + 2a_2 + 2a_0 = 1\
5.34375a_3 + 2a_2 + 0a_1 + 2a_0 = 1
$
From this, we are able to construct the matrix:
$
mat(1,0,0,0;2,0,2,1.53125;2,0,2,5.34375;1,1,1,1) mat(a_0;a_1;a_2;a_3) = mat(1;1;1;1)
$
Solving the matrix:
$
"From Eq. 1: "a_0 = 1\
"From Eq. 2: "2a_0 + 2a_2 + 1.53125a_3 = 1\
"From Eq. 3: "2a_0 + 2a_2 + 5.34375a_3 = 1\
"Subtract Eq. 2 from Eq. 3: "3.8125a_3 = 0\
a_3 = 0\
"Substitute into Eq. 2: "2+ 2a_2 = 1\
a_2 = -1/2 = -1/2\
"Substitute into Eq. 4: "1 + a_1 - 1/2 = 1\
a_1 = 1/2\
$
Thus we get the final polynomial:
$
#rect(stroke: 0.5pt)[$-1/2x^2 + 1/2x + 1$]
$
]

#qa(auth:"ARCEO, Jose Sebastian")[
=== b. Gaussian basis ($sigma = 1/3$) with uniform points][
Using the Gaussian basis $Phi_j(x) = e^((-(x-x_j)^2)/(2 sigma^2))$, where $x_j = j/3$ and $sigma = 1/3$, our basis function is:
$
y(x) = a_0e^(-4.5x^2) + a_1 e^(-4.5(x - 1/3)^2) + a_2 e^(-4.5(x - 2/3)^2) + a_3 e^(-4.5(x - 1)^2)\
y'(x) = -9x a_0e^(-4.5x^2) -9(x - 1/3)a_1e^(-4.5(x - 1/3)^2)-\
9(x - 2/3)a_2e^(-4.5(x - 2/3)^2) -9(x - 1)a_3e^(-4.5(x - 1)^2)\
y'' = 81x^2a_0e^(-4.5x^2) - 9a_0e^(-4.5x^2) + 81(x-1/3)^2a_1e^(-4.5(x - 1/3)^2) - 9a_1e^(-4.5(x - 1/3)^2) + \
81(x-2/3)^2a_2e^(-4.5(x - 2/3)^2) - 9a_2e^(-4.5(x - 2/3)^2) + 81(x-1)^2a_3e^(-4.5(x - 1)^2) - 9a_3e^(-4.5(x - 1)^2)\
$
We know the uniform points at $i = 0,1,2,3$ are calculated as $x_i = i/3$. We solve first at the boundary conditions.

Left boundary:
$
y(0) = a_0 + a_1e^(-4.5(1/9)) + a_2e^(-4.5(4/9)) + a_3e^(-4.5) = 1\
a_0 + 0.60653a_1 + 0.13533a_2 + 0.01111a_3 = 1
$

Right boundary:
$
y(1) = a_0e^(-4.5) + a_1e^(-4.5(4/9)) + a_2e^(-4.5(1/9)) + a_3 = 1\
0.01111a_0 + 0.13533a_1 + 0.60653a_2 + a_3 = 1
$

Now, we solve at the interior points.

at $i = 1, x_i = 1/3$:
$
y''(1/3) = 9a_0e^(-1/2) - 9a_0e^(-1/2) - 9a_1 + 9a_2e^(-1/2) - 9a_2e^(-1/2) + 36a_3e^(-2) - 9a_3e^(-2)\
y''(1/3) = 27a_3e^(-2) - 9a_1\
y'(1/3) = -3a_0e^(-1/2) + 3a_2e^(-1/2) + 6a_3e^(-2)\
y(1/3) = a_0e^(-1/2) + a_1 + a_2e^(-1/2) + a_3e^(-2)\
(1+x^2)y'' -2x y'+2 y = 1\
10/9(27a_3e^(-2) - 9a_1) - 2/3(-3a_0e^(-1/2) + 3a_2e^(-1/2) + 6a_3e^(-2)) + 2(a_0e^(-1/2) + a_1 + a_2e^(-1/2) + a_3e^(-2)) = 1\
30a_3e^(-2 ) - 10a_1 + 2a_0e^(-1/2) - 2a_2e^(-1/2) - 4a_3e^(-2) + 2a_0e^(-1/2) + 2a_1 + 2a_2e^(-1/2) + 2a_3e^(-2) = 1\
28a_3e^(-2) -8a_1 + 4a_0e^(-1/2) = 1\
3.78939a_3 - 8a_1 + 2.42612a_0 = 1
$
at $i = 2, x_i = 2/3$:
$
y''(2/3) = 36a_0e^(-2) - 9a_0e^(-2) + 9a_1e^(-1/2) - 9a_1e^(-1/2) - 9a_2 + 9a_3e^(-1/2) - 9a_3e^(-1/2)\
y''(2/3) = 27a_0e^(-2) - 9a_2\
y'(2/3) = -6a_0e^(-2) - 3a_1e^(-1/2) + 3a_3e^(-1/2)\
y(2/3) = a_0e^(-2) + a_1e^(-1/2) + a_2 + a_3e^(-1/2)\
(1+x^2)y'' -2x y'+2 y = 1\
13/9(27a_0e^(-2) - 9a_2) - 4/3(-6a_0e^(-2) - 3a_1e^(-1/2) + 3a_3e^(-1/2)) + 2(a_0e^(-2) + a_1e^(-1/2) + a_2 + a_3e^(-1/2)) = 1\
39a_0e^(-2) - 13a_2 +8a_0e^(-2)+4a_1e^(-1/2) - 4a_3e^(-1/2) + 2a_0e^(-2) + 2a_1e^(-1/2) + 2a_2 + 2a_3e^(-1/2) = 1\
-2a_3e^(-1/2) -11a_2 + 6a_1e^(-1/2) + 49a_0e^(-2) = 1\
-1.21306a_3 - 11a_2 + 3.63918a_1 + 6.63143a_0 = 1\
$
From these, we derive the SLE:
$
#rect(stroke: 0.5pt)[$mat(1,0.60653,0.13533,0.01111;2.42612,-8,0,3.78939;6.63143,3.63918,-11,-1.21306;0.01111,0.13533,0.60653,1) mat(a_0;a_1;a_2;a_3) = mat(1;1;1;1)$]
$
]
#pagebreak()
= Remixed Problem
== Based on LE2 Reviewer, Item 5
#question-box()[
Solve the boundary value problem
$
(1+x^2)y'' - 2x y' + 2y = 1
$
with Dirichlet boundary conditions $y(0)=1$ and $y(1)=1$ using the Collocation Method with 2 collocation points. Use the multiquadratic basis $Phi_j (x) = sqrt((x - x_j)^2 + sigma^2)$ with $sigma = 1/3, x_j = j/3$, and using uniform points $x_i$. Setup the $4×4$ system and solve it using GE with partial pivoting.
]