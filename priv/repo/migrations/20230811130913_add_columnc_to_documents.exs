defmodule Workspace.Repo.Migrations.AddColumncToDocuments do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :file_size, :integer
    end
  end
end
