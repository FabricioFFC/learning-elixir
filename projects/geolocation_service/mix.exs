defmodule GeolocationService.MixProject do
  use Mix.Project

  def project do
    [
      app: :geolocation_service,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools],
      mod: {GeolocationService.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.10"},
      {:ecto_network, "~> 1.3"},
      {:ecto_sql, "~> 3.10"},
      {:ex_machina, "~> 2.7", only: :test},
      {:jason, "~> 1.2"},
      {:net_address, "~> 0.3.0"},
      {:nimble_csv, "~> 1.2"},
      {:phoenix, "~> 1.7.9"},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, "~> 0.17.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
