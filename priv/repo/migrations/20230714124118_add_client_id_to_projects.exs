defmodule Workspace.Repo.Migrations.AddClientIdToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :client_id, references(:clients, on_delete: :nothing)
    end
  end
end
