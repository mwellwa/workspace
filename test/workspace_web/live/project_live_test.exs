defmodule WorkspaceWeb.ProjectLiveTest do
  use WorkspaceWeb.ConnCase

  import Phoenix.LiveViewTest
  import Workspace.PortfolioFixtures

  @create_attrs %{
    client_contact: "some client_contact",
    client_name: "some client_name",
    description: "some description",
    end_date: "2023-06-18",
    project_name: "some project_name",
    risks: "some risks",
    start_date: "2023-06-18",
    status: "some status"
  }
  @update_attrs %{
    client_contact: "some updated client_contact",
    client_name: "some updated client_name",
    description: "some updated description",
    end_date: "2023-06-19",
    project_name: "some updated project_name",
    risks: "some updated risks",
    start_date: "2023-06-19",
    status: "some updated status"
  }
  @invalid_attrs %{
    client_contact: nil,
    client_name: nil,
    description: nil,
    end_date: nil,
    project_name: nil,
    risks: nil,
    start_date: nil,
    status: nil
  }

  defp create_project(_) do
    project = project_fixture()
    %{project: project}
  end

  describe "Index" do
    setup [:create_project, :register_and_log_in_user]

    test "lists all projects", %{conn: conn, project: project} do
      {:ok, _index_live, html} = live(conn, ~p"/projects")

      assert html =~ "Listing Projects"
      assert html =~ project.client_contact
    end

    test "saves new project", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/projects")

      assert index_live |> element("a", "New Project") |> render_click() =~
               "New Project"

      assert_patch(index_live, ~p"/projects/new")

      assert index_live
             |> form("#project-form", project: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#project-form", project: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/projects")

      html = render(index_live)
      assert html =~ "Project created successfully"
      assert html =~ "some client_contact"
    end

    test "updates project in listing", %{conn: conn, project: project} do
      {:ok, index_live, _html} = live(conn, ~p"/projects")

      assert index_live |> element("#projects-#{project.id} a", "Edit") |> render_click() =~
               "Edit Project"

      assert_patch(index_live, ~p"/projects/#{project}/edit")

      assert index_live
             |> form("#project-form", project: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#project-form", project: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/projects")

      html = render(index_live)
      assert html =~ "Project updated successfully"
      assert html =~ "some updated client_contact"
    end

    test "deletes project in listing", %{conn: conn, project: project} do
      {:ok, index_live, _html} = live(conn, ~p"/projects")

      assert index_live |> element("#projects-#{project.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#projects-#{project.id}")
    end
  end

  describe "Show" do
    setup [:create_project, :register_and_log_in_user]

    test "displays project", %{conn: conn, project: project} do
      {:ok, _show_live, html} = live(conn, ~p"/projects/#{project}")

      assert html =~ "Show Project"
      assert html =~ project.client_contact
    end

    test "updates project within modal", %{conn: conn, project: project} do
      {:ok, show_live, _html} = live(conn, ~p"/projects/#{project}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Project"

      assert_patch(show_live, ~p"/projects/#{project}/show/edit")

      assert show_live
             |> form("#project-form", project: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#project-form", project: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/projects/#{project}")

      html = render(show_live)
      assert html =~ "Project updated successfully"
      assert html =~ "some updated client_contact"
    end
  end
end
