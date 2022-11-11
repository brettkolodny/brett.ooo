import html/element.{Html, a, div, h1, h2, img, text}
import html/attribute.{class, href, src}
import pages/blog.{blog_link}
import twind/twind.{tw}

pub fn home() -> Html {
  div(
    [class(tw("flex flex-col justify-start items-center gap-8"))],
    [hero(), recent_blogs()],
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

fn recent_blogs() -> Html {
  div(
    [class(tw("flex flex-col gap-4 w-full max-w-5xl"))],
    [
      div(
        [class(tw("flex flex-col gap-2 items-start w-full"))],
        [
          h2(
            [class(tw("text-4xl text-[#189474] font-semibold"))],
            [text("Recent Blogs")],
          ),
          div(
            [class(tw("flex flex-row"))],
            [
              blog_link(
                "Building Web Apps for the 21st Century with Elixir, Phoenix, and Ash",
                "Nov, 2022",
                "/blog/building-with-ash",
              ),
            ],
          ),
        ],
      ),
      a(
        [href("/blog"), class(tw("text-[#189474] underline"))],
        [text("See more")],
      ),
    ],
  )
}
