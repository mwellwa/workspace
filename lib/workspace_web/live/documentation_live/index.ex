defmodule Workspace.DocumentationLive.Index do
  use WorkspaceWeb, :live_view

  use Phoenix.Component
  use Phoenix.HTML

  use Phoenix.VerifiedRoutes,
    endpoint: WorkspaceWeb.Endpoint,
    router: WorkspaceWeb.Router

  alias Workspace.Documentation

  attr :project, :any, required: true
  attr :documents, :list, required: true

  def document_list(assigns) do
    # document_name = String.replace(adoc_name, " ", "_")

    # IO.inspect(assigns, label: "===== Document List Assigns =====")

    ~H"""
    <div class="w-full grid gap-0">
      <.document
        :for={{label, i} <- Enum.with_index(@documents)}
        project={@project}
        label={label}
        index={i}
      >
        <:actions>
          <.link patch={~p"/projects/#{@project.id}/show/#{label}/upload"} phx-click={JS.push_focus()}>
            <button class="flex space-x-1 justify-center py-2 px-3 text-sm text-white font-semibold rounded-md bg-slate-900 cursor-pointer hover:bg-slate-700">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                class="w-5 h-5 mr-1 text-gray-50 text-md font-semibold"
              >
                <path d="M9.25 13.25a.75.75 0 001.5 0V4.636l2.955 3.129a.75.75 0 001.09-1.03l-4.25-4.5a.75.75 0 00-1.09 0l-4.25 4.5a.75.75 0 101.09 1.03L9.25 4.636v8.614z" />
                <path d="M3.5 12.75a.75.75 0 00-1.5 0v2.5A2.75 2.75 0 004.75 18h10.5A2.75 2.75 0 0018 15.25v-2.5a.75.75 0 00-1.5 0v2.5c0 .69-.56 1.25-1.25 1.25H4.75c-.69 0-1.25-.56-1.25-1.25v-2.5z" />
              </svg>
              Upload Document
            </button>
          </.link>
        </:actions>
      </.document>
    </div>
    """
  end

  attr :project, :any, required: true
  attr :label, :string, required: true
  attr :index, :integer, required: true

  slot :actions

  def document(%{project: %{id: project_id}, label: label} = assigns) do
    documents = Documentation.get_documents_by_project_and_label(project_id, label)

    ~H"""
    <div class="mt-4 p-4 space-y-6 border-2 rounded-md border-slate-200">
      <%= if !Enum.empty?(documents) do %>
        <% [head | tail] = documents %>
        <div class="flex items-center space-x-2">
          <h3 class="text-lg text-slate-800 font-semibold capitalize"><%= @label %></h3>
          <span class="inline-flex items-center rounded-full bg-yellow-50 px-2.5 py-1 text-xs font-medium text-yellow-800
       ring-1 ring-inset ring-yellow-600/20">
            Awaiting Approval
          </span>
        </div>
        <div class="flex items-center space-x-2">
          <p class="text-sm font-semibold text-slate-600"><%= head.file_name %></p>
          <.link href={~p"/download/#{head.uuid}"} target="_blank">
            <button class="flex items-center justify-center py-1.5 pl-1.5 pr-2.5 text-xs text-blue-700 font-semibold
             border border-blue-700 rounded-full cursor-pointer hover:text-white hover:bg-blue-700">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                class="w-4 h-4 mr-1 text-md"
              >
                <path d="M10.75 2.75a.75.75 0 00-1.5 0v8.614L6.295 8.235a.75.75 0 10-1.09 1.03l4.25 4.5a.75.75 0 001.09 0l4.25-4.5a.75.75 0 00-1.09-1.03l-2.955 3.129V2.75z" />
                <path d="M3.5 12.75a.75.75 0 00-1.5 0v2.5A2.75 2.75 0 004.75 18h10.5A2.75 2.75 0 0018 15.25v-2.5a.75.75 0 00-1.5 0v2.5c0 .69-.56 1.25-1.25 1.25H4.75c-.69 0-1.25-.56-1.25-1.25v-2.5z" />
              </svg>
              Download
            </button>
          </.link>
        </div>
        <div class="flex items-center justify-end space-x-4">
          <.link
            class="p-2 text-sm text-gray-500 font-semibold bg-gray-50 rounded-md"
            patch={~p"/projects/#{project_id}/show/#{label}/history"}
            phx-click={JS.push_focus()}
          >
            Version History
          </.link>
          <div class="flex-none">
            <.link
              class="flex space-x-1 justify-center py-2 px-3 text-sm text-white font-semibold
              border-2 rounded-md bg-slate-900 cursor-pointer hover:bg-slate-700"
              patch={~p"/projects/#{@project.id}/show/#{label}/upload"}
              phx-click={JS.push_focus()}
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                class="w-5 h-5 mr-1 text-gray-50 text-md font-semibold"
              >
                <path d="M9.25 13.25a.75.75 0 001.5 0V4.636l2.955 3.129a.75.75 0 001.09-1.03l-4.25-4.5a.75.75 0 00-1.09 0l-4.25 4.5a.75.75 0 101.09 1.03L9.25 4.636v8.614z" />
                <path d="M3.5 12.75a.75.75 0 00-1.5 0v2.5A2.75 2.75 0 004.75 18h10.5A2.75 2.75 0 0018 15.25v-2.5a.75.75 0 00-1.5 0v2.5c0 .69-.56 1.25-1.25 1.25H4.75c-.69 0-1.25-.56-1.25-1.25v-2.5z" />
              </svg>
              Update Document
            </.link>
          </div>
        </div>
      <% else %>
        <div class="flex items-center space-x-2">
          <h3 class="text-lg text-slate-800 font-semibold capitalize"><%= @label %></h3>
        </div>
        <div class="flex-none"><%= render_slot(@actions) %></div>
      <% end %>
    </div>
    """
  end

  # def document(%{project: %{id: project_id}, name: name} = assigns) do
  #   # IO.inspect(assigns, label: "===== Document Assigns =====")

  #   documents = Documentation.get_documents_by_project_and_label(project_id, name)
  #   [head | tail] = documents

  #   IO.inspect(head, label: "===== Head in document component (Name: #{name}) =====")
  #   IO.inspect(tail, label: "===== Tail in document component (Name: #{name}) =====")
  #   IO.inspect(documents, label: "===== Documents in document component (Name: #{name}) =====")

  #   # For the vie component:
  #   # <p><%= head.file_name %></p>
  #   # <.link href={~p"/download/#{head.uuid}"} phx-target="_blank">
  #   #   Download
  #   # </.link>

  #   ~H"""
  #   <div class="mt-4 p-4 space-y-2 border rounded-md border-slate-200">
  #     <h3 class="capitalize"><%= @name %></h3>
  #     <%= if !Enum.empty?(documents) do %>
  #       <p>If you are seeing this it means a document was attached</p>
  #       <p><%= head.file_name %></p>
  #       <.link href={~p"/download/#{head.uuid}"} phx-target="_blank">
  #         Download
  #       </.link>
  #       <p>Version History</p>
  #       <div class="flex-none"><%= render_slot(@actions) %></div>
  #     <% else %>
  #       <div class="flex-none"><%= render_slot(@actions) %></div>
  #     <% end %>
  #   </div>
  #   """
  # end
end
