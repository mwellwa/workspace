defmodule Workspace.DocumentationTest do
  use Workspace.DataCase

  alias Workspace.Documentation

  describe "documents" do
    alias Workspace.Documentation.Document

    import Workspace.DocumentationFixtures

    @invalid_attrs %{business_requirement_document: nil, project_initiation_document: nil, project_plan: nil, sign_offs: nil}

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Documentation.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Documentation.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      valid_attrs = %{business_requirement_document: "some business_requirement_document", project_initiation_document: "some project_initiation_document", project_plan: "some project_plan", sign_offs: "some sign_offs"}

      assert {:ok, %Document{} = document} = Documentation.create_document(valid_attrs)
      assert document.business_requirement_document == "some business_requirement_document"
      assert document.project_initiation_document == "some project_initiation_document"
      assert document.project_plan == "some project_plan"
      assert document.sign_offs == "some sign_offs"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Documentation.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      update_attrs = %{business_requirement_document: "some updated business_requirement_document", project_initiation_document: "some updated project_initiation_document", project_plan: "some updated project_plan", sign_offs: "some updated sign_offs"}

      assert {:ok, %Document{} = document} = Documentation.update_document(document, update_attrs)
      assert document.business_requirement_document == "some updated business_requirement_document"
      assert document.project_initiation_document == "some updated project_initiation_document"
      assert document.project_plan == "some updated project_plan"
      assert document.sign_offs == "some updated sign_offs"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Documentation.update_document(document, @invalid_attrs)
      assert document == Documentation.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Documentation.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Documentation.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Documentation.change_document(document)
    end
  end

  describe "documents" do
    alias Workspace.Documentation.Document

    import Workspace.DocumentationFixtures

    @invalid_attrs %{doc_type: nil, name: nil, s3_file_key: nil}

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Documentation.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Documentation.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      valid_attrs = %{doc_type: "some doc_type", name: "some name", s3_file_key: "some s3_file_key"}

      assert {:ok, %Document{} = document} = Documentation.create_document(valid_attrs)
      assert document.doc_type == "some doc_type"
      assert document.name == "some name"
      assert document.s3_file_key == "some s3_file_key"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Documentation.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      update_attrs = %{doc_type: "some updated doc_type", name: "some updated name", s3_file_key: "some updated s3_file_key"}

      assert {:ok, %Document{} = document} = Documentation.update_document(document, update_attrs)
      assert document.doc_type == "some updated doc_type"
      assert document.name == "some updated name"
      assert document.s3_file_key == "some updated s3_file_key"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Documentation.update_document(document, @invalid_attrs)
      assert document == Documentation.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Documentation.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Documentation.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Documentation.change_document(document)
    end
  end
end
