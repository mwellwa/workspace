defmodule WorkspaceWeb.DashboardLive do
  use WorkspaceWeb, :live_view

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       total_projects: 0,
       message: "Create or delete project",
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Total number of projects: <%= @total_projects %></h1>
    <h2><%= @message %></h2>
    <div class="space-x-2 my-2">
      <button
        phx-click="add_project"
        phx-value-number="1"
        class="p-3 text-sm font-semibold text-white bg-slate-900 rounded-md hover:bg-slate-700"
      >
        Create project
      </button>
      <button
        phx-click="delete_project"
        phx-value-number="1"
        class="p-3 text-sm font-semibold text-red-700 bg-rose-50 rounded-md hover:bg-red-600 hover:text-white"
      >
        Delete project
      </button>
    </div>
    """
  end

  def handle_event("add_project", %{"number" => value}, socket) do
    message = "Congratulations, you have created a project!"
    total_projects = socket.assigns.total_projects + 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        total_projects: total_projects
      )
    }
  end

  def handle_event("delete_project", %{"number" => value}, socket) do
    message =
      if socket.assigns.total_projects == 0 do
        "There are no more projects to delete."
      else
        "You have deleted a project."
      end

    total_projects =
      if socket.assigns.total_projects == 0 do
        0
      else
        socket.assigns.total_projects - 1
      end

    {
      :noreply,
      assign(
        socket,
        message: message,
        total_projects: total_projects
      )
    }
  end
end
