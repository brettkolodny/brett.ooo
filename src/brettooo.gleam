import gleam/string
import gleam/list
import server.{
  Request, Response, new_404_response, new_ico_response, new_png_response,
  new_response, new_svg_response, request_url, serve, url_from,
}
import twind/twind.{reset_sheet}
import pages/home.{home}
import pages/blog.{blog}
import pages/common.{render_page}
import pages/not_found.{not_found}
import deno
import promise.{Promise}

pub fn main() {
  serve(request_handler)
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
