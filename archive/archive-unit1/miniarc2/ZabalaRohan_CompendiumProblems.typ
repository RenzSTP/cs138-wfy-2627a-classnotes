// Zabala's Compendium Problems

#set page(width: 8.5in, height:11in, margin: auto)
#set text(size: 12pt)
#set math.mat(delim: "[")
#let tbl(..arguments) = table(
  align: center + horizon,
  inset: 7pt,
  stroke: 0.6pt + black,
  ..arguments
)

#text(size:20pt, weight: "bold")[Compendium Problems (Zabala)]

#text(size: 16pt, weight: "bold")[Problem 1]

1. Factor the following matrices into the LU decomposition using the LU Factorization Algorithm with $l_(i i) = 1$ for all i (Burden & Faires, Exercise Set 6.5, Item 5a, p. 414):

$ A =  mat(2,-1,1;3,3, 9; 3,3,5) $

#text(weight: "bold")[Solution:]

*I.*
Since $l_(i i) = 1$, this means we do Doolittle decomposition.

#align(center)[
  #tbl(
    columns: 4,
    [*Matrix*], [*Row Operation*], [*L*], [*U*],
    [$mat(2,-1,1; 3,3,9;3,3,5)$],
    [$R_2 arrow.l R_2 - 3/2 R_1$], [$mat(1,0,0;3/2,1,0;0,0,1)$], [$mat(2,-1,1; 0,9/2,15/2;3,3,5)$],

    [$mat(2,-1,1; 0,9/2,15/2;3,3,5)$], [$R_3 arrow.l R_3 - 3/2 R_1$], [$mat(1,0,0;3/2,1,0;3/2,0,1)$],[$mat(2,-1,1; 0,9/2,15/2;0,9/2,7/2)$],

    [$mat(2,-1,1; 0,9/2,15/2;0,9/2,7/2)$], [$R_3 arrow.l R_3 -  R_2$], [$mat(1,0,0;3/2,1,0;3/2,1,1)$], [$mat(2,-1,1; 0,9/2,15/2;0,0,-4)$]
  )
]

*II.* Now, we check $L U = A$.

$ L U = mat(1,0,0;3/2,1,0;3/2,1,1) mat(2,-1,1; 0,9/2,15/2;0,0,-4) = mat(2,-1,1; 3,3,9;3,3,5) $

*Answer:* $L = mat(1,0,0;3/2,1,0;3/2,1,1)$ and $U = mat(2,-1,1; 0,9/2,15/2;0,0,-4)$

#pagebreak()
#text(size: 16pt, weight: "bold")[Problem 2]

2. Use Crout factorization for tridiagonal systems to solve the following linear system (Burden & Faires, Exercise Set 6.6, Item 11a, p. 430):

$ x_1- x_2 = 0, quad -2 x_1+ 4 x_2 - 2 x_3 = -1, quad -x_2 + 2 x_3 = 3/2 $

#text(weight: "bold")[Solution:]

*I.* The coefficient matrix is tridiagonal, so in the Crout factorization $A = L U$, $L$ is lower bidiagonal and $U$ is upper bidiagonal with 1's on its diagonal.

$ A = mat(1,-1,0; -2,4,-2; 0,-1,2) = mat(l_11,0 ,0; l_21,l_22,0; 0,l_32,l_33) mat(1,u_12,0 ; 0,1,u_23; 0,0,1) $

Multiplying out and matching entries with $A$ gives the following.

#align(center)[
  #tbl(
    columns: 3,
    [*Entry of $A$*], [*Equation*], [*Result*],
    [$a_11 = 1$], [$l_11 = a_11$], [$l_11= 1$],
    [$a_12 = -1$], [$l_11 u_12 = a_12$], [$u_12= -1$],
    [$a_21 = -2$], [$l_21= a_21$], [$l_21= -2$],
    [$a_22 = 4$], [$l_22 = a_22 - l_21 u_12$], [$l_22 = 4 - (-2)(-1) = 2$],
    [$a_23 = -2$], [$l_22 u_23= a_23$], [$u_23 = -2 \/ 2 = -1$],
    [$a_32 = -1$], [$l_32 = a_32$], [$l_32 = -1$],
    [$a_33 = 2$], [$l_33 = a_33 - l_32 u_23$], [$l_33 = 2 -(-1)(-1) = 1$],
  )
]

