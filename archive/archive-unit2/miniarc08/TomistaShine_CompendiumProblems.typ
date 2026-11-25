// STYLING
#let ink = black
#let lightgray = rgb("#F2F2F2")
#let midgray = rgb("#888888")

// First line indent
#let fl-indent = 2.0em

/// END STYLING

// OVERVIEW
// LINES XY - YZ - COMPENDIUM FORMATS
// ABC - DEF CLASS NOTES FORMAT


//
// COMPENDIUM PROBLEM FORMAT
// (credits to Dean (?))
//////

//   #qa(auth: "Dean")[question][answer].
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

// ── Lesson notes 
//   #show: notes.with(title: [Power Method], subtitle: [Linear Algebra · Lesson 1])
//   = Section   == Subsection   === Run-in
//   #definition(name: [...])[body]  #theorem[body]  #algorithm[body]
//   #example[body]  #note[body]

#let notes-fill = rgb("#f0f0f0")
#let notes-tint = rgb("#f7f7f7")
#let notes-hairline = 0.5pt + rgb("#8c8c8c")
#let notes-muted = rgb("#555555")

#let notes-tag(label, name) = text(
  weight: "bold",
  if name == none { label } else { [#label : #name] },
)

#let notes-lede(name, body) = if name == none {
  body
} else {
  stack(dir: ttb, spacing: 0.35em, name, [
    #set par(first-line-indent: (all: false))
    #body
  ])
}

#let notes-box(body, name: none, fill: none, stroke: none) = block(
  width: 100%,
  inset: 9pt,
  radius: 2pt,
  fill: fill,
  stroke: stroke,
  above: 0.6em,
  below: 0.6em,
  notes-lede(name, body),
)

// style "borrowed" from LE1-MiniArc3 Team
#let definition(name: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + ink),
)[
  #set par(
    justify: true,
    first-line-indent: (all: false)
  )
  #text(fill: ink, weight: "bold")[
    Definition #if name != none [(#name)].
  ] #body
]


#let theorem(body, name: none) = notes-box(
  body,
  name: notes-tag("Theorem", name),
  stroke: 0.8pt + black,
)

#let algorithm(body, name: none) = notes-box(
  body,
  name: notes-tag("Algorithm", name),
  fill: notes-tint,
  stroke: 0.8pt + black,
)

// style "borrowed" from LE1-MiniArc3 Team
#let example(number: none, body) = block(
  fill: lightgray,
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  stroke: (left: 3pt + midgray),
)[
  #set par(first-line-indent: 0pt)
  #text(fill: ink, weight: "bold")[Example #if number != none [#number].]
  #body
]

#let note(body, name: none) = notes-box(body, name: notes-tag("Note", name))

#let notes(body, title: none, subtitle: none) = {
  if title != none {
    block(
      width: 100%,
      stroke: (bottom: 2pt + black),
      inset: (bottom: 7pt),
      text(size: 1.7em, weight: "bold", title),
    )
    if subtitle != none {
      block(above: 3pt, text(size: 0.95em, fill: notes-muted, subtitle))
    }
    v(0.6em)
  }
  set math.equation(numbering: "(1)")
  set table(inset: 5pt, stroke: notes-hairline)
  set figure(gap: 0.7em)
  show heading.where(level: 1): it => block(
    width: 100%,
    above: 1.1em,
    below: 0.5em,
    stroke: (bottom: 1.5pt + black),
    inset: (bottom: 4pt),
    text(size: 1.2em, weight: "bold", box(it.body)),
  )
  show heading.where(level: 2): it => block(
    width: 100%,
    above: 1em,
    below: 0.45em,
    stroke: (bottom: notes-hairline),
    inset: (bottom: 3pt),
    text(size: 1.05em, weight: "bold", box(it.body)),
  )
  show heading.where(level: 3): it => block(
    above: 0.8em,
    below: 0.3em,
    text(weight: "bold", style: "italic", box(it.body)),
  )
  body
}

//
// COMPENDIUM PROBLEM FORMAT END
//////

= Compendium Problem 1: General Linear FDA (Constant Coefficients)

