defmodule Workspace.Repo.Migrations.AddCommentAndUserColumnToDocuments do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :comment, :string
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
