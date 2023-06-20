defmodule Workspace.Portfolio.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :client_contact, :string
    field :client_name, :string
    field :description, :string
    field :end_date, :date
    field :project_name, :string
    field :risks, :string
    field :start_date, :date
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:project_name, :client_name, :client_contact, :description, :status, :risks, :start_date, :end_date])
    |> validate_required([:project_name, :client_name, :client_contact, :description, :status, :risks, :start_date, :end_date])
  end
end
