defmodule Axigbe.Accounts do
  use Ash.Domain

  resources do
    resource Axigbe.Accounts.User do
      define :list_users, action: :read
      define :get_user_by_email, args: [:email], action: :by_email
    end
    resource Axigbe.Accounts.Token
  end
end
