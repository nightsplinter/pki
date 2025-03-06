// This file is based on https://github.com/mgoulao/arkheion

#let arkheion(
  title: "",
  abstract: none,
  keywords: (),
  authors: (),
  custom_authors: none,
  body,
) = {
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 10mm, right: 10mm, top: 10mm, bottom: 15mm),
    numbering: "1",
    number-align: center,
    columns: 1,
  )
  set text(font: "New Computer Modern", lang: "de")
  show math.equation: set text(weight: 200)
  show math.equation: set block(spacing: 0.50em)
  set math.equation(numbering: "(1)")
  set heading(numbering: "1.1")

  // Set run-in subheadings, starting at level 4.
  show heading: it => {
    // H1 and H2
    if it.level == 1 {
      pad(
        bottom: 6pt,
        it
      )
    }
    else if it.level == 2 {
      pad(
        bottom: 5pt,
        it
      )
    }
    else if it.level > 3 {
      text(8pt, weight: "bold", it.body + " ")
    } else {
      it
    }
  }

  // Center Logo
  align(center)[
    #block(
      image("./assets/THM.png", alt: "Logo der Technische Hochschule Mittelhessen ", width: 50%)
    )
  ]

  line(length: 100%, stroke: 2pt)
  // Title row.
  pad(
    bottom: 4pt,
    top: 4pt,
    align(center)[
      #block(text(weight: 400, 1.75em, title))
      #block(text(weight: 100, 1.25em, "Praktikum Künstliche Intelligenz"))
      #block(text(weight: 100, 1.25em, "Wintersemester 2024/2025"))
      #v(1em, weak: true)
    ]
  )
  line(length: 100%, stroke: 2pt)

  // Author information.
  if custom_authors != none {
    custom_authors
  } else {
    pad(
      top: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center)[
            #grid(
              columns: (auto),
              rows: 2pt,
              [*#author.name*]
            )
          #author.email \
          #author.affiliation
        ]),
      ),
    )
  }

  // Abstract.
  if abstract != none {
    pad(
      x: 3em,
      top: 1em,
      bottom: 0.4em,
      align(center)[
        #heading(
          outlined: false,
          numbering: none,
          text(0.85em, smallcaps[Abstract]),
        )
        #set par(justify: true)
        #set text(hyphenate: false)

        #abstract
      ],
    )
  }

  // Keywords
  if keywords.len() > 0 {
      [*_Keywords_* #h(0.3cm)] + keywords.map(str).join(" · ")
  }
  // Main body.
  set par(justify: true)
  set text(hyphenate: false)
  set page(columns: 2)
  body
}

#let arkheion-appendices(body) = {
  counter(heading).update(0)
  counter("appendices").update(1)

  set heading(
    numbering: (..nums) => {
      let vals = nums.pos()
      let value = "ABCDEFGHIJ".at(vals.at(0) - 1)
      if vals.len() == 1 {
        return "APPENDIX " + value
      }
      else {
        return value + "." + nums.pos().slice(1).map(str).join(".")
      }
    }
  );
  [#pagebreak() #body]
}
