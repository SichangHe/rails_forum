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

const highlight_and_math = () => {
    if (!document.baseURI.match("/edit")) {
        check_for_tex();
        hljs.highlightAll();
    }
};

document.addEventListener("turbo:load", highlight_and_math);
document.addEventListener("turbo:frame-load", highlight_and_math);
