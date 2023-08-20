defmodule Workspace.Clients.Client do
  use Ecto.Schema
  import Ecto.Changeset

  alias Workspace.Projects.Project

  schema "clients" do
    field :country, :string
    field :email, :string
    field :name, :string
    field :phone_number, :string
    field :sector, :string
    timestamps()

    has_many :project, Project
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name, :email, :phone_number, :country, :sector])
    |> validate_required([:name, :email, :phone_number, :country, :sector])
    |> unique_constraint(:name)
  end
end
