defmodule Workspace.Repo.Migrations.AddUuidAndLabelColumnsToDocument do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :uuid, :string
    end
  end
end
