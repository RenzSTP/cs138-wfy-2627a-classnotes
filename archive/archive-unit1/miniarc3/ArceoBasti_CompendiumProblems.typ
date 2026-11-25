#set math.mat(delim: "[")

#let xv = $bold(upright(x))$
#let bv = $bold(upright(b))$
#let zv = $bold(upright(z))$
#let xvd = $bold(upright(dot(x)))$

= Problem 11, Problem Set 2.3, Numerical Methods in Engineering with MATLAB (Kiusalaas), p. 95

_Use the Gauss-Seidel method to solve_
$
mat(-2, 5, 9; 7, 1, 1; -3, 7, -1) mat(x_1; x_2; x_3) = mat(1; 6; -26)
$
We can first set up the system of equations for the Gauss-Seidel iteration. Initially, the matrix must first be rearranged to become strictly diagonally dominant. Looking at the largest coefficients for each variable and ordering them accordingly, we get:
$
mat(7,1,1;-3,7,-1;-2,5,9) mat(x_1; x_2; x_3) = mat(6;-26;1)
$
From this setup, we derive the system of equations:
$
7 x_1 + x_2 + x_3 = 6\
-3 x_1 + 7 x_2 - x_3 = -26\
-2 x_1 + 5 x_2 + 9 x_3 = 1\
$

We rearrange each equation to isolate the variables. By the Gauss-Seidel method:
$
x_1 ^((k + 1)) = (6 - x_2^((k)) - x_3^((k)))/7\
x_2 ^((k + 1)) = (-26 + 3x_1^((k+1)) + x_3^((k)))/7\
x_3 ^((k + 1)) = (1 + 2 x_1^((k+1)) - 5 x_2^((k+1)))/9\
$

Now that the system of equations is derived, we can now begin iteration with an initial value 
$
xv ^((0)) = mat(0;0;0)
$
=== Iteration 1:
We first input the initial values into the first equation:
$
x_1 ^((k + 1)) &= (6 - 0 - 0)/7\
&= 6/7
$
We input the value of $xv ^((1))$ into the following equation:
$
x_2 ^((k + 1)) &= (-26 + 3(6/7) + 0)/7\
&= (-182/7 + 18/7)(1/7)\
&= -164/49
$
Then, we input the previously found values into the last equation:
$
x_3 ^((k + 1)) &= (1 + 2 (6/7) - 5 (-164/49))/9\
&= 1/9 (49/49 + 84/49 + 820/49)\
&= 1/9(953/49)\
&= 953/441
$

Thus, after the first iteration, we get 
$
xv ^((1)) = mat(6/7;-164/49;953/441)
$

Alternatively, the problem could be solved by finding the iterative matrix $T_(G S) = (D - L)^(-1)U$. We start by finding the LDU decomposition of the matrix:
$
A = D - L - U = mat(7,0,0;0,7,0;0,0,9) - mat(0,0,0;3,0,0;2,-5,0) - mat(0,-1,-1;0,0,1;0,0,0) \
D - L = mat(7,0,0;-3,7,0;-2,5,9), U = mat(0,-1,-1;0,0,1;0,0,0)
$
We then take the inverse $(D - L) ^(-1)$ and multiply it to $U$:
$
(D-L)^(-1) = mat(1/7,0,0;3/49,1/7,0;-1/441,-5/63,1/9)\
T_(G S) = (D-L)^(-1)U = mat(0,-1/7,-1/7;0,-3/49,4/49;0,1/441,-34/441)
$
We also find:
$
(D-L)^(-1) bv &= mat(1/7,0,0;3/49,1/7,0;-1/441,-5/63,1/9) mat(6;-26;1)\
&= mat(6/7;-164/49;953/441)
$
which we can use in the equation 
$
xv^((k + 1)) = T_(G S) xv^((k)) + bold(upright(c))_(G_S) = (D-L)^(-1)U xv^((k)) + (D-L)^(-1) bv.
$
= Problems of the Week 3, Question 2, a & c

Let 
$
A = mat(1, -4/3; 4/3, 1), bv = mat(5/3;5)
$
and consider the IVP: 

$
xvd = bv - A xv, xv (0) = mat(p;q), p, q in RR.\
$
Take note that $xv (0) = xv ^((0))$.

== (a)
_With $h = 1$, $p = 1991$, and $q = 35$, apply forward explicit Euler for three iterations and compare it with the third Jacobi iterate $zv ^((3))$ for $A zv = bv$, starting from the same vector. Find the norm below and $H_E$ such that Euler converges for every initial vector exactly when $0 < h < H_E$._

