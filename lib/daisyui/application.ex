defmodule Daisyui.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DaisyuiWeb.Telemetry,
      Daisyui.Repo,
      {DNSCluster, query: Application.get_env(:daisyui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Daisyui.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Daisyui.Finch},
      # Start a worker by calling: Daisyui.Worker.start_link(arg)
      # {Daisyui.Worker, arg},
      # Start to serve requests, typically the last entry
      DaisyuiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Daisyui.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DaisyuiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
