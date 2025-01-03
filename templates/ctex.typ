#let serif-font = state("serif-font", ("FandolSong", "New Computer Modern"))
#let sans-font = state("sans-font", ("FandolHei", "New Computer Modern Sans"))

#let ex = 0.5

#let page-header = context {
  let current-page = counter(page).get()
  let chapter-match = query(heading.where(level: 1))

  let same-page = chapter-match.filter(m => counter(page).at(m.location()) == current-page)
  let prev-page = chapter-match.filter(m => counter(page).at(m.location()) < current-page)
  if prev-page.len() > 0 and same-page.len() == 0 {
    let chap = prev-page.last()
    counter(page).display("1")
    h(1fr)
    set text(font: "FandolKai", style: "italic")
    numbering("第一章", ..counter(heading).at(chap.location()))
    h(1em)
    chap.body
  }
}

#let ctex-template(body) = context {
  // lshort-zh 使用了 zihao=false 选项，导致字号为 10pt
  set text(font: serif-font.get(), size: 10pt, lang: "zh")
  // 行间距目测得到
  set par(justify: true, first-line-indent: 2em, leading: 0.69em)
  set block(spacing: 0.7em)
  // 一行 42 个字
  set page(paper: "a4", margin: (x: (210mm - 42em) / 2), header: page-header)

  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(numbering: "第一章")

  // huge, Large, large size
  let heading-size = (none, 20pt, 14pt, 12pt)
  // 目测得到
  let before-space = (none, 100pt, 1.75 * 14pt, 1.6 * 12pt)
  let after-space = (none, 50pt, 1.15 * 14pt, 1.1 * 12pt)

  show heading: it => {
    let lvl = it.level
    set align(center) if lvl <= 2
    set text(size: heading-size.at(lvl))
    set par(first-line-indent: 0pt)
    set block(above: before-space.at(lvl), below: after-space.at(lvl))

    if lvl == 1 {
      pagebreak(weak: true)
      v(5em)
    }

    counter(heading).display(it.numbering)
    h(1em)
    it.body
  }
  show heading.where(level: 2): set align(center)

  show ref: it => {
    let el = it.element
    counter(el.func()).display(el.numbering)
  }

  // 目测值
  show list: set block(spacing: 13pt)

  set list(marker: text(font: "New Computer Modern", "•"))
  show list: it => {
    pad(left: 12pt, it)
  }

  show raw: set text(font: "New Computer Modern Mono", size: 1.2em)

  show regex("(\p{Greek}|\u{0301})+"): set text(font: "New Computer Modern")
  show regex("[a-zA-Z ]+"): set text(lang: "en")

  body
}

#let intro(body) = context {
  set text(font: sans-font.get())
  pad(x: 2em, body)
  v(2 * ex * 10pt)
}
