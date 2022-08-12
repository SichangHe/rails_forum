// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "trix";
import "@rails/actiontext";
import hljs from "highlight.js";

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

hljs.configure({ cssSelector: "pre" });

const load_check = () => {
    if (!document.baseURI.match("/edit")) {
        check_for_tex();
        hljs.highlightAll();
    }
    const click_hides = document.getElementsByClassName("click-hide");
    for (const e of click_hides) {
        e.addEventListener("click", () => (e.style.display = "none"));
    }
};

document.addEventListener("turbo:load", load_check);
document.addEventListener("turbo:frame-load", load_check);

import LocalTime from "local-time";
LocalTime.start();
