defmodule WorkspaceWeb.DocumentationLive.VersionHistoryComponent do
  use WorkspaceWeb, :live_component
  alias Workspace.Documentation
  alias Workspace.Documentation.Document

  def update(assigns, socket) do
    IO.inspect(assigns, label: "===== Current User in Version History Component =====")

    # IO.inspect(socket |> assign(assigns) |> assign_document() |> assign_document_history(),
    #   label: "===== After Piping ====="
    # )

    {:ok,
     socket
     |> assign(assigns)
     |> assign_document()
     |> assign_document_history()}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, socket.assigns.id, ref)}
  end

  def assign_document(%{assigns: %{project: project}} = socket) do
    assign(socket, :document, %Document{project_id: project.id})
  end

  def assign_document_history(%{assigns: %{project: project, doc_name: doc_name}} = socket) do
    documents = Documentation.get_documents_by_project_and_label(project.id, doc_name)

    assign(socket, :version_history, documents)
  end

  defp save_document(:upload, params, %{assigns: %{project: project}} = socket) do
    # IO.inspect(socket, label: "========= Save Document ==============")

    document_params =
      params_with_file_path(socket, params)
      |> Map.put(:project_id, socket.assigns.project.id)

    case Documentation.create_document(document_params) do
      {:ok, document} ->
        # IO.inspect(document, label: "========= Created Document From Changeset")

        {:noreply,
         socket
         |> put_flash(:info, "Document created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp upload_static_file(%{path: path}, entry) do
    # IO.inspect(entry, label: "====== Entry Param =====")
    filename = Path.basename(path)
    dest = Path.join([:code.priv_dir(:workspace), "static", "uploads", filename])
    File.cp!(path, dest)

    {:ok, ~p"/uploads/#{filename}"}
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"

  defp params_with_file_path(socket, params) do
    path =
      socket
      |> consume_uploaded_entries(socket.assigns.id, &upload_static_file/2)
      |> List.first()

    Map.put(params, :file_path, path)
  end
end
