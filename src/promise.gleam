pub external type Promise(a)

pub external fn new(v: a) -> Promise(b) =
  "./ffi.js" "promiseNew"

// const promiseThen = <T, U>(p: Promise<T>, cb: (value: T) => U): Promise<U> => {
pub external fn then(p: Promise(a), f: fn(a) -> b) -> Promise(b) =
  "./ffi.js" "promiseThen"

pub external fn resolve(value: a) -> Promise(a) =
  "./ffi.js" "promiseResolve"
