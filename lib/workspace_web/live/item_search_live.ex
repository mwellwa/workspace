defmodule WorkspaceWeb.ItemSearchLive do
  use WorkspaceWeb, :live_view

  alias Workspace.Clients

  def mount(_params, _session, socket) do
    clients = Clients.list_clients()

    {:ok, assign(socket, suggestions: clients, selected: [])}
  end

  def handle_event("suggest", %{"search" => search}, socket) do
    suggestions = Clients.list_clients() |> suggest(search)

    {:noreply, assign(socket, suggestions: suggestions)}
  end

  def handle_event("select", %{"id" => id}, socket) do
    item = Clients.get_client!(id)
    selected = Enum.uniq_by([item] ++ socket.assigns.selected, & &1.id)
    suggestions = filter_selected(socket.assigns.suggestions, selected)

    socket =
      assign(socket,
        selected: selected,
        suggestions: suggestions
      )

    {:noreply, socket}
  end

  defp suggest(items, search) do
    Enum.filter(items, fn i ->
      i.name
      |> String.downcase()
      |> String.contains?(String.downcase(search))
    end)
  end

  defp filter_selected(items, selected) do
    Enum.filter(items, fn i -> !Enum.any?(selected, fn s -> i.id == s.id end) end)
  end
end
