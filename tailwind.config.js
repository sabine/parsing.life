const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
    content: ["**/*.mlx", "**/*.html"],
    darkMode: "class",
    theme: {
        screens: {
            sm: "40em",
            md: "48em",
            lg: "64em",
            xl: "80em",
        },
        extend: {
            colors: {
                text: "#eee",
                background: "#222",
            },
            typography: (theme) => ({
                DEFAULT: {
                    css: {
                        color: theme("colors.text"),
                        a: {
                            color: theme("colors.text"), // Links
                            "&:hover": {
                                color: theme("colors.text"), // Hovered links
                            },
                        },
                        h1: { color: theme("colors.text") },
                        h2: { color: theme("colors.text") },
                        h3: { color: theme("colors.text") },
                        strong: { color: theme("colors.text") },
                    },
                },
            }),
            fontFamily: {
                sans: ["Roboto", ...defaultTheme.fontFamily.sans],
                display: ["Sixtyfour", ...defaultTheme.fontFamily.serif],
            },
        },
    },
    plugins: [
        require("@tailwindcss/forms"),
        require("@tailwindcss/typography"),
        require("@tailwindcss/aspect-ratio"),
    ],
};
