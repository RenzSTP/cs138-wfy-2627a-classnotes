#import "assets.typ": notes, definition, theorem, algorithm, example, note
#set math.mat(delim: "[")

// STYLING

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

#set math.mat(delim: "[")


#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")



#let definition2(title: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #text(fill: ink, weight: "bold")[Definition #if title != none [(#title)].]
  #body
]

#let theorem2(title: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: 1pt + ink,
)[
  #text(fill: ink, weight: "bold")[Theorem #if title != none [(#title)].]
  #emph(body)
]

#let example(number: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + midgray),
)[
  #text(fill: ink, weight: "bold")[Example #if number != none [#number].]
  #body
]

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

#let remark(body) = block(
  fill: none,
  inset: (left: 10pt),
  width: 100%,
)[
  #text(style: "italic", fill: midgray)[Remark: ] #body
]


#let table_of_contents-subitem(title, page) = {
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: 0.5em,

    [#h(1em) #title],
    box(
      width: 100%,
      clip: true,
      repeat[.]
    ),
    [#page],
  )
}

/// END STYLING

// TITLE PAGE
#page(numbering: none)[
  #v(3em)
  #title[CLASS NOTES]
  #align(center)[
    #set text(size: 20pt) 
    #v(-1em)
    *- Approximating Eigenvalues -*
  ]
  
  #v(-0.5em)
  #align(center)[
    #set text(size: 12pt)    
    John Ray Aranas, Mikaela Dizon, Adrian Christian Domingo, \ Gabriel Ian Carl Matias, Daniel Dean Ognita, Samantha Mikaylah Reyes,\ Luis Antonio Sarmiento, Hanna Charisse Tingin 
  ]
  #align(center)[
    #set text(size: 10pt)
    September 24, 2026]
  
  #v(4em)
  
  #align(center)[Presented to  \ *UNIVERSITY OF THE PHILIPPINES\
  DEPARTMENT OF COMPUTER SCIENCE*
  ]
  
  #v(9em)
  #align(center)[
    In partial fulfillment of the course \
    *Elementary Numerical Computing II*
  ] #v(-0.5em)
  
  
  #v(1em)
  
  #pagebreak()
  
  #line(length: 100%)
  #text(size: 16pt, weight: "bold")[Contents]
  #v(-0.25em)

  
  #text(weight: "bold")[I. Methods for Approximating Eigenvalues]
  #table_of_contents-subitem[Power Method][83]
  #table_of_contents-subitem[Normalized Power Method][87]
  #table_of_contents-subitem[Inverse Power Method][91]
  #table_of_contents-subitem[Shifted Inverse Power Method][95]
  #table_of_contents-subitem[Gershgorin Circle Theorem][98]
  #table_of_contents-subitem[Rayleigh's Equation][101]
  #table_of_contents-subitem[QR Factorization][105]
  #text(weight: "bold")[II. Miscellaneous]
  #table_of_contents-subitem[Contributions][108]

  
  
  // #pagebreak()
]
// END TITLE PAGE







#show: notes.with(
  title: [The Power Method],
  subtitle: [ Arc 4 · Part 1 · Dominant Eigenvalues and the like],
)

= Usage

Factoring the characteristic polynomial is impractical for large $n$, and full matrix decompositions (like QR) cost $O(n^3)$. The power method relies on matrix–vector products ($A x$), making it fast for large, sparse matrices (and I think also memory efficient).

#definition(name: "Dominant Eigenvalue")[
  An eigenvalue $lambda_1$ is called *dominant* if its magnitude is strictly greater than that of all other eigenvalues:
  
  $ abs(lambda_1) > abs(lambda_2) >= abs(lambda_3) >= dots >= abs(lambda_n) $

  Its corresponding eigenvector $v_1$ is the *dominant eigenvector*. 
]
#note[
  Dominance is about magnitude $abs(lambda)$, not algebraic value. For instance, an eigenvalue of $-7$ dominates an eigenvalue of $+4$.
]

*Assumptions:*
To guarantee the derivation works smoothly, we assume:
+ *Strict gap:* $abs(lambda_1) > abs(lambda_2)$, so the dominant eigenvalue is unique in magnitude (no ties).
+ *Diagonalizable:* $A$ has $n$ linearly independent eigenvectors, allowing any initial vector to be expanded as $x^((0)) = sum_(i=1)^n c_i v_i$.
+ *Non-zero start:* The initial guess satisfies $c_1 != 0$ so that the component along $v_1$ exists to be amplified.

= Convergence
To see why the method works, express the initial guess $x^((0))$ as a linear combination of the eigenvectors:

$ x^((0)) = c_1 v_1 + c_2 v_2 + dots + c_n v_n $

Applying $A$ repeatedly $k$ times scales each eigenvector by its eigenvalue:

$ A^k x^((0)) = c_1 lambda_1^k v_1 + sum_(i=2)^n c_i lambda_i^k v_i $

Factoring out the dominant eigenvalue term $lambda_1^k$:

$ A^k x^((0)) = lambda_1^k (c_1 v_1 + sum_(i=2)^n c_i (lambda_i / lambda_1)^k v_i) $ <power-expansion>

Because $abs(lambda_1) > abs(lambda_i)$ for all $i >= 2$, the ratio satisfies $abs(lambda_i slash lambda_1) < 1$. As $k -> oo$, each power decays to zero:

$ (lambda_i / lambda_1)^k -> 0 quad ==> quad A^k x^((0)) approx lambda_1^k c_1 v_1 $

While the overall magnitude grows or shrinks by $lambda_1^k$, the *direction* of the vector rotates directly into alignment with $v_1$ (as long as $c_1 != 0$).

== Estimating the Eigenvalue

Once the vector aligns with the eigenvector ($y^((k)) approx c v_1$), applying $A$ simply scales it by $lambda_1$:

$ x^((k+1)) = A x^((k)) approx lambda_1 x^((k)) $

Looking at any coordinate $p$ where the entry is non-zero:

$ lambda_1 approx (x^((k+1)))_p / (x^((k)))_p $ <ratio-estimate>

#theorem(name: "Linear Convergence")[
  If $A$ is diagonalizable and $abs(lambda_1) > abs(lambda_2)$, the ratio estimate converges linearly to $lambda_1$ at a rate governed by $abs(lambda_2 slash lambda_1)$:

  $ abs(lambda^((k)) - lambda_1) = O(abs(lambda_2 slash lambda_1)^k) $
]

*Observations on the Rate:*
- *Dominance gap:* The ratio $abs(lambda_2 slash lambda_1)$ controls the speed. The smaller it is, the fewer iterations you need. If it is close to $1$, progress is very slow.
- *Initial guess impact:* A poor starting vector (where $c_1$ is small compared to $c_2$) delays convergence during the first few steps, but the *asymptotic rate* of error reduction per step is still roughly $abs(lambda_2 slash lambda_1)$.

