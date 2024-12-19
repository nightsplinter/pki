#let project(title: "", author: "", keywords: (), body,) = {

  // Set the document's basic properties.
  set document(author: author, title: title, keywords: keywords)
  set par(leading: 1em)
  set page(numbering: none, number-align: center, margin: 1.5cm)
  set text(font: "Times New Roman", lang: "de", size: 10pt)
  set heading(numbering: "1.1")

  // Extract the keywords.
  let logoPath = keywords.at(0)
  let university = keywords.at(1)
  let course = keywords.at(2)
  let currentDate = datetime.today().display("[day].[month].[year]")

  // Logo of the university.
  align(center)[
    #block(
    image(logoPath, alt: "Logo der Technische Hochschule Mittelhessen ", width: 60%)
    )
  ]

  // Name of the university and faculty.
  pad(
    top: 2em,
    bottom: 3em,
    grid(
    columns: (1fr),
    row-gutter: 0.8em,
      align(center)[
        #text(weight: "thin", 1.3em, university)
      ],
    ),
  )

  // Title
  align(center)[
    #block(text(weight: "semibold", 1.5em, title))
  ]

  // Course of study.
  pad(
    top: 3em,
    bottom: 4em,
    x: 2em,
    grid(
      columns: (1fr),
      align: center,
      row-gutter: 0.8em,
      [#strong("im Modul")],
      [#strong(course)]
    ),
  )

  // Table with the title and author.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr, 2fr),
      row-gutter: 1.8em,
       // Author
      align(left, strong("Autorin:")), author,
    ),
  )

  // Main body.
  set par(justify: true)

  body
}
