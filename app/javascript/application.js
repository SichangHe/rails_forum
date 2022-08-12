// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

const wait_for_variable = async (variable) => {
    while (!window.hasOwnProperty(variable)) await delay(100);
};

const check_for_tex = async () => {
    if (document.body.textContent.match(/(?:\$|\\\(|\\\[|\\begin\{.*?})/)) {
        if (document.getElementById("MathJax-script") == null) {
            let script = document.createElement("script");
            script.async = true;
            script.id = "MathJax-script";
            script.src =
                "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js";
            document.head.appendChild(script);
        } else MathJax.typeset();
    }
};

const check_for_highlight = async () => {
    const code_blocks = document.querySelectorAll("pre:not([class])");
    if (code_blocks.length > 0) {
        if (document.getElementById("Highlight-js") == null) {
            let script = document.createElement("script");
            script.async = true;
            script.id = "Highlight-js";
            script.src =
                "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.6.0/highlight.min.js";
            document.head.appendChild(script);
            await wait_for_variable("hljs");
            hljs.configure({ cssSelector: "pre" });
        }
        for (const code_block of code_blocks) {
            hljs.highlightElement(code_block);
        }
    }
};

const load_check = () => {
    if (!document.baseURI.match("/edit")) {
        check_for_tex();
        check_for_highlight();
    }
    const click_hides = document.getElementsByClassName("click-hide");
    for (const e of click_hides) {
        e.addEventListener("click", () => (e.style.display = "none"));
    }
    const click_disable = document.getElementsByClassName("click-disable");
    for (const e of click_disable) {
        e.addEventListener("click", () => {
            e.style.pointerEvents = "none";
            e.classList.add("text-gray-600");
        });
    }
};

document.addEventListener("turbo:load", load_check);
document.addEventListener("turbo:frame-load", load_check);

import LocalTime from "local-time";
LocalTime.start();
