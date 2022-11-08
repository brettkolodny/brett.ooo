import { Ok, Error } from "./gleam.mjs";
import { serve } from "https://deno.land/std@0.161.0/http/server.ts";

export { serve };

export const readFileSync = (path) => {
  try {
    const file = Deno.readFileSync(path);
    return new Ok(file);
  } catch {
    return new Error();
  }
};

export const readFile = async (path) => {
  try {
    const file = await Deno.readFile(path);
    return new Ok(file);
  } catch {
    return new Error();
  }
};

export const getRequestURL = (req) => {
  return req.url;
};

export const newResponse = (body) => {
  return new Response(body, {
    headers: {
      "content-type": "text/html; charset=utf-8",
    },
  });
};

export const newSvgResponse = (body) => {
  return new Response(body, {
    headers: {
      "content-type": "image/svg+xml",
    },
  });
};

export const new404Response = (body) => {
  return new Response(body, {
    headers: {
      "content-type": "text/html; charset=utf-8",
    },
    status: 404,
  });
};

export const cwd = () => Deno.cwd();

export const promiseNew = (p) => new Promise(() => p);

export const promiseThen = (p, cb) => {
  return p.then((v) => cb(v));
};

export const promiseResolve = (v) => Promise.resolve(v);
