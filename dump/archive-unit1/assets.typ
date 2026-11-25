// assets.typ — importable document formats.
//
//   #import "assets.typ": qa, notes, definition, theorem, algorithm, example, note

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
  stack(dir: ttb, spacing: 0.35em, name, body)
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


#let definition(body, name: none) = notes-box(
  body,
  name: notes-tag("Definition", name),
  fill: notes-fill,
  stroke: (left: 2pt + black),
)

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

#let example(body, name: none) = notes-box(
  body,
  name: notes-tag("Example", name),
  stroke: (left: notes-hairline),
)

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
