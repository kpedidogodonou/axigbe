[
  import_deps: [:phoenix, :ash, :ash_authentication, :ash_authentication_phoenix, :ash_postgres, :ecto, :ecto_sql, ],
  subdirectories: ["priv/*/migrations"],
  plugins: [Spark.Formatter, Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"]
]
