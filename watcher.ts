const gleamCompile = async () => {
  try {
    const process = Deno.run({
      cmd: ["gleam", "build", "--target=javascript"],
    });
    await process.status();
  } catch (e) {
    console.error(e);
  }
};

const watcher = Deno.watchFs(".");
for await (const event of watcher) {
  if (event.kind === "modify") {
    event.paths.forEach((path) => {
      if (path.endsWith(".gleam")) {
        console.log(path);
        gleamCompile();
      }
    });
  }
}
