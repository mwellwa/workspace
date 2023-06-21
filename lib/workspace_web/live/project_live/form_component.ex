defmodule WorkspaceWeb.ProjectLive.FormComponent do
  use WorkspaceWeb, :live_component

  alias Workspace.Portfolio

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage project records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="project-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="flex gap-x-4">
          <div class="w-1/2">
            <.input field={@form[:project_name]} type="text" label="Name" />
          </div>
          <div class="w-1/2">
            <.input field={@form[:client_name]} type="text" label="Client" />
          </div>
        </div>
        <div class="flex gap-x-4">
          <div class="w-4/6">
            <.input field={@form[:client_contact]} type="text" label="Client contact" />
          </div>
          <div class="w-2/6">
            <.input field={@form[:status]} type="text" label="Status" />
          </div>
        </div>
        <.input field={@form[:description]} type="textarea" label="Description" />
        <div class="flex gap-x-4">
          <div class="w-1/2">
            <.input field={@form[:start_date]} type="date" label="Start date" />
          </div>
          <div class="w-1/2">
            <.input field={@form[:end_date]} type="date" label="End date" />
          </div>
        </div>
        <.input field={@form[:risks]} type="text" label="Risks" />
        <:actions>
            <.button phx-disable-with="Saving...">Save Project</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{project: project} = assigns, socket) do
    changeset = Portfolio.change_project(project)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"project" => project_params}, socket) do
    changeset =
      socket.assigns.project
      |> Portfolio.change_project(project_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"project" => project_params}, socket) do
    save_project(socket, socket.assigns.action, project_params)
  end

  defp save_project(socket, :edit, project_params) do
    case Portfolio.update_project(socket.assigns.project, project_params) do
      {:ok, project} ->
        notify_parent({:saved, project})

        {:noreply,
         socket
         |> put_flash(:info, "Project updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_project(socket, :new, project_params) do
    case Portfolio.create_project(project_params) do
      {:ok, project} ->
        notify_parent({:saved, project})

        {:noreply,
         socket
         |> put_flash(:info, "Project created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
