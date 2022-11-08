pub external type UInt8Array

pub external fn read_file_sync(path: String) -> Result(UInt8Array, Nil) =
  "./ffi.js" "readFileSync"
