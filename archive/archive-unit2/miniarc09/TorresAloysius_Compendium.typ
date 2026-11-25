#set page("a4", numbering: "1")
#set text(size: 12pt)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")

#let Coll = $"Coll"$
#let Ld = $cal(L)$
#let Fv = $upright(bold(F))$
#let av = $upright(bold(a))$
#let bv = $upright(bold(b))$
#let ddx = $dif / (dif x)$
#let d2dx = $dif^2 / (dif^2 x)$

#let solbox(body) = align(center)[#block(
  stroke: 0.5pt,
  inset: 20pt,
  width: 90%,

  )[
    #set text(size: 12pt)
    #set align(left)
  #body
]]

= LE 2 Question (slightly remixed)
Consider the linear, second-order IVP
$
y'' + y = x
$

with initial conditions
$
y(0) = 0, y'(0) = 0
$
defined on $0 <= x <= 1$.

This IVP has the analytical solution $y = x - sin x$.

Solve the equation via the _collocation_ method with 3
collocation points. Use a monomial basis with uniform
points.

== Solution
We have $n = 3$ collocation points. Thus, the step size is
$
h = (beta - alpha) / (n + 1) = (1 - 0)/(3 + 1)
  = 1 / 4
$
with corresponding uniform collocation points
$
x_i = i h," "i = 1, 2, 3
\ => x = 1/4, 2/4, 3/4
$

The basis functions are the monomial basis functions, that
is:
$
Phi_j (x_i) = (x_i)^j
$
such that we have the interpolating function:
$
Coll(x_i) &= sum_(j = 0)^n a_j Phi_j (x_i)
\ &= a_0 + a_1 x_i + a_2 (x_i)^2 + a_3 (x_i)^3 + a_4 (x_i)^4
$
since we have a total of $n + 2$ conditions to satisfy
(3 collocation points, 2 boundary points).

Looking at the left-hand side of the ODE as a linear operator,
we have:
$
Ld[y] &= y'' + y
\ &= dif^2 / (dif x^2) y + y
$

#pagebreak()
Applying this to to each basis function $Phi_j (x)$, we get:
$
Ld[Phi_0(x)]   &= Ld[x^0]
               &&= dif^2 / (dif x^2) x^0 + x^0
               &&= 0 + 1 &&= 1
\ Ld[Phi_1(x)] &= Ld[x^1]
               &&= dif^2 / (dif x^2) x^1 + x^1
               &&= 0 + x &&= x
\ Ld[Phi_2(x)] &= Ld[x^2]
               &&= dif^2 / (dif x^2) x^2 + x^2
               &&= 2 dot 1 + x^2 &&= 2 + x^2
\ Ld[Phi_3(x)] &= Ld[x^3]
               &&= dif^2 / (dif x^2) x^3 + x^3
               &&= 3 dot 2 dot x^(3-2) + x^3
               &&= 6x + x^3
\ Ld[Phi_4(x)] &= Ld[x^4]
               &&= dif^2 / (dif x^2) x^4 + x^4
               &&= 4 dot 3 dot x^(4-2) + x^4
               &&= 12x^2 + x^4
$
by linearity.

The original ODE then gives us:
$
& y'' + y = x
\ &=> Ld[y] = x
\ &=> Ld[Coll(x_i)] = x_i
$


The boundary conditions are simply expressed as:
$
&& y(0) &= 0
\ && Coll(0) &= 0
$
and
$
&& y'(0) &= 0
\ && (dif / (dif x) Coll)(0) &= 0
\ && (
    ddx Phi_0 (x) + ddx Phi_1 (x) + ddx Phi_2 (x)
    ddx Phi_3 (x) + ddx Phi_4 (x)
  )(0) &= 0
$
by linearity of the differential operator.

