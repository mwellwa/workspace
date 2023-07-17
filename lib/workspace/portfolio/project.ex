defmodule Workspace.Portfolio.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Workspace.Clients.Client

  schema "projects" do
    field :contact, :string
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :risks, :string
    field :start_date, :date
    field :status, :string
    field :business_requirement_document, :string
    belongs_to :client, Client

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :name,
      :contact,
      :description,
      :status,
      :risks,
      :start_date,
      :end_date,
      :business_requirement_document,
      :client_id
    ])
    |> validate_required([
      :name,
      :contact,
      :description,
      :client_id
    ])
  end
end
