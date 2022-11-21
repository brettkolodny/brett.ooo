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
        [href(link), target("_blank"), class(tw("flex flex-col gap-1"))],
        [
          img([
            src(image_path),
            class(tw("bg-black w-60 h-48 rounded-md shadow-md mb-2")),
          ]),
          div(
            [
              class(tw(
                "text-[#189474] text-lg font-semibold w-[280px] underline",
              )),
            ],
            [text(name)],
          ),
          div([class(tw("w-60 text-sm text-gray-600"))], [text(description)]),
        ],
      ),
    ],
  )
}
