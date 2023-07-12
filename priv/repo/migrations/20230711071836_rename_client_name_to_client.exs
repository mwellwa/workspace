defmodule Workspace.Repo.Migrations.RenameClientNameToClient do
  use Ecto.Migration

  def change do
    rename table(:projects), :client_name, to: :client
  end
end
