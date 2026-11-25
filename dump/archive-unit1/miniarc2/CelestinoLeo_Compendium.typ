CELESTINO, Leo \
2023-05694
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

#let problem(number: none, source: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #text(fill: ink, weight: "bold")[Compendium Problem #if number != none [#number]]
  #if source != none [ #text(size: 9pt, fill: midgray)[(Source: #source)]]
  #linebreak()
  #body
]

#problem(number: "1", source: "Burden & Faires, Chapter 6, Exercise Set 6.6")[
  Show that Gaussian elimination can be performed on $A$ without row interchanges if and only if all leading principal submatrices of A are nonsingular. [_Hint_: Partition each matrix in the equation
  $
  A^((k))=M^((k-1)) M^((k-2)) ... M^((1)) A
  $
  vertically between the $k$th and the $(k+1)$st columns and horizontally between the $k$th and the $(k+1)$st rows (see Exercise 14 of Section 6.3). Show that the nonsingularity of the leading principal submatrix of A is equivalent to $a^((k))_(k k) != 0$.
  ]
]
For the purposes of this problem, the matrix $A^((k))$ is the matrix obtained after multiplying A by its first $k$ Gaussian transformation matrices $M^((k-1)) M^((k-2)) ... M^((1))$. 

Each Gaussian transformation matrix performs one column's part of the Gaussian eliminations necessary to reduce the entries below $A_(k k)$ to $0$---i.e. each $M^((k))$ is the product of elementary matrices $E_(k, k+1) E_(k, k+2),...E_(k,n)$ where $E_(k,j)$ performs a row-addition operation on row $j$ using row $k$ to reduce all entries below the leading entry of row $k$ to $0$. For example (from the book): 
$
M^((1)) = mat(
  1, 0, dots, 0;
  -m_(2,1), 1, dots, 0; 
  -m_(3,1), 0, dots, 0; 
  dots.v, dots.down, dots.down, 0;
  -m_(n,1), 0, dots, 1
)
$
where
$
-m_(i,1) = a_(i,1) / a_(1,1)
$
This can be viewed as part of the product of elementary matrices $E_(1, 2) E_(1, 3),...E_(1, n)$ where $E_(i,1)$ uses $a_(1,1)$ to reduce all entries below the first row and first column to zero. 

This means that the matrix $A^((k))$ takes the form 
$
A^((k)) = mat(
  a^((k))_(1,1), a^((k))_(1,2), dots, a^((k))_(1,n),;
  0, a^((k))_(2,2), dots, a^((k))_(2, n),; 
  0, 0, dots, 0; 
  dots.v, dots.down, dots.down, a^((k))_(n-1,n);
  0, 0, dots, a^((k))_(n, n)
)
$
which is the leading principal submatrix of $A$, reduced to _row echelon form_ (not reduced row echelon form). 

The determinant of an upper triangular matrix is the product of all its entries $U_(i i)$ where $i in {1, ..., n}$, i.e. its diagonal entries; this can be proven using the cofactor expansion method of calculating a matrix determinant. 

The determinant of $A^((k))$ is therefore the product of its diagonal entries. This includes $A^((n))$, which is equivalent to the REF form of $A$. Note that there were no row scaling operations done, so their determinants should be equal.

A matrix is non-singular (invertible) if and only if its determinant is nonzero. The determinant of $A^((n))$ is nonzero if all its diagonal entries $a^( (k))_(k k)$ are nonzero, since multiplying any number by $0$ will only yield $0$. 

If this determinant obtained as-is is nonzero (i.e. no diagonal entries are $0$), then there 