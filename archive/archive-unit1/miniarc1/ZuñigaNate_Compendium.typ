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



// ============================================================
// SCALED PARTIAL PIVOTING
// ============================================================

=== Gaussian Elimination with Scaled Partial Pivoting

==== Solved Problem #1
Exercise 17, item 9b from Exercise Set 6.2 in Burden and Faires, Numerical Analysis.

#problem[
  Given the following linear system:

  $ cases(3.03x_1 − 12.1x_2 + 14x_3 =−119,
          −3.03x_1 + 12.1x_2 − 7x_3 = 120,
          6.11x_1 − 14.2x_2 + 21x_3 =−139) $

  $ "Actual Solution": x =[0, 10, 1/7]^T $

  Use Gaussian elimination and scaled partial pivoting on the linear system, and compare the approximations to the actual solution.
]

Solution:\
We have the form $bold(A x = b)$, or alternatively, the augmented matrix $bold([A | b])$ wherein

$ bold([A | b] = mat(delim: "[", augment: #3,
    3.03, -12.1, 14, -119;
    -3.03, 12.1, -7, 120;
    6.11, -14.2, 21, -139;
  )) $

Firstly, let us determine the scale factors $s_i$ for each row $r_i$. These are determined by $ bold(s_i = max_(1 <= j <= n) |a_(i j)|), "or the maximum absolute value entry in each row" r_i $

For this system, we take $s_i$ to be

$ s_1 = max_(1 <= j <= n) |a_(1 j)| = 14\
  s_2 = max_(1 <= j <= n) |a_(2 j)| = 12.1\
  s_3 = max_(1 <= j <= n) |a_(3 j)| = 21 $

Now, let us find the first pivot row $p$.
We do this by finding $ bold(p = arg max_(k <= i <= n)
    frac(|a_(i k)^((k))|, s_i)), "or the row "r_i" with the largest ratio between its candidate "a_(i k)" and "s_i $

We then have
$ (|a_(1 1)|)/s_1 = 3.03/14 approx 0.2164 \
  (|a_(2 1)|)/s_2 = 3.03/12.1 approx 0.2504 \
  (|a_(3 1)|)/s_3 = 6.11/21 approx #box[0.2910] \
  "wherein "r_3 "has the greatest ratio of the three."\
  "Thus, "r_3" is the pivot row and "a_(3 1) "is the selected pivot point." $

We then swap rows $r_1$ and $r_3$ for $a_(3 1) "to become the diagonal pivot of "c_1. $

$ mat(delim: "[", augment: #3,
    3.03, -12.1, 14, -119;
    -3.03, 12.1, -7, 120;
    6.11, -14.2, 21, -139;
  )
  attach(arrow.r, t: bold(r_1 <-> r_3))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    -3.03, 12.1, -7, 120;
    3.03, -12.1, 14, -119;
  )
$

After which we can zero out the remaining column entries in $c_1$ using $a_(1 1) "and row operations."$

$ mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    -3.03, 12.1, -7, 120;
    3.03, -12.1, 14, -119;
  )
  attach(arrow.r, t: bold(r_2 -> r_2 + 3.03/6.11 r_1))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    3.03, -12.1, 14, -119;
  )
$

$ mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    3.03, -12.1, 14, -119;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 - 3.03/6.11 r_1))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    0, -5.06, 3.59, -50.07;
  )
$

For the second pivot, we compare $r_2$ and $r_3$ in $c_2$. The original scale factors travel with their rows, so $s_2 = 12.1$ and $s_3 = 14$ (the current $r_3$ is the original $r_1$).

$ (|a_(2 2)|)/s_2 = 5.06/12.1 approx #box[0.4182] \
  (|a_(3 2)|)/s_3 = 5.06/14 approx 0.3614 \
  "Thus, "r_2" is already the pivot row and no swap is needed." $

We then zero out the remaining entry in $c_2$.

$ mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    0, -5.06, 3.59, -50.07;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 + r_2))
  mat(delim: "[", augment: #3,
    6.11, -14.2, 21, -139;
    0, 5.06, 3.41, 51.07;
    0, 0, 7.00, 1.00;
  )
$

The system is now upper triangular, so we use back substitution.

$ x_3 = 1.00/7.00 $

$ x_2 = (51.07 - 3.41 x_3)/5.06 approx 9.9966 $

$ x_1 = (-139 + 14.2 x_2 - 21 x_3)/6.11 approx -0.0079 $

$ #box(stroke: 0.5pt, inset: 8pt)[
  $therefore$ We have $ bold(x_(G E) = [-0.0079, 9.9966, 1/7]^T) $ which is very close to the actual solution of $x = [0, 10, 1/7]^T$.
] $

\
==== Solved Problem #2
Exercise 31 from Exercise Set 6.2 in Burden and Faires, Numerical Analysis.

