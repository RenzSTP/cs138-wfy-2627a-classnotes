// John Tibay
Tibay, John Michael \
Problem 1. #image("TrefethenExercise211c.png")
Soln. Gaussian elimination with pivoting gives us a factorization $P A = L U$, where $P$ is a permutation matrix. Since the determinant is multiplicative, we have $det(A)det(P) = det(P A) = det(L U) = det(L) det(U)$. $L$ is assured to be unit triangular, so $det(L) = 1$. On the other hand, $P$ is a permutation matrix, so $det(P) = (-1)^s$ where $s$ is the number of row switches that happened. Finally, the determinant of $U$ is just the product of the diagonals because it is triangular: if we do cofactor expansion on the first column, we see that $det(U) = u_11 * M$ where M is the corresponding minor. So, by wishful thinking, $det(U)$ is just the product of the diagonal entries. Thus, the determinant of $A$ is just the product of the diagonal entries of $U$ (which are also the pivots) times $(-1)^s$.

Problem 2. #image("TrefethenExercise203a.png")
Soln. 
#image("JohnProblem2Soln.jpg")

Remixed Problem. Find an expression for the $k"th"$ pivot when doing Gaussian Elimination on $A$, which is also the element $u_(k k) "of" U$ (assuming no row switches). We assume an LU factorization exists. Use this to kind of maybe explain why the leading principal minors are related to the existence of an LU factorization.\
Soln. Let $A_k$ be the _kth leading principal submatrix_ or basically the submatrix formed by the first k columns and rows. 
#image("JohnRemixProbSoln.jpg")
This sort of explains why the determinants of the leading principal submatrices have to be nonzero for an LU factorization to exist (without row swapping): the pivot expression depends on the inverse of $A_(k-1)$.