#note(name: "Scaling is Free")[
  Multiplying $y^((k))$ by any non-zero scalar changes its length but preserves its direction and the ratio estimate in @ratio-estimate. This (invariance) is what allows the normalized power method to prevent underflow/overflow without altering the math.
]
= Example

To see the mechanics with less arithmetic, consider

$ A = mat(4, 2; 1, 3) $ <P_method_example>

The characteristic equation $(4 - lambda)(3 - lambda) - 2 = lambda^2 - 7 lambda + 10 = 0$ yields exact eigenvalues:

$ lambda_1 = 5, quad lambda_2 = 2 $

with dominant eigenvector $v_1 = mat(2; 1)$. 

The theoretical convergence rate is $abs(lambda_2 slash lambda_1) = 2/5 = 0.40$. Let's start with a generic guess $x^((0)) = mat(1; 1)$ and track the first coordinate ($p = 1$).

*Iteration 1:*
$ x^((1)) = A x^((0)) = mat(4, 2; 1, 3) mat(1; 1) = mat(6; 4) $
$ lambda^((1)) = (x^((1))) / (x^((0))) = 6 / 1 = 6.0 $

*Iteration 2:*
$ x^((2)) = A x^((1)) = mat(4, 2; 1, 3) mat(6; 4) = mat(32; 18) $
$ lambda^((2)) = (x^((2))) / (x^((1))) = 32 / 6 = 16 / 3 approx 5.333333 $

Carrying this forward:

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (center, center, center, center, center),
    table.header([$k$], [$x^((k))$], [$lambda^((k))$], [Abs. Error], [Error Ratio]),
    [$1$], [$(6, 4)$], [$6.000000$], [$1.000000$], [—],
    [$2$], [$(32, 18)$], [$5.333333$], [$0.333333$], [$0.333$],
    [$3$], [$(164, 86)$], [$5.125000$], [$0.125000$], [$0.375$],
    [$4$], [$(828, 422)$], [$5.048780$], [$0.048780$], [$0.390$],
    [$5$], [$(4156, 2094)$], [$5.019324$], [$0.019324$], [$0.396$],
  ),
  caption: [Unnormalized power iteration from $x^((0)) = (1, 1)$.],
)

Notice two things:
+ *Direction:* Looking at the vector entries, the ratio $x_1^((k)) slash x_2^((k))$ goes from $6/4 = 1.5$ to $4156/2094 approx 1.985$, aligning with the true eigenvector $v_1 = (2, 1)$.
+ *Convergence rate:* The error drops by roughly a factor of $0.4$ each iteration, matching the theoretical limit $abs(lambda^2 slash lambda^1) = 2/5 = 0.40$ as $k$ grows.

Also note that $norm(y^((k)))_oo$ grew from $1$ to over $4000$ in just five steps because each multiplication scales the vector roughly by $lambda_1 = 5$. This means the y values can get a lot of digits quickly, leading to rounding errors, truncation errors and the like .
= Algorithm

#algorithm(name: "Unnormalized Power Iteration")[
  *Inputs:* Matrix $A$, initial guess $x^((0))$, tolerance $epsilon$, max iterations $N$.

  + Choose a start vector $x^((0))$ (usually just all ones or random values—almost any arbitrary pick will have some component along $v_1$).
  + Pick an index $p$ where the entry is non-zero (commonly the entry with the largest magnitude to keep divisions stable).
  + For $k = 1, 2, dots, N$:
    - Compute $y = A x$.
    - Calculate eigenvalue estimate: $lambda^((k)) = y_p slash x_p$.
    - Check stopping criteria: stop if $abs(lambda^((k)) - lambda^((k-1))) <= epsilon abs(lambda^((k)))$ or if the residual $norm(y - lambda^((k)) x) <= epsilon$.
    - Update $x <- y$.
  + Output $lambda^((k))$ and the unit eigenvector $x slash norm(x)$.
]

*Notes on practical use:*
- *Cost per step:* Just one matrix–vector multiply per step ($O(n^2)$ for dense matrices, $O("nnz")$ if sparse). You only need to keep two vectors in memory, meaning no matrix inversions or factorizations required.
- *Iteration count:* Convergence depends purely on the ratio $abs(lambda_2 slash lambda_1)$. If the ratio is small, it converges in just a few iterations; if it's near $1$, it takes a massive number of steps ($k approx log(epsilon) slash log(abs(lambda_2 slash lambda_1))$).
- *Coding considerations:* The unnormalized loop works fine on paper for a few steps, but actual code should normalize $x <- y slash norm(y)$ inside the loop to avoid the overflow/underflow issues mentioned in the failure cases.
= When Does It Fail


+ *Tied Eigenvalues ($abs(lambda_1) = abs(lambda_2)$).*
  If distinct eigenvalues share the maximum absolute value, the sequence cannot isolate a single direction:
  - If $lambda_2 = -lambda_1$, the iterates flip back and forth between two directions, and the ratio estimate oscillates without settling.
  - If $lambda_(1,2) = a plus.minus b i$ are complex conjugate pairs (consider real non-symmetric matrices), this is similar to the previous case.
  
  _(If $lambda_1 = lambda_2$ share the same value and possess independent eigenvectors, the method does not fail; it converges to a vector in $"span"(v_1, v_2)$)._

+ *No Component Along $v_1$ ($c_1 = 0$).*
  If the initial vector has no constant along the dominant eigenvector ($c_1 = 0$), there is nothing for the method to amplify through multiplication. With exact calculation, it will converge to the next largest eigenvalue ($lambda_2$) instead.


+ *Overflow and Underflow.*
  Because $norm(y^((k)))$ scales asymptotically as $C abs(lambda_1)^k$:
  - $abs(lambda_1) > 1$ grows too quickly,precision limited by how many digits can be stored for calculation, not infinite in the case of machines.
  - $abs(lambda_1) < 1$ quickly approaches 0, following ratios are difficult to then evaluate due to truncation error or rounding error.
  
  Resolved typically through normalization.

+ *Eigenvalues are close in value ($abs(lambda_2) approx abs(lambda_1)$).*
  When the second eigenvalue is very close in magnitude to the first, the ratio $abs(lambda_2 slash lambda_1) = 1 - sigma$ is just below $1$. The method converges, but requires an enormous number of iterations. In that case, refer shifting methods ($A - sigma I$) or Rayleigh Quotient methods.


#pagebreak()
#show: notes.with(
  title: [The Normalized Power Method],
  subtitle: [Arc 4 · Part 2 · Rescaling per Iteration],
)

= Why normalize?

