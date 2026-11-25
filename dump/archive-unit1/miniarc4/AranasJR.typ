#import "../assets.typ": notes, definition, theorem, algorithm, example, note

#show: notes.with(
  title: [QR Factorization],
  subtitle: [Arc 4 · Part 7a · Compendium]
)

#set math.equation(numbering: none)

== Problem 1
*Exercise 15.* Find a QR factorization of the matrix. *(Lay, Lay, & Mcdonald, 2016, p.361)*

$ mat(delim: "[", 1, 2, 5; -1, 1, -4; -1, 4, -3; 1, -4, 7; 1, 2, 1) $

\
#underline[*Solution*]
\

Let the columns of $A$ be

$ a_1 = [1, -1, -1, 1, 1]^T $ $ a_2 = [2, 1, 4, -4, 2]^T $ $ a_3 = [5, -4, -3, 7, 1]^T $

We apply the Gram-Schmidt process.

\

*Find $q_1$*

$ norm(a_1) = sqrt(1^2 + (-1)^2 + (-1)^2 + 1^2 + 1^2) = sqrt(5). $



$ q_1 = frac(a_1, norm(a_1)) = 1 / sqrt(5) [1, -1, -1, 1, 1]^T. $

*Find $q_2$*

Compute the projection of $a_2$ onto $q_1$:

$ r_12 = q_1^T a_2 = 1 / sqrt(5) (2 - 1 - 4 - 4 + 2) = -sqrt(5). $

$ u_2 = a_2 - r_12 q_1 = a_2 + sqrt(5)q_1 = a_2 + a_1 $

$ = [3, 0, 3, -3, 3]^T. $

$ norm(u_2) = sqrt(3^2 + 3^2 + (-3)^2 + 3^2) = 6. $

$ q_2 = u_2 / norm(u_2) = [1/2, 0, 1/2, -1/2, 1/2]^T. $

*Find $q_3$*

First compute the projections of $a_3$:

$ r_13 = q_1^T a_3 = 1 / sqrt(5) (5 + 4 + 3 + 7 + 1) = 4sqrt(5). $

$ r_23 = q_2^T a_3 = 1/2 (5 - 3 - 7 + 1) = -2. $

$ u_3 = a_3 - r_13 q_1 - r_23 q_2 $

$ = a_3 - 4sqrt(5)q_1 + 2q_2 $

$ = [2, 0, 2, 2, -2]^T. $


We now get its norm which is:

$ norm(u_3) = sqrt(2^2 + 2^2 + 2^2 + (-2)^2) = 4. $



$ q_3 = u_3 / norm(u_3) = [1/2, 0, 1/2, 1/2, -1/2]^T. $

*Construct $Q$*

Using the values we just got from $q_1$, $q_2$, $q_3$, we can now make construct Q.
$ Q = mat(delim: "[", 1/sqrt(5), 1/2, 1/2; -1/sqrt(5), 0, 0; -1/sqrt(5), 1/2, 1/2; 1/sqrt(5), -1/2, 1/2; 1/sqrt(5), 1/2, -1/2). $

*Construct $R$*

Using the ff formula we can construct R (which is the upper triangular):

$ r_(i j) = q_i^T a_j, $

$ R = mat(delim: "[", sqrt(5), -sqrt(5), 4sqrt(5); 0, 6, -2; 0, 0, 4). $

Therefore, the QR factorization is

*$ A = Q R. $*


== Problem 2
*Exercise 23.* Suppose $A = Q R$ is a QR factorization of an $m times n$ matrix $A$ (with linearly independent columns). Partition $A$ as $[A_1 \, A_2]$, where $A_1$ has $p$ columns. Show how to obtain a QR factorization of $A_1$, and explain why your factorization has the appropriate properties. *(Lay, Lay, & Mcdonald, 2016, p.361)*

\
#underline[*Solution*]
\

*First, we do the block partitioning.*

Let $A = Q R$ be the given Q R factorization of the $m times n$ matrix $A$, where $Q$ is an $m times n$ matrix with orthonormal columns and $R$ is an $n times n$ upper triangular matrix.

