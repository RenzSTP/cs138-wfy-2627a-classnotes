// COMPENDIUM PROBLEM FORMAT
#let midgray = rgb("#888888")

#let qa-question-fill = rgb("#ececec")
#let qa-question-rule = 2.5pt + black
#let qa-answer-stroke = 0.8pt + black
#let qa-padding = 9pt
#let qa-gap = 5pt
#let qa-outer-gap = 0.85em

#let question-box(body) = block(
  width: 100%,
  fill: qa-question-fill,
  stroke: (left: qa-question-rule),
  inset: qa-padding,
  above: 0pt,
  below: 0pt,
  radius: (right: 2pt),
  text(fill: black, body),
)

#let answer-box(body, auth: none) = block(
  width: 100%,
  stroke: qa-answer-stroke,
  radius: 2pt,
  inset: qa-padding,
  above: 0pt,
  below: 0pt,
  if auth == none {
    body
  } else {
    grid(columns: 1fr, row-gutter: 6pt, body, align(right, text(weight: "bold", auth)))
  },
)

#let qa(question, answer, auth: none) = block(
  width: 100%,
  above: qa-outer-gap,
  below: qa-outer-gap,
  stack(dir: ttb, spacing: qa-gap, question-box(question), answer-box(answer, auth: auth)),
)

= Compendium Problem 1: Centered-Difference Extrapolation

#qa(
  [
    *Source*: Burden & Faires, _Numerical Analysis_, 9th ed., Exercise Set 4.2,
    Exercise 1(a), p. 191.

    Approximate $f'(x_0)$ for $f(x) = ln x$ at $x_0 = 1$ using the Richardson
    estimate $N_3(h)$ with initial step size $h = 0.4$.
  ],
  [
    *Solution.*

    *Compute the centered differences.* For any step size $s$, the centered
    difference at $x_0 = 1$ is
    $ N_(1)(s) = frac(ln(1+s) - ln(1-s), 2s). $

    At $s = 0.4$, this gives
    $ N_(1)(0.4) = frac(ln(1.4) - ln(0.6), 0.8) approx 1.059122325484. $
    We use the same formula at $s = 0.2$ and $s = 0.1$.

    *Apply Richardson extrapolation twice.* The centered difference starts
    with an $s^2$ error term. The first extrapolation cancels it using the
    factor $2^2 = 4$.
    $ N_(2)(s) = frac(4 N_(1)(s/2) - N_(1)(s), 3). $
    This leaves an error of order $s^4$. The second extrapolation uses
    $2^4 = 16$ to cancel that term.
    $ N_(3)(s) = frac(16 N_(2)(s/2) - N_(2)(s), 15). $

    #align(center)[
      #table(
        columns: 4,
        inset: 6pt,
        stroke: 0.5pt + midgray,
        [$s$], [$N_(1)(s)$], [$N_(2)(s)$], [$N_(3)(s)$],
        [0.4], [1.059122325484], [0.998509585199], [*1.000010877066*],
        [0.2], [1.013662770270], [0.999917046324], [],
        [0.1], [1.003353477311], [], [],
      )
    ]

    Thus, the sixth-order estimate is $N_(3)(0.4) approx 1.000010877066$.
    The exact derivative is $f'(1) = 1$, so the absolute error is approximately
    $1.088 times 10^(-5)$.
  ],
  auth: [FELIX, RAPHAEL ANTON],
)

= Compendium Problem 2: Forward-Difference Extrapolation

