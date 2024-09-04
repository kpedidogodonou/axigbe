defmodule Axigbe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AxigbeWeb.Telemetry,
      Axigbe.Repo,
      {DNSCluster, query: Application.get_env(:axigbe, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Axigbe.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Axigbe.Finch},

      {AshAuthentication.Supervisor, otp_app: :axigbe},

      # {Nx.Serving, serving: serving(), name: MyServing },

      # {Nx.Serving, serving: serving(), name: GteServing },

      # Start a worker by calling: Axigbe.Worker.start_link(arg)
      # {Axigbe.Worker, arg},
      # Start to serve requests, typically the last entry
      AxigbeWeb.Endpoint

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Axigbe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # def serving do
    # {:ok, model_info} =
    #   Bumblebee.load_model({:hf, "finiteautomata/bertweet-base-emotion-analysis"},
    #   log_params_diff: false)

    #   {:ok, tokenizer} =
    #     Bumblebee.load_tokenizer({:hf, "vinai/bertweet-base"})

      # repo = {:hf, "thenlper/gte-small"}

      # {:ok, model_info} = Bumblebee.load_model(repo)
      # {:ok, tokenizer} = Bumblebee.load_tokenizer(repo)



      # Bumblebee.Text.TextEmbedding.text_embedding(model_info, tokenizer,
      #   compile: [batch_size: 64, sequence_length: 512],
      #   defn_options: [compiler: EXLA],
      #   output_attribute: :hidden_state,
      #   output_pool: :mean_pooling)


    # Bumblebee.Text.text_classification(model_info, tokenizer,
    #   compile: [batch_size: 10, sequence_length: 100],
    #   defn_options: [compiler: EXLA])
  # end


  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AxigbeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
