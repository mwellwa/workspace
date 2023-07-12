defmodule Workspace.Repo.Migrations.RenameClientContactToContact do
  use Ecto.Migration

  def change do
    rename table(:projects), :client_contact, to: :contact
  end
end