#problem[
  Suppose that

  $ cases(2x_1 + x_2 + 3x_3 = 1,
          4x_1 + 6x_2 + 8x_3 = 5,
          6x_1 + alpha x_2 + 10x_3 = 5) $

  with $|alpha| < 10.$ For which of the following values of $alpha$ will there be no row interchange required when solving this system using scaled partial pivoting?

  A. $alpha = 6$ \
  B. $alpha = 9$ \
  C. $alpha = -3$
]

Solution:\
We have the form $bold(A x = b)$, or alternatively, the augmented matrix $bold([A | b])$ wherein

$ bold([A | b] = mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    4, 6, 8, 5;
    6, alpha, 10, 5;
  )) $

We take $s_i$ for each row $r_i$ to be

$ s_1 = max_(1 <= j <= n) |a_(1 j)| = 3\
  s_2 = max_(1 <= j <= n) |a_(2 j)| = 8\
  s_3 = max_(1 <= j <= n) |a_(3 j)| = 10\ "since" |alpha| < 10 "means" alpha "can never be the largest entry of" r_3. $

Then for the pivot on $c_1$, we have

$ (|a_(1 1)|)/s_1 = 2/3 approx 0.67 \
  (|a_(2 1)|)/s_2 = 4/8 = 0.5 \
  (|a_(3 1)|)/s_3 = 6/10 = 0.6 $

Thus, $a_(1 1)$ remains the pivot on $c_1$. No swap occurs.

Now, we zero out the remaining entries on $c_1$ using $a_(1 1)$ and row operations.

$ mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    4, 6, 8, 5;
    6, alpha, 10, 5;
  )
  attach(arrow.r, t: bold(r_2 -> r_2 - 2 r_1))
  mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    0, 4, 2, 3;
    6, alpha, 10, 5;
  )
$

$ mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    0, 4, 2, 3;
    6, alpha, 10, 5;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 - 3 r_1))
  mat(delim: "[", augment: #3,
    2, 1, 3, 1;
    0, 4, 2, 3;
    0, alpha - 3, 1, 2;
  )
$

For the second pivot, we compare $r_2$ and $r_3$ in $c_2$.

$ (|a_(2 2)|)/s_2 = 4/8 = 0.5 $

We can restrict $alpha$ using the above ratio $0.5$. For there to be no row swapping, $alpha$ has to fulfill the following:

$ (|a_(3 2)|)/s_3 = (|alpha - 3|)/10 <= 0.5 $

We thus have

$ |alpha - 3| <= 5 \
  -5 <= alpha - 3 <= 5 \
  -2 <= alpha <= 8 $

Thus, no row interchange is required for $bold(-2 <= alpha <= 8)$. At $alpha = -2$ and $alpha = 8$, a tie between the ratios occurs, and the topmost row of those being compared, $r_2$, is chosen. Any other value of $alpha$ within the above range will ensure that $r_2$ has the largest ratio and $a_(2 2)$ remains the pivot for $c_2$.

From the given choices, $alpha = 6$ lies within $[-2, 8]$, while $alpha = 9$ and $alpha = -3$ do not.

$ #box(stroke: 0.5pt, inset: 8pt)[$bold(therefore " A. " alpha = 6)$] $

#pagebreak()
==== Remixed Problem

#problem[
  Given the following linear system, where $alpha$ is a real parameter:

  $ cases(0.5x_1 + 9x_2 + 2x_3 = 16.5,
          3x_1 + 4x_2 - x_3 = 12,
          alpha x_1 + 2x_2 + 5x_3 = alpha - 1) $

  $ "Actual Solution: "x =[1, 2, -1]^T ", " forall alpha $

  (a) For which values of $alpha$ does scaled partial pivoting select $r_3$ as the first pivot row? For which values does plain partial pivoting select $r_3$? For which $alpha$ do the two strategies disagree?

  (b) For $alpha = 3.5$, use Gaussian elimination and scaled partial pivoting with four-decimal-place rounding, and compare the approximation to the actual solution.
]

Solution:\
For this problem, we can take the augmented matrix $[A | b]$ to be

$ bold([A | b] = mat(delim: "[", augment: #3,
    0.5, 9, 2, 16.5;
    3, 4, -1, 12;
    alpha, 2, 5, alpha - 1;
  )) $

(a) For scaled partial pivoting on the system, we first take the scale factor $s_i$ per row $r_i$.

$ s_1 = max_(1 <= j <= n) |a_(1 j)| = 9\
  s_2 = max_(1 <= j <= n) |a_(2 j)| = 4 $

We can omit finding $s_3$ as we have yet to find a value for $alpha$ nor restrict it to a certain range; it is either $|alpha|$ or 5, whichever is larger. In the meantime, let's calculate the ratios needed to determine the first pivot row for the system.

We have

$ (|a_(1 1)|)/s_1 = 0.5/9 approx 0.0556 \
  (|a_(2 1)|)/s_2 = 3/4 = 0.75 $

Note that if $alpha$ is sufficiently large (in our case, $|alpha| >= 5$), it may itself be chosen as $s_3$, giving us

