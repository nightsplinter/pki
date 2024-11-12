#let project(title: "", author, body) = {
  set document(author: author, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Linux Libertine", lang: "de")

  // Set paragraph spacing.
  show par: set block(above: 0.70em, below: 0.70em)

  set heading(numbering: "1.1")
  set par(leading: 0.58em)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.50em, title))
  ]

  // Author information.
  pad(
    top: 0.3em,
    bottom: 0.3em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      align(center, strong(author)),
    ),
  )

  // Main body.
  set par(justify: true)

  body
}
