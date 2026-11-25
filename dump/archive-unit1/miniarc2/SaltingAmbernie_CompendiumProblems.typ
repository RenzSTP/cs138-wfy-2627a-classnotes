= Compendium Problems (Salting, Ambernie)

\ *1. [Burden and Faires. Chapter 6. Exercise Set 6.5,  page 410 Item 7a]*

Modify the _LU_ Factorization Algorithm so that it can be used to solve a linear system, and then solve
the following linear systems.

$
&2x_1 - x_2 + x_3 = -1, \
&3x_1 + 3x_2 + 9x_3 = 0, \
&3x_1 + 3x_2 + 5x_3 = 4,
$

Let $
A = mat(delim: "[",
2, -1, 1;
3, 3, 9;
3, 3, 5;
),
B = mat(delim: "[",
-1;
0;
4;
)
$

Finding _LU (A = LU)_.

$
L = mat(delim: "[",
1, 0, 0;
l_(2 1), 1, 0;
l_(3 1), l_(3 2), 1;
),

U = mat(delim: "[",
u_(1 1), u_(1 2), u_(1 3);
0, u_(2 2), u_(2 3);
0, 0, u_(3 3);
)
$

For the first row of $U$,

$
u_(1 1) = 2, u_(1 2) = -1, u_(1 3) = 1
$

For the first col of $L$,

$
l_(2 1) = a_(2 1) / u_(1 1) = 3/2 \
l_(3 1) = a_(3 1) / u_(1 1) = 3/2
$

For other entries of $U$ and $L$,

$
u_(2 2) = 3 + 3/2 = 9/2 \
u_(2 3) = 9 - 3/2 = 15/2 \
l_(3 2) = (9/2) / (9/2) = 1 \
u_(3 3) = 5 - 18/2 = -4
$

Thus we have $A = L$$U$,

$
L = mat(delim: "[",
1, 0, 0;
3/2, 1, 0;
3/2, 1, 1;
),

U = mat(delim: "[",
2, -1, 1;
0, 9/2, 15/2;
0, 0, -4;
)
$

Applying Forward Substitution $L y = b$:

$
mat(delim: "[",
1, 0, 0;
3/2, 1, 0;
3/2, 1, 1;
)mat(delim: "[",
y_1;
y_2;
y_3;
) =
mat(delim: "[",
-1;
0;
4;
)
$

$
y_1 &= -1, \
3/2y_1 + y_2 &= 0 arrow y_2 = 3/2 \
3/2y_1 + y_2 + y_3 &= 4 arrow y_3 = 4 \
$

Thus,

$
y = mat(delim: "[",
-1;
3/2;
4;
)
$

Applying Backward Substitution $U x = y$,

$
-4x_3 &= 4 arrow x_3 = -1 \
9/2x_2 + 15/2x_3 &= 3/2 arrow x_2 = 2 \
2x_1 - x_2 + x_3 &= -1 arrow x_1 = 1
$

Thus,

*$
x = mat(delim: "[",
-1;
2;
-1;
)
$*

\ *2. [Burden and Faires. Chapter 6. Exercise Set 6.6, page 427 Item 20]*

Suppose that $A$ and $B$ are strictly diagonally dominant $n times n$ matrices. Which of the following must be strictly diagonally dominant?

a. $-A$ \ b. $A^t$ \ c. $A + B$ \ d. $A^2$ \ e. $A - B$

Remember that a matrix $A$ is strictly diagonally dominant (SDD) if for every row i:

$
|a_(i i)| > sum_(j eq.not i)|a_(i j)|
$

*_For a. $-A$_* *(True)*

Let $M = -A$. 

All of its entries are just:

$
m_(i j) = -a_(i j)
$

So, the diagonals are:

$
|m_(i i)| = |-a_(i i)| = |a_(i i)|
$

With the sum of its off-diagonal entries being:
$
sum_(j eq.not i)|m_(i j)|=sum_(j eq.not i)|-a_(i j)|=sum_(j eq.not i)|a_(i j)|
$

Because $A$ is always strictly diagonally dominant, which means:

$
|m_(i i)| > sum_(j eq.not i)|m_(i j)|
$

Therefore, $-A$ is always *strictly diagonally dominant.*

\ *_For b. $A^t$_* *(False)*

SDD is defined row-wise, so by transposing a matrix (i.e. swapping rows and cols), even if it's col-dominant, this does not imply it's also row-dominant.

Take a look at this counterexample:

$
A = mat(
  delim: "[",
6, 1;
6, 7;
)
$

$|2| > |1|$ and  $|2| > |0|$, thus A is SDD.

$
A^t = mat(
  delim: "[",
6, 6;
1, 7;
)
$

For row 1, we can see $|6| gt.not |6|$, thus it is not SDD.

Therefore, $A^t$ *is not always strictly diagonally dominant.* 

\ *_For c. $A + B$_* *(False)*

Consider the counterexample:
$
A = mat(
  delim: "[",
9, 6;
6, 7;
), 

B = mat(
  delim: "[",
-9, 6;
6, -7;
)
$

Adding the diagonals $9 - 9 = 0 gt.not 6 + 6 = 12$.

Therefore, $A + B$ *is not always strictly diagonally dominant.*

\ *_For d. $A^2$_* *(False)*

Consider 

$
A &= mat(
  delim: "[",
9, -6;
6, 7;
) \

A^2 &= mat(
  delim: "[",
9, -6;
6, 7;)
mat(
  delim: "[",
9, -6;
6, 7;
) \
&= mat(
  delim: "[",
81 - 36, -54 - 42;
54 + 42, -36 + 49;
)
\
&= mat(
  delim: "[",
45, -96;
96, 13;
)
$

Note that $|45| gt.not |-96|$.

Therefore, $A^2$ *is not always strictly diagonally dominant.*

\ *_For e. $A - B$_* *(False)*

Consider the matrices where $A = B arrow A - B = 0$. 

The resulting matrix is the zero matrix, which *will never be strictly diagonally dominant.*