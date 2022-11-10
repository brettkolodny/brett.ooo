import promise.{Promise}

pub external type UInt8Array

pub external fn read_file_sync(path: String) -> Result(UInt8Array, Nil) =
  "./ffi.js" "readFileSync"

pub external fn read_file(path: String) -> Promise(Result(UInt8Array, Nil)) =
  "./ffi.js" "readFile"

pub external fn read_text_file(path: String) -> Promise(Result(String, Nil)) =
  "./ffi.js" "readTextFile"

pub external fn cwd() -> String =
  "./ffi.js" "cwd"
