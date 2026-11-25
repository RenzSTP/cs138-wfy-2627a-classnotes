#import "../assets.typ": notes, definition, theorem, algorithm, example, note
#set math.mat(delim: "[")

#show: notes.with(
  title: [Gershgorin Circle Theorem],
  subtitle: [ Mini-Arc 4 · Part 7a · Compendium])

== Problem 1
*Exercise Set 9.3 Item 3.a.* Use the Gershgorin Circle Theorem to determine bounds for (a) the eigenvalues and (b) the spectral radius of the following matrices:
$ A = mat(1, 0, 0; -1, 0, 1; -1, -1, 2) $ (Burden & Faires, p. 576)

== Solution
By the Gershgorin Circle Theorem, all eigenvalues of $A$ lie in the union of the disks $D_i$, where each disk is centered at $a_{i i}$ with radius $R_i = sum_(j != i) |a_{i j}|$.

We calculate the disks for each row:
- Row 1: Center $a_{1 1} = 1$, Radius $R_1 = |0| + |0| = 0$. Thus, $D_1 = {z in CC: |z - 1| <= 0}$.
- Row 2: Center $a_{2 2} = 0$, Radius $R_2 = |-1| + |1| = 2$. Thus, $D_2 = {z in CC: |z| <= 2}$.
- Row 3: Center $a_{3 3} = 2$, Radius $R_3 = |-1| + |-1| = 2$. Thus, $D_3 = {z in CC: |z - 2| <= 2}$.

*(a) Bounds for the Eigenvalues* \ The eigenvalues must lie in the region $D_1 union D_2 union D_3$. Notice that $D_1$ (the point $z=1$) is completely contained within $D_3$. Therefore, the bounds for the eigenvalues are defined by the union of $D_2$ and $D_3$:
$ {z in CC: |z| <= 2} union {z in CC: |z - 2| <= 2} $

*(b) Bounds for the Spectral Radius* \ The spectral radius $rho(A)$ is the maximum absolute value of any eigenvalue $lambda$. 
- The maximum distance from the origin in $D_2$ is $2$.
- The maximum distance from the origin in $D_3$ occurs at $z = 4$ (by triangle inequality: $|z| = |z - 2 + 2| <= |z - 2| + 2 <= 4$).
Therefore, the spectral radius is bounded by $rho(A) <= 4$.

#pagebreak()

== Problem 2
*Exercise Set 9.3 Item 15.* Use the Gershgorin Circle Theorem to show that a strictly diagonally dominant matrix must be nonsingular. (Burden & Faires, p. 578)

== Solution
Let $A$ be an $n times n$ strictly diagonally dominant matrix. By definition, for every row $i$, the magnitude of the diagonal entry is strictly greater than the sum of the magnitudes of all other entries in that row:
$ |a_(i i)| > sum_(j != i) |a_(i j)| = R_i $

The Gershgorin disks for $A$ are defined as:
$ D_i = {z in bb(C) : |z - a_(i i)| <= R_i} $

For a matrix to be singular, $0$ must be one of its eigenvalues. If $0$ is an eigenvalue, by the Gershgorin Circle Theorem, it must lie in at least one of the disks $D_i$. 

Assume for the sake of contradiction that $0 in D_k$ for some row $k$. This would imply:
$ |0 - a_(k k)| <= R_k $
$ |a_(k k)| <= R_k $

This directly contradicts the strict diagonal dominance property $|a_(k k)| > R_k$. Therefore, $0$ cannot lie in any Gershgorin disk, meaning $0$ cannot be an eigenvalue of $A$. Since $0$ is not an eigenvalue, the matrix $A$ must be nonsingular. $qed$

#pagebreak()

== Remix Problem
Consider the matrix $M$ with an unknown real parameter $k$:
$ M = mat(4, -1, 0; -1, k, -1; -1, -1, 4) $

(a) Using the Gershgorin Circle Theorem's application to strict diagonal dominance, determine the range of values for $k$ that guarantees $M$ is nonsingular.

(b) Let $k = 4$. Use the Gershgorin Circle Theorem to determine the bounds for the eigenvalues and the spectral radius of $M$.

== Solution
*(a) Range of k for Nonsigularity* \
A strictly diagonally dominant matrix is nonsingular because its Gerhsgorin disks do not contain $0$. For $M$ to be strictly diagonally dominant, the magnitude of the diagonal entry in each row must strictly exceed the sum of the magnitudes of the other entries in that row:
- Row 1: $|4| > |-1| + |0| => 4 > 1$
- Row 2: $|k| > |-1| + |-1| => |k| > 2$
- Row 3: $|4| > |-1| + |-1| => 4 > 2$

Therefore, $M$ is guaranteed to be nonsingular for any real number $k$ such that $|k| > 2$, or in other words, when $k < -2$ or $k > 2$.

*(b) Eigenvalue and Spectral Radius Bounds* \
At $k = 4$, we have
$ M = mat(4, -1, 0; -1, 4, -1; -1, -1, 4) $

We construct the Gershgorin disks $D_i$ centered at $a_(i i)$ with radius $R_i = sum_(j != i) |a_(i j)|$:
- Row 1: Center $4$, Radius $1 + 0 = 1$. Thus, $D_1 = {z in CC: |z - 4| <= 1}$.
- Row 2: Center $4$, Radius $1 + 1 = 2$. Thus, $D_2 = {z in CC: |z - 4| <= 2)$.
- Row 3: Center $4$, Radius $1 + 1 = 2$. Thus, $D_3 = {z in CC: |z - 4| <= 2)$.

*Eigenvalue Bounds:* 
The eigenvalues are contained within the union $D_1 union D_2 union D_3$. Because $D_1$ is completely enclosed by the identical disks $D_2$ and $D_3$, the bounding region simplifies to:
$ {z in CC : |z - 4| <= 2) $

*Spectral Radius Bound:*
The spectral radius $rho(M)$ is the maximum possible magnitude $|z|$ for any eigenvalue in this region. Maximizing distance from the origin using the triangle inequality:
$ |z| = |z - 4 + 4| <= |z - 4| + 4 <= 2 + 4 = 6 $
Thus, the spectral radius is bounded by $rho(M) <= 6$.