Thus, we get the following matrix:
$
A av = bv
\ => 
mat(
"BC1":,
  Phi_0 (x_0), Phi_1 (x_0), Phi_2 (x_0),
  Phi_3 (x_0), Phi_4 (x_0);
  
"BC2":,
  ddx(Phi_0 (x_4)), ddx (Phi_1 (x_4)), ddx (Phi_2 (x_4)),
  ddx(Phi_3 (x_4)), ddx (Phi_4 (x_4));
  
"Coll"_1:,
  Ld[Phi_0 (x_1)], Ld[Phi_1 (x_1)], Ld[Phi_2 (x_1)],
  Ld[Phi_3 (x_1)], Ld[Phi_4 (x_1)];
  
"Coll"_2:,
  Ld[Phi_0 (x_2)], Ld[Phi_1 (x_2)], Ld[Phi_2 (x_2)],
  Ld[Phi_3 (x_2)], Ld[Phi_4 (x_2)];
  
"Coll"_3:,
  Ld[Phi_0 (x_3)], Ld[Phi_1 (x_3)], Ld[Phi_2 (x_3)],
  Ld[Phi_3 (x_3)], Ld[Phi_4 (x_3)];

)
mat(a_0 ; a_1 ; a_2; a_3; a_4)
= mat(0; 0; x_1; x_2; x_3)
$

#pagebreak()
Applying $Phi_j (x_i) = (x_i)^j$, the linear operator $Ld$,
and the differential operator $ddx$, we get:
$
mat(
  1, x_0, (x_0)^2, (x_0)^3, (x_0)^4;
  
  0, 1, 2(x_0), 3(x_0)^2, 4(x_0)^3;
  
  1, x_1, 2 + (x_1)^2, 6x_1 + (x_1)^3,
  12(x_1)^2 + (x_1)^4;
  
  1, x_2, 2 + (x_2)^2, 6x_2 + (x_2)^3,
  12(x_2)^2 + (x_2)^4;
  
  1, x_3, 2 + (x_3)^2, 6x_3 + (x_3)^3,
  12(x_3)^2 + (x_3)^4;
)
mat(a_0 ; a_1 ; a_2; a_3; a_4)
= mat(0; 0; x_1; x_2; x_3)
$

Evaluating with $x_i = i h$, we have:
$
mat(
  1, 0, (0)^2, (0)^3, (0)^4;
  
  0, 1, 2(0), 3(0)^2, 4(0)^3;
  
  1, 1/4, 2 + (1/4)^2, 6(1/4) + (1/4)^3,
  12(1/4)^2 + (1/4)^4;
  
  1, 2/4, 2 + (2/4)^2, 6(2/4) + (2/4)^3,
  12(2/4)^2 + (2/4)^4;
  
  1, 3/4, 2 + (3/4)^2, 6(3/4) + (3/4)^3,
  12(3/4)^2 + (3/4)^4;
)
mat(a_0 ; a_1 ; a_2; a_3; a_4)
= mat(0; 0; 1/4; 2/4; 3/4)
$

Simplifying, we have:
$
mat(
  1, 0, 0, 0, 0;
  0, 1, 0, 0, 0;
  1, 1/4, 33/16, 97/64, 193/256;
  1, 1/2, 9/4, 25/8, 49/16;
  1, 3/4, 41/16, 315/64, 1809/256;
)
mat(a_0 ; a_1 ; a_2; a_3; a_4)
= mat(0; 0; 1/4; 2/4; 3/4)
$

You may solve this system either via LU decomposition
or by directly inverting the matrix.

We will skip the algebra, but it can be shown that:
$
A^(-1) =
mat(
  1.0       , -0.0       ,  0.0     ,  0.0    , -0.0;
  0.0       ,  1.0       ,  0.0     ,  0.0    , -0.0;
 -0.502858  ,  0.00726009,  1.53545 , -1.53328,  0.500692;
  0.00641776, -0.184724  , -1.76381 ,  2.76948, -1.01208;
  0.0363673 ,  0.019895  ,  0.671725, -1.37297,  0.664879;
)
$

