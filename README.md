# Ruby Workspace Experiment

The goal of this repo is to replicate the developer experience of [Nx](https://nx.dev)'s "integrated monorepo" setup for the Ruby world.

I will be sticking to tools available in the Ruby world as far as possible to build out this workspace, as that is also one of the goals of this experiment.

I will be using [`rake`](https://github.com/ruby/rake) as the main buildling block because I think it is good enough to get started with.

For example, this repo can already let you do:

```sh
# to run an app with args passed to it
rake run <app_name_here> arg, another_arg, one_more

# to run the test suite in the app or lib
rake test <app_or_lib_name_here>
```

## Workspace layout

The code is organised in the following parts:

- `root`: This is the root folder. All the common and essential files (e.g. `Gemfile`, `Rakefile`, config files for rubocop, vscode workspace, testing frameworks etc) should go here.

- `core`: This directory contains code that (at the moment) makes this workspace actually work. In the future, I will be moving the `Workspace::Core` to its own gem or something. Ideally this directory should be used for 'common' code (something that stiches together apps and libs). Not everyone may require this directory.

- `apps`: This is where your applications will live.
- `libs`: This is where your libraries will live.

This is an example of how `apps` and `libs` should be organised:

```
├── apps
│   ├── calculator
│   │   ├── main.rb
│   │   ├── test.rb
│   │   └── some_internal_module
│   │       ├── main.rb
│   │       └── some_internal_class.rb
│   └── weather
│       ├── main.rb
│       └── test.rb
├── libs
│   ├── utilities
│   │   ├── main.rb
│   │   ├── test.rb
│   │   ├── formatting
│   │   │   ├── main.rb
│   │   │   └── test.rb
│   │   └── math
│   │       ├── main.rb
│   │       └── test.rb
│   └── ui_components
│       ├── main.rb
│       ├── test.rb
│       └── button
│           ├── main.rb
│           └── test.rb
```

The automatic lazy constant resolution system requires that the following rules are followed:

- each 'module' (regardless of its depth in directory levels) has a `main.rb` file which declares all the important constants or imports them using `require_relative`. This is similar in spirit to `index.js` in Node or `main.ts` in Deno.

      Note: the alternative to `require_relative` is the `Workspace::Core::Loadable` module or `autoload`. It is really up to the developer to decide how they want to initialise/import/declare their constants.

- each module can optionally have a `test.rb` file with tests for that module in it, alternatively this file can `require_relative` other test files in the module if you need to break down your test files into a few smaller ones.

- tests must be 'invocable' by simply `require_relative`-ing them, or by running them directly as a ruby script like this:

  ```sh
  ruby <test_file_name>.rb
  ```

- applications need to have a `Main` class of type `Workspace::Core::Runnable` as the 'entry point'.

- applications must not import anything from another application.

- libraries must not import anything from any application.

- libraries may import something from another library.

## Disclaimer

- literally everything here is subject to change.
- this is an experiment. do not use this in production.
