defmodule Axigbe.Repo do
  use AshPostgres.Repo,
    otp_app: :axigbe

  def installed_extensions do
    # Add extensions here, and the migration generator will install them.
    ["uuid-ossp", "citext", "ash-functions", AshMoney.AshPostgresExtension]
  end
end
