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
  #text(style: "italic", fill: black)[Remark: ] #body
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

=== Gaussian Elimination with Partial and Full Pivoting

==== Solved Problem #1
Example 2 from 6.2 Pivoting Strategies of Burden and Faires. Numerical Analysis.

#problem(
  number: 1,
  )[
  Apply Gaussian elimination to the system

  $
  E_1 : 0.003000 x_1 + 59.14 x_2 = 59.17
  $

  $
  E_2 : 5.291 x_1 - 6.130 x_2 = 46.78,
  $

  using partial pivoting and four-digit arithmetic with rounding, and compare the results
  to the exact solution $x_1 = 10.00$ and $x_2 = 1.000$.
]

===== Solution

The given system can be represented by the augmented matrix

$
mat(
  0.003000, 59.14, 59.17;
  5.291, -6.130, 46.78;
  delim: "[",
  augment: #2
)
$

At the first elimination stage, partial pivoting searches for the
largest absolute value in the current pivot column. Thus, we compare
the entries in the first column:

$
max(abs(0.003000), abs(5.291))
= abs(5.291).
$

Since the largest entry is in the second row, interchange $R_1$ and
$R_2$:

$
R_1 arrow.l.r R_2.
$

The reordered system becomes

$
5.291 x_1 - 6.130 x_2 &= 46.78, \
0.003000 x_1 + 59.14 x_2 &= 59.17.
$

$
mat(
  5.291, -6.130, 46.78;
  0.003000, 59.14, 59.17;
  delim: "[",
  augment: #2
)
$

The elimination multiplier is

$
m_21
= 0.003000 / 5.291
= 0.0005670.
$

Using the row operation

$
R_2 arrow.r R_2 - m_21 R_1
$

and applying four-digit arithmetic with rounding, the system reduces to


$
mat(
  5.291, -6.130, 46.78;
  ,59.14, 59.14;
  delim: "[",
  augment: #2
)
$
$
5.291 x_1 - 6.130 x_2 &approx 46.78, \
59.14 x_2 &approx 59.14.
$

We then apply back substitution. From the second equation,

$
x_2 = 59.14 / 59.14 = 1.000.
$

Substituting $x_2 = 1.000$ into the first equation gives

$
x_1
= (46.78 + 6.130(1.000)) / 5.291
= 52.91 / 5.291
= 10.00.
$

Therefore,

#align(center)[#rect(inset: 5pt, stroke: 0.5pt)[ 
$
(x_1, x_2) = (10.00, 1.000).
$]]

#remark[
  *The importance of pivoting.* Without pivoting, the very small value
  $0.003000$ would be used as the first pivot, producing a very large
  multiplier and making the computation more susceptible to round-off
  error. Partial pivoting avoids this by interchanging the rows and
  using $5.291$ as the first pivot instead. As a result, the system
  produces the correct solution even when four-digit arithmetic with
  rounding is used.
]


==== Solved Problem #2
Exercise 27(a) from 6.2 Pivoting Strategies of Burden and Faires. Numerical Analysis.

#problem(
  number: 2,

)[
  Use Gaussian elimination and three-digit chopping arithmetic with full pivoting to solve the following
  linear system, and compare the approximations to the actual solution.

  $
  0.003 x_1 + 58.9 x_2 = 59.2,\
   5.31 x_1 - 6.10 x_2 = 47.0.
  $
  Actual solution $[10, 1]$.
]
===== Solution

The given system can be represented by the augmented matrix

$
mat(
  0.003, 58.9, 59.2;
  5.31, -6.10, 47.0;
  delim: "[",
  augment: #2
)
$

Under full pivoting, we search the entire remaining coefficient matrix
for the entry with the largest absolute value.

The largest absolute entry is $58.9$, located in row 1, column 2.
Since $58.9$ is already in the first row, no row interchange is
necessary. However, it must be moved into the first pivot position by
interchanging columns 1 and 2:

$
C_1 arrow.l.r C_2.
$

Because the columns correspond to the variables, this also changes
the working variable order from

$
[x_1, x_2] quad "to" quad [x_2, x_1].
$

The reordered system is therefore

$
58.9 x_2 + 0.003 x_1 &= 59.2, \
-6.10 x_2 + 5.31 x_1 &= 47.0.
$

$
mat(
  58.9, 0.003, 59.2;
  -6.10,5.31, 47.0;
  delim: "[",
  augment: #2
)
$

The elimination multiplier is

$
m_21
= (-6.10) / 58.9
= -0.103,
$

using three-digit chopping arithmetic.

We then perform

$
R_2 arrow.r R_2 - m_21 R_1.
$

Using three-digit chopping,

$
m_21(0.003)
= (-0.103)(0.003)
= -0.000309.
$

Thus, the new coefficient of $x_1$ is

$
5.31 - (-0.000309)
= 5.31.
$

For the right-hand side,

$
m_21(59.2)
= (-0.103)(59.2)
= -6.09.
$

This gives

$
47.0 - (-6.09)
= 53.09
arrow.r 53.0.
$

Therefore, the reduced system is

$
58.9 x_2 + 0.003 x_1 &= 59.2, \
5.31 x_1 &= 53.0.
$

$
mat(
  58.9, 0.003, 59.2;
  ,5.31, 53.0;
  delim: "[",
  augment: #2
)
$


We then solve through back substitution. From the second equation,

$
x_1
= 53.0 / 5.31
= 9.98.
$

Substituting this into the first equation,

$
0.003(9.98)
= 0.0299
$

and

$
59.2 - 0.0299
= 59.1.
$

Therefore,

$
x_2
= 59.1 / 58.9
= 1.00.
$

Hence,

