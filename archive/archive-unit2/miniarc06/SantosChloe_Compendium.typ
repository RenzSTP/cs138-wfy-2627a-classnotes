// STYLING PREAMBLE

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true, first-line-indent: 2.0em)
#show title: set align(center)
#show title: set text(size: 48pt)

  // I really hate how this is not the default
#set math.mat(delim: "[")

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// IMPORTS
#import "../assets.typ": qa, notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

/// END STYLING PREAMBLE


// `qa` wrapper: no first-line indent inside the question/answer boxes
#let problem(question, answer) = qa(
  { set par(first-line-indent: 0pt); question },
  { set par(first-line-indent: 0pt); answer },
)


// SECTION HEADER
#show: notes.with(
  title: [Sturm–Liouville Problems],
  subtitle: [Chloe Althaia Santos]
)

#set math.equation(numbering: none)

// PROBLEM 1
#problem[
  *Solved Problem \#1.* _Source:_ Burden and Faires, _Numerical Analysis_, 9th ed., Section 8.2,
  Exercise 14.

  Let
  $\{phi_0, phi_1, dots.h, phi_n\}$ be a set of nonzero, pairwise orthogonal
  real-valued functions on $[a, b]$, under a positive weight $w(x)$. Show that
  the functions are linearly independent.

][
  *Solution.* Suppose constants $c_0, dots.h, c_n$ satisfy
  #[
    #set math.equation(numbering: "(1)")
    $ sum_(i=0)^n c_i phi_i (x) = 0 quad "for all" x in [a, b]. $
  ]
  Fix any $j in {0, dots.h, n}$. Multiply (1) by $w(x) phi_j (x)$ and integrate:
  $ 0 = integral_a^b (sum_(i=0)^n c_i phi_i (x)) w(x) phi_j (x) dif x
      = sum_(i=0)^n c_i chevron.l phi_i, phi_j chevron.r_w. $
  Every term with $i != j$ vanishes by orthogonality, leaving
  $ 0 = c_j chevron.l phi_j, phi_j chevron.r_w
      = c_j integral_a^b w(x) phi_j (x)^2 dif x. $
  The integral is strictly positive since $w > 0$ and $phi_j$ is nonzero (for
  the usual continuous-function setting). Thus $c_j = 0$. Since $j$ was
  arbitrary,
  $ c_0 = c_1 = dots.h = c_n = 0. $
  Therefore ${phi_0, dots.h, phi_n}$ is linearly independent.
  #h(1fr) $square$
]
\

// PROBLEM 2

#problem[
  *Solved Problem 2.* _Source:_ Burden and Faires, _Numerical Analysis_, 9th ed., Section 9.5,
  Exercise 13

  A four-interior-node approximation of a vibrating-bar eigenvalue problem gives the symmetric matrix
  $ A = mat(
      2, -1, 0, 0;
      -1, 2, -1, 0;
      0, -1, 2, -1;
      0, 0, -1, 2
    ). $
  (a) Find its four eigenvalues $mu_1, dots.h, mu_4$ to accuracy $10^(-5)$.
  (b) Relate these values to approximations of the bar's Sturm–Liouville
  eigenvalues in terms of constant stiffness $p > 0$ and density $rho > 0$ when
  the grid spacing is $h = 0.2$.

  
][
  *Solution.* (a) _Matrix eigenvalues._ A symmetric tridiagonal Toeplitz matrix
  of size $N = 4$, with diagonal entries $2$ and off-diagonal entries $-1$, has
  eigenvalues
  $ mu_k = 2 - 2 cos((k pi) / (N + 1)) = 2 - 2 cos((k pi) / 5),
    quad k = 1, 2, 3, 4. $
  (The associated eigenvectors have components
  $v_j^((k)) = sin(j k pi \/ 5)$.) Therefore,

  #align(center)[
    #table(
      columns: (auto, auto, auto),
      align: (center + horizon, left + horizon, center + horizon),
      fill: (_, y) => if y == 0 { lightgray },
      [*$k$*], [*Exact expression*], [*$mu_k$ (rounded to 5 d.p.)*],
      [1], [$2 - 2 cos(pi \/ 5)$], [0.38197],
      [2], [$2 - 2 cos(2 pi \/ 5)$], [1.38197],
      [3], [$2 - 2 cos(3 pi \/ 5)$], [2.61803],
      [4], [$2 - 2 cos(4 pi \/ 5)$], [3.61803],
    )
  ]

  (b) _Approximate continuous eigenvalues._ Since $A bold(w) = mu_k bold(w)$,
  compare with (2):
  $ mu_k = 0.04 rho / p lambda_k^((h))
    quad ==> quad
    lambda_k^((h)) = 25 p / rho mu_k. $
  Thus, in increasing order,
  $ lambda_1^((h)) approx 9.54915 p / rho, quad
    lambda_2^((h)) approx 34.54915 p / rho, \
    lambda_3^((h)) approx 65.45085 p / rho, quad
    lambda_4^((h)) approx 90.45085 p / rho. $

]