// The power method multiplies by $A$ over and over, so every iterate carries the factor
// $lambda_1^k$: for $abs(lambda_1) > 1$ the vector overflows, for
// $abs(lambda_1) < 1$ it flushes to zero, in both cases long before the direction has settled. The growth is pure scaling, and a nonzero scalar multiple carries the same direction. Dividing it out at every step keeps the iterate bounded.

Applying the Power Method repeatedly can result in a build-up in the obtained eigenvalues.  This can cause unnecessary difficulty in computation, as well as potential overflow and underflow errors.  It can be avoided by normalizing the obtained eigenvector in every iteration.


#definition(name: "Normalized iteration")[

\

  $ x^((k+1)) = (A x^((k))) / norm(A x^((k))), quad x^((0)) = "initial guess", norm(x^((0))) = 1. $



 *pivot ($infinity$-norm) scaling:* divide by the component of largest
    magnitude, sign included. If $abs((A x^((k)))_p) = norm(A x^((k)))_oo$ then
    $x^((k+1)) = (A x^((k))) slash (A x^((k)))_p$, so the pivot component of the
    new iterate is exactly $1$.\
    \
    Note that any norm can be used as a scaling factor.
]

= Algorithm

#algorithm(name: "Normalized iteration")[\
  + Pick a tolerance $epsilon$ and an iteration cap. Take $x^((0))$ with a
    nonzero component along the wanted eigenvector and normalize it.
  + Repeat: Compute $x^((k+1)) = A x^((k))$, then divide by $abs(abs(x^((k+1))))$.

  + Stop when $abs(lambda^((k)) - lambda^((k-1))) <= epsilon abs(lambda^((k)))$, or
    when $norm(A x - lambda^((k)) x) <= epsilon$.
  + Return $lambda$ and the normalized eigenvector $x slash norm(x)$.
]

= Example

Find a dominant eigenvector of 

$
  A = mat( 1, 4, 0; 1, 5, 0; 1, 3, 8, delim: "[") space space space "using"
  x^((0)) = mat(1;1;1; delim: "["),
$
*Characteristic Equation* (for checking):
$
  det(lambda I - A) &= mat(delim: "|", 
  lambda -1, -4, 0;
  -1, lambda -5, 0;
  -1, -3, lambda - 8
  )\
  0 &= (0) mat(delim: "|", 
  -1, lambda-5;
  -1, -3
  ) -
  (0) mat(delim: "|", 
  lambda -1, -4; 
  -1, -3
  ) + 
  (lambda-8) mat(delim: "|",
  lambda - 1, -4;
  -1, lambda-5
  )\
$
$
  0 &= 0 - 0 + (lambda-8)[(lambda-1)(lambda-5) - (-1)(-4)]\
  &= (lambda-8)(lambda^2-5lambda-lambda+4-5)\
  &= (lambda-8)(lambda^2-6lambda-1)\
$
*Eigenvalues:*
$
lambda = 8, 3 plus.minus 2 sqrt(2)

$

*Iteration 1:*
$ 
x^((1)) &= A x^((0)) = mat( 1, 4, 0; 1, 5, 0; 1, 3, 8, delim: "[") mat(1;1;1; delim: "[")\

x^((1)) &= mat(delim: "[", 5; 6; 12)\

x^((1))/abs(abs(x^((1))))_infinity &= 1/12 mat(delim: "[", 5; 6; 12)
= 
bold(mat(delim: "[", 5/12; 6/12; 1))\
$

*Iteration 2:*
$
  x^((2)) = A x^((1)) &= mat( 1, 4, 0; 1, 5, 0; 1, 3, 8, delim: "[") mat(delim: "[", 5/12; 6/12; 1)=mat(delim: "[", 29/12; 35/12; 119/12)\
  
  x^((2))/abs(abs(x^((2))))_infinity &= 12/119 mat(delim: "[", 29/12; 35/12; 119/12)   \=
  bold(mat(delim: "[", 29/119; 35/119; 1)) 
  
$

*Iteration 3:*
$
  x^((3)) = A x^((2)) &= mat( 1, 4, 0; 1, 5, 0; 1, 3, 8, delim: "[") mat(delim: "[", 29/119; 35/119; 1) =mat(delim: "[", 169/119; 204/119; 1086/119)\
  
  x^((3))/abs(abs(x^((3))))_infinity &= 119/1086 mat(delim: "[", 169/119; 204/119; 1086/119) =
  
  bold(mat(delim: "[", 169/1086; 204/1086; 1) ) \
$
*Iteration 4:*
$
  x^((4)) = A x^((3)) &= mat( 1, 4, 0; 1, 5, 0; 1, 3, 8, delim: "[") mat(delim: "[", 169/1086; 204/1086; 1) =mat(delim: "[", 985/1086; 1189/1086; 9469/1086)\
  
  x^((4))/abs(abs(x^((4))))_infinity &= 1086/9469 mat(delim: "[", 985/1086; 1189/1086; 9469/1086) =
  
  bold(mat(delim: "[", 985/9469; 1189/9469; 1)  )  
$
#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (center, center, center, center, center),
    table.header([$k$], [$x^((k)T)$], [$lambda^((k))$ before normalization], [Abs. Error], [Error Ratio]),
    [$1$], [$(5/12, 6/12, 1)$], [$12.000000$], [$4.000000$], [—],
    [$2$], [$(29/119, 35/119, 1)$], [$9.916667$], [$1.916667$], [$0.479$],
    [$3$], [$(169/1086, 204/1086, 1)$], [$9.126050$], [$1.126050$], [$0.588$],
    [$4$], [$(985/9469, 1189/9469, 1)$], [$8.719153$], [$0.719153$], [$0.639$],
    [$5$], [$(5741/80304, 6930/80304, 1)$], [$8.480727$], [$0.480727$], [$0.668$],
  ),
  caption: [Normalized power iteration from $x^((0)) = [1, 1, 1]$],
)
Notice that $x^((k))_3$ is the value that is always used as the scaling factor.  It also approaches 8 (an exact eigenvalue in A!) as we continue iterating before normalization.  The obtained vector $x^((k))_3$ also approaches the eigenvector$ [0, 0, 1]^T$ formed by 8. This implies that 8 is a dominant eigenvalue in matrix A.  


Now consider the #link(<P_method_example>)[*example* used in the ordinary Power Method]:
$ A = mat(4, 2; 1, 3) $ 
We apply the same method, but we apply normalization before we proceed to the next iteration.

*Iteration 1:*
$ x^((1)) = A x^((0)) = mat(4, 2; 1, 3) mat(1; 1) = mat(6; 4) $
$
abs(abs(x^((1))))_infinity = 6
$
$
x^((1))/abs(abs(x^((1))))_infinity &= 1/6 mat(6; 4)\
&= mat(1;2/3)
$
$ lambda^((1)) = (x^((1))) / (x^((0))) = 6 / 1 = 6$

