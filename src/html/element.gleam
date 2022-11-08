import gleam/list
import gleam/string
import html/attribute.{Attribute}

pub type Html {
  Node(tag: String, attributes: List(Attribute), children: List(Html))
  Text(content: String)
}

pub fn div(attributes: List(Attribute), children: List(Html)) -> Html {
  Node(tag: "div", attributes: attributes, children: children)
}

pub fn h1(attributes: List(Attribute), children: List(Html)) -> Html {
  Node(tag: "h1", attributes: attributes, children: children)
}

pub fn h2(attributes: List(Attribute), children: List(Html)) -> Html {
  Node(tag: "h2", attributes: attributes, children: children)
}

pub fn script(attributes: List(Attribute), children: List(Html)) -> Html {
  Node(tag: "script", attributes: attributes, children: children)
}

pub fn img(attributes: List(Attribute)) -> Html {
  Node(tag: "img", attributes: attributes, children: [])
}

pub fn a(attributes: List(Attribute), children: List(Html)) -> Html {
  Node(tag: "a", attributes: attributes, children: children)
}

pub fn link(attributes: List(Attribute)) -> Html {
  Node(tag: "link", attributes: attributes, children: [])
}

pub fn node(
  tag: String,
  attributes: List(Attribute),
  children: List(Html),
) -> Html {
  Node(tag: tag, attributes: attributes, children: children)
}

pub fn text(content: String) -> Html {
  Text(content: content)
}

pub fn render(html: Html) -> String {
  case html {
    Node(tag, attributes, children) -> {
      let attributes =
        list.map(
          attributes,
          fn(attribute) { attribute.0 <> "=\"" <> attribute.1 <> "\" " },
        )
        |> string.concat
      let opening_tag = "<" <> tag <> " " <> attributes <> ">"
      let rendered_children =
        list.map(children, render)
        |> string.concat
      let closing_tag = "</" <> tag <> ">"
      opening_tag <> rendered_children <> closing_tag
    }

    Text(content) -> content
  }
}
