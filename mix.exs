defmodule Astrologer.Mixfile do
  use Mix.Project

  def project do
    [app: :astrologer,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Astrologer, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext, :httpoison]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.1.4"},
      {:phoenix_html, "~> 2.5"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.10"},
      {:cowboy, "~> 1.0"},
      {:rethinkdb, "~> 0.4.0"},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:httpoison, "~> 0.8.0"}
    ]
  end
end
