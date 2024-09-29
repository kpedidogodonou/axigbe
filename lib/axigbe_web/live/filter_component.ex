defmodule AxigbeWeb.AxigbeLive.FilterComponent do
  use AxigbeWeb, :live_component

  alias AxigbeWeb.Forms.FilterForm

  def render(assigns) do
    ~H"""
    <div id="table-filter">
      <.simple_form
        :let={filterdata}
        for={@changeset}
        as="filter"
        phx-submit="search"
        phx-target={@myself}
      >
        <div>
          <div class="w-15" >
            <.input
                label="Mon budget"
                type="number"
                field={filterdata[:budget]}/>
          </div>

          <div class="w-15" >
            <.input
            label="Je recherche"
            field={filterdata[:name]}/>
          </div>


          <div class="btn-submit">

              <.button>
                Search
              </.button>
          </div>
        </div>
      </.simple_form>
    </div>
    """
  end

  def update(%{filter: filter}, socket) do
    IO.puts("updating......")

    {:ok, assign(socket, :changeset, FilterForm.change_values(filter))}
  end

  def handle_event("search", %{"filter" => filter}, socket) do
    IO.puts("Searching......")
    IO.inspect(filter)

    case FilterForm.parse(filter) do
      {:ok, opts} ->
        send(self(), {:update, opts})
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end
