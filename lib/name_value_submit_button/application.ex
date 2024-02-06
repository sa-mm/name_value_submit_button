defmodule NameValueSubmitButton.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NameValueSubmitButtonWeb.Telemetry,
      NameValueSubmitButton.Repo,
      {DNSCluster, query: Application.get_env(:name_value_submit_button, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NameValueSubmitButton.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NameValueSubmitButton.Finch},
      # Start a worker by calling: NameValueSubmitButton.Worker.start_link(arg)
      # {NameValueSubmitButton.Worker, arg},
      # Start to serve requests, typically the last entry
      NameValueSubmitButtonWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NameValueSubmitButton.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NameValueSubmitButtonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
