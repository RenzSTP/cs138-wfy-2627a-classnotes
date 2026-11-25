#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

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

#let lub(x) = text(fill: blue)[$#x$]
#let lur(x) = text(fill: red)[$#x$]
#let luv(x) = text(fill: violet)[$#x$]

Notice that if we multiply $L$ and $U$ together, we get this:

$mat(delim: "[", a_11, a_12, a_13, ..., a_(1 n); 
  a_21, a_22, a_23, ..., a_(2 n); 
  a_31, a_32, a_33, ...., a_(3 n); 
  dots.v, dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), a_(n 3), ...,  a_(n n)) 
= mat(delim: "[", l_11,l_11 u_12, l_11 u_13,..., l_11 u_(1 n); 
  l_21, l_21 u_12 + l_22, l_21 u_13 + l_22 u_23, ..., l_21 u_(1 n) + l_22 u_(2 n); 
  l_31, l_31 u_12 + l_32, l_31 u_13 + l_32 u_23 + l_33, ..., l_31 u_(1 n) + l_32 u_2n + l_32 u_(3 n);
  dots.v, dots.v, dots.v, dots.down, dots.v;
  l_(n 1), l_(n 1) u_12 + l_(n 2), l_(n 1) u_13 + l_(n 2) u_23 + l_33, ..., l_(n 1) u_(1 n) + l_(n 2) u_(2 n) + ... + l_(n n) u_(n n)
) $

If we equate each element of both sides, we can rearrange this to get the $l_(i j)$ and $u_(i j)$ of $L$ and $U$, respectively.

// have to check this
For $L$

$ l_(i j) = a _(i j) - sum _(k=1)^(j-1) l_(i k) u_(k j) " for " i >= j $

For $U$

$ u_(i j) = 1/l_(i i) (a _(i j) - sum _(k=1)^(j-1) l_(j k) u_(k i)) " for " i < j $


This may look a little intimidating at first glance, but once we do an example, we will find it to be easy, hopefully.


By the end of applying this algorithm, we will have:

$ mat(delim: "[",
  lub(l_11), lur(u_12), lur(...), lur(u_(1 n));
  lub(l_21), lub(l_22), lur(...), lur(u_(2 n));
  lub(dots.v), lub(dots.v), lub(dots.down), lur(dots.v);
  lub(l_(n 1)), lub(l_(n 2)), lub(...), lub(l_(n n));
) => 
L= mat(delim: "[",
  lub(l_11), 0, ..., 0;
  lub(l_21), lub(l_22), ..., 0;
  lub(dots.v), lub(dots.v), lub(dots.down), 0;
  lub(l_(n 1)), lub(l_(n 2)), lub(...), lub(l_(n n));
), U = 
mat(delim: "[",
  1, lur(u_12), lur(...), lur(u_(1 n));
  0,1, lur(...), lur(u_(2 n));
  dots.v, dots.v, dots.down, lur(dots.v);
  0, 0,..., 1;
)
$

We will proceed by starting with the first column, then the remaining of the first row, then the remaining of the second column, then the remaining of the second row, and so on.

Visually:

$
mat(delim: "[",
  lub(\(1\)), lur(\(2\)), lur(...), lur(\(2\));
  lub(\(1\)), lub(\(3\)), lur(...), lur(\(4\));
  lub(dots.v), lub(dots.v), lub(dots.down), lur(dots.v);
  lub(\(1\)), lub(\(3\)), lub(...), lub(\("last"\));
)
$


// For $L$

// $ l_(i j) = a _(i j) - sum _(k=1)^(j-1) l_(i k) u_(k j) " for " i >= j $

// For $U$

// $ u_(i j) = 1/l_(i i) (a _(i j) - sum _(k=1)^(j-1) l_(j k) u_(k i)) " for " i < j $


Here we have a matrix $A$ that we want to decompose. The right hand side is for visual purposes and we do not need to write or memorize it.

