defmodule Workspace.PortfolioFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Workspace.Portfolio` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        client_contact: "some client_contact",
        client_name: "some client_name",
        description: "some description",
        end_date: ~D[2023-06-18],
        project_name: "some project_name",
        risks: "some risks",
        start_date: ~D[2023-06-18],
        status: "some status"
      })
      |> Workspace.Portfolio.create_project()

    project
  end
end
