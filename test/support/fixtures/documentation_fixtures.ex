defmodule Workspace.DocumentationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Workspace.Documentation` context.
  """

  @doc """
  Generate a document.
  """
  def document_fixture(attrs \\ %{}) do
    {:ok, document} =
      attrs
      |> Enum.into(%{
        doc_type: "some doc_type",
        name: "some name",
        s3_file_key: "some s3_file_key"
      })
      |> Workspace.Documentation.create_document()

    document
  end
end
