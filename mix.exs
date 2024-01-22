defmodule Daisyui.MixProject do
  use Mix.Project

  def project do
    [
      app: :daisyui,
      version: "0.1.0",
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Dialyzer
      dialyzer: [
        plt_local_path: "priv/plts/project.plt",
        plt_core_path: "priv/plts/core.plt",
        plt_add_apps: [:mix]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Daisyui.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix Framework
      {:bandit, ">= 1.1.0"},
      {:phoenix, "~> 1.7.10"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.3"},

      # Database and Ecto
      {:ecto_sql, "~> 3.11"},
      {:postgrex, ">= 0.0.0"},

      # Testing and Linting
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:tailwind_formatter, "~> 0.4.0", only: [:dev, :test], runtime: false},
      {:recode, "~> 0.6", only: [:dev, :test]},

      # Assers
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},

      # Internationalization and Localization
      {:gettext, "~> 0.20"},
      {:ex_cldr, "~> 2.37"},
      {:ex_cldr_plugs, "~> 1.3"},

      # HTTP and API Utilities
      {:finch, "~> 0.13"},
      {:jason, "~> 1.2"},

      # Mailing
      {:swoosh, "~> 1.3"},

      # Data Processing and Parsing
      {:floki, ">= 0.30.0", only: :test},

      # Monitoring and Tracing
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},

      # Clustering
      {:dns_cluster, "~> 0.1.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      # Setup Project
      setup: [
        "deps.get",
        "repo.setup",
        "assets.setup",
        "assets.build"
      ],

      # Database management
      "repo.create": [
        "ecto.create"
      ],
      "repo.migrate": [
        "ecto.migrate"
      ],
      "repo.drop": [
        "ecto.drop"
      ],
      "repo.setup": [
        "repo.create",
        "repo.migrate",
        "run priv/repo/seeds.exs"
      ],
      "repo.reset": [
        "repo.drop",
        "repo.setup"
      ],

      # Run tests
      test: [
        "repo.create --quiet",
        "repo.migrate --quiet",
        "test"
      ],

      # Translation management
      "gettext.update": [
        "gettext.extract --merge"
      ],
      "gettext.lint": [
        "gettext.extract --check-up-to-date"
      ],

      # Asset management
      "assets.setup": [
        "tailwind.install --if-missing",
        "esbuild.install --if-missing",
        "cmd cd assets && npm install"
      ],
      "assets.update": [
        "tailwind.install",
        "esbuild.install",
        "cmd cd assets && npm update"
      ],
      "assets.build": [
        "tailwind default",
        "esbuild default"
      ],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "phx.digest"
      ],

      # Run linters
      lint: [
        # temporarily disabled because of redefining module warnings
        # "compile --all-warnings --warnings-as-errors",
        "format --check-formatted",
        "credo --strict",
        "deps.audit",
        "gettext.lint",
        "dialyzer"
      ]
    ]
  end
end
