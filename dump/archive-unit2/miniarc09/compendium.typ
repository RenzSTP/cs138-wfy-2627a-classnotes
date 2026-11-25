#include("compendium_title.typ")

#pagebreak()
#include("ArceoBasti_Compendium.typ")

#pagebreak()
#include("ElizardeSamantha_Compendium.typ")

#pagebreak()
#include("ManzanoJohn_Compendium.typ")

#pagebreak()
#include("ParaguyaKatrin_Compendium.typ")

#pagebreak()
#include("TorresAloysius_Compendium.typ")

// From ChatGPT
#let h1s(path) = {
  let content = read(path)

  // Remove math expressions, including multiline ones
  content = content.replace(regex("(?s)\\$.*?\\$"), "")

  // Extract level-1 headings
  let matches = content.matches(regex("(?m)^= (.+)$"))
  let headings = matches.map(m => m.captures.at(0))

  eval(headings.join(", "), mode: "markup")
}
  


#pagebreak()
= Contribution log
#table(
  columns: (auto, 1fr),
  inset: 6pt,
  stroke: 0.5pt,
  [*Name*], [*Compendium problem*],
  [Arceo, Jose Sebastian],
  h1s("ArceoBasti_Compendium.typ"),
  [Elizarde, Samantha Coleen],
  h1s("ElizardeSamantha_Compendium.typ"),
  [Manzano, John Anthony],
  h1s("ManzanoJohn_Compendium.typ"),
  [Paraguya, Katrin Lara],
  // special case haha, haha
  [_From Heath, Scientific Computing: an introductory survey, 2nd ed., Example 10.8, p.433_],
  [Torres, Aloysius Reve],
  h1s("TorresAloysius_Compendium.typ"),
)