*Iteration 2:*
$ x^((2)) = A x^((1)) = mat(4, 2; 1, 3) mat(1;2/3) = mat(16/3; 3) $
$
abs(abs(x^((2))))_infinity = 16/3
$
$
x^((2))/abs(abs(x^((2))))_infinity &= 3/16 mat(16/3; 3)\
&= mat(1;9/16)
$
#note[ 
The estimate of the dominant eigenvalue is exactly the same as the ordinary Power Method.
]

= When Does It Fail?

Since the Normalized Power Method is _still_ essentially just the Power Method, *apart from potentially creating overflow and underflow in values during iteration*, it follows that it retains the same weaknesses in finding dominant eigenvalues.

  + *Equivalent Eigenvalues.* $abs(lambda_2) = abs(lambda_1)$ still prevents the direction
    from settling and scaling cannot break a tie.
    
  + *No Component Along $v_1$ ($c_1 = 0$).* If the initial vector has no constant along the dominant eigenvector ($c_1 = 0$) such that it cannot be represented as a multiple of the dominant eigenvector,  there is nothing for the method to amplify through multiplication. With exact calculation, it will converge to the next largest eigenvalue ($lambda_2$) instead.
  
  + *Signs.* Pivot scaling keeps the sign of the pivot component, so when
    $lambda_1 < 0$ the iterates alternate in sign. An eigenvector is defined only up to sign, and the pivot convention picks one of the two.


#pagebreak()











#show: notes.with(
  title: [The Inverse Power Method],
  subtitle: [ Arc 4 · Part 3 · Smallest-magnitude eigenvalue],
)


== Idea

The power method gives the largest-magnitude eigenvalue. Run the same
iteration on $A^(-1)$ and it approaches the dominant eigenvalue of
$A^(-1)$, which is the reciprocal of the smallest-magnitude eigenvalue
of $A$.

#block(
  inset: 12pt,
  stroke: 1pt + black,
  radius: 2pt,
  width: 100%,
)[
  *Theorem: Reciprocal eigenpairs*

  If $A$ is invertible and $(lambda, v)$ is an eigenpair of $A$ with
  $lambda != 0$, then $(1/lambda, v)$ is an eigenpair of $A^(-1)$.

  From
  $A v = lambda v$, it follows that $A^(-1) v = 1/lambda v.$

  Thus, if
$0 < abs(lambda_1) < abs(lambda_2) <= dots <= abs(lambda_n),$ then $1/lambda_1$ is the dominant eigenvalue of $A^(-1)$.
]

== Convergence
Suppose $A$ is diagonalizable with eigenvectors
$v_1, dots, v_n$, and write the starting vector as

$
x^((0)) = c_1 v_1 + c_2 v_2 + dots + c_n v_n,
quad c_1 != 0.
$

Applying $A^(-1)$ repeatedly gives

$
A^(-k) x^((0))
= c_1 (1/lambda_1)^k v_1
+ c_2 (1/lambda_2)^k v_2
+ dots
+ c_n (1/lambda_n)^k v_n.
$

Factor out the dominant term:

$
A^(-k) x^((0))
=
(1/lambda_1)^k
[
  c_1 v_1
  + sum_(i=2)^n
    c_i (lambda_1/lambda_i)^k v_i
].
$

Since
$abs(lambda_1/lambda_i) < 1,
$ all the other terms approach zero as $k arrow infinity$.
Therefore, the direction approaches $v_1$, the eigenvector associated
with the *smallest-magnitude eigenvalue of* $A$.

The convergence is linear, with asymptotic rate $abs(lambda_1/lambda_2).$

The farther apart the two smallest eigenvalue magnitudes are, the
faster the convergence.

== Note: Don't Compute the Inverse

Although the theory is written as

$
x^((k+1)) = A^(-1) x^((k)),
$

we *don't compute* $A^(-1)$.

Instead, we solve the linear system $(A z^((k+1)) = x^((k)))$
for $z^((k+1))$, then normalize:

$
x^((k+1))
=
z^((k+1)) / norm(z^((k+1))).
$

For repeated iterations, $A$ can be factorized once: $A = L U.$

Then each iteration only requires
$
L y = x^((k)),
quad
U z^((k+1)) = y.
$
== Example

Consider the example:

$
A =
mat(
  3, 1;
  1, 3
),
quad
x^((0)) =
mat(
  1;
  0
).
$

The eigenvalues of $A$ are $4$ and $2$, so we expect inverse iteration
to approach the eigenpair associated with $(lambda_"min" = 2)$.

Instead of calculating $A^(-1)$, we solve for
$A z^((1)) = x^((0))$ as our Iteration 1.

Thus,

$
mat(
  3, 1;
  1, 3
)
mat(
  z_1;
  z_2
)
=
mat(
  1;
  0
).
$

gives us the system $3 z_1 + z_2 = 1,
quad
z_1 + 3 z_2 = 0.
$

Solving for the values of $z_1$ and $z_2$, we get:

$
z_1 = 3/8,
quad
z_2 = -1/8.
$

This gives us the result:

$
z^((1))
=
mat(
  3/8;
  -1/8
).
$

Using the infinity norm, we have

$
parallel z^((1)) parallel_infinity = 3/8,
$ so $ x^((1))
=
z^((1)) / (parallel z^((1)) parallel_infinity)
=
mat(
  1;
  -1/3
).
$

=== Iteration 2

We now solve for $A z^((2)) = x^((1))$.

Thus,

$
mat(
  3, 1;
  1, 3
)
mat(
  z_1;
  z_2
)
=
mat(
  1;
  -1/3
).
$

gives us the system $3 z_1 + z_2 = 1,
quad
z_1 + 3 z_2 = -1/3.
$

Solving for $z_1$ and $z_2$, we get:

$
z_1 = 5/12,
quad
z_2 = -1/4.
$

This gives us the result:

$
z^((2))
=
mat(
  5/12;
  -1/4
),
$

and

$
x^((2))
=
mat(
  1;
  -3/5
).
$

Continuing the process, we end up with:

$
x^((k))
arrow
mat(
  1;
  -1
),
$

This is an eigenvector corresponding to $(lambda = 2).$

Overall, we can conclude that the inverse power method isolates the
smallest-magnitude eigenvalue, whereas the ordinary power method
would approach $lambda = 4$.

== Algorithm

#block(
  inset: 12pt,
  stroke: 1pt + black,
  radius: 2pt,
  width: 100%,
)[
  *Algorithm: Inverse Power Method*

  + Choose an initial nonzero vector $x^((0))$.

  + If using LU decomposition, factorize $A = L U$ once.

  + For $k = 0, 1, 2, dots$, solve $A z^((k+1)) = x^((k))$ using $L y = x^((k)), quad U z^((k+1)) = y.$

  + Normalize:
    $
    x^((k+1))
    =
    z^((k+1)) / norm(z^((k+1))).
    $

  + Estimate the corresponding eigenvalue and stop once the estimate/residual has converged.

  + Compute the smallest-magnitude eigenvalue and its eigenvector.
]

