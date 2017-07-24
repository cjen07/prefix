defmodule Prefix.Mixfile do
  use Mix.Project

  def project do
    [
      app: :prefix,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
      ∀ Q, ∃h, ∀ f, g ∈ Q, s.t h(f, g) "then" f ≡ g + f
    """
  end

  defp package do
    [
      files: ["lib/z.ex", "mix.exs", "README.md"],
      maintainers: ["Chen Wang"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/cjen07/prefix"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