and thus:
$
av &= A^(-1) bv
\  &= mat(
  0.0;
  0.0;
 -0.007260086238593274;
  0.1847244041849113;
 -0.019895042952167524;
) = mat(a_0 ; a_1 ; a_2; a_3; a_4)
$

#pagebreak()
The final answer, with each coefficient rounded to 4 significant figures, is:

#solbox[
$
y(x) approx Coll(x)
 = -0.007260 x^2 + 0.1847 x^3 - 0.01990 x^4
$
]

We can compare the values of the analytical solution and the collocation
method's approximation up to 4 significant figures:
#table(
  columns: 4,
  [$x$], [$y(x) = x - sin x$], [$Coll(x)$], [Absolute error],
  [$0$], [$0$], [$0$], [$0$],
  [$1/4$], [$0.002596$], [$0.002355$], [$0.0002412$],
  [$2/4$], [$0.02057$], [$0.02003$], [$0.0005424$],
  [$3/4$], [$0.06836$], [$0.06755$], [$0.0008093$],
  [$1$], [$0.1585$], [$0.1576$], [$0.0009597$],
)

== Remix
Solve the same problem, but using Gaussian radial basis
functions and Chebyshev points.

Compare the accuracy of your solution with the monomial
basis functions, as well as to the analytical solution.

#pagebreak()
= Scientific Computing (Heath), p. 444 Computer Problems 10.2, adapted
Consider the nonlinear, two-point BVP
$
u'' = -(1 + e^u)
$
with boundary conditions
$
u(0) = 0, u(1) = 1
$
such that the BVP is defined on $t = [0, 1]$.

Using the method of collocation with 3 uniform points
and monomial basis functions, explicitly write the nonlinear
system $Fv(av) = bv$ where
$av = mat(a_0, a_1, a_2, a_3, a_4)^top$.


== Solution

We have $n = 3$ collocation points. Thus, the step size is
$
h = (beta - alpha) / (n + 1) = (1 - 0)/(3 + 1)
  = 1/4
$
with corresponding uniform collocation points
$
t_i = i h, " " i = 1, 2, 3
\ => t = 1/4, 2/4, 3/4
$

The basis functions are the monomial basis functions, that is:
$
Phi_j(t_i) = (t_i)^j
$
such that we have the approximating function:
$
Coll(t) &= sum_(j = 0)^4 a_j Phi_j(t)
\ &= a_0 + a_1 t + a_2 t^2 + a_3 t^3 + a_4 t^4
$
since we have a total of $n + 2 = 5$ conditions to satisfy
(3 collocation points, 2 boundary points).

Recall that the BVP is nonlinear. Thus, we define
the nonlinear differential operator $cal(N)$ as:
$
cal(N)[u] = u'' + e^u
$
such that the original ODE becomes
$
&& u'' &= -(1 + e^u)
\ && u'' &= -1 - e^u
\ && u'' + e^u &= -1
\ && cal(N)[u] &= -1
$

Unlike the linear case, we cannot simply apply $cal(N)$ to
each basis function separately and sum the results. Thus, we
must substitute the entire definition of the interpolating
function $Coll(t)$ into the differential equation.

Differentiating twice, we obtain:
$
d2dx Coll(t) = 2a_2 + 6a_3 t + 12a_4 t^2
$

Thus, we have:
$
cal(N)[Coll(t)]
&= d2dx Coll(t) + e^(Coll(t))
\ &= 2a_2 + 6a_3 t + 12a_4 t^2
  + e^(a_0 + a_1 t + a_2 t^2 + a_3 t^3 + a_4 t^4).
$

At the collocation points, we require
$
cal(N)[Coll(t_i)] = -1,
quad i = 1, 2, 3.
$

The boundary conditions are simply expressed as:
$
u(0) &= 0
\ Coll(0) &= 0
\ a_0 + a_1(0) + a_2(0)^2 + a_3(0)^3 + a_4(0)^4 &= 0
\ a_0 + 0 + 0 + 0 + 0 &= 0
\ a_0 &= 0
$
and
$
u(1) &= 1
\ Coll(1) &= 1
\ a_0 + a_1(1) + a_2(1)^2 + a_3(1)^3 + a_4(1)^4 &= 1
\ a_0 + a_1 + a_2 + a_3 + a_4 &= 1.
$