We partition $A$ into two block columns:
$ A = mat(A_1, A_2, delim: "[") $
where $A_1$ is an $m times p$ matrix and $A_2$ is an $m times (n - p)$ matrix.

\

*We partition $Q$  into two blocks:*
$ Q = mat(Q_1, Q_2, delim: "[") $
where $Q_1$ consists of the first $p$ columns of $Q$ (dimension $m times p$), and $Q_2$ consists of the remaining $n - p$ columns.

*We partition $R$ into block components:*

$ R = mat(R_11, R_12; 0, R_22, delim: "[") $
*where:*
- $R_11$ is a $p times p$ upper triangular matrix.
- $R_12$ is a $p times (n - p)$ matrix.
- $R_22$ is an $(n - p) times (n - p)$ upper triangular matrix.
- The lower-left block consists entirely of zeros due to the upper triangular structure of $R$.

*Block Matrix Multiplication*.

Substituting these partitioned blocks into the equation $A = Q R$ yields:
$ mat(A_1, A_2, delim: "[") = mat(Q_1, Q_2, delim: "[") mat(R_11, R_12; 0, R_22, delim: "[") $

Carrying out the block matrix multiplication, we obtain:
$ mat(A_1, A_2, delim: "[") = mat(Q_1 R_11, Q_1 R_12 + Q_2 R_22, delim: "[") $

Equating the first block columns from both sides gives the relation:
$ A_1 = Q_1 R_11 $

*Verification of Properties.*

To establish that $A_1 = Q_1 R_11$ constitutes a valid reduced QR factorization for $A_1$, we verify the required conditions:

1. *Orthonormal Columns ($Q_1$):* Since the full matrix $Q$ has orthonormal columns ($Q^T Q = I_n$), any sub-matrix formed by a subset of its columns ($Q_1$) retains mutually orthonormal columns, such that $Q_1^T Q_1 = I_p$.
2. *Upper Triangular Matrix ($R_11$):* Because $R$ is an $n times n$ upper triangular matrix, its leading principal submatrix $R_11$ of size $p times p$ is also upper triangular.
3. *Linear Independence:* Since the original matrix $A$ has linearly independent columns, all diagonal entries of $R$ are non-zero, which ensures that the diagonal entries of $R_11$ are likewise non-zero and invertible.

*Thus, $A_1 = Q_1 R_11$ provides the exact QR factorization for $A_1$.*

\
\

== Remixed Problem



Let $A$ be the modified $5 times 3$ matrix:
$ A = mat(
  1, 1, 3;
  0, 2, -1;
  1, -1, 2;
  1, 0, 1;
  0, 1, 2;
  delim: "["
) $

*(a)* Compute the exact QR factorization $A = Q R$ using the Gram-Schmidt process, where $Q$ has orthonormal columns and $R$ is a $3 times 3$ upper triangular matrix.

*(b)* Partition the matrix $A$ as $[A_1  A_2]$, where $A_1$ consists of the first 2 columns. Using the block-partitioned form of your $Q$ and $R$ matrices from Part (a), extract the sub-matrices $Q_1$ and $R_11$ to explicitly write out the reduced QR factorization for $A_1$ (i.e., $A_1 = Q_1 R_11$).

\
#underline[*Solution*]
\

#set math.mat(delim: "[")

*(a) QR Factorization*

Let the columns of $A$ be $a_1$, $a_2$, and $a_3$.

We have $ a_1 = mat(1; 0; 1; 1; 0)$, $a_2 = mat(1; 2; -1; 0; 1) $, and $a_3 = mat(3; -1; 2; 1; 2) $

We start Gram-Schmidt with $a_1$. Its length is

$ norm(a_1) = sqrt(1^2 + 0^2 + 1^2 + 1^2 + 0^2) = sqrt(3) $

Normalizing $a_1$ gives the first orthonormal vector:

$ q_1 = a_1 / norm(a_1) = 1/sqrt(3) mat(1; 0; 1; 1; 0) $

The first diagonal entry of $R$ is the length of $a_1$:

$ r_11 = norm(a_1) = sqrt(3) $

For $a_2$, we first check how much of $a_2$ lies in the $q_1$ direction:

$ q_1^T a_2 = 1/sqrt(3) (1 + 0 - 1 + 0 + 0) = 0 $

The projection is zero, so $a_2$ is already orthogonal to $q_1$. We can use $a_2$ directly as the second Gram-Schmidt vector:

$ u_2 = a_2 = mat(1; 2; -1; 0; 1) $

Its length is

$ norm(u_2) = sqrt(1^2 + 2^2 + (-1)^2 + 0^2 + 1^2) = sqrt(7) $

Normalizing $u_2$ gives

$ q_2 = u_2 / norm(u_2) = 1/sqrt(7) mat(1; 2; -1; 0; 1) $.

The corresponding entries of $R$ are

$ r_12 = q_1^T a_2 = 0 $


$ r_22 = norm(u_2) = sqrt(7) $

For the third column, $a_3$ must be made orthogonal to both $q_1$ and $q_2$. We first find its two projections:

$ q_1^T a_3 = 1/sqrt(3) (3 + 0 + 2 + 1 + 0) = 2sqrt(3) $

$ q_2^T a_3 = 1/sqrt(7) (3 - 2 - 2 + 0 + 2) = 1/sqrt(7) = sqrt(7)/7 $

Remove these two components from $a_3$:

$ u_3 = a_3 - (q_1^T a_3)q_1 - (q_2^T a_3)q_2 $

$ u_3 = mat(6/7; -9/7; 1/7; -1; 13/7) $

The length of this vector is

$ norm(u_3) = sqrt((6/7)^2 + (-9/7)^2 + (1/7)^2 + (-1)^2 + (13/7)^2) = 4sqrt(21)/7 $

Normalize $u_3$ to obtain the third orthonormal vector:

$ q_3 = u_3 / norm(u_3) = mat(sqrt(21)/14; -3sqrt(21)/28; sqrt(21)/84; -sqrt(21)/12; 13sqrt(21)/84) $

The remaining entries in the third column of $R$ come from the projections we calculated:

$ r_13 = q_1^T a_3 = 2sqrt(3) $

$ r_23 = q_2^T a_3 = sqrt(7)/7 $

$ r_33 = norm(u_3) = 4sqrt(21)/7 $

Putting the three orthonormal vectors together gives

$ Q = mat(sqrt(3)/3, sqrt(7)/7, sqrt(21)/14; 0, 2sqrt(7)/7, -3sqrt(21)/28; sqrt(3)/3, -sqrt(7)/7, sqrt(21)/84; sqrt(3)/3, 0, -sqrt(21)/12; 0, sqrt(7)/7, 13sqrt(21)/84) $

Putting the coefficients together gives

$ R = mat(sqrt(3), 0, 2sqrt(3); 0, sqrt(7), sqrt(7)/7; 0, 0, 4sqrt(21)/7) $

#box(stroke: 1pt, inset: 6pt)[The product $Q R$ reconstructs $A$, so this gives the required QR factorization.]

*(b) QR Factorization of $A_1$*

The first two columns of $A$ are

$ A_1 = mat(1, 1; 0, 2; 1, -1; 1, 0; 0, 1) $.

From the $Q$ matrix in Part (a), we only need its first two columns because $A_1$ contains only the first two columns of $A$:

$ Q_1 = mat(sqrt(3)/3, sqrt(7)/7; 0, 2sqrt(7)/7; sqrt(3)/3, -sqrt(7)/7; sqrt(3)/3, 0; 0, sqrt(7)/7) $.

From $R$, we take the upper-left $2 times 2$ block:

$ R_11 = mat(sqrt(3), 0; 0, sqrt(7)) $

The multiplication of these two matrices gives

$ A_1 = Q_1 R_11 $

The columns of $Q_1$ remain orthonormal because they are columns of the original orthonormal matrix $Q$. The matrix $R_11$ remains upper triangular because it is the upper-left block of the upper triangular matrix $R$

#box(stroke: 1pt, inset: 6pt)[
  So $Q_1 R_11$ has exactly the properties required for a QR factorization of $A_1$. 
]


#set math.equation(numbering: "(1)")

== References
 1. Lay, David C., Steven R. Lay, and Judith McDonald. 2016. Linear Algebra and Its Applications