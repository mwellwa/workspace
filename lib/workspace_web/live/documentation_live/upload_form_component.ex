defmodule WorkspaceWeb.DocumentationLive.UploadFormComponent do
  use WorkspaceWeb, :live_component
  alias Workspace.Documentation
  alias Workspace.Documentation.Document

  def update(assigns, socket) do
    IO.inspect(assigns, label: "===== Current User in Upload Form Component =====")

    socket =
      socket
      |> assign(assigns)
      |> assign_document()
      |> assign_form()
      |> assign(:uploaded_files, [])
      |> allow_upload(assigns.id,
        accept: ~w(.pdf .doc .docx),
        max_entries: 1,
        max_file_size: 9_000_000,
        auto_upload: true
      )

    IO.inspect(socket.assigns)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_document()
     |> assign_form()
     |> assign(:uploaded_files, [])
     |> allow_upload(assigns.id,
       accept: ~w(.pdf .doc .docx),
       max_entries: 1,
       max_file_size: 9_000_000,
       auto_upload: true
     )}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, socket.assigns.id, ref)}
  end

  def handle_event("save", %{"document" => document_params}, socket) do
    document_params =
      document_params
      |> Map.new(fn {key, value} ->
        {String.to_existing_atom(key), value}
      end)

    save(:upload, document_params, socket)
  end

  def assign_document(%{assigns: %{project: project}} = socket) do
    assign(socket, :document, %Document{project_id: project.id})
  end

  def assign_form(%{assigns: %{document: document}} = socket) do
    changeset = Documentation.change_document(document)
    assign(socket, form: to_form(changeset))
  end

  # New version of the save document
  defp save(:upload, params, socket) do
    IO.inspect(params, label: "==== The save function =====")
    document_params = params_with_upload_entry(socket, params)

    case Documentation.create_document(document_params) do
      {:ok, document} ->
        IO.inspect(document, label: "========= Created Document From Changeset")

        {:noreply,
         socket
         |> put_flash(:info, "Document created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  # defp save_document(:upload, params, %{assigns: %{project: project}} = socket) do
  #   document_params =
  #     params_with_file_path(socket, params)
  #     |> Map.put(:project_id, socket.assigns.project.id)

  #   case Documentation.create_document(document_params) do
  #     {:ok, document} ->
  #       # IO.inspect(document, label: "========= Created Document From Changeset")

  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Document created successfully")
  #        |> push_navigate(to: socket.assigns.navigate)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, changeset: changeset)}
  #   end
  # end

  def params_with_upload_entry(socket, params) do
    document_params =
      socket
      |> consume_uploaded_entries(socket.assigns.id, &upload_static_file/2)
      |> List.first()
      |> Map.merge(params)
  end

  defp upload_static_file(%{path: path}, entry) do
    filename = Path.basename(path)
    dest = Path.join([:code.priv_dir(:workspace), "static", "uploads", filename])
    File.cp!(path, dest)

    upload_entry = %{
      file_name: entry.client_name,
      file_size: entry.client_size,
      file_type: entry.client_type,
      file_path: ~p"/uploads/#{Path.basename(dest)}",
      uuid: entry.uuid
    }

    {:ok, upload_entry}
  end

  defp upload_static_entry(%{path: path}, entry) do
    IO.inspect(entry, label: "====== Entry Param =====")

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