Since $a_0 = 0$ from the first boundary condition,
the second boundary condition simplifies to
$
a_1 + a_2 + a_3 + a_4 = 1.
$

Thus, we obtain a system of five nonlinear equations
for the five unknown coefficients.

Writing the system as $Fv(av) = bv$, where
$
av = mat(a_0; a_1; a_2; a_3; a_4)
$

#pagebreak()
we have:
$
Fv(av) = bv
\ =>
mat(
  "BC"_1:,
  a_0;

  "Coll"_1:,
  2a_2 + 6a_3 t_1 + 12a_4 t_1^2 + e^(Coll(t_1));

  "Coll"_2:,
  2a_2 + 6a_3 t_2 + 12a_4 t_2^2 + e^(Coll(t_2));

  "Coll"_3:,
  2a_2 + 6a_3 t_3 + 12a_4 t_3^2 + e^(Coll(t_3));
  
  "BC"_2:,
  a_0 + a_1 + a_2 + a_3 + a_4;
)
= mat(0; -1; -1; -1; 1)
$


Evaluating with $t_i = i h$, $Fv(av)$ becomes:
$
mat(
  a_0;

  2a_2 + 6a_3(1/4) + 12a_4(1/4)^2
  + e^(a_0 + a_1(1/4) + a_2(1/4)^2
  + a_3(1/4)^3 + a_4(1/4)^4);

  2a_2 + 6a_3(2/4) + 12a_4(2/4)^2
  + e^(a_0 + a_1(2/4) + a_2(2/4)^2
  + a_3(2/4)^3 + a_4(2/4)^4);

  2a_2 + 6a_3(3/4) + 12a_4(3/4)^2
  + e^(a_0 + a_1(3/4) + a_2(3/4)^2
  + a_3(3/4)^3 + a_4(3/4)^4);
  
  a_0 + a_1 + a_2 + a_3 + a_4;
)
$

Simplifying, we have:
$
mat(
  a_0;

  2a_2 + 6/4 a_3 + 12/16 a_4
  + e^(a_0 + 1/4 a_1 + 1/16 a_2 + 1/64 a_3 + 1/256 a_4);

  2a_2 + 12/4 a_3 + 48/16 a_4
  + e^(a_0 + 2/4 a_1 + 4/16 a_2
  + 8/64 a_3 + 16/256 a_4);

  2a_2 + 18/4 a_3 + 108/16 a_4
  + e^(a_0 + 3/4 a_1 + 9/16 a_2
  + 27/64 a_3 + 81/256 a_4);
  
  a_0 + a_1 + a_2 + a_3 + a_4;
)
$


Further simplifying the fractions, we obtain the final
nonlinear system $Fv(av) = bv$:

#solbox[
$
Fv(av) =
mat(
  a_0;

  2a_2 + 3/2 a_3 + 3/4 a_4
  + e^(a_0 + 1/4 a_1 + 1/16 a_2 + 1/64 a_3 + 1/256 a_4);

  2a_2 + 3a_3 + 3a_4
  + e^(a_0 + 1/2 a_1 + 1/4 a_2 + 1/8 a_3 + 1/16 a_4);

  2a_2 + 9/2 a_3 + 27/4 a_4
  + e^(a_0 + 3/4 a_1 + 9/16 a_2
  + 27/64 a_3 + 81/256 a_4);
  
  a_0 + a_1 + a_2 + a_3 + a_4;
)
= mat(0; -1; -1; -1; 1)
= bv
$
]

Unlike the linear collocation problem, this system cannot be
solved directly by inverting the matrix or by LU decomposition.

== Remix
Solve the problem via Newton linearization. Explicitly
write the Jacobian $J_F$ of the system.