== When Does It Fail?
+ *Singular matrix.* If $A$ has an eigenvalue $lambda = 0$, then
  $A^(-1)$ does not exist and the linear system may not have a unique
  solution.
+ *Similar smallest eigenvalues.* If $abs(lambda_1) approx abs(lambda_2),$ then $abs(lambda_1/lambda_2) approx 1.$ From this, we can conclude that convergence can be very slow.
+ *Unsuitable starting vector.* If $x^((0))$ has no component along the
  desired eigenvector, inverse iteration can't amplify that direction.
+ *Ill-conditioning.* If $A$ is nearly singular, solving
  $A z = x^((k))$ can become numerically sensitive.



#pagebreak()

#show: notes.with(
  title: [The Shifted Inverse Power Method],
  subtitle: [Arc 4 · Part 4 · Targeting an eigenvalue closest to chosen $sigma$],
)

== Idea

While the regular Inverse/Power methods provide the smallest/largest eigenvalues, we can use the Shifted Inverse Power Method to find the other eigenvalues of a matrix.

Shifting targets different eigenvalues depending on the scalar $sigma$, we have

$ (A - sigma I) v = (lambda - sigma) v, $

so the eigenpairs of $(A - sigma I)^(-1)$ are $(1 slash (lambda - sigma), v)$ with
the *same* eigenvectors as $A$. Inverse iteration on $A - sigma I$ therefore
converges to the eigenvalue whose distance to $sigma$ is smallest.

#definition(name: "Shift and target")[
  $sigma$ is called the *shift*. This must not be an eigenvalue of $A$, so that
  $A - sigma I$ is invertible, and the iteration then converges to
   the eigenvalue of $A$ closest to
  $sigma$, with $v_t$ as its eigenvector.
]

#theorem(name: "Rate")[
  Let $sigma$ be a shift that is not an eigenvalue of A, and let $lambda_t$ be the eigenvalue closest to $sigma$. The directional error decays at the rate of
  $(abs(lambda_t - sigma) / abs(lambda_s - sigma))^k$, where $lambda_s$ is the
  second-closest eigenvalue to $sigma$ among those present in the initial vector $x^((0))$. Consequently, a closer initial guess to the closest eigenvalue results in faster convergence as it yields a smaller ratio.
]
== Example
Consider the following example:
$
A =
mat(
  4, 1;
  1, 3
),
quad
x^((0)) =
mat(
  1;
  1
), 
quad
sigma = 2
$
Suppose we want to find the eigenvalue of $A$ closest to the target shift $sigma$ = 2. To do so, we apply the Inverse Power Method to the shifted matrix $(A - sigma I)$. Computing for our shifted matrix, we have:

$
A - 2 I =
mat(
  4-2, 1;
  1, 3-2
) = 
mat(
  2, 1;
  1, 1
)
$

=== First Iteration
As mentioned earlier in the Inverse Power Method, instead of explicitly computing for the inverse, we will be solving $(A - 2 I) z^((1)) = x^((0))$ for our first iteration. That is,
$
mat(
  2, 1;
  1, 1
)
mat(
  z_1;
  z_2
) =
mat(
  1;
  1
)
$
Solving for $z^((1))$ gives us the result
$
z^((1)) = 
mat(
  0;
  1
)
$
Using the infinity norm, $parallel z^((1)) parallel_infinity = 1,$ we normalize the acquired result, so that
$
x^((1)) = 
z^((1))/(parallel z^((1))parallel_infinity)
= 
1/1
mat(
  0;
  1
)
=
mat(
  0;
  1
)
$
Calculating the estimate for this iteration, we have
$
lambda^((1)) = 1/1 + 2 = 3
$
=== Second Iteration
For this iteration, we now solve $(A - 2 I) z^((2)) = x^((1))$.
$
mat(
  2, 1;
  1, 1
)
mat(
  z_1;
  z_2
) =
mat(
  0;
  1
)
$
Solving this once again gives us
$
z^((2)) = 
mat(
  -1;
  2
)
$

Using the infinity norm, $parallel z^((2)) parallel_infinity = 2,$ we normalize the acquired result, so that
$
x^((2)) = 
z^((2))/(parallel z^((2))parallel_infinity)
= 
1/2
mat(
  -1;
  2
)
=
mat(
  -0.5;
  1
)
$
Calculating the estimate for this iteration, we have
$
lambda^((2)) = 1/2 + 2 = 2.5
$
== How do we get the shift $sigma$?
From the example above, the shift $sigma$ is already provided, but there are different ways on how we can find a decent value for it if not given.
+ An eigenvalue already computed by the Inverse Power Method/Power Method
+ *Gershgorin Disc Theorem*: Since this gives us a range of where eigenvalues may be, we can use the resulting circles to have a more accurate guess.
+ *Rayleigh Quotient*: We can update the shift at each iteration using the normalized vector acquired, which produces an increasingly accurate target shift.

== Algorithm
#algorithm(name: "Shifted Inverse Power Method")[
  + Take a nonzero starting vector $x^((0))$, and a shift $sigma$ (you can derive this from any of the ways mentioned above)
  + If using LU decomposition, factorize $(A - sigma I) = L U$ once.
  + For $k = 0, 1, 2, ...,$ solve $(A-sigma I)z^((k+1))=x^((k))$ using $L y = x^((k)), quad U z^((k+1)) = y.$
  + Normalize:
    $
    x^((k+1))
    =
    z^((k+1)) / norm(z^((k+1))).
    $
  + Estimate the corresponding eigenvalue and stop once it has converged.
  + Compute the final eigenvalue and eigenvector.
]

== Convergence Issues
+ *When $sigma$ is equidistant from two eigenvalues.* This creates a tie, making it a similar convergence problem to having two similar eigenvalues in the previous methods.
+ *When $sigma$ is too far away.* Since the convergence is determined by the ratio of the two smallest distances, a far guess would result in many iterations required. While the method doesn't fail here, it will suffer from slow convergence.

= References
+ Delft Institute of Applied Mathematics from the TU Delft University of Technology. (2025) 9.3. The power method — Linear algebra. Retrieved September 23, 2026, from https://interactivetextbooks.tudelft.nl/linear-algebra/Chapter9/PowerMethod.html
+ Harvey Mudd College. (2020) The Power Methods for Eigenvalue problems. Retrieved September 23, 2026, from https://pages.hmc.edu/ruye/MachineLearning/lectures/ch1/node3.html
+ H. Fawzi. (2022) Numerical Analysis – Lecture 21. Retrieved September 23, 2026, from https://www.damtp.cam.ac.uk/user/hf323/M22-II-NA/Lect21.pdf

// =========================================================

//                         GROUP 8

