defmodule Workspace.Repo.Migrations.RenameFromDocTypeToFileType do
  use Ecto.Migration

  def change do
    rename table(:documents), :doc_type, to: :file_type
  end
end
