defmodule AxigbeWeb.Forms.SortingForm do
  import Ecto.Changeset

  alias Axigbe.EctoHelper

  @fields %{
    sort_by: EctoHelper.enum([:price, :name]),
    sort_dir: EctoHelper.enum([:asc, :desc])
  }

  @default_values %{
    sort_by: :price,
    sort_dir: :asc
  }

  def parse(params) do 
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(), do: @default_values
end
