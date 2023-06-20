# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Workspace.Repo.insert!(%Workspace.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Workspace.Portfolio

projects = [
  %{
    client_contact: "Client 1",
    client_name: "Client 1",
    description: "A dummy project",
    end_date: "2023-07-23",
    project_name: "Project 1",
    risks: "Might not work",
    start_date: "2023-06-23",
    status: "open"
  },
  %{
    client_contact: "Client 2",
    client_name: "Client 2",
    description: "A dummy project",
    end_date: "2023-10-23",
    project_name: "Project 2",
    risks: "Might not work",
    start_date: "2023-06-25",
    status: "open"
  },
  %{
    client_contact: "Client 3",
    client_name: "Client 3",
    description: "A dummy project",
    end_date: "2023-07-23",
    project_name: "Project 3",
    risks: "Might not work",
    start_date: "2023-06-23",
    status: "open"
  }
]

Enum.each(projects, fn project -> Portfolio.create_project(project) end)