// =========================================================

#pagebreak()
#show: notes.with(
  title: [Gershgorin Circle Theorem],
  subtitle: [ Arc 4 · Part 5 · Bounding Eigenvalues],
)

== Idea
The previous methods discussed are only efficient for $3 times 3$ matrices, or when we have a rough idea on what the true eigenvalues are. For larger matrices, these methods rely on trial and error, and are often impractical.

Instead of calculating the exact values, we can identify a specific "range" or region on the complex plane in which eigenvalues are guaranteed to exist.

== Derivation
We begin with the standard eigenvalue equation: 
$ A v = lambda v $ 
where $A = [a_(i j)]$ and $v = [v_i]$

Let $v_i$ be the entry in the eigenvector $v$ with the largest absolute magnitude, or let $|v_i| = max{|v_k|}$. 
By focusing on the $i^(t h)$ row of the matrix multiplication $A v = lambda v$, we get: 
$ sum_(c=1)^n a_(i c) v_c = lambda v_i $ 
#note[This is similar to factoring out $lambda^((k))$ in the normalized power method.]

We pull out the diagonal term $c = i$ 
$ a_(i i)v_i + sum_(c = 1, c != i)^n a_(i c) v_c = lambda v_i $ 

Rearranging the equation, we get 
$ sum_(c = 1, c != i)^n a_(i c) v_c = lambda v_i - a_(i i)v_i $ 
$ sum_(c = 1, c != i)^n a_(i c) v_c = (lambda - a_(i i)) v_i $ 

Dividing both sides by our maximum eigenvector entry $v_i$, we have 
$ sum_(c = 1, c != i)^n (a_(i c) v_c)/v_i = lambda - a_(i i) $

Taking the absolute value of both sides, 
$ abs(sum_(c = 1, c != i)^n (a_(i c) v_c)/v_i) = abs(lambda - a_(i i)) $ 

By the triangle inequality, we now have an upper bound for our eigenvalue:
$ abs(lambda - a_(i i)) <= sum_(c = 1, c != i)^n abs((a_(i c) v_c)/v_i) $

Since we have defined $v_i$ to be the largest eigenvector entry, we know that $v_c/v_i <= 1$. Thus, we can substitute $1$ for this fraction
$ abs(lambda - a_(i i)) <= sum_(c = 1, c != i)^n abs((a_(i c) v_c)/v_i) <= sum_(c = 1, c != i)^n abs(a_(i c)) dot abs(1) $

Simplifying, we get
$ abs(lambda - a_(i i)) <= sum_(c = 1, c != i)^n abs(a_(i c)) $
\
#theorem(name: "Gershgorin Discs")[
  For any complex eigenvalue and row $i$,
  $ abs(lambda - a_(i i)) <= sum_(c = 1, c != i)^n abs(a_(i c)) $

  This region is called the Gershgorin Disc. An $n times n$ matrix has $n$ Gershgorin discs. \
  When constructing each disc, we have the following properties:
  - the disc is centered at the diagonal entry $a_(i i)$
  - the radius of the disc is the sum of the non-diagonal entries of the row $i$
  - the discs are plotted on the complex plane

  The theorem states that the eigenvalues of $A$ can be found inside ANY of the matrix's Gershgorin discs. 

  *Theorem Extensions*
  + If a Gershgorin Disc is completely isolated by itself, there must be an eigenvalue in it.
  + If there are $k$ overlapping discs, there must be exactly $k$ eigenvalues (including repeated eigenvalues) in the union of these overlapping Discs.
]

== Example
Consider the following $3 times 3$ matrix:
$ A = mat(1, 3, 8; 3, 1, 3; 8, 3, 1) $

Constructing the Gershgorin Discs, we have: 

Disc 1: $|lambda - 1| <= |3| + |8| => |lambda - 1| <= 11$
- centered at $1$
- spans from $-10$ to $12$

Disc 2: $|lambda - 1| <= |3| + |3| => |lambda - 1| <= 6$
- centered at $1$
- spans from $-5$ to $7$

Disc 3: $|lambda - 1| <= |8| + |3| => |lambda - 1| <= 11$
- centered at $1$
- spans from $-10$ to $12$

All three discs share the same center and overlap entirely. The union of these discs is the boundary of the largest one (Disc 1 and 3), which spans from $-10$ to $12$. Because $k=3$, the union of these discs contain all $3$ eigenvalues. 

Solving for the three eigenvalues by the characteristic polynomial, we will get
$ lambda_1 = -7 $
$ lambda_2 = 5 + sqrt(34) approx 10.83 $
$ lambda_3 = 5 - sqrt(34) approx -0.83 $

All true eigenvalues indeed lie within the union of the three discs.

#pagebreak()
#show: notes.with(
  title: [Rayleigh's Quotient],
  subtitle: [ Arc 4 · Part 6 · The Scalar Estimate for eigenvalues],
)

== Derivation

Notice that for a symmetric matrix $A$ ($A^T = A$, $||A||_2 = rho(a)$), we have:
#align(center)[$A x = lambda x$]
#align(center)[$=> x^T A x = x^T (lambda x) = lambda x^T x$]
#align(center)[$=> lambda_min <= lambda^* = frac(x^T A x, x^T x) <= lambda_max$]
\
#definition(name: "Rayleigh's Quotient")[
  Given a symmetric matrix $A$, let the approximate eigenvalue $lambda^*$ be the following:
  
  \ #text(size: 1.5em)[#align(center)[$lambda^* = frac(x^T A x, x^T x)  $]]\

  where $x$ is an eigenvector approximation
]

#note[
  Rayleigh's Quotient is essentially a *modified inverse power method*, but converges faster.
]

== Procedure
1. Select an initial random vector $x^((0))$ with a largest entry 1 ($||x^((0))|| = 1$).
2. Get the first approximate eigenvalue $lambda^((0))$ with $x^((0))$.

  #align(center)[$lambda^((0))=rho(x^((0)))= frac((x^((0)))^T A x^((0)), (x^((0)))^T x^((0)))$]

3. For iteration k = 0, 1, 2, ...: 
#h(1cm) a) Get $y^((k))$ by solving the following system:
#align(center)[$(A - lambda^((k)) I) y^((k)) = x^((k))$]
#h(1cm) b) Get largest absolute entry of $y^((k))$: $||y^((k))||_(infinity)$

#h(1cm) c) Get $x^((k+1))$ by dividing $y^((k))$ by $||y^((k))||_(infinity)$
#align(center)[$x^((k+1))=frac(y^((k)), ||y^((k))||_infinity)$]

#h(1cm) d) Get the next approximate eigenvalue $lambda^((k+1))$ using Rayleigh's Quotient
#align(center)[$lambda^((k+1))=rho(x^((k+1)))= frac((x^((k+1)))^T A x^((k+1)), (x^((k+1)))^T x^((k+1)))$]