#qa(
  [
    *Source*: Burden & Faires, _Numerical Analysis_, 9th ed., Exercise Set 4.2,
    Exercise 8, p. 191.

    The forward difference is
    $ F(h) = frac(f(x_0+h) - f(x_0), h). $
    Given the expansion
    $ f'(x_0) = F(h) - frac(h, 2) f''(x_0) - frac(h^2, 6) f'''(x_0)
      + cal(O)(h^3), $
    use Richardson extrapolation to derive an $cal(O)(h^3)$ approximation
    for $f'(x_0)$.
  ],
  [
    *Solution.*

    Rearranging the given expansion gives
    $ F(h) = f'(x_0) + c_1 h + c_2 h^2 + cal(O)(h^3), $
    where $c_1 = frac(f''(x_0), 2)$ and $c_2 = frac(f'''(x_0), 6)$.

    *Cancel the first-order error.* When we halve $h$, the $c_1 h$ term
    is halved and the $c_2 h^2$ term is divided by $4$. Multiplying the finer
    estimate by $2$ and subtracting the coarser estimate gives
    $ F_(2)(h) = 2 F(h/2) - F(h)
      = f'(x_0) - frac(c_2, 2) h^2 + cal(O)(h^3). $

    *Cancel the second-order error.* The leading error term is now
    proportional to $h^2$, so the finer estimate has one-fourth of that term.
    $ F_(3)(h) = frac(4 F_(2)(h/2) - F_(2)(h), 3)
      = f'(x_0) + cal(O)(h^3). $

    Substituting $F_(2)(h/2) = 2 F(h/4) - F(h/2)$ and
    $F_(2)(h) = 2 F(h/2) - F(h)$ gives
    $ F_(3)(h) = frac(8 F(h/4) - 6 F(h/2) + F(h), 3). $

    Expanding the three forward differences gives the third-order formula.
    $ F_(3)(h) =
      frac(-21 f(x_0) + 32 f(x_0+h/4) - 12 f(x_0+h/2) + f(x_0+h), 3h). $
  ],
  auth: [FELIX, RAPHAEL ANTON],
)
#pagebreak(weak: true)
= Original Remix: Richardson Extrapolation with Two Chebyshev Nodes

#qa(
  [
    *Source*: Adapted from Burden & Faires, _Numerical Analysis_, 9th ed.,
    Exercise Set 8.3, Exercise 1(c), p. 527, and Exercise Set 4.2,
    Exercise 1(a), p. 191.

    Let $g(x) = ln(x+2)$. Approximate $g'(-1)$ using the centered difference
    $ D(h) = frac(ln(1+h) - ln(1-h), 2h). $

    + Find the two roots $z_1, z_2$ of $T_2(z) = 2z^2 - 1$. For each root,
      compute $t_i = 0.08(1+z_i)$ and set $h_i = sqrt(t_i)$.
    + Compute $D(h_1)$ and $D(h_2)$. Cancel the leading $h^2$ error using
      $ R = frac(t_2 D(h_1) - t_1 D(h_2), t_2 - t_1). $
    + Differentiate $g(x)$ to find $g'(-1)$ exactly and calculate the
      absolute error of $R$.
  ],
  [
    *Solution.*

    *Choose the step sizes.* Solving $2z^2 - 1 = 0$ gives
    $z_1 = -1/sqrt(2)$ and $z_2 = 1/sqrt(2)$. Map the roots to
    $[0, 0.16]$ with $t_i = 0.08(1+z_i)$, take $h_i = sqrt(t_i)$,
    and evaluate the centered difference at each step size.

    #align(center)[
      #table(
        columns: 4,
        inset: 6pt,
        stroke: 0.5pt + midgray,
        [$z_i$], [$t_i$], [$h_i$], [$D(h_i)$],
        [$-1/sqrt(2)$], [0.023431457505], [0.153073372946], [1.007922164430],
        [$1/sqrt(2)$], [0.136568542495], [0.369551813005], [1.049660453314],
      )
    ]

    *Apply one Richardson step.* Using the unrounded values,
    $ R = frac(t_2 D(h_1) - t_1 D(h_2), t_2 - t_1)
      approx bold(0.999277881767). $

    This is the value at $t = 0$ of the line through the two data points.
    The centered difference has the form
    $ D(h) = g'(-1) + c h^2 + cal(O)(h^4)
      = g'(-1) + c t + cal(O)(t^2). $
    In the numerator of $R$, the leading error terms $t_2 c t_1$ and
    $t_1 c t_2$ cancel.

    *Check the answer.* Since $g'(x) = 1/(x+2)$, the exact value is
    $g'(-1) = 1$. The absolute error is
    $ abs(R - g'(-1)) approx bold(0.000722118233). $
  ],
  auth: [FELIX, RAPHAEL ANTON],
)