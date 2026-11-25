#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt, font: "New Computer Modern", lang: "en")
#set par(justify: true)

#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

#show heading.where(level: 1): it => [
  #set text(fill: ink, size: 16pt, weight: "bold")
  #v(0.6em)
  #it
  #v(0.2em)
  #line(length: 100%, stroke: 1pt + ink)
  #v(0.4em)
]

#show heading.where(level: 2): it => [
  #set text(fill: ink, size: 13pt, weight: "bold")
  #v(0.5em)
  #it
  #v(0.2em)
]

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

// STYLING

#set page("a4", numbering: "1", number-align: top + right)
#set text(size: 12pt)
#set par(justify: true)
#show title: set align(center)
#show title: set text(size: 48pt)

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

=== Matrix norms

==== Solved Problem #1
Source: Burden & Faires, Exercise Set 7.1, Exercise 4c

#problem[
  Consider the tridiagonal symmetric matrix:

  $A = mat(2, -1, 0; -1, 2, -1; 0, -1, 2)$
  
- Compute the $l_oo$ norm $||A||_oo$ (Maximum Row Sum Norm).
-  Compute the $l_1$ norm $||A||_1$ (Maximum Column Sum Norm).
- Compute the Frobenius norm $||A||_F$.
- Compute the $l_2$ spectral norm $||A||_2$.
]

1. * $l_oo$ Norm (Maximum Row Sum):*
   $
   "Row 1: " |2| + |-1| + |0| = 3 \
   "Row 2: " |-1| + |2| + |-1| = 4 \
   "Row 3: " |0| + |-1| + |2| = 3
   $
   #rect(
   $ ||A||_oo = max(3, 4, 3) = 4 $)

2. * $l_1$ Norm (Maximum Column Sum):*
   The column sums = row sums since $A$ is symmetric:
   #rect(
   $ ||A||_1 = max(3, 4, 3) = 4 $)

3. * Frobenius Norm $||A||_F$:*
   $
   ||A||_F &= sqrt(sum_(i=1)^3 sum_(j=1)^3 |a_(i j)|^2) \
           &= sqrt(2^2 + (-1)^2 + 0^2 + (-1)^2 + 2^2 + (-1)^2 + 0^2 + (-1)^2 + 2^2) \
           &= sqrt(4 + 1 + 0 + 1 + 4 + 1 + 0 + 1 + 4) = sqrt(12) \
           &=
           #rect($2 sqrt(3) approx 3.4641$)
   $

4. * $l_2$ Spectral Norm $||A||_2$:*
   Since $A$ is symmetric, $||A||_2 = rho(A)$. Solving $det(A - lambda I) = (2 - lambda)[(2 - lambda)^2 - 2] = 0$ yields eigenvalues:
   $ lambda_1 = 2, quad lambda_2 = 2 - sqrt(2), quad lambda_3 = 2 + sqrt(2) $

   #rect(
   $ ||A||_2 = rho(A) = 2 + sqrt(2) approx 3.4142$)


=== Solved Problem 2
Source: Burden & Faires, Exercise Set 7.1, Exercise 12

#problem[
  Let $S$ be a real and nonsingular matrix, and let $||.||$ be any norm on $RR^n$. Define $||.||'$ by $||bold(x)||' = ||S bold(x)||$. Show that $||.||'$ is also a norm on $RR^n$.
]


- $||A|| > 0$ if $A != 0$:
  For any $x != 0$, since S is nonsingular, $S x != 0$. Applying this property to $A = S x$ gives us $||x||' = ||S x|| > 0$. If $x = 0$, $S x = 0$, so $||0||' = ||S 0|| = 0$.

- $||alpha A|| = |alpha| . ||A||$ $forall alpha in RR$:
  For any scalar $alpha in RR$ and $x in RR^n$:
  $||alpha x||' = ||S(alpha x)|| = ||alpha (S x)|| = |alpha| . ||S x|| = |alpha| . ||x||'$

- $||A + B|| <= ||A|| + ||B||$:
  For any vectors $x, y in RR^n$:
  $||x + y||' = ||S(x + y)|| = ||S x + S y|| <= ||S x|| + ||S y|| = ||x||' + ||y||'$

- $||A B|| <= ||A|| . ||B||$:
  holds for matrix products under $||.||'$, since $||A B||' = ||S A B|| <= ||S A|| . ||B||$.

- $||A x|| <= ||A|| . ||x||$ $forall x in RR^n$:
  holds for matrix-vector products, since $||A x||' = ||S A x|| <= ||S A|| . ||x||$.

Therefore, $||.||'$ satisfies all required norm properties and is a valid norm on $RR^n square$.

=== Remixed Problem

#problem[
  Let A be the symmetric tridiagonal matrix:
$ A = mat(2, -1, 0; -1, 2, -1; 0, -1, 2) $

and let S be the diagonal nonsingular scaling matrix:
$ S = mat(1, 0, 0; 0, 2, 0; 0, 0, 1) $

1. Norm Verification: Show that$ ||x||' = ||S x||_oo$ defines a valid vector norm on $RR^3$.
2. Original Matrix Norms: Compute the Frobenius norm $||A||_F$ and the $l_2$ spectral norm $||A||_2$.
]

1. Properties:

- $||A|| > 0$ if $A != 0$:
  For any $x != 0$, since $S$ is nonsingular, $S x != 0$. Applying this property gives us $||x||' = ||S x||_oo > 0$. If $x = 0$, $S x = 0$, so $||0||' = ||S 0||_oo = 0$.

- $||alpha A|| = |alpha| . ||A|| forall alpha in RR$:
  For any scalar $alpha in RR$ and $x in RR^3$:
  $ ||alpha x||' = ||S(alpha x)||_oo = ||alpha (S x)||_oo = |alpha| . ||S x||_oo = |alpha| . ||x||' $

- $||A + B|| <= ||A|| + ||B||$:
  For any vectors $x, y in RR^3$:
  $ ||x + y||' = ||S(x + y)||_oo = ||S x + S y||_oo <= ||S x||_oo + ||S y||_oo = ||x||' + ||y||' $

- $||A B|| <= ||A|| . ||B||$:
  Holds for matrix products under $||.||'$, since $||A B||' = ||S A B||_oo <= ||S A||_oo . ||B||_oo$.

- $||A x|| <= ||A|| . ||x|| forall x in RR^n$:
  Holds for matrix-vector products, since $||A x||' = ||S A x||_oo <= ||S A||_oo . ||x||$.

Therefore, $||.||'$ satisfies all required norm properties and is a valid norm on $RR^3 square$.
