import html/element.{Html, div, h1, img, text}
import html/attribute.{class, src}
import twind/twind.{tw}

pub fn home() -> Html {
  div(
    [
      class(tw(
        "flex flex-col justify-start items-center gap-8 h-screen bg-base-50",
      )),
    ],
    [hero(), div([], [])],
  )
}

fn hero() -> Html {
  div(
    [
      class(tw(
        "flex flex-row justify-center items-center w-full py-8 bg-[#94E6E3]",
      )),
    ],
    [
      div(
        [
          class(tw(
            "flex flex-row justify-start items-center gap-8 w-full max-w-5xl",
          )),
        ],
        [
          img([src("/static/img/home-hero.png")]),
          div(
            [class(tw("flex flex-col gap-2"))],
            [
              h1(
                [class(tw("text-4xl font-bold text-[#333333]"))],
                [text("Brett Kolodny")],
              ),
              div(
                [class(tw("max-w-xs text-[#333333]"))],
                [
                  text(
                    "Developer of software, knitter of bad scarves, ruler of threes.",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  )
}
