== Motivating Ideas:
What if there was a way to simplify the process of finding the unknown vector $x$, such that we minimize the number of arithmetic operations we perform and even minimize human error, instead of naively finding its inverse? But, how do we want to factor A in the first place?

 (1) Let $A = C D$ where $C, D$ have the same dimensions as $A$:

$
A x = b
$

$
C D x = b
$

$
C (D x) = b 
$

(2) Now, let $y$ be a vector, such that:
$
D x = y
$
And $ C (D x) = C y = b $

(3) Given our definitions, we have:
$
C (D x) = C y
$
$ 
D x = y 
$


Now, what if we can make it such that $C y = b$ and $D x = y$ can only be solved using forward or backward substitution.

*Matrix factorization* addresses this by separating the work into two stages:

 + *Factor* the coefficient matrix $A$ into a product of simpler matrices, doing only once with cost of $O(n^3)$.
 + *Solve* the resulting matrices for each right-hand side $b$. Because these are triangular, this costs only $O(n^2)$ operations, and can be repeated as needed.

The most fundamental example of this idea is *LU decomposition* #footnote[Warning:
This only works if $A$ is a non-singular matrix. Otherwise, if $A$ is singular (i. e. has no inverse) then there will exist a 0 row in $A$ after sufficient ERO operations.
],
 which gives $A = L U$, where $L$ is lower triangular and $U$ is upper triangular. Given these, solving $A x = b$ becomes:

$
L U x = b
$

which we solve in two more cheap steps using vector $y = U x$:

+ *Forward substitution:* Solve $L y = b$ for $y$ from top to bottom since $L$ is lower triangular.

+ *Backward substitution:* Solve $U x = y$ for $x$ from bottom to top since $U$ is upper triangular.

Each of these costs only $O(n^2)$ operations, cheaper than $O(n^3)$.

There are 3 methods that we can do this: 
- Method 1: *Doolittle* Decomposition
- Method 2: *Crout* Decomposition
- Method 3: *Cholesky* Decomposition

Throughout the notes, we will be treating the matrix as a sandwich with toppings. You will see why soon.
