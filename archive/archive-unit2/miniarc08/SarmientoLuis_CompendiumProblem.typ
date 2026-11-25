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
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis, qa

/// END STYLING PREAMBLE


// SECTION HEADER
#show: notes.with(
  title: [Problem 1],
)

#qa(auth: "SARMIENTO, Luis Antonio P.")[
  *Source:* Sauer, T. Numerical Analysis (2nd ed.), Exercise Set 5.1
#let dotline(w) = box(baseline: -0.25em, line(length: w, stroke: (dash: "dotted", thickness: 1.2pt)))

Item 6a. Use the three-point centered-difference formula for the second derivative to approximate
$f''(0)$, where $f (x) = cos x$, for $h = 0.1$
][
The central difference formula for the second derivative is as follows: 
$
f''(x) approx (f(x+h) - 2f(x) + f(x-h))/h^2
$

Substituting $x=0$ and $h=0.1$ into the formula, we have
$
f''(0) approx (f(0+0.1) - 2f(0) + f(0-0.1))/0.1^2 = (f(0.1) - 2f(0) + f(-0.1))/0.01
$
Since $f(x)=cos x$, we substitute $f(0.1) = cos (0.01), f(0) = cos (0), " and" f(-0.01) = cos (-0.01)$ into Equation (2).

$
f''(0) approx (cos (0.1) - 2cos(0) + cos(-0.1))/0.1^2
$

This gives us

$
f''(0) approx (cos (0.1) - 2cos(0) + cos(-0.1))/0.01 = -0.9992
$

We now have the approximation $f''(0) approx -0.9992$.
]

// SECTION HEADER
#show: notes.with(
  title: [Problem 2],
)

#qa(auth: "SARMIENTO, Luis Antonio P.")[
  *Source:* Iyengar and Jain, Numerical Methods. Exercise Set 3.1.
#let dotline(w) = box(baseline: -0.25em, line(length: w, stroke: (dash: "dotted", thickness: 1.2pt)))

Item 8. Obtain the value of f′(0.04) using an approximate formula for the given data:
#figure(
  align(center)[
    #table(
      columns: 7,
      align: center + horizon,
      stroke: 0.5pt,
      $x$, [0.01], [0.02], [0.03], [0.04], [0.05], [0.06],
      $y$, [0.1023], [0.1047], [0.1071], [0.1096], [0.1122], [0.1148]
    )
  ]
)
][
*Solution.*
Recall that the forward difference formula is as follows:

$
f'(x) approx (f(x+h) - f(x))/h
$

Since our $x$ values in the table are evenly spaced, we can use the forward difference formula to approximate the value of $f'(0.04)$, with step size $h=0.01$. Substituting into the formula, we have:

$
f'(0.04) approx (f(0.04 + 0.01) - f(0.04))/0.01
$

From the given data, we know that $f(0.05) = 0.1122$ and $f(0.04) = 0.1096$. Substituting once more using these values,

$
(f(0.05) - f(0.04))/0.01 = (0.1122-0.1096)/0.01 = 0.26
$

We now have the approximation $f'(0.04) approx 0.26$.
]

= Remix

#qa(auth: "SARMIENTO, Luis Antonio P.")[
Obtain the value of $f''(0.03)$ using an approximate formula for the given data:
#figure(
  align(center)[
    #table(
      columns: 7,
      align: center + horizon,
      stroke: 0.5pt,
      $x$, [0.01], [0.02], [0.03], [0.04], [0.05], [0.06],
      $y$, [0.1023], [0.1047], [0.1071], [0.1096], [0.1122], [0.1148]
    )
  ]
)
][
*Solution.* For this problem, we can use the central difference formula for the second derivative, 

$
f''(x) approx (f(x+h) - 2f(x) + f(x-h))/h^2
$

Since the $x$ values are evenly spaced, we can use this formula with a step size of $h=0.01$ to find an approximation for $f''(0.03)$. Substituting $h=0.01 "and" x=0.03$, we have:
$
f''(0.03) approx (f(0.03+0.01) - 2f(0.03) + f(0.03-0.01))/0.01^2
$


From the given data, we know that $f(0.04)=0.1096$, $f(0.03)=0.1071$, and $f(0.02)=0.1047$. Substituting these values into Equation (9),

$
(f(0.04) - 2f(0.03) + f(0.02))/0.01^2 = (0.1096 - 0.2142 + 0.1047)/0.0001 = 1
$

We now have the approximation $f''(0.03) approx 1$.
]

= References
+ Sauer, T. (2012). Numerical Analysis (2nd ed.). Pearson.
+ Iyengar, S. R. K., & Jain, R. K. (2009). Numerical Methods. New Age International Publishers.
