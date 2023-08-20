defmodule Workspace.Repo.Migrations.AddLabelColumnToDocuments do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :label, :string
    end
  end
end
