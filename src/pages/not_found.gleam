import html/element.{Html, div, h1, img, text}
import html/attribute.{class, src}
import twind/twind.{tw}

pub fn not_found() -> Html {
  div(
    [class(tw("flex flex-col justify-center items-center w-full h-screen"))],
    [
      img([class(tw("h-64")), src("/static/img/404.png")]),
      h1([], [text("Page not found")]),
    ],
  )
}
