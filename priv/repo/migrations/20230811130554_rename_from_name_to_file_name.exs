defmodule Workspace.Repo.Migrations.RenameFromNameToFileName do
  use Ecto.Migration

  def change do
    rename table(:documents), :name, to: :file_name
  end
end
