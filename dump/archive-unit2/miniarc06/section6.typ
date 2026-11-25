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
#import "../assets.typ": notes, definition, theorem, algorithm, example, note, section-subheading, section-emphasis

#show: notes.with(
  title: [Power Series],
)
/// END STYLING PREAMBLE
#definition(name: "Power Series")[
  Recall that in Math 22, the power series for some $y$ is represented as:
  $ 
  y &= a_0+a_1x+a_2x^2+... \
  y &= sum_(n=0)^oo a_n x^n
  $
  
]
In differentiating a power series, we get the following:
$
y' &= 0 + 2a_2x+3a_3x^2+ ...\
y' &= sum_(n=1)^oo n a_n x^(n-1)\
&"Reindexing: (that is, "n -> n+1) \
y' &= sum_(n=0)^oo (n+1)a_(n+1)x^n
$
And
$
y'' &= 0 + 0+6a_3x+ 12a_4x^2 + 20a_5x^3 + ...\
y'' &= sum_(n=2)^oo n(n+1) a_n x^(n-2)\
&"Reindexing: (that is, "n -> n+2) \
y'' &= sum_(n=0)^oo (n+2)(n+1)a_(n+2)x^n
$

== Taylor and Maclaurin Series

#definition(name: "Taylor and Maclaurin series")[
  The _Taylor series_ of $f$ about $x_0$ is
  $ f(x) = sum_(n=0)^oo (f^((n)) (x_0)) / n! (x - x_0)^n. $
  If we take $x_0 = 0$, this gives the _Maclaurin series_ 
  $ f(x) = sum_(n=0)^oo (f^((n)) (0)) / n! x^n $
]

#block(breakable: false)[
#theorem(name: "Four common Maclaurin series to know")[
  $ sin x &= sum_(n=0)^oo (-1)^n x^(2n+1) / (2n+1)! = x - x^3 / 3! + x^5 / 5! - dots.c quad &&"(all " x ")" \
    cos x &= sum_(n=0)^oo (-1)^n x^(2n) / (2n)! = 1 - x^2 / 2! + x^4 / 4! - dots.c &&"(all " x ")" \
    e^x &= sum_(n=0)^oo x^n / n! = 1 + x + x^2 / 2! + x^3 / 3! + dots.c &&"(all " x ")" \
    ln(1 + x) &= sum_(n=0)^oo (-1)^n x^(n+1) / (n+1) = x - x^2 / 2 + x^3 / 3 - dots.c &&(|x| < 1) $
]]

== Solving an ODE by Power Series

#algorithm(name: "Power Series solution")[
  + Substitute $y = sum a_n x^n$ and the formulas for $y'$, $y''$ into the ODE.
  + Reindex so every sum contains $x^n$ and starts at the same $n$.
  + A power series equal to $0$ has every coefficient $0$, so set each coefficient of $x^n$ to zero. This gives a recurrence for  $a_n$.
  + Solve the recurrence, find the pattern, and recognize the resulting series.
]

#example(number: "1")[
  Solve $y'' + c^2 y = 0$, $c != 0$.

  _Known answer:_ Characteristic equation is $r^2 + c^2 = 0 => r = plus.minus c i$, so $y = C_1 sin(c x) + C_2 cos(c x)$. Now we rebuild it from power series.

  Substituting,
  $ 
  y'' + c^2y &= 0 \
  sum_(n=0)^oo (n+2)(n+1) a_(n+2) + c^2 sum_n(=0)^oo a_n x^n &= 0 \
  sum_(n=0)^oo [(n+2)(n+1)a_(n+2)+c^2a_n]x^n &= 0  \
  $
  A power series equal to 0 must have every coefficient to 0, that is, every coefficient of $x^n$ is 0. Therefore, we get recurrence:
  $
  (n+2)(n+1)a_(n+2)+c^2a_n &= 0 \
  a_(n+2) &= - (c^2 a_n) / ((n+2)(n+1)), a_0, a_1 in RR. $
  The recurrence links $a_n$ to $a_(n+2)$, so even and odd terms separate:

  For even:
  $ a_2 = - c^2 / (2 dot 1) a_0, quad a_4 = c^4 / 4! a_0, quad a_6 = - c^6 / 6! a_0 quad \ ==> quad a_(2k) &= ((-1)^k c^(2k)) / (2k)! a_0, $
  For odd:
  $ a_3 = - c^2 / 3! a_1, quad a_5 = c^4 / 5! a_1 quad \ ==> quad a_(2k+1) &= ((-1)^k c^(2k)) / (2k+1)! a_1. $
  Assembling, with $c^(2k) x^(2k+1) = (c x)^(2k+1) / c$,
  $ y = a_0 sum_(k=0)^oo ((-1)^k (c x)^(2k)) / (2k)! + a_1 / c sum_(k=0)^oo ((-1)^k (c x)^(2k+1)) / (2k+1)! = a_0 cos(c x) + a_1 / c sin(c x), $
  which matches the known answer with $C_2 = a_0$ and $C_1 = a_1 / c$.

  Check, $c = 2$: $a_2 = -2 a_0$ and $a_4 = (2/3) a_0$, and $cos 2x = 1 - 2x^2 + (2/3) x^4 - dots.c$. ✓
]
