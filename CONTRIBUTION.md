# Contribution

## Base Line

Contributions are welcomed!

Without specification,
your contributions will and must be under the same
[MIT license](./LICENSE) as this repository.

## Procedure

Fork this repository,
work on your fork,
and submit a pull request.

## Style Guide

Please use the formatters mentioned in the [README](./README.md)

Specifically:

- Use erb-beautify for ERB.
- ~~headwind will apply automatically to all files
    except `class:` in ERB.
    Please try matching orders for `class:` manually.~~
    This problem is solved using custom classRegex for headwind in `.vscode/settings.json`
- Use markdownlint for Markdown.
- Use prettier for JavaScript and CSS.
- Use solargraph for Ruby.

Additionally:

- Leave `TODO` where something is yet to be done.
- Use single quotes for Ruby string literals in ERB if possible.
- Format all Ruby files before committing:

    ```shell
    rubocop -a
    ```
