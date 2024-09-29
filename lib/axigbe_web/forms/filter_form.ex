defmodule AxigbeWeb.Forms.FilterForm do
  import Ecto.Changeset


  @fields %{
    budget: :integer,
    name: :string
  }

  @default_values %{
    budget: nil,
    name: nil
  }
#
  def default_values(overrides \\ %{}) do
    Map.merge(@default_values, overrides)
  end

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> validate_number(:budget, greater_than_or_equal_to: 0)
    |> apply_action(:insert)
  end

  def change_values(values \\ @default_values) do
    IO.inspect("changing values")
    {values, @fields}
    |> cast(%{}, Map.keys(@fields))
  end

  def contains_filter_values?(opts) do
    @fields
    |> Map.keys()
    |> Enum.any?(fn key -> Map.get(opts, key) end)
  end
end
