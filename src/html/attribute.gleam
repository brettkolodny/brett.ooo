pub type Attribute =
  #(String, String)

pub fn class(class: String) -> Attribute {
  #("class", class)
}

pub fn src(src: String) -> Attribute {
  #("src", src)
}

pub fn href(href: String) -> Attribute {
  #("href", href)
}

pub fn attribute(tag: String, value: String) -> Attribute {
  #(tag, value)
}
