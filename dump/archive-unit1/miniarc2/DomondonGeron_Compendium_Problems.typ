1). Let 

$
  A = mat( delim: "[",
    alpha, 1, 0;
    beta, 2, 1;
    0, 1, 2;
  )
$

Find all values for $alpha$ and $beta$ for which 

b. A is strictly diagonally dominant

For A to be strictly diagonally dominant, we want:

$
  abs(alpha) > abs(1) + abs(0) \
  abs(2) > abs(beta) + abs(1) \
$

From the first condition, we get:

$
abs(alpha) > 1
$

And from the second:

$
  2 > abs(beta) + 1 \
  2 - 1 >abs( beta) \
  abs(beta) < 1
$

Hence, for A to be SDD, $abs(alpha) > 1$ and $abs(beta) > 1$.

d: A is (symmetric) positive definite

_Note: the specific question from Burden and Faires does not explicitly include the symmetric condition because symmetry is already included in the book's definition of positive definite matrices._

Notice that for A to be symmetric, it only needs to fulfill the condition that $a_(i j) = a_(j i)$. We can see that $beta = a_(2 1)$ and $a_(1 2)$ = 1. Hence, we can conclude that 

$
  beta = 1
$

Now, recall in the class notes that a matrix is symmetric positive definite iff it has a Cholesky decomposition. Hence, we can try to find the Cholesky of A to determine the value of $alpha$.

$
  A = mat( delim: "[",
    alpha, 1, 0;
    1, 2, 1;
    0, 1, 2;
  ) \
  
  = mat( delim: "[",
    1, 0, 0;
    1/a, 1, 0;
    0, 0, 1
  ) mat( delim: "[",
    alpha, 1, 0; 
    0, 2 - 1/a, 1;
    0, 1, 2
  ) \
  
  = mat( delim: "[",
    1, 0, 0;
    1/alpha, 1, 0;
    0, alpha / (2 alpha - 1), 1
  )mat( delim: "[",
    alpha, 1, 0; 
    0, 2 - 1/a, 1;
    0, 0, (3 alpha - 2) / (2 alpha - 1)
  )  \
  = L U \
$
Now, note that after this step, we usually further decompose $A$ into $A = L D U$. However, we only really need to guarantee that the entries of D are positive for $A$ to maintain its positive definiteness. Recall that the entries of D are taken as the square roots of the diagonal entries of whichever between L and U contain non-1 diagonal entries. In this case, that matrix would be U, giving us the following conditions:

$
  alpha > 0
   \
   2 - 1/alpha > 0 \
   (3 alpha - 2) / (2 alpha - 1) > 0\
$

Simplifying, we get:
$
alpha > 0
 \
 alpha > 1/2 \
 alpha > 2/3
$

The tightest bound among the three is $alpha > 2/3$. Hence, A is symmetric positive definite if $alpha > 2/3$ and $beta = 1$.

\

2). Construct the operation count for solving an $n times n$ linear system using the Crout Factorization Algorithm.

Solving a system using Crout can be divided into three main steps: factorization, forward substitution, and backward substitution.

Factorization: \
Burden and Faires uses Algorithm 6.4 to compute the factorization of Crout.

In particular, Algorithm 6.4 provides the following entrywise definitions for $L$ and $U$:
\

For $j = 1, dots, n$:

- Column $j$ of $L$: $l_(i j) = a_(i j) - sum_(k=1)^(j-1) l_(i k) u_(k j)$ for $i = j, dots, n$. There are $n - j + 1$ entries, each needing $j - 1$ multiplications and $j - 1$ subtractions.
- Row $j$ of $U$: $u_(j i) = 1/l_(j j) (a_(j i) - sum_(k=1)^(j-1) l_(j k) u_(k i))$ for $i = j + 1, dots, n$. There are $n - j$ entries, each needing $j - 1$ multiplications, $j - 1$ subtractions, and $1$ division.

Note that Step 2 is the $i = 1$ case of Step 5 (cost $(n-1)(1)$, no add/sub), and Step 6 is the $i = n$ case of Step 4 (cost $n - 1$). So the sums can be written over $i = 1, dots, n$ for Step 4/6 and $i = 1, dots, n-1$ for Step 5.

Multiplications/divisions:
$ sum_(i=1)^(n) (i - 1) + sum_(i=1)^(n-1) (n - i)(2i - 1) $

