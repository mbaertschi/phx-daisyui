[
  subdirectories: ["priv/*/migrations"],
  import_deps: [:ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations"],
  plugins: [
    TailwindFormatter,
    Phoenix.LiveView.HTMLFormatter,
    Recode.FormatterPlugin
  ],
  inputs: [
    "*.{heex,ex,exs}",
    "{config,lib,test}/**/*.{heex,ex,exs}",
    "priv/*/seeds.exs",
    "storybook/**/*.exs"
  ]
]