$ L = mat(1,0,0; -2,2,0; 0,-1,1), quad U = mat(1,-1,0; 0,1,-1; 0,0,1) $

*II.* We solve $L z =b$ by forward substitution, where $b = (0, -1, 3\/2)^t$.

#align(center)[
  #tbl(
    columns: 3,
    [*Row of $L z = b$*], [*Equation*], [*Solution*],
    [1], [$z_1 = 0$], [$z_1 = 0$],
    [2], [$-2 z_1 + 2 z_2 = -1$], [$z_2 = -1\/2$],
    [3], [$-z_2 + z_3 = 3\/2$], [$z_3 = 3\/2 - 1\/2 = 1$],
  )
]

*III.* We solve $U x = z$ by back substitution.

#align(center)[
  #tbl(
    columns: 3,
    [*Row of $U x = z$*], [*Equation*], [*Solution*],
    [3], [$x_3 = 1$], [$x_3 = 1$],
    [2], [$x_2 - x_3 = -1\/2$], [$x_2 = -1\/2 + 1 = 1\/2$],
    [1], [$x_1 - x_2 = 0$], [$x_1 = 1\/2$],
  )
]

*IV.* Now, we check $L U = A$.

$ L U = mat(1,0,0; -2,2,0; 0,-1,1) mat(1,-1,0; 0,1,-1; 0,0,1) = mat(1,-1,0; -2,4,-2; 0,-1,2) $

*Answer:* $x = mat(1\/2; 1\/2; 1)$

#pagebreak()


#text(size: 16pt, weight: "bold")[Remix Problem]

*(Taken from POTW 2 2(c))*

Consider the matrix $ A = mat(2,2,5; -2,2,3; 1,-3,2)  $ with upper triangular from (a) of POTW 2: Item 2
$ U = mat(3,-1,2; 0,4,3; 0,0,5) $

Apply Gram-Schmidt to the columns of $A$, in their given order,  using the usual L2-norm. Place the resulting vectors $q_i$ for i = 1,2,3 in the columns of Q and let $R$ be the upper triangular matrix of the coefficients $r_(i j)$, so that $A = Q R$.


*Solution:*

*I.* Applying Gram-Schmidt:

The columns are $a_1 = vec(2,-2,1)$, $a_2 = vec(2,2,-3)$, and $a_3 = vec(5,3,2)$.

#align(center)[
  #tbl(
    columns: 4,
    [*Step*], [*Coefficients*], [*$v_k$*], [*$r_(k k )$*],
    [$k = 1$],
    [None], [$v_1 = a_1 = vec(2,-2,1)$], [$r_11 = sqrt(4+4 +1) = 3 $ \ $q_1 = vec(2/3, -2/3, 1/3)$] ,

    [$k=2$], [$r_12 = q_1^T a_2 = 4/3 - 4/3 -1 = -1$], [$v_2 = a_2 -(-1) *q_1 = vec(8/3, 4/3, -8/3)$],[$r_22 = sqrt(64/9+16/9+64/9)=4$ \ $q_2 = vec(2/3, 1/3, -2/3)$],

    [$k=3$], [$r_13 = q_1^T a_3 = 10/3 -6/3+2/3 = 2$ \ $r_23 = q_2^T a_3 = 10/3 +1 - 4/3 = 3$], [$v_3 = a_3 - 2 q_1 -3q_2 = vec(5/3, 10/3, 10/3)$],[$r_33 = sqrt(25/9 + 100/9+100/9 ) = 5$ \ $q_3 = vec(1/3, 2/3, 2/3)$],
  )
]

*II.* Finding Q and R

$ Q = mat(2/3, 2/3, 1/3; -2/3, 1/3, 2/3; 1/3, -2/3, 2/3), quad R = mat(3,-1,2;0,4,3;0,0,5) $

We check each column:

First:

$ 3q_1 = 3 vec(2/3, -2/3, 1/3) = vec(2, -2, 1) = a_1 checkmark $

Second:

$ -1q_1 + 4_q_2 = vec(-2/3 +8/3, 2/3+4/3, -1/3-8/3) = vec(2, 2, -3) = a_2 checkmark $

Third:

$ 2q_1 + 3q_2 + 5q_3 = vec(4/3+2+5/3, -4/3 + 1 + 10/3, 2/3 - 2 + 10/3) = vec(5,3,2) = a_3 checkmark $

Thus, the columns of $Q$ are orthonormal, so $Q^T Q = I$.
