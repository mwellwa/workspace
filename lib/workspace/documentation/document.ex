defmodule Workspace.Documentation.Document do
  use Ecto.Schema
  import Ecto.Changeset

  alias Workspace.Projects.Project
  alias Workspace.Accounts.User

  schema "documents" do
    field :file_name, :string
    field :file_type, :string
    field :file_path, :string
    field :file_size, :integer
    field :label, :string
    field :uuid, :string
    field :comment, :string
    field :status, :string
    belongs_to :project, Project
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [
      :file_name,
      :file_type,
      :file_path,
      :file_size,
      :label,
      :uuid,
      :status,
      :project_id,
      :comment,
      :user_id
    ])

    # |> validate_required([:name, :doc_type, :document_upload])
  end
end
