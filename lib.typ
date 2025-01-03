
#let templates = (
  ctex: (
    style: (..args) => {
      import "/templates/ctex.typ": ctex-template
      ctex-template(..args)
    },
    module: "/templates/ctex.typ",
  ),
  pageless: (
    style: (..args) => {
      import "/templates/pageless.typ": pageless-template
      pageless-template(..args)
    },
    module: "/templates/pageless.typ",
  ),
)

/// The template function is used to apply a style to a content.
///
/// #let style-enums = `"ctex" or "pageless"`
///
/// - style (str, style-enums): The used style.
/// - content (content): The content to be styled.
/// -> content
#let template(style: "ctex", content) = {
  show: templates.at(style).style
  content
}
