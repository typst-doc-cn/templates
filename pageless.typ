
#import "@preview/numbly:0.1.0": *

#let current-heading-state = state("current-heading-state")

#let essential-section(it) = context {
  let counter = counter(heading).get()
  current-heading-state.update(_ => (
    elem: it,
    counter: counter
  ))
  pagebreak()
  it
}

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: none, authors: (), body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(
    height: auto,
    width: 210mm,
    header: context {
      let current-heading = current-heading-state.get()
      if current-heading == none {
        return
      }
      set align(right)
      
      numbly("第{1}节")(..current-heading.counter)
      h(0.75em)
      emph(current-heading.elem.body)
    }
    // numbering: "1", number-align: center,
  )

  set heading(numbering: "1")
  show link: text.with(blue)
  set text(font: ("Libertinus Serif", "Noto Serif CJK SC"), size: 14pt, lang: "zh", region: "cn")

  // Title row.
  if title != none {
    align(center)[
      #block(text(weight: 700, 1.75em, title))
    ]
  }

  // Main body.
  set par(justify: true)

  show raw.where(block: true): rect.with(width: 100%, radius: 2pt, fill: luma(240), stroke: 0pt)

  body
}
