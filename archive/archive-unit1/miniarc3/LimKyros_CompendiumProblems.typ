#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

// I really hate how this is not the default
#set math.mat(delim: "[")


#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

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

#let definition(title: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #text(fill: ink, weight: "bold")[Definition #if title != none [(#title)].]
  #body
]

#let theorem(title: none, body) = block(
  fill: white,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: 1pt + ink,
)[
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

#problem(number: "7", source: "Burden & Faires, Numerical Analysis, Exercise Set 7.4, #7")[
  *Statement:* 
  
  *(a)* Prove that the coefficient matrix of the system below is tridiagonal and positive definite, then
  
  *(b)* find the first two iterations of the SOR method with optimal $omega$ using *$x^((0)) = 0$*.

  $
    10x_1 + 5x_2 &= 6, \
    5x_1 + 10x_2 - 4x_3 &= 25, \
    -4x_2 + 8x_3 - x_4 &= -11, \
    -x_3 + 5x_4 &= -11.
  $

  *Solution:*

  *Part (a)*

  The coefficient matrix is given by

  $
    A =
    mat(
      10, 5, 0, 0;
      5, 10, -4, 0;
      0, -4, 8, -1;
      0, 0, -1, 5;
    ).
  $

  It is evident that the non-zero entries of $A$ lie on the main diagonal and the diagonals above and below it (i.e., $a_(i j) = 0$ for $|i - j| > 1$), thus $A$ is tridiagonal.

  If a matrix is tridiagonal, symmetric, has positive diagonal entries, and is strictly diagonally dominant, then it is positive definite. Note that $A$ is symmetric (that is, $A^top = A$), and all entries $a_(i i) > 0$. We show that $|a_(i i)| > sum_(i != j) |a_(i j)|$ below:

  - $|10| > |5| arrow.r.double 10 > 5$
  - $|10| > |5| + |-4| arrow.r.double 10 > 9$
  - $|8| > |-4| + |-1| arrow.r.double 8 > 5$
  - $|5| > |-1| arrow.r.double 5 > 1$

  Thus $A$ is strictly diagonally dominant, and it follows that it is positive definite.

  *Part (b)*

  We know that the optimal relaxation parameter for successive overrelaxation given a tridiagonal positive definite matrix is given by

  $
    omega = frac(2, 1 + sqrt(1 - (rho(T_j))^2))
  $

  where $rho(T_j) = max(|lambda_i|)$ for all eigenvalues $lambda_i$. The decomposition $A = L + D + U$ implies that

  $
    T_j = -D^(-1)(L + U) =
    mat(
      -frac(1, 10), 0, 0, 0;
      0, -frac(1, 10), 0, 0;
      0, 0, -frac(1, 8), 0;
      0, 0, 0, -frac(1, 5);
    )
    mat(
      0, 5, 0, 0;
      5, 0, -4, 0;
      0, -4, 0, -1;
      0, 0, -1, 0;
    ) =
    mat(
      0, -0.5, 0, 0;
      -0.5, 0, 0.4, 0;
      0, 0.5, 0, 0.125;
      0, 0, 0.2, 0;
    ),
  $

  thus
  
  $
    det(T_j - lambda I_4) = 
    det mat(
      -lambda, -0.5, 0, 0;
      -0.5, -lambda, 0.4, 0;
      0, 0.5, -lambda, 0.125;
      0, 0, 0.2, -lambda;
    ) = lambda^4 - 0.475lambda^2 + 0.00625 = 0
  $

  Let $u = lambda^2$. Substituting this into the characteristic equation yields a quadratic equation
  $
    u^2 - 0.475u + 0.00625 = 0
  $
  with $u_1 approx 0.46146$, $u_2 approx 0.01354$. It is evident that $rho(T_j) = sqrt(0.46146) approx 0.67931$, so $omega = 2(1 + sqrt(1 - 0.67931^2))^(-1) approx 1.1535$, which implies that the optimal relaxation factor induces over-relaxation.

  The formula for each scalar for an iteration of SOR is given by
  $
    x_i^((k)) =
    (1 - omega) x_i^((k-1))
    + omega/a_(i i) (
      b_i
      - sum_(j=1)^(i-1) a_(i j) x_j^((k))
      - sum_(j=i+1)^n a_(i j) x_j^((k-1))
    ).
  $

  With all needed information, we now run the first iteration:
  - $x_1^((1)) = (1-1.535)(0) + frac(1.1535, 10)(6 - 5(0)) = 0.6921$
  - $x_2^((1)) = (1-1.535)(0) + frac(1.1535, 10)(25 - 5(0.6921) - (-4)(0)) = 2.4846$
  - $x_3^((1)) = (1-1.535)(0) + frac(1.1535, 8)(-11 - (-4)(2.4846) - (-1)(0)) = -0.1531$
  - $x_4^((1)) = (1-1.535)(0) + frac(1.1535, 5)(-11 - (-1)(-0.1531)) = -2.5730$

  So $x^((1)) = mat(0.6921, 2.4846, -0.1531, -2.5730)^top$. We run the second iteration:
  - $x_1^((2)) = (1-1.535)(0.6921) + frac(1.1535, 10)(6 - 5(2.4846)) = -0.8471$
  - $x_2^((2)) = (1-1.535)(2.4846) + frac(1.1535, 10)(25 - 5(-0.8471) - (-4)(-0.1531)) = 2.9203$
  - $x_3^((2)) = (1-1.535)(-0.1531) + frac(1.1535, 8)(-11 - (-4)(2.9203) - (-1)(-2.5730)) = -0.2493$
  - $x_4^((2)) = (1-1.535)(-2.5730) + frac(1.1535, 5)(-11 - (-1)(-0.2493)) = -2.2002$

  Thus,
  #theorem[$
    x^((2)) = mat(-0.8471; 2.9203; -0.2493; -2.2002).
  $]
]

#problem(number: "8", source: "Burden & Faires, Numerical Analysis, Exercise Set 7.3, #14")[
  *Statement:* 
  
  Show that if a matrix $A$ is strictly diagonally dominant, then $||T_j||_infinity < 1$.

  *Proof:*

  We know that the Jacobi iteration matrix $T_j = -D^(-1)(L + U)$. Also, we can denote the entries of $T_j$ as
  $
    t_(i j) = cases(-frac(a_(i j), a_(i i))" for "i != j, 0" for "i = j)
  $

  The infinity norm is defined as $||T_j||_infinity = m a x_(1 <= i <= n) sum_(j=1)^(n)|t_(i j)|$. Observe the absolute sum of elements in $T_j$ below:
  $
    sum_(j=1)^(n)|t_(i j)| = sum_(j != i)frac(|a_(i j)|, |a_(i i)|)
  $

  By definition, if a matrix $A$ is SDD, the inequality below holds:
  $
    |a_(i i)| > sum_(j != i)|a_(i j)| arrow.long.double sum_(j != i)frac(|a_(i j)|, |a_(i i)|) < 1
  $

  Since this holds for every row $i$, the maximum row sum must also be strictly less than $1$, therefore $||T_j||_infinity < 1$.

  #align(right)[*Q.E.D.*]
]

