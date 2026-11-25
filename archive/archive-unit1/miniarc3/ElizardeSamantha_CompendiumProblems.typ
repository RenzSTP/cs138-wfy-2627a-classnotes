= Items 6 & 8, Exercise Set 7.2, Numerical Analysis (Burden and Faires)

== Solved Problem 1

For each matrix, find the spectral radius and determine if they are convergent.

a.  
$
A = mat(delim: "[", 
1, 1; 
-2, -2; 
)
$
Calculating the eigenvalues of $A$ using $det(A- lambda I)=0$,
$ 
A - lambda I &= mat(delim: "[", 
1 - lambda, 1; 
-2, -2 - lambda; 
)\
det (A-  lambda I) &=  (1 - lambda)(-2 - lambda) + 2 = 0\
&=> -2 + lambda^2 + 2 lambda - lambda + 2 = 0 \
&=> lambda^2 + lambda = 0 \
&=> lambda (lambda + 1) = 0 \
lambda &= 0, -1
$

Calculating the spectral radius $rho (A)$,
$ 
rho (A) &= max(|0|, |-1|) \
&= 1\
$

Since $rho (A) = 1 lt.not 1$, the matrix is not convergent. 

c.  
$
C = mat(delim: "[", 
3, 4; 
1, 0; 
)
$
Calculating the eigenvalues of $C$ using $det(C- lambda I)=0$,
$ 
C - lambda I &= mat(delim: "[", 
3 - lambda, 4; 
1, - lambda; 
)\
det (C-  lambda I) &=  (3 - lambda)(- lambda) - 4 = 0\
&=> -3 lambda + lambda^2 -4 = 0 \
&=> (lambda - 4) (lambda + 1) = 0 \
lambda &= 4, -1
$

Calculating the spectral radius $rho (C)$,
$ 
rho (A) &= max(|4|, |-1|) \
&= 4\
$

Since $rho (A) = 4 lt.not 1$, the matrix is not convergent. 

e.  
$
E = mat(delim: "[", 
1/2, 0, 0; 
-1, 1/2, 0; 
2, 2, -1/3;
)
$
Calculating the eigenvalues of $E$ using $det(E- lambda I)=0$,
$ 
E - lambda I &= mat(delim: "[", 
1/2 - lambda, 0, 0; 
-1, 1/2 - lambda, 0; 
2, 2, -1/3 - lambda;
)\
det (E - lambda I) &=  (-1/2 - lambda) mat(delim: "|", 1/2 - lambda, 0; 2, -1/3 - lambda;) + 0 + 0= 0\
&=> (1/2 - lambda)(1/2 - lambda)(-1/3 - lambda) = 0 \
lambda &= 1/2, -1/3
$

Calculating the spectral radius $rho (E)$,
$ 
rho (E) &= max(|1/2|, |-1/3|) \
&= 1/2\
$

Since $rho (E) = 1/2 < 1$, the matrix is convergent. 

 

= Item 9a, Exercise Set 7.3, Numerical Analysis (Burden and Faires)

== Solved Problem 2

The linear system
$
2x_1 space space - space x_2 +space space x_3 &= -1\
2x_1 + 2x_2 + 2x_3 &= space space 4\
-x_1 space space - space x_2 + 2x_3 &= -5
$
has the solution $(1, 2, -1)^T$.
a. Show that $rho (T_J) = sqrt(5)/2 > 1$

Getting the coefficient matrix $A$ from the SLE,
$
A = mat(delim: "[", 
2, -1, 1; 
2, 2, 2; 
-1, -1, 2; 
)
$

Decomposing $A$ into the $3 times 3$ matrices $L, D, U$ where $A=L+D+U$,
$
A = mat(delim: "[", 
0, 0, 0; 
2, 0, 0; 
-1, -1, 0; 
) + mat(delim: "[", 
2, 0, 0; 
0, 2, 0; 
0, 0, 2; 
) + mat(delim: "[", 
0, -1, 1; 
0, 0, 2; 
0, 0, 0; 
)
$
Calculating $T_J=-D^(-1)(L+U)$,
$
-D^(-1) &= mat(delim: "[", 
-1/2, 0, 0; 
0, -1/2, 0; 
0, 0, -1/2;
) \
-D^(-1)(L+U) &= mat(delim: "[", 
1/2, 0, 0; 
0, 1/2, 0; 
0, 0, 1/2;
) mat(delim: "[", 
0, -1, 1; 
2, 0, 2; 
-1, -1, 0; 
) \
&= mat(delim: "[", 
0, 1/2, -1/2; 
-1, 0, -1; 
1/2, 1/2, 0; 
) 
$

Calculating the eigenvalues of $T_J$ using $det(T_J- lambda I)=0$,
$ 
T_J- lambda I=
mat(delim: "[", 
- lambda, 1/2, -1/2; 
-1, - lambda, -1; 
1/2, 1/2, - lambda; 
) 
$

Using cofactor expansion along the first row,
$
det(T_J- lambda I) &= 
- lambda mat(delim: "|", 
- lambda, -1; 
1/2, 1/2; 
) +
1/2 (-1) mat(delim: "|", 
- 1, -1; 
1/2, - lambda; 
) -
1/2 mat(delim: "|", 
- 1, - lambda; 
1/2, 1/2; 
) = 0\
&=> -lambda (lambda^2 + 1/2) -1/2 (lambda +1/2) -1/2 (-1/2 + lambda/2) = 0\
&=> -lambda^3 - 5/4 lambda = 0\
&=> -lambda (lambda ^2 + 5/4) = 0\
&=> lambda = 0, sqrt(5)/2i, -sqrt(5)/2i
$

Calculating the spectral radius $rho (T_J)$,
$ rho (T_J) &= max(|0|, |sqrt(5)/2i|, |-sqrt(5)/2i|) \
&= sqrt(5)/2 \
&= 1.118 > 1
$

By showing that $rho (T_J)>1$, we can determine that the Jacobi iterative method is not guaranteed to converge for just any initial guess $x$.


= Remixed Problem

#set math.equation(numbering: "(1)", number-align: right + horizon)

It has been illustrated that the spectral radius of the Jacobi Iteration Matrix is greater than 1 ($rho (T_J) > 1$), and therefore does not meet the criteria for the convergence of a matrix. This means that it diverges for almost all initial guesses. Given the true solution $x=[1, 2, -1]^T$, can we derive an initial guess that will converge despite the fact that $rho (T_J) > 1$?

With the error iteration equation (at iteration $k$),
$ e^( (k) ) = x^( (k) ) - x = T_j^k e^( (0) ) $ 

We know the initial error vector $e^ ( (0) )$ can be defined as an linear combination of the eigenvectors $v$ of the iteration matrix $T_j$,
$ e^( (0) ) = c_1v_1 + c_2v_2 + c_3v_3, $ 
where $c$ is some real constant.

Substituting this to the error iteration equation by applying $T_j^k$ to $e^( (0) )$, we have,
$ e^( (k) ) = c_1 lambda_1^k v_ + c_2 lambda_2^k v_2 + c_3 lambda_3^k v_3 $ 

1. Get the eigenvector corresponding to the stable eigenvalue ($|lambda| < 1$).
2. Using the eigenvector from 1 and equation (2), determine an equation for $e^ ( (0) )$ 
3. Finally, with equation (1), determine the set of initial guesses $x^( (0) )$ that will make the Jacobi method converge.
4. The iteration will hit the exact solution in a single iteration (at $k=1$) due to the stable eigenvalue used. Explain why this is. 
