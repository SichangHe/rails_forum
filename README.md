# Steven He's experiment with Ruby on Rails for a forum

## Dependency

- Tailwindcss
- Ruby on Rails 7.0.3

## Initialize

`cd` here

```shell
gem install solargraph 
gem install solargraph-rails --version 1.0.0.pre.1
bundle
solargraph bundle
./bin/rails db:prepare
rubocop -a
```

## Development

Run the server and start tailwindcss

```shell
./bin/dev
```

The server will be available at port 3000

The text editor I use on this project is visual studio code

### Formatter

- aliariff.vscode-erb-beautify
- heybourn.headwind
- DavidAnson.vscode-markdownlint
- esbenp.prettier-vscode
- castwide.solargraph

The configuration for the formatters are in `.vscode/settings`,
so please always open the workspace at root level to get the consistent formatting.

### Other extension

- aaron-bond.better-comments
- streetsidesoftware.code-spell-checker
- kaiwood.endwise
- usernamehw.errorlens
- bung87.rails
- rebornix.ruby
- vortizhe.simple-ruby-erb
- bradlc.vscode-tailwindcss
- wingrunr21.vscode-ruby
- bung87.vscode-gemfile
- redhat.vscode-yaml

### Testing

```shell
./bin/rails test
```

## Database

The database is sqlite3 for local development
and PostgreSQL for production
