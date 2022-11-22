import html/element.{Html, a, div, img, text}
import html/attribute.{class, href, src, target}
import twind/twind.{tw}

pub fn project_link(
  name: String,
  description: String,
  link: String,
  image_path: String,
) -> Html {
  div(
    [class(tw("flex flex-col justify-center items-start"))],
    [
      a(
        [
          href(link),
          target("_blank"),
          class(tw("flex flex-col gap-4 lg:gap-1")),
        ],
        [
          img([
            src(image_path),
            class(tw(
              "bg-black w-[512px] lg:w-60 lg:h-48 rounded-md shadow-md mb-2",
            )),
          ]),
          div(
            [
              class(tw(
                "text-[#189474] text-6xl lg:text-lg font-semibold underline",
              )),
            ],
            [text(name)],
          ),
          div(
            [class(tw("w-[512px] lg:w-60 text-3xl lg:text-sm text-gray-600"))],
            [text(description)],
          ),
        ],
      ),
    ],
  )
}
