defmodule Workspace.Repo.Migrations.RenameProjectNameToName do
  use Ecto.Migration

  def change do
    rename table(:projects), :project_name, to: :name
  end
end
