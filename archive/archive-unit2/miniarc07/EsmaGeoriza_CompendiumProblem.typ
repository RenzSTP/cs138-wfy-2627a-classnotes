#import "../assets.typ": qa, note

#set par(justify: true)
#set math.equation(numbering: "(1)")
#set table(stroke: 0.5pt + rgb("#999999"), inset: 4pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

// Problems: 
== Compendium Problem 1

#qa(auth: "GEORIZA ESMA")[
Adapted from Burden and Faires, Exercise Set 11.2, Item 2

Use the Nonlinear Shooting Algorithm with $h = 0.25$ to approximate the slope of the boundary value problem @

$y′′ = 2 y^3, −1 <= x <=0, y(−1) = 1/2 , y(0) = 1/3$.

Compare your results to the actual solution $y(x) = 1/(x + 3)$.

][
1. *Get the 1st IVP.* 

  We let $y'(-1) = s$, so we can have the IVP  
  $y'' = f(x, y, y') = 2 y^3$  written in matrix form as:

  $y' = mat(y'_1; y'_2) = mat(y_2; 2 y^3)$ 
  
  where $y_1 = y$ and $y_2 = y'$ with initial values $y(−1) = 1/2 " and " y(0) = 1/3$.

2. *Get the 2nd IVP.* 

  Let $z = (partial y)/(partial t)$. From,   $z''= (partial f(x, y, y'))/(partial s) 
  = (partial f) / (partial y) z  + (partial f) / (partial y') z' = (6 y^2)z + 0 z' = 6 y^2z$. 
  
  The initial values are $ z(-1) = 0 " and " z'(-1) = 1$.

  Writing this in vector form,
  
  $z' = mat(z'_1; z'_2) = mat(z_2; 6 y^2z)$ 
  
  where $z_1 = z$ and $z_2 = z'$.

  
3. *Vector form*

  Collecting the two IVPs into one,
  
  Let $w = mat(y_1; y_2; z_1; z_2)$ with initial values $w_0 = mat(1/2; s; 0; 1)$.
  
  Then, $w' = F(x, w) = mat(y_2; 2 y^3; z_2; 6 y^2z)$
  //to solve for $y_1$ & $z_1$ needed in Newton's method.

4. *Newton's scheme*

  $ s_k = s_(k - 1) - (y_1(0, s_(k - 1)) - 1/3)/(z_1(0, s_(k - 1))). $

5. Expected slope

  $y(x) = 1 / (x + 3) => y'(x) = - 1 / (x + 3)^2$

  $y'(-1) = - 1 / (-1 + 3)^2 = - 1/4$

  So, the true slope is $s = -1/4$. Let's use $s = 1$ for the fun of it.

  #table(
    columns: 2,
    [n], [s],
    [0], [1.0000000000],
[1],[0.2890450491] ,
[2],[-0.1676038430],
[3],[-0.2485814631],
[4 ],[-0.2500132367],
[5],[-0.2500136379]
  )

  In five iteration $s$ is already very close to $-1/4$.

]
== Compendium Problem 2 

#qa(auth: "GEORIZA ESMA")[
Use the RK4 with $h = 0.25$ to approximate the solution of the boundary value problem

$y′′ = 2 y^3, −1 <= x <=0, y(−1) = 1/2 , y(0) = 1/3$.

Compare your results to the actual solution $y(x) = 1/(x + 3)$.
][
We use the matrix we got from compendium problem 1.
  
$w' = F(x, w) = mat(y_2; 2 y^3; z_2; 6 y^2z)$ 

with initial values $w_0 = mat(1/2; s; 0; 1)$.

 $w_(n+1)​ = w_n ​+ h/6 ​(K_1​ +  2 K_2 ​ + 2K_3 ​+ K_4​)$

  ​​$K_1 = F(w_n​)$\ 
  $K_2 = F(w_n​+ h/2 ​K_1​)$\
  $K_3 = F(w_n​+h/2 ​K_2​)$\
  $K_4 = F(w_n​ + h K_3​)$.​

  #table(
    columns: 6,
    [h], [x], [y1], [y2], [z1], [z2],
    [0], [-1.0000], [0.50000000], [-0.25001364], [0.00000000], [1.00000000],
  [1], [-0.7500], [0.44444634], [-0.19754156], [0.25346193], [1.04026651],
  [2], [-0.5000], [0.40000194], [-0.16000899], [0.52521165], [1.14222908],
  [3], [-0.2500], [0.36363754], [-0.13223946], [0.82821384], [1.28814875],
  [4], [0.0000], [0.33333333], [-0.11111875], [1.17213673], [1.46839969],
  )
  
  We can see that $y_1$  is roughly equal to the correct implication as below

  #table(
    columns: 2,
    [x], [y(x)],
    [-1], [0.5],
    [-0.75], [0.4444444444],
    [-0.5], [0.4],
    [-0.25], [0.3636363636],
    [0], [0.3333333333],)
  ]