$ (|a_(3 1)|)/s_3 = (|alpha|)/(|alpha|) = 1 > 0.75, $

so $r_3$ is always selected.

On the other hand, if $|alpha| < 5$, then $s_3 = 5$, giving

$ (|a_(3 1)|)/s_3 = (|alpha|)/5 > 0.75 \
  |alpha| > 3.75 $

so $r_3$ is selected for $3.75 < |alpha| < 5$.

Since $r_1$ never has the largest ratio, and a tie at $|alpha| = 3.75$ is broken toward the first row ($r_2$), scaled partial pivoting selects $r_3$ as the first pivot row for

$ bold({alpha | |alpha| > 3.75}), "or" {alpha < -3.75 "or" alpha > 3.75} $

For partial pivoting, however, we only compare the magnitudes $|a_(i 1)|$, with the largest value of these becoming the pivot. As such, we have

$ |a_(1 1)| = 0.5 \
  |a_(2 1)| = 3 \
  |a_(3 1)| = |alpha| $

wherein $r_3$ is selected when $|alpha| > 3$, and a tie at $|alpha| = 3$ is broken toward $r_2$. Thus, partial pivoting selects $r_3$ as the first pivot row for

$ bold({alpha | |alpha| > 3}), "or" {alpha < -3 "or" alpha > 3} $

$ #box(stroke: 0.5pt, inset: 8pt)[
  We now have ranges for the values of $alpha_S$ and $alpha_P$, for which scaled partial pivoting and regular partial pivoting select $r_3$ as the first pivot row, respectively: \
  $ alpha_S: {alpha | |alpha| > 3.75} \
    alpha_P: {alpha | |alpha| > 3.00} $
  wherein the two methods disagree if $bold(3 < |alpha| <= 3.75)$, where regular partial pivoting selects $r_3$ while scaled partial pivoting selects $r_2$.
] $

\
(b) At $alpha = 3.5$, we have the following augmented matrix:

$ bold([A | b] = mat(delim: "[", augment: #3,
    0.5, 9, 2, 16.5;
    3, 4, -1, 12;
    3.5, 2, 5, 2.5;
  )) $

The scale factor $s_i$ for every row $r_i$ is taken as:

$ s_1 = 9 \
  s_2 = 4 \
  s_3 = 5 $

Now, we select the first pivot row using $s_i$ and column $c_1$:

$ (|a_(1 1)|)/s_1 = 0.5/9 approx 0.0556 \
  (|a_(2 1)|)/s_2 = 3/4 = 0.75 \
  (|a_(3 1)|)/s_3 = 3.5/5 = 0.7 $

Thus, row $r_2$ is selected as the first pivot row and we swap with row $r_1$:

$ mat(delim: "[", augment: #3,
    0.5, 9, 2, 16.5;
    3, 4, -1, 12;
    3.5, 2, 5, 2.5;
  )
  attach(arrow.r, t: bold(r_1 <-> r_2))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0.5, 9, 2, 16.5;
    3.5, 2, 5, 2.5;
  )
$

Then we continue by zeroing out the remaining entries in $c_1$:

$ mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0.5, 9, 2, 16.5;
    3.5, 2, 5, 2.5;
  )
  attach(arrow.r, t: bold(r_2 -> r_2 - 1/6 r_1))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    3.5, 2, 5, 2.5;
  )
$

$ mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    3.5, 2, 5, 2.5;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 - 7/6 r_1))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    0, -2.6667, 6.1667, -11.5;
  )
$

For the second pivot, the scale factors travel with their rows: the current $r_2$ is the original $r_1$, so its scale factor is $9$, and the current $r_3$ is the original $r_3$, so its scale factor is $5$. We compare the two rows in $c_2$:

$ 8.3333/9 approx #box[0.9259] \
  2.6667/5 approx 0.5333 $

wherein the current $r_2$ has the greater ratio. Thus, $r_2$ is already the pivot row and no swap is needed. We then zero out the remaining entry in $c_2$.

$ mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    0, -2.6667, 6.1667, -11.5;
  )
  attach(arrow.r, t: bold(r_3 -> r_3 + 2.667/8.333 r_2))
  mat(delim: "[", augment: #3,
    3, 4, -1, 12;
    0, 8.3333, 2.1667, 14.5;
    0, 0, 6.8600, -6.8600;
  )
$

The system is now upper triangular, so we use back substitution.

$ x_3 = (-6.8600)/6.8600 = -1.0000 $

$ x_2 = (14.5 - 2.1667 x_3)/8.3333 = 16.6667/8.3333 approx 2.0000 $

$ x_1 = (12 - 4x_2 + x_3)/3 = (12 - 8.0000 - 1.0000)/3 = 1.0000 $

$ #box(stroke: 0.5pt, inset: 8pt)[
  $therefore$ We have $ bold(x_(G E) = [1.0000, 2.0000, -1.0000]^T) $ which matches the actual solution of $x = [1, 2, -1]^T$ to four decimal places.
] $
