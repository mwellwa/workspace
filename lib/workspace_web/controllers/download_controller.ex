defmodule WorkspaceWeb.DownloadController do
  use WorkspaceWeb, :controller

  alias Workspace.Documentation
  alias Workspace.Documentation.Document

  def download(conn, %{"file_uuid" => file_uuid}) do
    document = Documentation.get_document_by_uuid!(file_uuid)
    path = "priv/static" <> document.file_path

    conn
    |> put_resp_header("content-disposition", "attachment; filename=#{document.file_name}")
    |> send_download({:file, path}, filename: document.file_name)
  end
end
