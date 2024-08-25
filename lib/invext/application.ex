defmodule Invext.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      InvextWeb.Telemetry,
      Invext.Repo,
      {DNSCluster, query: Application.get_env(:invext, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Invext.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Invext.Finch},
      # Start a worker by calling: Invext.Worker.start_link(arg)
      # {Invext.Worker, arg},
      # Start to serve requests, typically the last entry
      InvextWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Invext.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InvextWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
