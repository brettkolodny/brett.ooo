import html/element.{Html, a, div, h1, node, text}
import html/attribute.{class, href}
import promise.{Promise}
import deno
import pages/not_found.{not_found}
import twind/twind.{tw}

pub fn blog(blog_name: String) -> Promise(Html) {
  case blog_name {
    "" -> blog_home()
    _ ->
      deno.read_text_file(deno.cwd() <> "/static/blog/" <> blog_name <> ".md")
      |> promise.then(fn(content) {
        case content {
          Ok(c) ->
            div(
              [class(tw("flex justify-center items-center w-full"))],
              [
                div(
                  [class(tw("max-w-4xl"))],
                  [
                    div(
                      [class("markdown-body")],
                      [node("style", [], [text(md_css())]), text(render_md(c))],
                    ),
                  ],
                ),
              ],
            )
          _ -> not_found()
        }
      })
  }
}

pub fn blog_link(name: String, date: String, link: String) -> Html {
  div(
    [class(tw("flex flex-col justify-center items-start w-full"))],
    [
      a(
        [href(link), class(tw("flex flex-col gap-1"))],
        [
          div(
            [
              class(tw(
                "text-4xl lg:text-base text-[#333333] font-semibold w-[512px] lg:w-[280px] underline",
              )),
            ],
            [text(name)],
          ),
          div([class(tw("text-xl lg:text-sm text-gray-400"))], [text(date)]),
        ],
      ),
    ],
  )
}

fn blog_home() -> Promise(Html) {
  div(
    [class(tw("flex justify-center items-center"))],
    [
      div(
        [class(tw("flex flex-col items-start w-full max-w-5xl"))],
        [
          h1(
            [class(tw("text-[#189474] text-4xl font-semibold py-8"))],
            [text("Blogs")],
          ),
          blog_link(
            "Building Web Apps for the 21st Century with Elixir, Phoenix, and Ash",
            "Nov, 2022",
            "/blog/building-with-ash",
          ),
        ],
      ),
    ],
  )
  |> promise.resolve
}

external fn render_md(md: String) -> String =
  "../ffi.js" "render"

external fn md_css() -> String =
  "../ffi.js" "mdCSS"
