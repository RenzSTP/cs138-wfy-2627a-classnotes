PACTOLIN, Renz

= COMPENDIUM PROBLEMS:
1. *[Burden and Faires, _Numerical Analysis_ 9th ed., pp. 410 Problem 4b]* Consider the following matrices. Find the permutation matrix P so that PA can be factored into the product LU, where L is lower triangular with 1s on its diagonal and U is upper triangular for this matrix:

$ "d. "A = mat(delim: "[",
  1,  1, -1, 2;
  2,  2,  4, 5;
  1, -1,  1, 7;
  2,  3,  4, 6;
) $

*ANSWER:*

#table(
  columns: (auto, auto, auto, auto, auto),
  inset: (6pt, 12pt),
  align: center,

  table.header(
    [*Matrix*],
    [*Row Operation*],
    [*$L$ Matrix*],
    [*$U$ Matrix*],
    [*$P$ Matrix*],
  ),

  // Step 1: R_1 <-> R_2
  $mat(
    delim: "[",
    2, 2, 4, 5;
    1, 1, -1, 2;
    1, -1, 1, 7;
    2, 3, 4, 6;
  )$,
  
  $R_1 <-> R_2$,
  
  $mat(
    delim: "[",
    1, 0, 0, 0;
    0, 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    1, 1, -1, 2;
    1, -1, 1, 7;
    2, 3, 4, 6;
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    1, 0, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
  )$,

  // Step 2: R_2 -> R_2 - 1/2 R_1
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, 0, -3, -frac(1, 2);
    1, -1, 1, 7;
    2, 3, 4, 6;
  )$,
  $R_2 -> R_2 - frac(1, 2) R_1$,
  $mat(
    delim: "[",
    1, 0, 0, 0;
    frac(1, 2), 1, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, 0, -3, -frac(1, 2);
    1, -1, 1, 7;
    2, 3, 4, 6;
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    1, 0, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
  )$,

  // Step 3: R_3 -> R_3 - 1/2 R_1
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, 0, -3, -frac(1, 2);
    0, -2, -1, frac(9, 2);
    2, 3, 4, 6;
  )$,
  $R_3 -> R_3 - frac(1, 2) R_1$,
  $mat(
    delim: "[",
    1, 0, 0, 0;
    frac(1, 2), 1, 0, 0;
    frac(1, 2), 0, 1, 0;
    0, 0, 0, 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, 0, -3, -frac(1, 2);
    0, -2, -1, frac(9, 2);
    2, 3, 4, 6;
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    1, 0, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
  )$,

  // Step 4: R_4 -> R_4 - R_1
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, 0, -3, -frac(1, 2);
    0, -2, -1, frac(9, 2);
    0, 1, 0, 1;
  )$,
  $R_4 -> R_4 - R_1$,
  $mat(
    delim: "[",
    1, 0, 0, 0;
    frac(1, 2), 1, 0, 0;
    frac(1, 2), 0, 1, 0;
    1, 0, 0, 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, 0, -3, -frac(1, 2);
    0, -2, -1, frac(9, 2);
    0, 1, 0, 1;
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    1, 0, 0, 0;
    0, 0, 1, 0;
    0, 0, 0, 1;
  )$,

  // Step 5: R_2 <-> R_3
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, -2, -1, frac(9, 2);
    0, 0, -3, -frac(1, 2);
    0, 1, 0, 1;
  )$,
  $R_2 <-> R_3$,
  $mat(
    delim: "[",
    1, 0, 0, 0;
    frac(1, 2), 1, 0, 0;
    frac(1, 2), 0, 1, 0;
    1, 0, 0, 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, -2, -1, frac(9, 2);
    0, 0, -3, -frac(1, 2);
    0, 1, 0, 1;
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    0, 0, 1, 0;
    1, 0, 0, 0;
    0, 0, 0, 1;
  )$,

  // Step 6: R_4 -> R_4 + 1/2 R_2
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, -2, -1, frac(9, 2);
    0, 0, -3, -frac(1, 2);
    0, 0, -frac(1, 2), frac(13, 4);
  )$,
  $R_4 -> R_4 + frac(1, 2) R_2$,
  $mat(
    delim: "[",
    1, 0, 0, 0;
    frac(1, 2), 1, 0, 0;
    frac(1, 2), 0, 1, 0;
    1, -frac(1, 2), 0, 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, -2, -1, frac(9, 2);
    0, 0, -3, -frac(1, 2);
    0, 0, -frac(1, 2), frac(13, 4);
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    0, 0, 1, 0;
    1, 0, 0, 0;
    0, 0, 0, 1;
  )$,

  // Step 7: R_4 -> R_4 - 1/6 R_3
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, -2, -1, frac(9, 2);
    0, 0, -3, -frac(1, 2);
    0, 0, 0, frac(10, 3);
  )$,
  $R_4 -> R_4 - frac(1, 6) R_3$,
  $mat(
    delim: "[",
    1, 0, 0, 0;
    frac(1, 2), 1, 0, 0;
    frac(1, 2), 0, 1, 0;
    1, -frac(1, 2), frac(1, 6), 1;
  )$,
  $mat(
    delim: "[",
    2, 2, 4, 5;
    0, -2, -1, frac(9, 2);
    0, 0, -3, -frac(1, 2);
    0, 0, 0, frac(10, 3);
  )$,
  $mat(
    delim: "[",
    0, 1, 0, 0;
    0, 0, 1, 0;
    1, 0, 0, 0;
    0, 0, 0, 1;
  )$,
)

