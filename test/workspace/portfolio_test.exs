defmodule Workspace.PortfolioTest do
  use Workspace.DataCase

  alias Workspace.Portfolio

  describe "projects" do
    alias Workspace.Portfolio.Project

    import Workspace.PortfolioFixtures

    @invalid_attrs %{client_contact: nil, client_name: nil, description: nil, end_date: nil, project_name: nil, risks: nil, start_date: nil, status: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Portfolio.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Portfolio.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{client_contact: "some client_contact", client_name: "some client_name", description: "some description", end_date: ~D[2023-06-18], project_name: "some project_name", risks: "some risks", start_date: ~D[2023-06-18], status: "some status"}

      assert {:ok, %Project{} = project} = Portfolio.create_project(valid_attrs)
      assert project.client_contact == "some client_contact"
      assert project.client_name == "some client_name"
      assert project.description == "some description"
      assert project.end_date == ~D[2023-06-18]
      assert project.project_name == "some project_name"
      assert project.risks == "some risks"
      assert project.start_date == ~D[2023-06-18]
      assert project.status == "some status"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolio.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{client_contact: "some updated client_contact", client_name: "some updated client_name", description: "some updated description", end_date: ~D[2023-06-19], project_name: "some updated project_name", risks: "some updated risks", start_date: ~D[2023-06-19], status: "some updated status"}

      assert {:ok, %Project{} = project} = Portfolio.update_project(project, update_attrs)
      assert project.client_contact == "some updated client_contact"
      assert project.client_name == "some updated client_name"
      assert project.description == "some updated description"
      assert project.end_date == ~D[2023-06-19]
      assert project.project_name == "some updated project_name"
      assert project.risks == "some updated risks"
      assert project.start_date == ~D[2023-06-19]
      assert project.status == "some updated status"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Portfolio.update_project(project, @invalid_attrs)
      assert project == Portfolio.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Portfolio.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Portfolio.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Portfolio.change_project(project)
    end
  end
end