#qa(
  [
    *Source*: Burden & Faires, _Numerical Analysis_, 9th ed., Exercise Set 11.3, Problem 3(a).

    Use the Linear Finite-Difference Algorithm to approximate the solution
    to the boundary value problem
    $ y'' = -3y' + 2y + 2x + 3, quad 0 <= x <= 1, quad y(0) = 2, quad y(1) = 1, $
    with $h = 0.1$.
  ],
  [
    *Solution.*

    Rewriting in standard form, $y'' + 3y' - 2y = 2x+3$, so
    $P(x) = 3$, $Q(x) = -2$, $R(x) = 2x+3$. With $h = 0.1$ there are 9
    interior points $x_i = 0.1i$, $i = 1,dots,9$. Since $P, Q$ are
    constant, every row has the same coefficients:
    $ A_i = 1/h^2 - P/(2h) = 85, quad B_i = -2/h^2 + Q = -202, quad
      C_i = 1/h^2 + P/(2h) = 115. $

    Moving the known boundary values $y_0 = 2$, $y_(10) = 1$ to the
    right-hand side gives $d_1 = R(x_1) - A_1 y_0 = -166.8$,
    $d_i = R(x_i)$ for $i = 2,dots,8$, and $d_9 = R(x_9) - C_9 y_(10) = -110.2$.

    *Forward sweep* ($l_1 = B_1$, $u_1 = C_1\/l_1$, $z_1 = d_1\/l_1$; then
    $l_i = B_i - A_i u_(i-1)$, $u_i = C_i\/l_i$, $z_i = (d_i - A_i z_(i-1))\/l_i$):

    #align(center)[
      #table(
        columns: 5,
        inset: 6pt,
        stroke: 0.5pt + midgray,
        [$i$], [$d_i$], [$l_i$], [$u_i$], [$z_i$],
        [1], [$-166.800$], [$-202.000$], [$-0.56931$], [$0.82574$],
        [2], [$3.400$], [$-153.609$], [$-0.74865$], [$0.43479$],
        [3], [$3.600$], [$-138.364$], [$-0.83114$], [$0.24108$],
        [4], [$3.800$], [$-131.353$], [$-0.87550$], [$0.12708$],
        [5], [$4.000$], [$-127.582$], [$-0.90138$], [$0.05331$],
        [6], [$4.200$], [$-125.383$], [$-0.91719$], [$0.00264$],
        [7], [$4.400$], [$-124.039$], [$-0.92713$], [$-0.03366$],
        [8], [$4.600$], [$-123.194$], [$-0.93349$], [$-0.06056$],
        [9], [$-110.200$], [$-122.654$], [—], [$0.85649$],
      )
    ]

    *Back substitution* ($y_9 = z_9$, $y_i = z_i - u_i y_(i+1)$):

    #align(center)[
      #table(
        columns: 10,
        inset: 5pt,
        stroke: 0.5pt + midgray,
        [$x_i$], [0.1], [0.2], [0.3], [0.4], [0.5], [0.6], [0.7], [0.8], [0.9],
        [$y_i$], [1.4054], [1.0181], [0.7791], [0.6474], [0.5943],
                  [0.6002], [0.6515], [0.7390], [0.8565],
      )
    ]

    with $y(0) = 2$ and $y(1) = 1$ as given.
  ],
  auth: [TOMISTA, FATIMA SHINE],
)
= Compendium Problem 2: General Linear FDA (Variable Coefficients)

#qa(
  [
    *Source*: Burden & Faires, _Numerical Analysis_, 9th ed., Exercise Set 11.3, Problem 3(c).

    Use the Linear Finite-Difference Algorithm to approximate the solution
    to the boundary value problem
    $ y'' = -(x+1) y' + 2y + (1-x^2) e^(-x), quad 0 <= x <= 1, quad y(0) = -1, quad y(1) = 0, $
    with $h = 0.1$.
  ],
  [
    *Solution.*

    Rewriting in standard form, $y'' + (x+1)y' - 2y = (1-x^2)e^(-x)$, so
    $P(x) = x+1$, $Q(x) = -2$, $R(x) = (1-x^2)e^(-x)$. Here $P$ varies
    with $x_i$, so $A_i, C_i$ must be recomputed at every row:
    $ A_i = 1/h^2 - (x_i+1)/(2h), quad B_i = -2/h^2 - 2 = -202, quad
      C_i = 1/h^2 + (x_i+1)/(2h). $

    With $y_0 = -1$, $y_(10) = 0$: $d_1 = R(x_1) - A_1 y_0$,
    $d_i = R(x_i)$ for $i=2,dots,8$, $d_9 = R(x_9) - C_9 y_(10) = R(x_9)$.

    #align(center)[
      #table(
        columns: 6,
        inset: 6pt,
        stroke: 0.5pt + midgray,
        [$i$], [$A_i$], [$C_i$], [$l_i$], [$u_i$], [$z_i$],
        [1], [94.500], [105.500], [$-202.000$], [$-0.52228$], [$-0.47226$],
        [2], [94.000], [106.000], [$-152.906$], [$-0.69324$], [$-0.29546$],
        [3], [93.500], [106.500], [$-137.182$], [$-0.77634$], [$-0.20629$],
        [4], [93.000], [107.000], [$-129.800$], [$-0.82434$], [$-0.15214$],
        [5], [92.500], [107.500], [$-125.748$], [$-0.85488$], [$-0.11553$],
        [6], [92.000], [108.000], [$-123.351$], [$-0.87555$], [$-0.08902$],
        [7], [91.500], [108.500], [$-121.887$], [$-0.89017$], [$-0.06890$],
        [8], [91.000], [109.000], [$-120.995$], [$-0.90087$], [$-0.05316$],
        [9], [90.500], [109.500], [$-120.472$], [—], [$-0.04057$],
      )
    ]

    Back-substituting ($y_9 = z_9$, $y_i = z_i - u_i y_(i+1)$):

    #align(center)[
      #table(
        columns: 10,
        inset: 5pt,
        stroke: 0.5pt + midgray,
        [$x_i$], [0.1], [0.2], [0.3], [0.4], [0.5], [0.6], [0.7], [0.8], [0.9],
        [$y_i$], [$-0.8142$], [$-0.6548$], [$-0.5183$], [$-0.4019$], [$-0.3030$],
                  [$-0.2193$], [$-0.1488$], [$-0.0897$], [$-0.0406$],
      )
    ]

    with $y(0) = -1$ and $y(1) = 0$ as given.
  ],
  auth: [TOMISTA, FATIMA SHINE],
)

