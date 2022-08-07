const defaultTheme = require("tailwindcss/defaultTheme");

const disabledCss = {
    "code::before": false,
    "code::after": false,
    "blockquote p:first-of-type::before": false,
    "blockquote p:last-of-type::after": false,
    pre: false,
    code: false,
    "pre code": false,
    "code::before": false,
    "code::after": false,
};

module.exports = {
    content: [
        "./public/*.html",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js",
        "./app/views/**/*.{erb,haml,html,slim}",
    ],
    theme: {
        extend: {
            fontFamily: {
                sans: ["Inter var", ...defaultTheme.fontFamily.sans],
            },
            typography: {
                DEFAULT: { css: disabledCss },
            },
        },
    },
    plugins: [
        require("@tailwindcss/forms"),
        require("@tailwindcss/aspect-ratio"),
        require("@tailwindcss/typography"),
    ],
};
