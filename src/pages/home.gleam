import html/element.{Html, a, div, h1, img, text}
import html/attribute.{class, href, src}
import twind/twind.{tw}

pub fn home() -> Html {
  div(
    [
      class(tw(
        "flex flex-col justify-center items-center gap-8 h-screen bg-base-50",
      )),
    ],
    [
      h1(
        [
          class(tw(
            "text-xl md:text-2xl px-8 md:px-0 text-center font-bold text-base-900",
          )),
        ],
        [text("A new site is currently baking, check back later!")],
      ),
      img([src("/static/img/bread.svg"), class(tw("h-24"))]),
      div(
        [class(tw("flex flex-row justify-center gap-2"))],
        [
          a(
            [href("#"), class(tw("text-lg text-primary-600 underline"))],
            [text("github")],
          ),
          a(
            [href("#"), class(tw("text-lg text-primary-600 underline"))],
            [text("linkedin")],
          ),
          a(
            [href("#"), class(tw("text-lg text-primary-600 underline"))],
            [text("art")],
          ),
        ],
      ),
    ],
  )
}
