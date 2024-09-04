defmodule Axigbe.Accounts.Token do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication.TokenResource],
    domain: Axigbe.Accounts

  postgres do
    table "tokens"
    repo Axigbe.Repo
  end
end
