pub external fn tw(class: String) -> String =
  "../twind.js" "tw"

pub external fn reset_sheet() -> Nil =
  "../twind.js" "resetSheet"

pub external fn get_style_tag_with_sheet() -> String =
  "../twind.js" "getStyleTagWithSheet"
