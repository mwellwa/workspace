defmodule Workspace.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :project_name, :string
      add :client_name, :string
      add :client_contact, :string
      add :description, :string
      add :status, :string
      add :risks, :string
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end
  end
end