#h(1cm) e) Stop when the difference in between iterations is less than $epsilon$.

#note[Each iteration triples the number of digits of accuracy! (Trefethen & Bau, 1997)]

== Why This Works
For any $mu in RR$ that is not an eigenvalue of matrix $A$. The eigenvectors of $A$ would be the same as the eigenvectors of $(A - mu I )^(-1)$, and the corresponding eigenvalues are ${(lambda_j - mu)^(-1)}$ where ${lambda_j}$ are eigenvalues of $A$. 

Assume $mu$ is approximately the same as an $lambda_j$ of matrix $A$. Hence, $(lambda_J - mu)^(-1)$ could be  larger than $(lambda_j - mu)^(-1)$ for every $j != J$. If we apply power iteration to $(A - mu I)^(-1)$, it will rapidly converge to $q_J$. 

= Example
Given

#align(center)[$A= mat(1,3,8; 3, 1, 3; 8, 3, 1,  delim: "["), lambda = 5 + sqrt(34) approx 10.830952$]

1. Select a guess vector $x^((0))$, for this, we can just use a generic vector:
#align(center)[$x = mat(1; 1; 1, delim: "[")$]
\
2. Get first approximate eigenvalue $lambda^((0))$ with $x^((0))$:
#align(center)[$lambda^((0)) =mat(1; 1; 1, delim: "[")^T mat(1, 3, 8; 3, 1, 3; 8, 3, 1, delim: "[")mat(1; 1; 1, delim: "[") div mat(1; 1; 1, delim: "[")^T mat(1; 1; 1, delim: "[") $]
#align(center)[$=> mat(1, 1, 1, delim: "[") mat(1, 3, 8; 3, 1, 3; 8, 3, 1, delim: "[") mat(1; 1; 1, delim: "[") div mat(1, 1, 1, delim: "[") mat(1; 1; 1, delim: "[") $]
#align(center)[$=> mat(12, 7, 12, delim: "[")  mat(1; 1; 1, delim: "[") div 3 $]
#align(center)[$=> 31/3 approx 10.333333...$]

=== For k = 0:
#line(length: 4em)
0a) Get $y^((0))$ by solving the following system:
#align(center)[$(A - lambda^((0)) I) y^((0)) = x^((0))$]
#align(center)[$=> mat(1-31/3,3,8; 3, 1-31/3, 3; 8, 3, 1-31/3,  delim: "[") mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") = mat(1; 1; 1, delim: "[")$]
#align(center)[$=> mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") = mat(-28/3,3,8; 3, -28/3, 3; 8, 3, -28/3,  delim: "[")^(-1)mat(1; 1; 1, delim: "[")$]

#align(center)[$=> mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") = mat(0.8111, 0.5400, 0.8688; 0.5400, 0.2400, 0.5400; 0.86888, 0.5400, 0.8111,  delim: "[")mat(1; 1; 1, delim: "[")$]

#align(center)[$=>mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") =mat(2.220000; 1.320000; 2.220000, delim: "[")$]

#note[For Casio fx-991EX calculators, you can use $"MatX"^(-1)$ to calculate the inverse of a matrix.]

0b) Get largest absolute entry of $y^((0))$: $||y^((0))||_(infinity)$

#align(center)[$||mat(2.220000; 1.320000; 2.220000, delim: "[")||_(infinity) = 2.200000$]

0c) Get $x^((1))$ by dividing $y^((0))$ by $||y^((0))||_(infinity)$
#align(center)[$x^((1))= 1/2.200000 mat(2.220000; 1.320000; 2.220000, delim: "[") = mat(1.000000; 0.594594; 1.000000, delim: "[")$]

0d) Get the next approximate eigenvalue $lambda^((1))$ using Rayleigh's Quotient

#align(center)[$lambda^((1))=rho(x^((1)))= frac((x^((1)))^T A x^((1)), (x^((1)))^T x^((1)))$]

#align(center)[$=>mat(1.000000; 0.594594; 1.000000, delim: "[")^T mat(1, 3, 8; 3, 1, 3; 8, 3, 1, delim: "[") mat(1.000000; 0.594594; 1.000000, delim: "[") div mat(1.000000; 0.594594; 1.000000, delim: "[")^T mat(1.000000; 0.594594; 1.000000, delim: "[")$]

#align(center)[$=>mat(1.000000, 0.594594, 1.000000, delim: "[") mat(1, 3, 8; 3, 1, 3; 8, 3, 1, delim: "[") mat(1.000000; 0.594594; 1.000000, delim: "[") div mat(1.000000, 0.594594, 1.000000, delim: "[") mat(1.000000; 0.594594; 1.000000, delim: "[")$]

#align(center)[$=>mat(1.000000, 0.594594, 1.000000, delim: "[") mat(1, 3, 8; 3, 1, 3; 8, 3, 1, delim: "[") mat(1.000000; 0.594594; 1.000000, delim: "[") div mat(1.000000, 0.594594, 1.000000, delim: "[") mat(1.000000; 0.594594; 1.000000, delim: "[")$]

#align(center)[$=>mat(10.783782, 6.594594, 10.783782, delim: "[")  mat(1.000000; 0.594594; 1.000000, delim: "[") div 2.353542$]

#align(center)[$=>25.488670/ 2.353542approx 10.829919$]

=== For k = 1:
#line(length: 4em)
1a) Get $y^((1))$ by solving the following system:
#align(center)[$(A - lambda^((1)) I) y^((1)) = x^((1))$]
#align(center)[$=> mat(1-10.822919,3,8; 3, 1-10.822919, 3; 8, 3, 1-10.822919,  delim: "[") mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") = mat(1.000000; 0.594594; 1.000000, delim: "[")$]
#align(center)[$=> mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") = mat(-9.822919,3,8; 3, -9.822919, 3; 8, 3, -9.822919,  delim: "[")^(-1)mat(1; 1; 1, delim: "[")$]

#align(center)[$=>mat(y_1^((0));y_2^((0));y_3^((0)), delim: "[") =mat(964.521200;588.665322;964.521200, delim: "[")$]

1b) Get largest absolute entry of $y^((1))$: $||y^((1))||_(infinity)$

#align(center)[$||mat(964.521200;588.665322;964.521200, delim: "[")||_(infinity) = 964.521200$]

1c) Get $x^((2))$ by dividing $y^((1))$ by $||y^((1))||_(infinity)$
#align(center)[$x^((2))= 1/964.521200 mat(964.521200;588.665322;964.521200, delim: "[") = mat(1.000000; 0.610317; 1.000000, delim: "[")$]

1d) Get the next approximate eigenvalue $lambda^((2))$ using Rayleigh's Quotient

#align(center)[$lambda^((2))=rho(x^((2)))= frac((x^((2)))^T A x^((2)), (x^((2)))^T x^((2)))$]

