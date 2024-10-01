defmodule AxigbeWeb.LiveHome do
  use AxigbeWeb, :live_view

  alias Axigbe.Market
  alias AxigbeWeb.Forms.SortingForm
  alias AxigbeWeb.Forms.FilterForm
  alias AxigbeWeb.Forms.PaginationForm



  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}

  @impl true
  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_products()

    {:noreply, assign_products(socket)}
  end

  @impl true
  @spec handle_info({:update, any()}, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info({:update, opts}, socket) do
    params = merge_and_sanitize_params(socket, opts)
    path = unverified_path(socket, AxigbeWeb.Router, "/", params)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  def maybe_reset_pagination(overrides) do
    if FilterForm.contains_filter_values?(overrides) do
      Map.put(overrides, :page, 1)
    else
      overrides
    end
  end

  defp merge_and_sanitize_params(socket, overrides \\ %{}) do
    %{filter: filter, pagination: pagination} = socket.assigns
    overrides = maybe_reset_pagination(overrides)


    %{}
    |> Map.merge(filter)
    |> Map.merge(pagination)
    |> Map.merge(overrides)
    |> Map.drop([:total_count])
    |> Enum.reject(fn {_key, value} -> is_nil(value) end)
    |> Map.new()
  end

  defp assign_total_count(socket, total_count) do
    update(socket, :pagination, fn pagination ->
      %{
        pagination
        | total_count: total_count
      }
    end)
  end

  defp parse_params(socket, params) do
    with {:ok, filter_opts} <- FilterForm.parse(params),
         {:ok, pagination_opts} <- PaginationForm.parse(params) do

    socket
    |> assign_filter(filter_opts)
    |> assign_pagination(pagination_opts)
    else
    _error ->
      socket
      |> assign_filter()
      |> assign_pagination()
    end
  end

  defp assign_pagination(socket, overrides \\ %{}) do
    assign(socket, :pagination, PaginationForm.default_values(overrides))
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  defp assign_products(socket) do
     params = merge_and_sanitize_params(socket)


     %Ash.Page.Keyset{results: products, count: total_count} =
        Market.search_products(params)
    socket
    |> assign(:products, products)
    |> assign_total_count(total_count)
    end


  defp assign_filter(socket, overrides \\ %{}) do
    assign(socket, :filter, FilterForm.default_values(overrides))
  end
end
