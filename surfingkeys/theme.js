/* Unmap the Ace Vim editor. */
api.iunmap("<Ctrl-i>");
api.unmap("<Ctrl-i>");

/* Unmap emoji completion in insert mode. */
api.iunmap(":");

/* Order: left-right hand, inside-out, home-bottom-top-row. */
api.Hints.setCharacters("fdsajklghvcxzmbnuioprewqty");

const Catppuccin = {
	// Flavor: Mocha
	Base: "#1e1e2e",
	Blue: "#89b4fa",
	Crust: "#11111b",
	Flamingo: "#f2cdcd",
	Green: "#a6e3a1",
	Lavender: "#b4befe",
	Mantle: "#181825",
	Maroon: "#eba0ac",
	Mauve: "#cba6f7",
	Overlay0: "#6c7086",
	Overlay1: "#7f849c",
	Overlay2: "#9399b2",
	Peach: "#fab387",
	Pink: "#f5c2e7",
	Red: "#f38ba8",
	Rosewater: "#f5e0dc",
	Sapphire: "#74c7ec",
	Sky: "#89dceb",
	Subtext0: "#a6adc8",
	Subtext1: "#bac2de",
	Surface0: "#313244",
	Surface1: "#45475a",
	Surface2: "#585b70",
	Teal: "#94e2d5",
	Text: "#cdd6f4",
	Yellow: "#f9e2af",
};

// https://github.com/brookhong/Surfingkeys/blob/master/docs/API.md#visualstyle
api.Visual.style("marks", `background-color: ${Catppuccin.Sapphire};`);
api.Visual.style("cursor", `background-color: ${Catppuccin.Blue};`);

// https://github.com/brookhong/Surfingkeys/blob/master/docs/API.md#hintsstyle
const styles = `
  background: ${Catppuccin.Teal} none;
  border: solid 1px ${Catppuccin.Blue};
  color: ${Catppuccin.Crust};
  font: bold 12px "JetBrains Mono";
  padding: 2px;
  text-transform: lowercase;
`;
api.Hints.style(styles);
api.Hints.style(
	`div { ${styles} }
   div.begin { color: ${Catppuccin.Crust}; }`,
	"text",
);

/* List of pages to block. */
settings.blocklistPattern = /docs.google.com/;

/* Always use the omnibar when switching tabs. */
settings.tabsThreshold = 0;

settings.theme = `
:root {
  ${Object.entries(Catppuccin)
		.map(([key, value]) => `--catppuccin-${key.toLowerCase()}: ${value};`)
		.join(" ")}
}

/*
  =============
  Bookmarks (b)
  =============
*/

.sk_theme {
  background: var(--catppuccin-base);
  color: var(--catppuccin-text);
  font-family: "JetBrains Mono";
}

.sk_theme .prompt,
.sk_theme .separator,
.sk_theme .resultPage {
  color: var(--catppuccin-yellow);
}

.sk_theme input {
  color: inherit;
}

/* Disable alternating colors */
.sk_theme #sk_omnibarSearchResult > ul > li:nth-child(odd) {
  background: inherit;
}

.sk_theme #sk_omnibarSearchResult > ul > li.focused {
  background-color: var(--catppuccin-surface0);
}

.sk_theme .omnibar_highlight {
  color: var(--catppuccin-green);
}

.sk_theme .omnibar_folder {
  color: var(--catppuccin-mauve);
}

.sk_theme .omnibar_timestamp {
  color: var(--catppuccin-maroon);
}

.sk_theme .url {
  color: var(--catppuccin-sky);
}

/*
  =======
  URL (t)
  =======
*/

.sk_theme .omnibar_visitcount {
  color: var(--catppuccin-peach);
}

/*
  ========
  Help (?)
  ========
*/

.sk_theme .feature_name {
  color: var(--catppuccin-peach);
}

.sk_theme kbd {
  background-color: var(--catppuccin-mantle);
  color: inherit;
}

.sk_theme .annotation {
  color: inherit;
}

/*
  ==============
  Rich hints (;)
  ==============
*/

#sk_keystroke {
  background-color: var(--catppuccin-base);
  color: var(--catppuccin-green);
}

.expandRichHints kbd > .candidates {
  color: var(--catppuccin-pink);
}

.expandRichHints span.annotation {
  color: var(--catppuccin-lavender);
}
`;