== Remixed Problem
#qa(auth: "GEORIZA ESMA")[
Use collocation of points and find a function satisfying the points derived from the second compendium problem.

  #table(
    columns: 3,
    [h], [x], [y1], 
    [0], [-1.0000], [0.50000000], 
  [1], [-0.7500], [0.44444634], 
  [2], [-0.5000], [0.40000194], 
  [3], [-0.2500], [0.36363754], 
  [4], [0.0000], [0.33333333], 


  )
Compute the slope from the created equation and compare it to the true slope, $y'(0) = -1/4$ in compendium problem 1.
][
  We want $f$ that passes through $(x, y_i)$.

So we have 5 equations with 5 unknowns

$A a=y_i$ with $A_(i j)=Phi_j (x_i)$.

We will use $Phi_j (x_i) = e^(-1/2 ((x_i - x_j)/sigma)^2)$ as the basis function with $sigma = 1$.


$
mat(
  e^0, e^(-1/8), e^(-1/2), e^(-9/8), e^(-2);
  e^(-1/8), e^0, e^(-1/8), e^(-1/2), e^(-9/8);
  e^(-1/2), e^(-1/8), e^0, e^(-1/8), e^(-1/2);
  e^(-9/8), e^(-1/2), e^(-1/8), e^0, e^(-1/8);
  e^(-2), e^(-9/8), e^(-1/2), e^(-1/8), e^0;
)
mat(a_0; a_1; a_2; a_3; a_4) = mat(0.5; 0.4444444444; 0.4; 0.3636363636; 0.3333333333)
$

Using a calculator to solve this,

$
a = mat(
  2.0980021140;
  -4.2271059987;
  5.0418126781;
  -3.4312652408;
  1.3918069924;
)$

Interpolating this into the function $f(x) approx sum_(j=0)^(2) a_j Phi_j (x)$ 

we have, \
$ f(x) approx 2.0980021140 e^(-1/2 (x + 1)^2) - 4.2271059987 e^(-1/2 (x + 0.75)^2) + 5.0418126781 e^(-1/2 (x + 0.5)^2) + -3.4312652408 e^(-1/2 (x + 0.25)^2)+ 1.3918069924 e^(-1/2 x^2)$

Taking the derivative,

$f'(x) = -1.39181 e^(-0.5 x^2) x + 2.098 e^(-0.5 (x + 1)^2) (-x - 1) - 4.22711 e^(-0.5 (x + 0.75)^2) (-x - 0.75) + 5.04181 e^(-0.5 (x + 0.5)^2) (-x - 0.5) - 3.43127 e^(-0.5 (x + 0.25)^2) (-x - 0.25)$

Evaluating this at $x=-1$, we get 

$ f′(−1)=0.10205856 ​$ 

This is very far from the true value $y'(-1) = -0.25$, so maybe the basis function is bad.

  
]