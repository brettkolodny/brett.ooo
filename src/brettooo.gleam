import gleam/string
import gleam/list
import server.{
  Request, Response, new_404_response, new_ico_response, new_response,
  new_svg_response, request_url, serve, url_from,
}
import twind/twind.{get_style_tag_with_sheet, reset_sheet}
import html/element.{Html, link, node, render, text}
import html/attribute.{attribute, href}
import pages/home.{home}
import pages/blog.{blog}
import pages/not_found.{not_found}
import deno
import promise.{Promise}

pub fn main() {
  serve(request_handler)
}

fn render_page(html: Html) -> String {
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
          ],
        ),
        node("body", [], [html]),
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
      |> render_page
      |> new_response
      |> promise.resolve
    "/blog" <> path ->
      blog(path)
      |> render_page
      |> new_response
      |> promise.resolve
    "/static" <> path -> static_asset(path)
    _ ->
      not_found()
      |> render_page
      |> new_response
      |> promise.resolve
  }
}
