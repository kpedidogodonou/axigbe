defmodule Axigbe.Accounts do
  use Ash.Domain

  resources do
    resource Axigbe.Accounts.User
    resource Axigbe.Accounts.Token 
  end
end
