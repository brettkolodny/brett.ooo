import promise.{Promise}
import server.{Response, new_404_response, new_pdf_response}
import deno

pub fn resume() -> Promise(Response) {
  deno.read_file(deno.cwd() <> "/static/Brett Kolodny - Resume.pdf")
  |> promise.then(fn(content) {
    case content {
      Ok(c) -> new_pdf_response(c)
      _ -> new_404_response("404")
    }
  })
}