The first sum is $(n(n-1))/2$. For the second, use $sum_(i=1)^(n-1) i = (n(n-1))/2$ and $sum_(i=1)^(n-1) i^2 = ((n-1) n (2n-1))/6$:
$ sum_(i=1)^(n-1) (n - i)(2i - 1)
  = (2n + 1) (n(n-1))/2 - n(n-1) - ((n-1) n (2n-1))/3
  = (n(n-1)(2n-1))/6 . $

Hence, we can simply add the addition/subtraction counts from each subproblem to obtain the total addition/subtraction count of the whole process, and do the same for multiplication and division.
$ (n(n-1))/2 + (n(n-1)(2n-1))/6 = (n(n-1)(2n+2))/6 = (n^3 - n)/3 . $

Additions/subtractions:
// show derivation here balikan nalang

\
\
\

Remix Problem

Recall that we have two ways of finding the Cholesky of a symmetric positive definite matrix: 1). using the matrix derivation, and 2). the entrywise Cholesky algorithm. Construct the operation count for obtaining the Cholesky of a given SPD matrix using both methods, and compare the operation count for each. 

1). Matrix form

We refer to an $n times n$ matrix A decomposed into $A = G G^T$ using the steps outlined in Cholesky Decomposition - Derivation from LDU Matrix in the class notes.

As a prerequisite, we first analyze finding the LDU decomposition of A. Thankfully, we have already counted the steps that it takes to find an LU decomposition! Then, we only need to add the multiplications needed to factor out D. \

Then, we consider the step where we take the square root S of D. As outlined in the class notes, that operation only takes $n$ square roots. \

The next step involves multiplying L with S. Although normal matrix multiplication is usually done in $O(n^3)$ time, we can use the fact that S is a diagonal matrix to conclude that finding LS will only take $n^2$ multiplication steps, since each col of L is simply scaled. \

Lastly, finding $L S ^T$simply involves rearranging the $n^2$ terms in LS.

Hence, the total operation count in finding the Cholesky is as follows:

$ "Mult/div:" quad (n^3 - n)/3 + (n(n-1))/2 + n^2 = n^3/3 + (3 n^2)/2 - (5n)/6 $

$ "Add/sub:" quad (2n^3 - 3n^2 + n)/6 = n^3/3 - n^2/2 + n/6 $

$ "Square roots:" quad n $

2) Algorithmic (entrywise definition)

Unlike the previous form, there is no explicit need with the algorithmic approach to find the LDU decomposition. We can refer to the Cholesky Algorithm section of the class notes for the steps.

For the first step, we notice that each diagonal entry for L contains:

$ l_(j j) = sqrt(a_(j j) - sum_(k=1)^(j-1) l_(j k)^2) . $
- $j - 1$ terms, each pne being a square which yields $j - 1$ multiplications.
- Adding the $j - 1$ terms takes $j - 2$ additions, and subtracting the sum from $a_(j j)$ takes $1$ more, so $j - 1$ additions/subtractions.
- $1$ square root.

For the second step, we notice that the sum has, for each i:
- $j - 1$ terms, each a product: $j - 1$ multiplications.
- $j - 2$ additions for the sum and $1$ subtraction from $a_(i j)$: $j - 1$ additions/subtractions.
- $1$ division by $l_(j j)$.

Hence, Step 2 costs $(n-1)(j-1)$ multiplications, the same number of additions, and $n - j$ divisions.

Note that Step 3, consisting only of assignments, contributes zero operations.

Now, we add up the operation count of all three steps across all $j$ from 1 to n.

Multiplications: 

For easier bookkeeping, we substitute m = j - 1:
$ sum_(j=1)^(n) (n - j + 1)(j - 1) = sum_(m=0)^(n-1) (n - m) m = n sum m - sum m^2 . $
Using $sum_(m=0)^(n-1) m = (n(n-1))/2$ and $sum_(m=0)^(n-1) m^2 = ((n-1) n (2n-1))/6$:
$ n dot (n(n-1))/2 - ((n-1) n (2n-1))/6 = (n(n-1)(3n - (2n - 1)))/6 = (n(n-1)(n+1))/6 = (n^3 - n)/6 . $

Next, we count the number of additions. Note however that for steps 1 and 2, the number of multiplications and additions/subtractions are the same, so we also get:

$
(n^3 - n)/6
$
additions and subtractions.

Then, we have (n - j) divisions per iteration, which yields

$
 sum_(j=1)^(n) (n - j) = (n(n-1))/2 . 
$
divisions. \

lastly, Step 1 takes a square root for each diagonal, which means that there are $n$ square roots.

\
Disclaimer: I used `https://www.freemathhelp.com/summation-calculator/` to simplify some of these summations

