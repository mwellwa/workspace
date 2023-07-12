defmodule Workspace.Portfolio.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :contact, :string
    field :client, :string
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :risks, :string
    field :start_date, :date
    field :status, :string
    field :business_requirement_document, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :name,
      :client,
      :contact,
      :description,
      :status,
      :risks,
      :start_date,
      :end_date,
      :business_requirement_document
    ])
    |> validate_required([
      :name,
      :client,
      :contact,
      :description,
      :status,
      :risks,
      :start_date,
      :end_date
    ])
  end
end
