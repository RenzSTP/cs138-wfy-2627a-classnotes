// Hello! This is the asset and styling guide for the class notes. 

// Kindly go to line ~223 to see the 
// showcase of how to use the different 
// styling functions.


// assets.typ — importable document formats.
//
//   #import "assets.typ": qa, notes, definition, theorem, algorithm, example, note

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


// class notes stylng
#let section-subheading(number, title) = {
  v(0.75em)
  block(
    width: 100%,
    above: 0pt,
    below: 0pt,
  )[
    #set par(first-line-indent: 0pt)
    #text(size: 18pt, weight: "bold")[#number. #title]
  ]
  v(0.75em)
}

#let section-emphasis(title) = {
  set par(first-line-indent: 0pt)
  v(1.0em)
  text(size: 1.2em, weight: "bold", title)
  v(-0.5em)
}

// deprecated defs
// old definition of definition
#let definition-alt(body, name: none) = notes-box(
  body,
  name: notes-tag("Definition", name),
  fill: notes-fill,
  stroke: (left: 2pt + black),
)

#let example-alt(body, name: none) = notes-box(
  body,
  name: notes-tag("Example", name),
  stroke: (left: notes-hairline),
)


#show: notes.with(
  title: [Styling Demo!],
)
// justify and indent to preference
#set par(
  justify: true,
  first-line-indent: (amount: fl-indent, all: true)
)
  
// for boxing final answers
#let solution-box(body) = align(center)[
  #box(
    stroke: 1pt,
    inset: 5pt,
  )[
    #body
  ]
]
// SHOWCASE
A generic paragraph looks like this: 

#lorem(100)

\ 

#definition(name: "Titular definition")[
  This is what a definition looks like. Its description directly follows its title without any line breaks. This should help visually differentiate it from theorems, where the description is under the theorem title.

  I will now begin to lorem ipsum to pad out lines: #lorem(15)
]

\

#theorem(name: "Arithmetic and Axioms")[ 
  #v(0.4em)
  Hello! This is what a theorem should look like. It should feel a bit more formal, I guess? The chosen contrast between this and definition seems a bit arbitrary, but its here.
]

#v(1em) Here is what an example would look like (merged styling from Miniarc-3 and Miniarc-4):
#example(number: "1")[
  For the system from the lecture,
  $ mat(
      5, -2, 3;
      -3, 9, 1;
      2, -1, -7
    )
    mat(x_1; x_2; x_3)
    =
    mat(-1; 2; 3), $

  the matrix splitting is
  $ D = mat(
      5, 0, 0;
      0, 9, 0;
      0, 0, -7
    ), $

  $ L = mat(
      0, 0, 0;
      -3, 0, 0;
      2, -1, 0
    ),
    quad
    U = mat(
      0, -2, 3;
      0, 0, 1;
      0, 0, 0
    ). $

  Adding these three matrices reconstructs $A$.
  Since every diagonal entry is nonzero, $D$ is
  invertible, and, by algebra, we have:
  $ D^(-1) = mat(
      1/5, 0, 0;
      0, 1/9, 0;
      0, 0, -1/7
    ). $

  which #lorem(20)

  We have shown that $A = x dot b$.
]

Containing worked examples in a colored block helps emphasize where the solution starts and ends, while counting each solution step makes it easier to prove each statement individually.


== Common bugs and other issues...
#v(1em)

*MINOR BUG*: Indentation for paragraphs are not automatic after a styled asset (i.e. after a header or a definition/theorem block). You can remedy this by doing "\#h(2em)". Its something related with how Typst "declares" paragraphs after a block.

See how this next paragraph is automatically indented but not the previous one? oof

  - Note (Louie): Fixed by setting `first-line-indent` to 
    a dictionary value with `all: true`, and manually
    turning it to `0` for block elements e.g. theorems,
    definitions.

\ 

#h(-2em)
*MINOR BUG:* After declaring *"\#show: notes.with(
  title: [...],)"* once, all headers formated with "=", "==", and so on will have a line below it. This is because the function notes redefines the style of *all* headers, even though it looks like it should only be locally defined.

  This is why this typst document opts to use a new style function "#section-subheading" and "#section-emphasis" as temporary (?) solution.


  - Note (Louie): I don't entirely understand; how exactly
    is ```typ #show notes.with()``` supposed to be used?
    The way it's used right now, anything after the `show`
    rule becomes part of the `body` argument, thus the
    heading styles get inherited.


