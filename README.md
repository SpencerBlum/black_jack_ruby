# CLI Black Jack App 

In this project you will be able to player a game of 21
## Rules

- BlackJack: A player or dealer scores 21 points; they win, the game is over.
- Bust: A player or dealer scores over 21 points; they lose, the game is over.
- Hit: When a player or dealer asks for another card.
- Stay: When a player decides to end their turn.

## Run App

@@ rails runner ./bin/run.rb] @@
## Run tests

@@ bundle exec rspec @@

## Gems

- ruby '2.6.1'
- gem 'rails', '~> 6.0.4', '>= 6.0.4.7'
- gem 'sqlite3', '~> 1.4'
- gem 'puma', '~> 4.1'
- gem "tty-prompt"
- gem 'byebug'
- gem 'bootsnap', '>= 1.4.2', require: false
- gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
- gem 'rspec-rails', '~> 5.0.0'
- gem 'listen', '~> 3.2'
- gem 'spring'
- gem 'spring-watcher-listen', '~> 2.0.0'
- gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
