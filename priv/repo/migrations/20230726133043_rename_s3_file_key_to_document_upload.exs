defmodule Workspace.Repo.Migrations.RenameS3FileKeyToDocumentUpload do
  use Ecto.Migration

  def change do
    rename table(:documents), :s3_file_key, to: :document_upload
  end
end
