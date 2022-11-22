import html/element.{Html, a, div, img}
import html/attribute.{class, href, src, target}
import twind/twind.{tw}

pub fn art_link(link: String, image_path: String) -> Html {
  div(
    [class(tw("flex flex-col justify-center items-start"))],
    [
      a(
        [href(link), target("_blank"), class(tw("flex flex-col gap-1"))],
        [
          img([
            src(image_path),
            class(tw(
              "bg-black w-[512px] lg:w-64 lg:h-48 rounded-md shadow-md mb-2 object-cover",
            )),
          ]),
        ],
      ),
    ],
  )
}
