import html/element.{Html, a, div, h1, h2, img, text}
import html/attribute.{class, href, src, target}
import pages/blog.{blog_link}
import pages/portfolio.{project_link}
import pages/art.{art_link}
import twind/twind.{tw}

pub fn home() -> Html {
  div(
    [class(tw("flex flex-col justify-start items-center gap-8"))],
    [hero(), featured_projects(), featured_art()],
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
            "flex flex-row justify-start items-center gap-8 w-full max-w-4xl lg:max-w-5xl",
          )),
        ],
        [
          img([src("/static/img/home-hero.png")]),
          div(
            [class(tw("flex flex-col gap-2"))],
            [
              h1(
                [class(tw("text-7xl lg:text-4xl font-bold text-[#333333]"))],
                [text("Brett Kolodny")],
              ),
              div(
                [class(tw("max-w-xs text-lg lg:text-base text-[#333333]"))],
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
    [class(tw("flex flex-col gap-8 lg:gap-4 w-full max-w-4xl lg:max-w-5xl"))],
    [
      div(
        [class(tw("flex flex-col gap-16 lg:gap-4 items-start w-full"))],
        [
          h2(
            [class(tw("text-7xl lg:text-4xl text-[#189474] font-semibold"))],
            [text("Recent Blogs")],
          ),
          div(
            [
              class(tw(
                "flex flex-col lg:flex-row flex-wrap justify-start items-center lg:items-start gap-16 lg:gap-8 w-full",
              )),
            ],
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

fn featured_projects() -> Html {
  div(
    [class(tw("flex flex-col gap-8 lg:gap-4 w-full max-w-4xl lg:max-w-5xl"))],
    [
      div(
        [class(tw("flex flex-col gap-16 lg:gap-4 items-start w-full"))],
        [
          h2(
            [class(tw("text-7xl lg:text-4xl text-[#189474] font-semibold"))],
            [text("Projects")],
          ),
          div(
            [
              class(tw(
                "flex flex-col lg:flex-row flex-wrap justify-start items-center lg:items-start gap-16 lg:gap-8 w-full",
              )),
            ],
            [
              project_link(
                "Hug",
                "A package for creating helpful, and pretty CLI messages.",
                "https://github.com/brettkolodny/gleam-hug",
                "/static/img/projects/hug.jpg",
              ),
              project_link(
                "Todoish",
                "A sharable real-time todo list built with Elixor, Phoenix, and Ash.",
                "https://github.com/brettkolodny/todoish",
                "/static/img/projects/todoish.jpg",
              ),
              project_link(
                "Mancala",
                "Multiplayer Mancala implemented using Elixir/OTP, Phoenix, LiveView, and Rust.",
                "https://github.com/brettkolodny/mancala_ex",
                "/static/img/projects/mancala.jpg",
              ),
              project_link(
                "Slice",
                "A hybrid functional and imperative scripting language",
                "https://github.com/brettkolodny/slice",
                "/static/img/projects/slice.jpg",
              ),
              project_link(
                "Incantation",
                "Wave based game built with Rust and Amethyst.",
                "https://github.com/brettkolodny/incantation-catastrophe",
                "/static/img/projects/incantation.jpg",
              ),
              project_link(
                "Memory Game",
                "A card matching memory game based on Seterra built with TypeScript and Electron.",
                "https://github.com/brettkolodny/Memory-Game",
                "/static/img/projects/memory.jpg",
              ),
            ],
          ),
        ],
      ),
      a(
        [
          href("https://www.github.com/brettkolodny"),
          target("_blank"),
          class(tw("text-[#189474] underline")),
        ],
        [text("See more")],
      ),
    ],
  )
}

fn featured_art() -> Html {
  div(
    [
      class(tw(
        "flex flex-col gap-8 lg:gap-4 w-full max-w-4xl lg:max-w-5xl mb-16",
      )),
    ],
    [
      div(
        [class(tw("flex flex-col gap-4 items-start w-full"))],
        [
          h2(
            [class(tw("text-7xl lg:text-4xl text-[#189474] font-semibold"))],
            [text("Art")],
          ),
          div(
            [
              class(tw(
                "flex flex-col lg:flex-row flex-wrap justify-start items-center lg:items-start gap-16 lg:gap-8 w-full",
              )),
            ],
            [
              art_link(
                "https://www.instagram.com/p/CQY7fxPl6pv/",
                "/static/img/art/bubbles.jpg",
              ),
              art_link(
                "https://www.instagram.com/p/CIE0nCEK0zB/",
                "/static/img/art/blast.jpg",
              ),
              art_link(
                "https://www.instagram.com/p/B5BSChBgC9T/",
                "/static/img/art/clock.jpg",
              ),
            ],
          ),
        ],
      ),
      a(
        [
          href("https://www.instagram.com/breadblends/"),
          target("_blank"),
          class(tw("text-[#189474] underline")),
        ],
        [text("See more")],
      ),
    ],
  )
}
