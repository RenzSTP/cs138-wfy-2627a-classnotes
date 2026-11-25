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

= Compendium Problem 1: FDA for NBCs (Modified First Entries)

#qa(
  [
    *Source*: Yew, A. _Boundary value problems: method of finite differences_, Neumann boundary conditions

    Consider the general linear second-order boundary value problem $y'' + p(x)y' + q(x)y = r(x)$ on the interval $[a, b]$, discretized with step size $Delta x$.

    For the first interior node $j = 1$ at $x_1$, central difference approximation yields the equation below:
    $
      (-1 - frac(p(x_1), 2)Delta x)y_0 + (2 + q(x_1)Delta x^2)y_1 + (-1 + frac(p(x_1), 2)Delta x)y_2 = -r(x_1)Delta x^2
    $

    Also, a Neumann boundary condition $y'(a) = gamma_l$ is imposed at the left boundary $x_0 = a$.

    Using an $cal(O)(Delta x)$ forward difference, eliminate the boundary unknown $y_0$ from the equation above, then rearrange the result to isolate the interior variables $y_1$ and $y_2$ on the left-hand side, and  define the modified $(1,1)$-entry of $A$ and updated right-hand side first entry of $b$.
  ],
  [*Solution.*
    The first-order forward difference approximation with the given left boundary is given by 
    $
      y'(a) approx frac(y_1 - y_0, Delta x) = gamma_l arrow.double.long y_1 - y_0 = gamma_l Delta x arrow.double.long y_0 = y_1 - gamma_l Delta x
    $

    We now substitute our obtained $y_0$ expression into the given equation, then do necessary algebra:
    $
      (-1 - frac(p(x_1), 2)Delta x)(y_1 - gamma_l Delta x) + (2 + q(x_1)Delta x^2)y_1 + (-1 + frac(p(x_1), 2)Delta x)y_2 = -r(x_1)Delta x^2 \ \
      
      arrow.double.long (-1 - frac(p(x_1), 2)Delta x)y_1 - (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x + \ (2 + q(x_1)Delta x^2)y_1 + (-1 + frac(p(x_1), 2)Delta x)y_2 = -r(x_1)Delta x^2 \ \

      arrow.double.long [(-1 - frac(p(x_1), 2)Delta x) + (2 + q(x_1)Delta x^2)]y_1 + \ (-1 + frac(p(x_1), 2)Delta x)y_2 - (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x = -r(x_1)Delta x^2 \ \

      arrow.double.long [(-1 - frac(p(x_1), 2)Delta x) + (2 + q(x_1)Delta x^2)]y_1 + \ (-1 + frac(p(x_1), 2)Delta x)y_2 = -r(x_1)Delta x^2 + (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x
    $

    Here, the coefficient $(-1 - frac(p(x_1), 2)Delta x) + (2 + q(x_1)Delta x^2)$ of $y_1$ is the modified matrix entry $A_(11)$, while the right-hand side $r(x_1)Delta x^2 + (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x$ is the modified vector entry $b_1$.
  ],
  auth: [LIM, GABRIELLE KYROS],
)  

= Compendium Problem 2: FDA for NBCs (Modified Last Entries)

#qa(
  [
    *Source*: Yew, A. _Boundary value problems: method of finite differences_, Neumann boundary conditions

    Consider the general linear second-order boundary value problem $y'' + p(x)y' + q(x)y = r(x)$ on the interval $[a, b]$, discretized with step size $Delta x$.

    For the final interior node $j = N$ at $x_N$, central difference approximation yields the equation below:
    $
      (-1 - frac(p(x_1), 2)Delta x)y_(N-1) + (2 + q(x_1)Delta x^2)y_N + (-1 + frac(p(x_1), 2)Delta x)y_(N+1) = -r(x_N)Delta x^2
    $

    Also, a Neumann boundary condition $y'(b) = gamma_r$ is imposed at the left boundary $x_(N+1) = b$.

    Using an $cal(O)(Delta x)$ backward difference, eliminate the boundary unknown $y_(N+1)$ from the equation above, then rearrange the result to isolate the interior variables $y_(N-1)$ and $y_N$ on the left-hand side, and  define the modified $(N,N)$-entry of $A$ and updated right-hand side last entry of $b$.
  ],
  [*Solution.*
    The first-order forward difference approximation with the given left boundary is given by 
    $
      y'(b) approx frac(y_(N+1) - y_N, Delta x) = gamma_l arrow.double.long y_(N+1) - y_N = gamma_l Delta x arrow.double.long y_(N+1) = y_N - gamma_l Delta x
    $

    We now substitute our obtained $y_(N+1)$ expression into the given equation, then do necessary algebra:
    $
      (-1 - frac(p(x_1), 2)Delta x)(y_N + gamma_l Delta x) + (2 + q(x_N)Delta x^2)y_N + (-1 + frac(p(x_1), 2)Delta x)y_(N+1) = -r(x_1)Delta x^2 \ \
      
      arrow.double.long (-1 - frac(p(x_1), 2)Delta x)y_1 - (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x + \ (2 + q(x_1)Delta x^2)y_1 + (-1 + frac(p(x_1), 2)Delta x)y_(N+1) = -r(x_1)Delta x^2 \ \

      arrow.double.long [(-1 - frac(p(x_1), 2)Delta x) + (2 + q(x_1)Delta x^2)]y_1 + \ (-1 + frac(p(x_1), 2)Delta x)y_2 - (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x = -r(x_1)Delta x^2 \ \

      arrow.double.long [(-1 - frac(p(x_1), 2)Delta x) + (2 + q(x_1)Delta x^2)]y_1 + \ (-1 + frac(p(x_1), 2)Delta x)y_2 = -r(x_1)Delta x^2 + (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x
    $

    Here, the coefficient $(-1 - frac(p(x_1), 2)Delta x) + (2 + q(x_1)Delta x^2)$ of $y_1$ is the modified matrix entry $A_(11)$, while the right-hand side $r(x_1)Delta x^2 + (-1 - frac(p(x_1), 2)Delta x)gamma_l Delta x$ is the modified vector entry $b_1$.
  ],
  auth: [LIM, GABRIELLE KYROS],
)  