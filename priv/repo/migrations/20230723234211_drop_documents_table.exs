defmodule Workspace.Repo.Migrations.DropDocumentsTable do
  use Ecto.Migration

  def change do
    drop table("documents")
  end
end
