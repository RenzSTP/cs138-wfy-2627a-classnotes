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

// SECTION HEADER
#show: notes.with(
  title: [Power Series Method],
  subtitle: [Russell Lawrence Sison]
)

// `qa` wrapper: no first-line indent inside the question/answer boxes
#let problem(question, answer) = qa(
  { set par(first-line-indent: 0pt); question },
  { set par(first-line-indent: 0pt); answer },
)


#qa(auth: "Sison, Russell Lawrence")[
  #set par(first-line-indent: 0pt)
  *Compendium Problem \#1.* Source: CS 138 Lecture Slides -- Eigenvalue BVPs (Power Series, Example 1).

  Solve $y'' + c^2 y = 0$, $c != 0$, by the power series method.
][
  #set par(first-line-indent: 0pt)
  The characteristic equation $r^2 + c^2 = 0$ gives $r = plus.minus c i$, so $y = C_1 sin(c x) + C_2 cos(c x)$. We now rebuild this from power series.

  *Step 1: substitute the series.* Via differentiating with reindexing, we substitute, then obtain our equation:
  $ y'' = sum_(n=0)^oo (n+2)(n+1) a_(n+2) x^n, quad sum_(n=0)^oo [(n+2)(n+1) a_(n+2) + c^2 a_n] x^n = 0. $

  *Step 2: recurrence.*   A power series equal to 0 must have every coefficient to 0, that is, every coefficient of $x^n$ is 0. Therefore, our recurrence is:
  $ a_(n+2) = - (c^2 a_n) / ((n+2)(n+1)), quad a_0, a_1 in RR $


  *Step 3: solve.*   The recurrence links $a_n$ to $a_(n+2)$, so even and odd terms separate.
  
  For evens, $a_2 = -c^2 a_0 / 2!$, $a_4 = c^4 a_0 / 4!$, $a_6 = -c^6 a_0 / 6!$, so
  $ a_(2k) = (-1)^k c^(2k) a_0 / (2k)!. $
  For odds:
  $ a_(2k+1) = (-1)^k c^(2k) a_1 / (2k+1)!. $

  *Step 4: assmbling.* Since $c^(2k) x^(2k) = (c x)^(2k)$ and $c^(2k) x^(2k+1) = (c x)^(2k+1) / c$,
  $ y = a_0 sum_(k=0)^oo (-1)^k (c x)^(2k) / (2k)! + a_1 / c sum_(k=0)^oo (-1)^k (c x)^(2k+1) / (2k+1)! = a_0 cos(c x) + a_1 / c sin(c x), $
  which matches with $C_2 = a_0$ and $C_1 = a_1 / c$.

  *Step 5: check.* With $c = 2$. $a_2 = -2 a_0$ and $a_4 = (2/3) a_0$, and $cos 2x = 1 - 2x^2 + (2/3) x^4 - dots.c$ ✓.
]
\ \ \
#qa(auth: "Sison, Russell Lawrence")[
  #set par(first-line-indent: 0pt)
  *Compendium Problem \#2.* Source: Burden and Faires, Numerical Analysis, 9th ed., Exercise Set 11.3, 3(c).

  Solve $y'' = -(x+1) y' + 2y + (1 - x^2) e^(-x)$, $0 <= x <= 1$, $y(0) = -1$, $y(1) = 0$, by power series about $x_0 = 0$.

  (Note: The problem content was changed from Finite Difference Approximation to Power Series method.)
][
  #set par(first-line-indent: 0pt)
  *Step 1: rearrange.* The coefficients are polynomials and the forcing is entire, so $x_0 = 0$ is ordinary and the series converges for all $x$.
  $ y'' + (x+1) y' - 2y = (1 - x^2) e^(-x). $

  *Step 2: series for each term.*
  $ y &= sum a_n x^n, \
    y'' &= sum (n+2)(n+1) a_(n+2) x^n, \
    y' &= sum (n+1) a_(n+1) x^n, \
    x y' &= sum n a_n x^n. $
  Adding $y'' + x y' + y' - 2y$ and collecting $x^n$:
  $ sum_(n=0)^oo [(n+2)(n+1) a_(n+2) + (n+1) a_(n+1) + (n-2) a_n] x^n = (1 - x^2) e^(-x). $

  *Step 3: series for the right side.* With $e^(-x) = sum (-1)^n x^n / n!$,
  $ (1 - x^2) e^(-x) = sum_(n=0)^oo (-1)^n x^n / n! - sum_(n=2)^oo (-1)^n x^n / (n-2)! = sum_(n=0)^oo b_n x^n, $
  $ b_0 = 1, quad b_1 = -1, quad b_n = (-1)^n (1 / n! - 1 / (n-2)!) quad (n >= 2), quad b_2 = -1/2. $

  *Step 4: recurrence.*
  $ a_(n+2) = (b_n - (n+1) a_(n+1) - (n-2) a_n) / ((n+2)(n+1)). $

  *Step 5: left condition and first coefficients.* $y(0) = a_0 = -1$; $a_1 = y'(0)$ stays symbolic.
  $ n = 0: quad & 2 a_2 + a_1 - 2(-1) = 1 quad && ==> quad a_2 = -(1 + a_1) / 2 \
    n = 1: quad & 6 a_3 + 2 a_2 - a_1 = -1 quad && ==> quad 6 a_3 = 2 a_1 quad ==> quad a_3 = a_1 / 3 \
    n = 2: quad & 12 a_4 + 3 a_3 + 0 dot a_2 = -1/2 quad && ==> quad a_4 = -(1 + 2 a_1) / 24 $

  *Step 6: right condition.* $y(1) = sum a_n = 0$. Truncating at $n = 4$ and splitting each $a_n$ into constant and $a_1$ parts:
  $ underbrace((-1 - 1/2 - 1/24), "constants") + underbrace((1 - 1/2 + 1/3 - 1/12), "coefficient of" a_1) a_1 = 0 $
  $ -37/24 + 3/4 a_1 = 0 quad ==> quad a_1 = 37/18 approx 2.056. $
  Keeping terms up to $n = 8$ gives $a_1 = 2.00003$, so $a_1 = 2$.

  *Step 7: assembling.* With $a_1 = 2$: $a_0, dots, a_4 = -1, 2, -3/2, 2/3, -5/24$, so
  $ a_n = (-1)^(n-1) (n+1) / n! = (-1)^(n-1) [1 / (n-1)! + 1 / n!]. $
  Summing the two parts separately,
  $ y = underbrace(sum_(n=1)^oo (-1)^(n-1) x^n / (n-1)!, x e^(-x)) + underbrace(sum_(n=0)^oo (-1)^(n-1) x^n / n!, -e^(-x)) = (x - 1) e^(-x). $

  *Step 8: check.*
  $ y' = (2 - x) e^(-x), quad y'' = (x - 3) e^(-x), $
  $ -(x+1)(2-x) + 2(x-1) + (1 - x^2) = x - 3 quad checkmark $
  $ y(0) = -1, quad y(1) = 0, quad y'(0) = 2 = a_1,\ quad y(0.3) = -0.7 e^(-0.3) = -0.5185728 "(matches the book)". $
]
\ \ \ \ \ \ \ \
#qa(auth: "Sison, Russell Lawrence")[
  #set par(first-line-indent: 0pt)
  *Remixed Problem.* 

  Let $epsilon = 0.005$. Consider the BVP
  $ y'' + epsilon^2 y = 0, quad y(0) = 1, quad y(1) = 1. $
  Use the power series about $x_0 = 0$ to find $y'(0)$, doing every step in 4-significant-digit rounding arithmetic. Then explain what goes wrong and name a better method.
][
  #set par(first-line-indent: 0pt)
  *Step 1: the series (from Problem \#1 with $c = epsilon$).* The point $x_0 = 0$ is ordinary, so $y = sum a_n x^n$ converges for all $x$, with $a_0 = y(0) = 1$ and $a_1 = y'(0)$ unknown:
  $ y = underbrace(1 - epsilon^2 x^2 / 2! + epsilon^4 x^4 / 4! - dots.c, a_0 "part") + a_1 underbrace((x - epsilon^2 x^3 / 3! + dots.c), "odd part"). $

  *Step 2: impose $y(1) = 1$.* Setting $x = 1$ (as in Problem \#2, Step 6), $sum a_n = 1$:
  $ (1 - epsilon^2 / 2! + epsilon^4 / 4! - dots.c) + a_1 (1 - epsilon^2 / 3! + dots.c) = 1. $

  *Step 3: evaluate in 4 digits.*
  $ epsilon^2 / 2! = 1.25 times 10^(-5), quad epsilon^4 / 4! approx 2.6 times 10^(-11), quad epsilon^2 / 3! approx 4.2 times 10^(-6). $
  Each bracket is $1$ minus something far below the 4th digit:
  $ 1 - 0.0000125 = 0.9999875 -> 1.000, quad 1 - 0.0000042 -> 1.000. $

  *Step 4: solve for $a_1$.*
  $ 1.000 + 1.000 a_1 = 1 quad ==> quad a_1 = y'(0) = 0. $
  The true value is $a_1 = epsilon (1 - cos epsilon) / sin epsilon = epsilon tan(epsilon / 2) approx 1.250 times 10^(-5)$, so the computed slope has a *100% error*.

  *Conclusion 1: catastrophic cancellation.* The slope is determined by the tiny difference $1 - (1 - epsilon^2 / 2 + dots.c) approx 1.25 times 10^(-5)$. Rounding to 4 digits (resolution about $10^(-4)$ near $1$) erases the $1.25 times 10^(-5)$, so subtracting two nearly equal numbers leaves no correct digit.

  *Conclusion 2: consequence and a better method.* Using the series here gives a slope of $0$ when the true slope is not $0$, so the series method is the wrong tool for this problem in finite precision. A better option would be to use a numerical method such as shooting or finite differences for BVPs with no closed form.
]
