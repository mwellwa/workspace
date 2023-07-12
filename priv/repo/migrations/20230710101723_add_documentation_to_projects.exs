defmodule Workspace.Repo.Migrations.AddDocumentationToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :business_requirement_document, :string
      add :project_initiation_document, :string
      add :project_plan, :string
    end
  end
end