#align(center)[$=>mat(1.000000; 0.610317; 1.000000, delim: "[")^T mat(1, 3, 8; 3, 1, 3; 8, 3, 1, delim: "[") mat(1.000000; 0.610317; 1.000000, delim: "[") div mat(1.000000; 0.610317; 1.000000, delim: "[")^T mat(1.000000; 0.610317; 1.000000, delim: "[")$]


#align(center)[$=>25.696291... div 2.372487... approx$ #box(stroke: black, outset: 0.2em)[10.830952]]


\
We repeat iterations until a specific condition (relative to the true eigenvalue or relative to the difference in between iterations) is satisfied.
== When Does It Fail?
We use Rayleigh's Quotient to speed up the convergence of a symmetric matrix, but it is not applicable in all scenarios.

-  *Nonsymmetric Matrix.* Although it may still work for those with _fairly symmetric_ eigenvectors, it is still not recommended since it will take a much longer time as it loses its cubic convergence.

- *Starting vector $x^((0)) = mat(0;0;0, delim: "[")$*. With this vector, the approximate eigenvalue simply diverges since you cannot divide by 0.


= References
1. Lay, D., Lay, S., & McDonald, J. (2015). _Linear Algebra and its Applications_.

2. Trefethen, L. &  Bau, D. (1997). _Numerical Linear Algebra_.

#pagebreak()
#show: notes.with(
  title: [QR Factorization],
  subtitle: [ Arc 4 · Part 7 · Orthogonal Decomposition],
)

\ #definition(name: "QR Decomposition")[ \
Every real  $n times n$ matrix $A $ can be factored into the product of an orthogonal matrix and an upper-triangular matrix:

#text(size: 1.5em)[#align(center)[$A = Q R$]]\

where $Q$ is an orthogonal matrix and $R$ is an upper-triangular matrix. A matrix $Q$ is orthogonal if: $ Q^T Q = I $
Therefore, $ Q^(-1) = Q^T $
The orthogonal property of $Q$ allows orthogonal transformations to preserve vector lengths and angles, which allows for more numerically stable transformations.


#block(
  width: 100%,
  inset: 0.8em,
  radius: 4pt,
  stroke: 0.8pt,
)[ #text(size: 0.7em)[
To construct $Q$ and $R$, we can apply the Gram-Schmidt process to the columns of $A$.

The *Gram-Schmidt* process can be summarized as

#text(size: 1.2em)[#align(center)[$ A
-> (a_1, a_2, ..., a_n)
-> (q_1, q_2, ..., q_n)
-> Q -> R $]]

Each $q_j$ is obtained by removing the components of $a_j$ in the directions of the previously constructed $q_i$'s, then normalizing the resulting vector.

Let

#text(size: 1.2em)[#align(center)[$ A = [a_1 | a_2 | ... | a_n], quad Q = [q_1 | q_2 | ... | q_n]. $]]

For each column $a_j$, define

#text(size: 1.1em)[#align(center)[$
v_j = a_j - sum_(i=1)^(j-1) r_(i j) q_i $]]

and normalize it to obtain

#text(size: 1.1em)[#align(center)[$
q_j = v_j / norm(v_j)_2. $]]

The coefficients are given by
#text(size: 1.1em)[#align(center)[$
r_(i j) = q_i dot a_j. $]]

Finally,

#text(size: 1.1em)[#align(center)[$
R = Q^T A. $]]
  ]
]
]




\ #definition(name: "QR Iteration")[
  
\ QR Iteration repeatedly applies QR decomposition to obtain a sequence of matrices.

*Starting with $A^0 = A$, at step $k$:*

1. Compute the QR decomposition:
   $ A^k = Q^k R^k $
2. Re-multiply factors in reverse order:
   $ A^(k+1) = R^k Q^k $

]

= Example
#set math.mat(delim: "[")

Let us apply one iteration of the QR method to the matrix given in the problem from Burden and Faires.

$ A = mat(
3, 1, 0;
1, 3, 1;
0, 1, 3
) $


Step 1: QR decomposition using Gram-Schmidt

$ v_1 = a_1 = mat(3; 1; 0), quad
r_(1 1) = norm(v_1)_2 = sqrt(10) approx 3.1623 $

$ q_1 approx mat(0.9487; 0.3162; 0) $

$ r_(1 2) = q_1 dot a_2 approx 1.8974 $

$ v_2 approx mat(-0.8; 2.4; 1), quad
r_(2 2) approx 2.7203, quad
q_2 approx mat(-0.2941; 0.8823; 0.3676) $

$ r_(1 3) = q_1 dot a_3 approx 0.3162 $

$ r_(2 3) = q_2 dot a_3 approx 1.9851 $

$ v_3 approx mat(0.2838; -0.8514; 2.2703), quad
r_(3 3) approx 2.4412, quad
q_3 approx mat(0.1162; -0.3487; 0.9300) $

Therefore,

$ Q approx mat(
0.9487, -0.2941, 0.1162;
0.3162, 0.8823, -0.3487;
0, 0.3676, 0.9300
) $

$ R approx mat(
3.1623, 1.8974, 0.3162;
0, 2.7203, 1.9851;
0, 0, 2.4412
) $

Step 2: QR iteration

$ A^(1) = R Q $

$ A^(1) approx
mat(
3.6000, 0.8602, 0.0000;
0.8602, 3.1297, 0.8974;
0.0000, 0.8974, 2.2703
) $

Since $A$ is symmetric, $A^(1)$ is also symmetric. Repeating the QR iteration causes the off-diagonal entries to approach zero, while the diagonal entries approach the eigenvalues of $A$.



= Why It Works?
\ Since $R^k = (Q^k)^T A^k$, we have:
$ A^(k+1) = (Q^k)^T A^k Q^k $
This is a *similarity transformation*, meaning $A^(k+1)$ and $A^k$ share the same eigenvalues at every iteration.


= References
Burden, R.L. and Faires, J.D. (2010) Numerical Analysis. 9th Edition, Brooks/Cole, Cengage Learning, Boston.
#pagebreak()

= Contribution Log

#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt,
  [*Name*], [*Contribution*],
  [Ognita, Daniel Dean], [Part 1, Power Method],
  [Matias, Gabriel Ian Carl], [Part 2, Normalized Power Method ],
  [Reyes, Samantha Mikaylah], [Part 3, Inverse Power Method],
  [Sarmiento, Luis Antonio], [Part 4, Shifted Inverse Power Method],
  [Tingin, Hanna Charisse], [Part 5, Gershgorin Circle Theorem],
  [Domingo, Adrian Christian], [Part 6, Rayleigh's Equation],
  [Aranas, John Ray], [Part 7, QR Factorization],
  [Dizon, Mikaela], [Part 7, QR Factorization],
)