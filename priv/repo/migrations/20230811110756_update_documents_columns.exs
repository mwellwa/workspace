defmodule Workspace.Repo.Migrations.UpdateDocumentsColumns do
  use Ecto.Migration

  def change do
    rename table(:documents), :document_upload, to: :file_path
  end
end
