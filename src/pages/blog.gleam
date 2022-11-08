import html/element.{Html, div, h1, text}
import html/attribute.{class}

pub fn blog(blog_name: String) -> Html {
  div(
    [],
    [
      h1([class("foobar")], [text(blog_name)]),
      h1([], [text("This is a blog!")]),
    ],
  )
}
