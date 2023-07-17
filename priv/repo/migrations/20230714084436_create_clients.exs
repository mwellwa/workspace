defmodule Workspace.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string
      add :email, :string
      add :phone_number, :string
      add :country, :string
      add :sector, :string

      timestamps()
    end
  end
end
