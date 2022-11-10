import gleam/string
import gleam/list
import server.{
  Request, Response, new_404_response, new_ico_response, new_png_response,
  new_response, new_svg_response, request_url, serve, url_from,
}
import twind/twind.{get_style_tag_with_sheet, reset_sheet, tw}
import html/element.{Html, a, div, link, node, render, text}
import html/attribute.{attribute, class, href}
import pages/home.{home}
import pages/blog.{blog}
import pages/not_found.{not_found}
import deno
import promise.{Promise}

pub fn main() {
  serve(request_handler)
}

fn nav_bar(path: String) -> Html {
  let links = case path {
    "/" -> [
      a([href("/")], [text("🥯 home")]),
      a([href("#")], [text("portfolio")]),
      a([href("/blog")], [text("blog")]),
      a([href("#")], [text("resume")]),
    ]
    "/blog" <> _ -> [
      a([href("/")], [text("home")]),
      a([href("#")], [text("portfolio")]),
      a([href("/blog")], [text("🥯 blog")]),
      a([href("#")], [text("resume")]),
    ]
    "/portfolio" <> _ -> [
      a([href("/")], [text("home")]),
      a([href("#")], [text("🥯 portfolio")]),
      a([href("/blog")], [text("blog")]),
      a([href("#")], [text("resume")]),
    ]
    _ -> [
      a([href("/")], [text("home")]),
      a([href("#")], [text("portfolio")]),
      a([href("/blog")], [text("blog")]),
      a([href("#")], [text("resume")]),
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

fn footer() -> Html {
  div(
    [class(tw("absolute bottom-0 flex justify-center items-center w-full"))],
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

fn render_page(path: String, html: Html) -> String {
  let nav = nav_bar(path)
  let footer = footer()

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
        node("body", [], [nav, html, footer]),
      ],
    )
    |> render

  doc_type <> html
}

fn static_asset(path: String) -> Promise(Response) {
  deno.read_file(deno.cwd() <> "/static" <> path)
  |> promise.then(fn(file) {
    case file {
      Ok(f) -> {
        let extension = case path {
          "/img/" <> file_name -> {
            let split_string = string.split(file_name, on: ".")
            list.last(split_string)
          }
          _ -> Error(Nil)
        }
        case extension {
          Ok("svg") -> new_svg_response(f)
          Ok("ico") -> new_ico_response(f)
          Ok("png") -> new_png_response(f)
          Error(_) -> new_404_response("404")
          _ -> new_404_response("404")
        }
      }
      Error(_) -> new_404_response("404")
    }
  })
}

fn request_handler(req: Request) -> Promise(Response) {
  reset_sheet()

  let url =
    request_url(req)
    |> url_from()

  case url.pathname {
    "/" ->
      home()
      |> render_page(url.pathname, _)
      |> new_response
      |> promise.resolve
    "/blog" <> path ->
      promise.then(
        blog(path),
        fn(html) {
          html
          |> render_page(url.pathname, _)
          |> new_response
        },
      )
    "/static" <> path -> static_asset(path)
    _ ->
      not_found()
      |> render_page(url.pathname, _)
      |> new_response
      |> promise.resolve
  }
}
