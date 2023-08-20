defmodule WorkspaceWeb.ProjectLive.Show do
  use WorkspaceWeb, :live_view

  alias Workspace.Projects
  alias Workspace.DocumentationLive

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(socket.assigns.current_user)

    {:ok, socket |> assign_documents()}
  end

  @impl true
  def handle_params(%{"id" => id, "doc_name" => doc_name} = params, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:project, Projects.get_project!(id))
     |> assign(:doc_name, doc_name)}
  end

  def handle_params(%{"id" => id} = params, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:project, Projects.get_project!(id))}
  end

  def handle_event("download", %{"file_uuid" => file_uuid}, socket) do
    IO.inspect(file_uuid, label: "===== Download Event Recieved =====")
    {:noreply, socket}
    # {:noreply,
    #  redirect(socket,
    #    to: Routes.download_path(WorkspaceWeb.Endpoint, :download, file_uuid: file_uuid)
    #  )}
  end

  defp page_title(:show), do: "Show Project"
  defp page_title(:edit), do: "Edit Project"
  defp page_title(:upload), do: "Upload Document"
  defp page_title(:change), do: "Change Document"
  defp page_title(:history), do: "Version History"

  defp assign_documents(socket) do
    assign(socket, :documents, [
      "business requirement document",
      "project plan",
      "project initiation document",
      "sign off",
      "test document",
      "test project plan"
    ])
  end
end