= Original Remix
Original Remix

#qa(
  [
    *Source*: Mixed from Compendium Problems 1 and 2 (Burden & Faires,
    Exercise Set 11.3, Problems 3(a) and 3(c))

    Use the Linear Finite-Difference Algorithm to approximate the solution
    to the boundary value problem
    $ y'' = -(x+1) y' + 2y + 2x + 3, quad 0 <= x <= 1, quad y(0) = 2, quad y(1) = 1, $
    with $h = 0.1$.
  ],
  [
    *Solution.*

    Standard form: $y'' + (x+1)y' - 2y = 2x+3$, so $P(x)=x+1$, $Q(x)=-2$,
    $R(x) = 2x+3$ — the variable coefficient of Problem 2 paired with the
    forcing term of Problem 1. As in Problem 2,
    $ A_i = 1/h^2 - (x_i+1)/(2h), quad B_i = -202, quad C_i = 1/h^2 + (x_i+1)/(2h), $
    with $y_0 = 2$, $y_(10) = 1$, so $d_1 = R(x_1) - A_1(2)$,
    $d_i = R(x_i)$ for $i=2,dots,8$, $d_9 = R(x_9) - C_9(1)$.

    #align(center)[
      #table(
        columns: 6,
        inset: 6pt,
        stroke: 0.5pt + midgray,
        [$i$], [$A_i$], [$C_i$], [$l_i$], [$u_i$], [$z_i$],
        [1], [94.500], [105.500], [$-202.000$], [$-0.52228$], [$0.91980$],
        [2], [94.000], [106.000], [$-152.906$], [$-0.69324$], [$0.54322$],
        [3], [93.500], [106.500], [$-137.182$], [$-0.77634$], [$0.34400$],
        [4], [93.000], [107.000], [$-129.800$], [$-0.82434$], [$0.21720$],
        [5], [92.500], [107.500], [$-125.748$], [$-0.85488$], [$0.12796$],
        [6], [92.000], [108.000], [$-123.351$], [$-0.87555$], [$0.06139$],
        [7], [91.500], [108.500], [$-121.887$], [$-0.89017$], [$0.00998$],
        [8], [91.000], [109.000], [$-120.995$], [$-0.90087$], [$-0.03051$],
        [9], [90.500], [109.500], [$-120.472$], [—], [$0.84617$],
      )
    ]

    Back-substituting:

    #align(center)[
      #table(
        columns: 10,
        inset: 5pt,
        stroke: 0.5pt + midgray,
        [$x_i$], [0.1], [0.2], [0.3], [0.4], [0.5], [0.6], [0.7], [0.8], [0.9],
        [$y_i$], [1.5456], [1.1983], [0.9449], [0.7740], [0.6755],
                  [0.6405], [0.6614], [0.7318], [0.8462],
      )
    ]

    with $y(0) = 2$ and $y(1) = 1$ as given. Note the solution sits
    uniformly above Problem 1's at every interior point, isolating the
    effect of changing $P(x)$ from constant to $x+1$ while holding $R(x)$
    and the boundary conditions fixed.
  ],
  auth: [TOMISTA, FATIMA SHINE],
)