#align(center)[#rect(inset: 5pt, stroke: 0.5pt)[ 
$
(x_1, x_2) approx (9.98, 1.00).
$]]

Compared with the given solution

$
(x_1, x_2) = (10, 1),
$

the full-pivoting approximation is close despite the use of
three-digit chopping arithmetic.

#remark[
  *The importance of full pivoting.* Unlike partial pivoting, which
  searches only the current pivot column, full pivoting searches the
  entire remaining coefficient matrix for the largest available
  pivot. In this example, this causes a column interchange, so the
  corresponding change in variable order must also be tracked.
  After solving, the variables are reported in their original order.
]


==== Original Remix

#problem(
  number: [Remix],
)[
  Suppose you are testing a Gaussian elimination program that supports both partial and
  complete pivoting. Rather than applying the methods to a given matrix, your goal is to
  construct a $3 times 3$ coefficient matrix whose entries cause the two pivoting strategies to behave
  differently during the first elimination stage.

  Construct a matrix $A$ satisfying the following conditions:

  1. Under partial pivoting, the first pivot is selected from row 2.
  2. Under complete pivoting, a different first pivot is selected from column 2.
  3. After the column interchange required by complete pivoting, the magnitudes of both
     first-stage elimination multipliers must be less than $0.1$.

  Determine suitable conditions on the entries of $A$, construct one matrix satisfying them, and
  verify that your matrix produces the required behavior.
]

===== Solution

Since the matrix is not given, we first determine what conditions its
entries must satisfy. Let

$
A =
mat(
  a, b, c;
  d, e, f;
  g, h, i,
  delim: "[",
).
$

We then impose each requirement on these entries until a suitable
matrix can be constructed.


===== 1. Condition Imposed by Partial Pivoting

At the first elimination stage, partial pivoting examines only the
first column. For it to select the entry in row 2, the magnitude of
$d$ must be larger than the other first-column entries:

$
abs(d) > abs(a)
quad "and" quad
abs(d) > abs(g).
$

We can choose

$
a = 4, quad d = 7, quad g = 5.
$

We now have the partially constructed matrix

$
A =
mat(
  4, b, c;
  7, e, f;
  5, h, i,
  delim: "[",
).
$

The first-column entries are therefore $4$, $7$, and $5$, so partial
pivoting will select $7$ from row 2.


===== 2. Condition Imposed by Full Pivoting

Full pivoting searches the entire active coefficient matrix. We want
it to choose an entry from column 2 rather than the $7$ selected by
partial pivoting.

Therefore, choose a column-2 entry whose magnitude is larger than
every other entry in the matrix. \
\ Let

$
b = 50.
$

We then keep all remaining entries smaller than $50$ in magnitude.
The matrix now has the form

$
A =
mat(
  4, 50, c;
  7, e, f;
  5, h, i,
  delim: "[",
).
$

Provided that the remaining entries have magnitude less than $50$,
full pivoting will select $50$ at position $(1, 2)$. Since it is
already in the first row, only a column interchange is necessary:

$
C_1 arrow.l.r C_2.
$


===== 3. Condition Imposed by the Elimination Multipliers

After full pivoting interchanges columns 1 and 2, the first column
becomes

$
mat(
  50;
  e;
  h,
  delim: "[",
).
$

Thus, the first-stage elimination multipliers are

$
m_21 = e / 50,
quad
m_31 = h / 50.
$

The problem requires both multiplier magnitudes to be less than
$0.1$. Therefore,

$
abs(m_21)
= abs(e / 50)
< 0.1
$

and

$
abs(m_31)
= abs(h / 50)
< 0.1.
$

This gives the conditions

$
abs(e) < 5,
quad
abs(h) < 5.
$

We can choose

$
e = 3
quad "and" quad
h = 2.
$

This gives the partially constructed matrix

$
A =
mat(
  4, 50, c;
  7, 3, f;
  5, 2, i,
  delim: "[",
).
$


===== 4. Constructing the Matrix

The entries $c$, $f$, and $i$ do not determine the first pivot under
either strategy and do not appear in the first-stage elimination
multipliers.

We only need to keep their magnitudes below $50$ so that $50$ remains
the full-pivoting choice.

One simple choice is

$
c = 2,
quad
f = 1,
quad
i = 20.
$

Therefore, one matrix satisfying all of the requirements is

#align(center)[#rect(inset: 7pt, stroke: 0.5pt)[ 
$

  A =
  mat(
    4, 50, 2;
    7, 3, 1;
    5, 2, 20,
    delim: "[",
  ).
$]]


===== Verification

*1. Partial pivoting*

The first-column candidates are

$
4, quad 7, quad 5.
$

Since $7$ has the largest magnitude, partial pivoting selects the
entry in row 2 and performs

$
R_1 arrow.l.r R_2.
$

Therefore, the first condition is satisfied.


*2. Full pivoting*

The largest absolute entry in the entire matrix is $50$, located at
position $(1, 2)$.

Thus, full pivoting selects $50$ and performs

$
C_1 arrow.l.r C_2.
$

After the column interchange, the matrix becomes

$
A' =
mat(
  50, 4, 2;
  3, 7, 1;
  2, 5, 20,
  delim: "[",
).
$

Therefore, the second condition is satisfied.


*3. Elimination multipliers*

Using $50$ as the first pivot,

$
m_21
= 3 / 50
= 0.06
< 0.1,
$

and

$
m_31
= 2 / 50
= 0.04
< 0.1.
$

Therefore, both first-stage elimination multipliers have magnitudes
less than $0.1$.

#align(center)[#rect(inset: 5pt, stroke: 0.5pt)[ 
$
therefore "All three conditions are satisfied."
$]]