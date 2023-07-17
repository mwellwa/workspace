defmodule WorkspaceWeb.ClientLive.Show do
  use WorkspaceWeb, :live_view

  alias Workspace.Clients

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:client, Clients.get_client!(id))}
  end

  defp page_title(:show), do: "Show Client"
  defp page_title(:edit), do: "Edit Client"
end