\

// ORIGINAL REMIX
#problem[
  *Original Remix of the Solved Problems.*

  Consider
  $ y'' + lambda y = 0, quad 0 < x < 1, quad y(0) = y(1) = 0. $
  #set enum(numbering: "(a)")
  + Determine the first two exact eigenpairs and verify that the
    eigenfunctions are orthogonal.
  + Approximate the equation on a uniform grid with three interior points;
    construct $A Y = mu Y$.
  + Find all three matrix eigenvalues and a corresponding eigenvector for each.
  + Verify discrete orthogonality and deduce linear independence.
  + Explain the conceptual relationship between the continuous and discrete
    results.
][
  *Solution.* (a) _Continuous eigenpairs._ For $lambda > 0$, set
  $k = sqrt(lambda)$ and write $y = C_1 cos(k x) + C_2 sin(k x)$. The condition
  $y(0) = 0$ gives $C_1 = 0$, and $y(1) = 0$ requires $sin k = 0$. For
  nontrivial solutions, $k = n pi$ with $n = 1, 2, dots.h$. Hence
  $ lambda_n = n^2 pi^2, quad y_n (x) = sin(n pi x). $
  The first two pairs are $(pi^2, sin pi x)$ and $(4 pi^2, sin 2 pi x)$. Their
  inner product equals
  $ integral_0^1 sin(pi x) sin(2 pi x) dif x
    = 1/2 integral_0^1 [cos(pi x) - cos(3 pi x)] dif x = 0. $
  Thus $y_1$ and $y_2$ are orthogonal with weight $r(x) = 1$.

  (b) _Three-point central difference._ There are $N = 3$ interior nodes with
  spacing $h = 1 \/ (N + 1) = 1 \/ 4$. At an interior node,
  $ (Y_(j-1) - 2 Y_j + Y_(j+1)) / h^2 + lambda Y_j = 0
    quad <==> quad
    -Y_(j-1) + 2 Y_j - Y_(j+1) = h^2 lambda Y_j. $
  With $Y_0 = Y_4 = 0$ this becomes
  $ A Y = mu Y, quad
    A = mat(2, -1, 0; -1, 2, -1; 0, -1, 2), quad
    mu = h^2 lambda = lambda \/ 16. $

  (c) _Eigenpairs of $A$._ The eigenvalues and eigenvectors are
  $ mu_k = 2 - 2 cos((k pi) / 4), quad
    v_j^((k)) = sin((j k pi) / 4), quad k, j = 1, 2, 3. $
  Writing $s = sqrt(2) \/ 2$, a convenient choice is

  #align(center)[
    #table(
      columns: (auto, auto, auto),
      align: center + horizon,
      fill: (_, y) => if y == 0 { lightgray },
      [*$k$*], [*$mu_k$*], [*$bold(v)_k$*],
      [1], [$2 - sqrt(2)$], [$(s, 1, s)^upright(T)$],
      [2], [$2$], [$(1, 0, -1)^upright(T)$],
      [3], [$2 + sqrt(2)$], [$(s, -1, s)^upright(T)$],
    )
  ]

  The corresponding finite-difference estimates are
  $lambda_k^((h)) = 16 mu_k$:
  $ lambda_1^((h)) approx 9.37258, quad
    lambda_2^((h)) = 32, quad
    lambda_3^((h)) approx 54.62742. $

  (d) _Orthogonality and independence._ Check the pairwise dot products:
  $ bold(v)_1^upright(T) bold(v)_2 &= s - s = 0, \
    bold(v)_1^upright(T) bold(v)_3 &= s^2 - 1 + s^2 = 2 (1/2) - 1 = 0, \
    bold(v)_2^upright(T) bold(v)_3 &= s - s = 0. $
  Each eigenvector is nonzero, and $norm(bold(v)_k)^2 = 2 > 0$. If
  $c_1 bold(v)_1 + c_2 bold(v)_2 + c_3 bold(v)_3 = bold(0)$, taking the dot
  product with $bold(v)_j$ gives
  $ 0 = c_j norm(bold(v)_j)^2 = 2 c_j quad ==> quad c_j = 0. $
  Since this holds for $j = 1, 2, 3$, the three eigenvectors are linearly
  independent.

  (e) _Interpretation._ In the continuous problem, eigenfunctions belonging to
  different eigenvalues are orthogonal under the weighted integral
  $integral_0^1 u(x) v(x) dif x$. In this constant-weight discretization, the
  symmetric matrix has eigenvectors orthogonal under the dot product. The same
  orthogonality-to-independence argument works for both, but these are
  different inner products: the dot product is the discrete analogue, not
  literally the same integral. Multiplying the dot product by $h$ would not
  change whether it is zero.
]

\

#text(size: 10pt)[
  *References.*
  #set enum(numbering: "[1]")
  + R. L. Burden and J. D. Faires, _Numerical Analysis_, 9th ed., Section 8.2
    Exercise 14; Section 9.5 Exercise 13; Chapter 9 introduction.
  ]
