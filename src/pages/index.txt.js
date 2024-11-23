import chalk from "chalk";

const page = `+----------------------------------------------------------------+
|                                                                |
|  ${chalk.bold("Brett Kolodny")} ${chalk.dim("(He/Him)")}                                        |
|                                                                |
|  Software Developer * BEAM Enthusiast * Amateur Knitter        |
|                                                                |
|  Hello! I'm a fullstack software developer living in Booklyn,  | 
|  NY with a particular interest in functional programming and   | 
|  making polished user experiences.                             |
|                                                                |
|  Highlighted projects                                          |
|  - ${chalk.underline("https://github.com/brettkolodny/gleam-hug")}                   |
|  - ${chalk.underline("https://github.com/brettkolodny/todoish")}                     |
|  - ${chalk.underline("https://github.com/brettkolodny/mancala_ex")}                  |
|                                                                |
|  ${chalk.dim("---------------------------------------------------------")}     |
|                                                                |
|  ${chalk.blue("Come say hi! -> brettkolodny@gmail.com")}                        |
|                                                                |
+----------------------------------------------------------------+
`

export function GET() {
  return new Response(page);
}
