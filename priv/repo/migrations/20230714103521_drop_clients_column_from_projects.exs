defmodule Workspace.Repo.Migrations.DropClientsColumnFromProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      remove(:client)
    end
  end
end
