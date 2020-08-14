# Url Dome API

Migration of my url-dome originally developed using Go. 

The idea behind this migration is to learn about Elixir and Functional Programming in general.

Tried to apply the main idea behind Clean Architecture by splitting the project between `use cases`, `external interfaces` and `entities` and avoid some coupling between the modules using behaviours and configurations

## Installation

Assuming you have Elixir installed.

Getting dependencies and compiling:
```
mix deps.get
mix compile
```

Running all the tests:
```
mix test
```

Running:
```
mix run --no-halt
```
