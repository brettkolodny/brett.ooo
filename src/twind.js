import { setup, tw } from "https://esm.sh/twind@0.16.16";
import { getStyleTag, virtualSheet } from "https://esm.sh/twind@0.16.16/sheets";

const sheet = virtualSheet();

setup({
  theme: {
    extend: {
      colors: {
        base: {
          "50": "#FAF9F7",
          "100": "#E8E6E1",
          "200": "#D3CEC4",
          "300": "#B8B2A7",
          "400": "#A39E93",
          "500": "#857F72",
          "600": "#625D52",
          "700": "#504A40",
          "800": "#423D33",
          "900": "#27241D",
        },
        primary: {
          "50": "#FFFAEB",
          "100": "#FCEFC7",
          "200": "#F8E3A3",
          "300": "#F9DA8B",
          "400": "#F7D070",
          "500": "#E9B949",
          "600": "#C99A2E",
          "700": "#A27C1A",
          "800": "#7C5E10",
          "900": "#513C06",
        },
      },
    },
  },
  sheet,
});

const resetSheet = () => sheet.reset();

const getStyleTagWithSheet = () => getStyleTag(sheet);

export { tw, resetSheet, getStyleTagWithSheet };