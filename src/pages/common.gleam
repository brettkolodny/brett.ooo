import html/element.{Html, a, div, link, node, render, span, text}
import html/attribute.{attribute, class, href, target}
import twind/twind.{get_style_tag_with_sheet, tw}

pub fn render_page(path: String, html: Html) -> String {
  let nav = nav_bar(path)
  let footer = footer()
  let body_style = tw("flex flex-col justify-between min-h-screen")

  // This needs to be done after all other rendering
  let style_tag = get_style_tag_with_sheet()

  let doc_type = "<!DOCTYPE html>"

  let html =
    node(
      "html",
      [#("lang", "en")],
      [
        node(
          "head",
          [],
          [
            node("title", [], [text("Brett Kolodny")]),
            text(style_tag),
            link([
              attribute("rel", "icon"),
              attribute("type", "image/x-icon"),
              href("/static/img/favicon.ico"),
            ]),
            text(
              "<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">
<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>
<link href=\"https://fonts.googleapis.com/css2?family=Outfit:wght@100;200;300;400;500;600;700;800;900&display=swap\" rel=\"stylesheet\">",
            ),
            node(
              "style",
              [],
              [text("html { font-family: 'Outfit', sans-serif; }")],
            ),
          ],
        ),
        node(
          "body",
          [class(body_style)],
          [div([class(tw("flex flex-col justify-start"))], [nav, html]), footer],
        ),
      ],
    )
    |> render

  doc_type <> html
}

pub fn nav_bar(path: String) -> Html {
  let links = case path {
    "/" -> [
      a(
        [href("/"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("🥯")]), text("home")],
      ),
      a(
        [href("/blog"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("blog")],
      ),
      a(
        [href("/resume"), target("_blank"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("resume")],
      ),
      a(
        [
          href("https://www.github.com/brettkolodny"),
          attribute("target", "_blank"),
          class(tw("flex flex-row gap-1")),
        ],
        [span([class(tw("w-4"))], [text("")]), text("github")],
      ),
    ]
    "/blog" <> _ -> [
      a(
        [href("/"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("home")],
      ),
      a(
        [href("/blog"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("🥯")]), text("blog")],
      ),
      a(
        [href("/resume"), target("_blank"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("resume")],
      ),
      a(
        [
          href("https://www.github.com/brettkolodny"),
          attribute("target", "_blank"),
          class(tw("flex flex-row gap-1")),
        ],
        [span([class(tw("w-4"))], [text("")]), text("github")],
      ),
    ]
    _ -> [
      a(
        [href("/"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("home")],
      ),
      a(
        [href("/blog"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("blog")],
      ),
      a(
        [href("/resume"), target("_blank"), class(tw("flex flex-row gap-1"))],
        [span([class(tw("w-4"))], [text("")]), text("resume")],
      ),
      a(
        [
          href("https://www.github.com/brettkolodny"),
          attribute("target", "_blank"),
          class(tw("flex flex-row gap-1")),
        ],
        [span([class(tw("w-4"))], [text("")]), text("github")],
      ),
    ]
  }

  div(
    [class(tw("flex justify-center items-center py-4 bg-[#94E6E3]"))],
    [
      div(
        [
          class(tw(
            "flex flex-row justify-start items-center gap-6 w-full max-w-5xl h-10",
          )),
        ],
        links,
      ),
    ],
  )
}

pub fn footer() -> Html {
  div(
    [class(tw("flex justify-center items-center w-full"))],
    [
      div(
        [
          class(tw(
            "flex flex-row justify-center-items-center w-full max-w-5xl gap-2 h-8",
          )),
        ],
        [
          text("Built with"),
          a([href("https://gleam.run/")], [text("✨")]),
          a([href("https://deno.land/")], [text("🦕")]),
        ],
      ),
    ],
  )
}