Using explicit forward Euler iteration can be written in the form $y_(k+1) = y_k + h f(x_k, y_k)$. For this problem, the explicit Euler formula to be used is
$
xv ^((k+1)) &= xv ^((k)) + h (bv - A xv ^((k)))\
&= (I - h A) xv ^((k)) + h bv
$
where $h = 1$. From this, we compute $I - 1A$:
$
I - A &= mat(1, 0;0, 1) - mat(1, -4/3; 4/3, 1)\
&= mat(0, 4/3; -4/3, 0)
$
Thus, the iteration is written as
$
xv ^((k+1)) = mat(0, 4/3; -4/3, 0) xv ^((k)) + mat(5/3;5)
$
We then begin iterating from $xv ^((0)) = mat(1991;35)$.

=== Iteration 1:
$
xv ^((1)) &= mat(0, 4/3; -4/3, 0) mat(1991;35) + mat(5/3;5)\
&= mat(140/3; -7964/3) + mat(5/3;5)\
&= mat(145/3; -7949/3)
$

=== Iteration 2:
$
xv ^((1)) &= mat(0, 4/3; -4/3, 0) mat(145/3; -7949/3) + mat(5/3;5)\
&= mat(-31796/9;-580/9) + mat(5/3;5)\
&= mat(-31781/9; -535/9)
$

=== Iteration 3:
$
xv ^((1)) &= mat(0, 4/3; -4/3, 0) mat(-31781/9; -535/9) + mat(5/3;5)\
&= mat(-2140/27;127124/27) + mat(5/3;5)\
&= mat(-2095/27;127259/27)
$

We now solve the same equation using the Jacobi iteration method. We first split the matrix $A$ to find its LDU decomposition and extract the diagonal $D$. We can see that $D = I = mat(1,0;0,1)$, and we can input this into the iteration formula for the Jacobi method:
$
zv ^((k+1)) &= -D^(-1) (L + U) zv ^((k)) + D^(-1) bv
$
However, since the diagonal $D$ is the identity matrix (which means that $D = D^(-1)$), the formula can be rewritten as 
$
zv ^((k+1)) &= -(A - I) zv ^((k)) + bv\
&= (I - A) zv ^((k)) + bv
$
which is the exact same form as the explicit forward Euler equation used earlier with $h = 1$. Thus, the iteration will remain the same, and the difference vector will be
$
xv ^((3)) - zv ^((3)) = mat(0;0), norm(xv ^((3)) - zv ^((3)))_oo = 0
$

== (c)
_Take $tilde(xv)=xv^((1)) = mat(5/4;5/2)$ (calculated from (b)). Apply one step of iterative refinement (in full precision) to $A zv = bv$. Find the residual $bold(upright(E))$, correction $Δ xv$, corrected vector, and final residual norm._

We first find the residual $bold(upright(E)) = bv - A tilde(xv)$.
$
bold(upright(E)) &= mat(5/3;5) - mat(1,-4/3;4/3,1) mat(5/4;5/2)\
&= mat(5/3;5) - mat(-25/12;25/6)\
&= mat(15/4;5/6)
$
To find the correction vector, we let $A Delta xv = bold(upright(E))$.
$
mat(1,-4/3;4/3,1) mat(Delta x_1;Delta x_2) &= mat(15/4;5/6)\
A^(-1) = 1/(det(A)) mat(1,4/3;-4/3,1) &= 9/25 mat(1,4/3;-4/3,1)\
Delta xv = A^(-1) bold(upright(E)) &= 9/25 mat(1,4/3;-4/3,1) mat(15/4;5/6)\
&= mat(7/4;-3/2)
$
We then find:
$
tilde(xv) + Delta xv &= mat(5/4;5/2) + mat(7/4;-3/2) = mat(3;1)\
A (tilde(xv) + Delta xv) &= mat(1,-4/3;4/3,1) mat(3;1) = mat(5/3;5)\
norm(bv - A(tilde(xv) + Delta xv))_oo &= 0
$
= Remix
_Apply two iterations of the Gauss-Seidel method on the following problem:_
$
mat(4, 7, -1;3,-2,6;4,1,1) mat(x_1; x_2; x_3) = mat(5;4;3)
$
_Afterwards, use $upright(bold(tilde(x))) = xv ^((2))$ to apply one step of iterative refinement._