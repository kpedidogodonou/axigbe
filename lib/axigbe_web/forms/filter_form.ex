defmodule AxigbeWeb.Forms.FilterForm do
  import Ecto.Changeset


  @fields %{
    # budget: AshMoney.Types.Money,
    name: :string,
    area: :string,
  }

  @default_values %{
    # budget: nil,
    name: nil,
    area: nil
  }


  def default_values(overrides \\ %{}) do
    Map.merge(@default_values, overrides)
  end

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    # |> validate_number(:budget, greater_than_or_equal_to: 0)
    |> apply_action(:insert)
  end

  def change_values(values \\ @default_values) do
    {values, @fields}
    |> cast(%{}, Map.keys(@fields))
  end

  def contains_filter_values?(opts) do
    @fields
    |> Map.keys()
    |> Enum.any?(fn key -> Map.get(opts, key) end)
  end
end