#pagebreak()
2. *[Burden and Faires, _Numerical Analysis_ 9th ed., pp. 427 Problem 24]* Suppose A and B commute, that is, $"AB" = "BA"$. Must $A^T$ and $B^T$ also commute?

*ANSWER:* TRUE

Proof:
$ "AB" = "BA" $
$ ("AB")^T = ("BA")^T $
$ B^T A^T = A^T B^T $

By definition of equality, $A^T$ and $B^T$ must commute if $A B = B A$. Equality is maintained even through transposition.


\
= REMIXED PROBLEM:
1. Does $A B = B A$ imply that $P_A P_B = P_B P_A$, wherein $P$ is the row permutation matrix of a LU decomposition $P A = L_D U_D$?

*ANSWER:* FALSE by Counter-example.

PROOF:

== I. Defining matrix A and B
\

Let $A = mat(delim: "[",
  0, 0, 1;
  0, 1, 0;
  1, 2, 0
)$ 

Let $B = A^2 = mat(delim:"[",
    1, 2, 0;
    0, 1, 0;
    0, 2, 1
  )$

Note that:
$ A B = B A $
$ A * A^2 = A^2 * A $
$ A^3 = A^3 $

So, $A B = B A$.

== II. Decomposing matrix A and B

Decomposing A:

#table(
  columns: (2.2fr, 2fr, 2.2fr, 2.2fr, 2.2fr),
  inset: 8pt,
  align: center,
  stroke: 0.5pt,

  [*Matrix*],
  [*Row Operation*],
  [*$L$ Matrix*],
  [*$U$ Matrix*],
  [*$P$ Matrix*],

  [
    $mat(
      delim: "[",
      0, 0, 1;
      0, 1, 0;
      1, 2, 0;
    )$
  ],
  [$R_1 ↔ R_3$],
  [
    $mat(
      delim: "[",
      1, 0, 0;
      0, 1, 0;
      0, 0, 1;
    )$
  ],
  [
    $mat(
      delim: "[",
      1, 2, 0;
      0, 1, 0;
      0, 0, 1;
    )$
  ],
  [
    $mat(
      delim: "[",
      0, 0, 1;
      0, 1, 0;
      1, 0, 0;
    )$
  ],
)

\ \ \ \  \ \ 
Decomposing B:
#table(
  columns: (2.2fr, 2fr, 2.2fr, 2.2fr, 2.2fr),
  inset: 8pt,
  align: center,
  stroke: 0.5pt,

  [*Matrix*],
  [*Row Operation*],
  [*$L$ Matrix*],
  [*$U$ Matrix*],
  [*$P$ Matrix*],

  [
    $mat(
      delim: "[",
      1, 2, 0;
      0, 1, 0;
      0, 2, 1;
    )$
  ],
  [$R_2 ↔ R_3$],
  [
    $mat(
      delim: "[",
      1, 0, 0;
      0, 1, 0;
      0, 0, 1;
    )$
  ],
  [
    $mat(
      delim: "[",
      1, 2, 0;
      0, 2, 1;
      0, 1, 0;
    )$
  ],
  [
    $mat(
      delim: "[",
      1, 0, 0;
      0, 0, 1;
      0, 1, 0;
    )$
  ],

  [
    $mat(
      delim: "[",
      1, 2, 0;
      0, 2, 1;
      0, 0, -frac(1, 2);
    )$
  ],
  [$R_3 → R_3 - frac(1, 2) R_2$],
  [
    $mat(
      delim: "[",
      1, 0, 0;
      0, 1, 0;
      0, frac(1, 2), 1;
    )$
  ],
  [
    $mat(
      delim: "[",
      1, 2, 0;
      0, 2, 1;
      0, 0, -frac(1, 2);
    )$
  ],
  [
    $mat(
      delim: "[",
      1, 0, 0;
      0, 0, 1;
      0, 1, 0;
    )$
  ],
)


== III. Comparing $P_A P_B = P_B P_A$

Note that we have:

$P_A = mat(
      delim: "[",
      0, 0, 1;
      0, 1, 0;
      1, 0, 0;
    )$, $P_B = mat(
      delim: "[",
      1, 0, 0;
      0, 0, 1;
      0, 1, 0;
    )$


Simplifying them:

$ P_A P_B = P_B P_A $
$ mat(
      delim: "[",
      0, 0, 1;
      0, 1, 0;
      1, 0, 0;
    )
  mat(
        delim: "[",
        1, 0, 0;
        0, 0, 1;
        0, 1, 0;
      )
  
    = 
    mat(
      delim: "[",
      1, 0, 0;
      0, 0, 1;
      0, 1, 0;
    ) 
    mat(
      delim: "[",
      0, 0, 1;
      0, 1, 0;
      1, 0, 0;
    ) $

$ "          "
mat(
  delim: "[",
  0, 1, 0;
  0, 0, 1;
  1, 0, 0;
)
=
mat(
  delim: "[",
  0, 0, 1;
  1, 0, 0;
  0, 1, 0;
) "FALSE"
$

Therefore, by counterexample, we have proven that $P_A P_B != P_B P_A$.