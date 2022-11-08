import deno.{UInt8Array}
import promise.{Promise}

pub external type Request

pub external type Response

pub external fn request_url(req: Request) -> String =
  "./ffi.js" "getRequestURL"

pub external fn serve(handler: fn(Request) -> Promise(Response)) -> Nil =
  "./ffi.js" "serve"

pub external fn new_response(text: String) -> Response =
  "./ffi.js" "newResponse"

pub external fn new_svg_response(img: UInt8Array) -> Response =
  "./ffi.js" "newSvgResponse"

pub external fn new_ico_response(ico: UInt8Array) -> Response =
  "./ffi.js" "newIcoResponse"

pub external fn new_404_response(body: String) -> Response =
  "./ffi.js" "new404Response"

pub type DenoURL {
  DenoURL(
    href: String,
    origin: String,
    protocol: String,
    username: String,
    password: String,
    host: String,
    hostname: String,
    port: String,
    pathname: String,
    hash: String,
    search: String,
  )
}

pub external fn url_from(url: String) -> DenoURL =
  "" "new URL"
