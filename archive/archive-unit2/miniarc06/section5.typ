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
  title: [Sturm-Liouville Applications],
  subtitle: []
)

#set math.equation(numbering: none)

// Justify and indent to preference (re-applied after show rule per assets note)
#set par(
  justify: true,
  first-line-indent: (amount: 2.0em, all: true)
)



#section-subheading("1", "Special Second Order Differential Equations")

Among the applications of the Sturm-Liouville theorem, it can be used in transforming classical second-order differential equations (SODEs) such as the Legendre, Chebyshev, Hermite, Laguerre, and Bessel equations into the Sturm-Liouville form.

#example(number: "1")[
  *Legendre Equation:* $(1 - x^2)y'' - 2x y' + k(k+1)y = 0$

  *Step 1: Rewrite in standard form:* Divide by $(1 - x^2)$:
  $ y'' - (2x)/(1 - x^2) y' + (k(k+1))/(1 - x^2) y = 0 $

  *Step 2: Derive the integrating factor $mu(x)$*
  $ mu(x) = e^(integral - (2x)/(1 - x^2) dif x) = e^(ln|1 - x^2|) = 1 - x^2 \
    ==> dif / (dif x) [1 - x^2] = -2x $

  *Step 3: Multiply standard form by $mu(x)$*
  $ (1 - x^2)y'' - 2x y' + k(k+1)y = 0 \
    dif / (dif x) [(1 - x^2) y'] + k(k+1) y = 0 $

  *Step 4: Identify Sturm–Liouville parameters*
  $ p(x) = 1 - x^2, quad q(x) = 0, quad r(x) = 1, quad lambda = k(k+1) $
]

#example(number: "2")[
  *Chebyshev Equation:* $(1 - x^2) y'' - x y' + k^2 y = 0$

  *Step 1: Rewrite in standard form:* Divide by $(1 - x^2)$:
  $ y'' - x/(1 - x^2) y' + k^2/(1 - x^2) y = 0 $

  *Step 2: Derive the integrating factor $mu(x)$*
  $ mu(x) = e^(integral - x/(1 - x^2) dif x) = e^(1/2 ln|1 - x^2|) = e^(ln sqrt(1 - x^2)) = sqrt(1 - x^2) \
    ==> dif / (dif x) [sqrt(1 - x^2)] = - x / sqrt(1 - x^2) $

  *Step 3: Multiply standard form by $mu(x)$*
  $ sqrt(1 - x^2) y'' - x / sqrt(1 - x^2) y' + k^2 / sqrt(1 - x^2) y = 0 \
    dif / (dif x) [sqrt(1 - x^2) y'] + k^2 / sqrt(1 - x^2) y = 0 $

  *Step 4: Identify Sturm–Liouville parameters*
  $ p(x) = sqrt(1 - x^2), quad q(x) = 0, quad r(x) = 1 / sqrt(1 - x^2), quad lambda = k^2 $
]

#example(number: "3")[
  *Hermite Equation:* $y'' - 2x y' + 2k y = 0$

  *Step 1: Derive the integrating factor $mu(x)$*
  $ mu(x) = e^(integral -2x dif x) = e^(-x^2) \
    ==> dif / (dif x) [e^(-x^2)] = -2x e^(-x^2) $

  *Step 2: Multiply standard form by $mu(x)$*
  $ e^(-x^2) y'' - 2x e^(-x^2) y' + 2k e^(-x^2) y = 0 \
    dif / (dif x) [e^(-x^2) y'] + 2k e^(-x^2) y = 0 $

  *Step 3: Identify Sturm–Liouville parameters*
  $ p(x) = e^(-x^2), quad q(x) = 0, quad r(x) = e^(-x^2), quad lambda = 2k $
]

#example(number: "4")[
  *Laguerre Equation:* $x y'' + (1 - x) y' + k y = 0$

  *Step 1: Rewrite in standard form:* 
  Divide by $x$:
  $ y'' + (1 - x)/x y' + k/x y = 0 $

  *Step 2: Derive the integrating factor $mu(x)$*
  $ mu(x) = e^(integral (1 - x)/x dif x) = e^(integral (1/x - 1) dif x) = e^(ln|x| - x) = e^(ln|x|) e^(-x) = x e^(-x) \
    ==> dif / (dif x) [x e^(-x)] = (1 - x) e^(-x) $

  *Step 3: Multiply standard form by $mu(x)$*
  $ x e^(-x) y'' + (1 - x) e^(-x) y' + k e^(-x) y = 0 \
    dif / (dif x) [x e^(-x) y'] + k e^(-x) y = 0 $

  *Step 4: Identify Sturm–Liouville parameters*
  $ p(x) = x e^(-x), quad q(x) = 0, quad r(x) = e^(-x), quad lambda = k $
]

#example(number: "5")[
  *Bessel Equation:* $x^2 y'' + x y' + (x^2 - k^2) y = 0$

  *Step 1: Rewrite in standard form:* Divide by $x^2$:
  $ y'' + 1/x y' + (1 - k^2/x^2) y = 0 $

  *Step 2: Derive the integrating factor $mu(x)$*
  $ mu(x) = e^(integral 1/x dif x) = e^(ln|x|) = x \
    ==> dif / (dif x) [x] = 1 $

  *Step 3: Multiply standard form by $mu(x)$*
  $ x y'' + y' + (x - k^2/x) y = 0 \
    dif / (dif x) [x y'] - k^2/x y + x y = 0 $

  *Step 4: Identify Sturm–Liouville parameters*
  $ p(x) = x, quad q(x) = - k^2 / x, quad r(x) = x, quad lambda = 1 $
]