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