$
A = mat(delim: "[", 6, 6, 12; 5, 9, 22; 3, 5, 13)
 = mat(delim: "[", l_11,l_11 u_12, l_11 u_13;
  l_21, l_21 u_12 + l_22, l_21 u_13 + l_22 u_23;
  l_31, l_31 u_12 + l_32, l_31 u_13 + l_32 u_23 + l_33)
$

If we look at the 1st columns, we notice that we can just copy it. This coincides with the equation for $l_(i j)$ where the summations does not contribute anything.

$ mat(delim: "[", lub(6), , ; lub(5), , ; lub(3), "   ", "  ") $

Now, we have the first column that coincides with the first column of $L$.

Next, notice how the elements of the right of the $l_11$ diagonal simply have $l_11$ multiplied to the $u_(1 i)$ elements. That means we can simply divide by $l_11$ to get the $u_(1 i)$ elements. Looking at the formula, it becomes $ u_(1 i) = 1/l_(1 1) (a _(1 i)) " for " i < j$.

$ mat(delim: "[", lub(6), lur(6/6), lur(12/6); lub(5), , ; lub(3), "   ", "  ") =>
mat(delim: "[", lub(6), lur(1), lur(2); lub(5), , ; lub(3), "   ", "  ") $

Now we move on to the remaining 2nd column. 
The equation says $ l_(i 2) = a _(i 2) - l_(i 1) u_(1 2) " for " i >= 2$.

$ mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), 9 - lub(5) dot lur(1), ; 
  lub(3), 5 - lub(3) dot lur(1), "  ")
  => mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), ; 
  lub(3), lub(2), "   ")
  $

We move on to the 2nd column of $U$. Notice how it is similar to the one above except that we also _divide by the diagonal_ just like the first row.

$ mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), 1/lub(4)(22 - lub(5) dot lur(2)); 
  lub(3), lub(2), "   ") =>
  mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), lur(3); 
  lub(3), lub(2), "   ") $

For the final element,

$ mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), lur(3); 
  lub(3), lub(2), 13 - (lub(3) dot lur(2)) - (lub(2) dot lur(3)) ) = 
  mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), lur(3); 
  lub(3), lub(2), lub(1)) $

This can now be separated into our $L$ and $U$ matrices:

$ mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), lur(3); 
  lub(3), lub(2), lub(1)) => 
  L = mat(delim: "[", 
  lub(6), 0, 0; 
  lub(5), lub(4), 0; 
  lub(3), lub(2), lub(1))
  , U = mat(delim: "[", 
  1, lur(1), lur(2); 
  0, 1, lur(3); 
  0, 0, 1) "(yey!)" $

Notice how you can actually just work on a single "matrix" and fill it up by working on the computations on your head or somewhere else. It can simply look like this:

// im not saying they will accept an answer like this im not sure actually
#example(number: "")[
$ A = mat(delim: "[", 6, 6, 12; 5, 9, 22; 3, 5, 13) =>
mat(delim: "[", 
  lub(6), lur(1), lur(2); 
  lub(5), lub(4), lur(3); 
  lub(3), lub(2), lub(1)) => 
  L = mat(delim: "[", 
  lub(6), 0, 0; 
  lub(5), lub(4), 0; 
  lub(3), lub(2), lub(1))
  , U = mat(delim: "[", 
  1, lur(1), lur(2); 
  0, 1, lur(3); 
  0, 0, 1) $
]
A fun way to remember this algorithm is sort of a game of 2 rules. For every cell, we subtract the multiplied pairs of elements above it and elements to its left.

For example, this can be clearly seen in solving for the final $l_33 = 13 - (lub(3) dot lur(2)) - (lub(2) dot lur(3)) = a_33 - (lub(l_31) dot lur(u_13)) - (lub(l_32) dot lur(u_23))$.

We add another rule for $u_(i j)$ where we also divide it by the diagonal $l_(i i)$ right after. This can be seen in solving $a_23 = 1/lub(4)(22 - lub(5) dot lur(2)) = 1/lub(a_22)(22 - lub(l_21) dot lur(u_13))$