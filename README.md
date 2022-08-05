# Steven He's experiment with Ruby on Rails for a forum

## dependency

- tailwindcss
- Ruby on Rails 7.0.3

## initialize

`cd` here

```shell
gem install solargraph 
gem install solargraph-rails --version 1.0.0.pre.1
bundle
solargraph bundle
./bin/rails db:migrate
```

## development

run the server and start tailwindcss

```shell
./bin/dev
```

the server will be available at port 3000

the text editor I use on this project is visual studio code

### formatter

- aliariff.vscode-erb-beautify
- heybourn.headwind
- DavidAnson.vscode-markdownlint
- esbenp.prettier-vscode
- castwide.solargraph

### other extension

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

### testing

```shell
./bin/rails test
```

## database

the database is sqlite3 for local development
and PostgreSQL for production
