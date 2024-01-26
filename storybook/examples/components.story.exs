defmodule Storybook.Examples.Components do
  use PhoenixStorybook.Story, :example
  use DaisyuiWeb.Components
  use DaisyuiWeb.Blocks

  import DaisyuiWeb.Layouts.Secondary, only: [page: 1]

  alias Phoenix.LiveView.JS

  def doc do
    "An example of what you can achieve with Phoenix core components."
  end

  defstruct [:id, :first_name, :last_name, :email, :age]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       current_id: 2,
       selected_user: nil,
       users: [
         %__MODULE__{
           id: 1,
           first_name: "Jose",
           last_name: "Valim",
           email: "jose.valim@example.com",
           age: 33
         },
         %__MODULE__{
           id: 2,
           first_name: "Chris",
           last_name: "McCord",
           email: "chris.mscord@example.com",
           age: 28
         }
       ]
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="home" open={@selected_user != nil}>
      <div class="grid gap-y-4">
        <.header>
          List of users
          <:subtitle>Feel free to add any missing user!</:subtitle>
          <:actions>
            <button type="button" class="btn" onclick="show_modal.showModal()">
              Create user
            </button>
          </:actions>
        </.header>
        <div class="overflow-x-auto pb-4">
          <.table
            id="user-table"
            rows={@users}
            row_click={
              fn user ->
                JS.push("select_user", value: %{id: user.id})
              end
            }
          >
            <:col :let={user} label="Id" class="font-semibold">
              <%= user.id %>
            </:col>
            <:col :let={user} label="First name">
              <%= user.first_name %>
            </:col>
            <:col :let={user} label="Last name">
              <%= user.last_name %>
            </:col>
            <:col :let={user} label="Email">
              <%= user.email %>
            </:col>
            <:col :let={user} label="Age" class="text-right">
              <%= user.age %>
            </:col>

            <:action :let={user} class="-mx-3 -my-1.5 sm:-mx-2.5">
              <.dropdown id={"user-#{user.id}"} class="dropdown-left">
                <:summary>
                  <summary class="btn btn-sm btn-ghost btn-square text-base-content/75 hover:text-base-content">
                    <.icon name="hero-ellipsis-horizontal" class="size-4" />
                  </summary>
                </:summary>
                <ul class="dropdown-content menu menu-sm bg-base-200 rounded-box border-white/5 outline-black/5 z-10 w-28 gap-1 border p-2 shadow-lg outline outline-1">
                  <li>
                    <button
                      type="button"
                      class="hover:bg-primary hover:text-primary-content"
                      phx-click={JS.push("select_user", value: %{id: user.id})}
                    >
                      View
                    </button>
                  </li>
                  <li>
                    <button type="button" class="hover:bg-primary hover:text-primary-content">
                      Edit
                    </button>
                  </li>
                  <li>
                    <.link
                      phx-click={JS.push("delete", value: %{id: user.id})}
                      data-confirm="Are you sure?"
                    >
                      Delete
                    </.link>
                  </li>
                </ul>
              </.dropdown>
            </:action>
          </.table>
        </div>
      </div>
      <:secondary>
        <div class="bg-base-100 border-white/5 outline-black/5 divide-base-content/10 flex min-h-screen w-96 flex-col divide-y border-l outline outline-1 md:ml-6">
          <div :if={@selected_user} class="flex min-h-0 flex-1 flex-col overflow-y-scroll p-4">
            <.header>
              User details
              <:subtitle><%= full_name(@selected_user) %></:subtitle>
              <:actions>
                <button
                  type="button"
                  class="btn btn-square btn-ghost drawer-button"
                  phx-click={JS.push("select_user", value: %{id: nil})}
                >
                  <.icon name="hero-x-mark-mini" class="size-5 md:size-6" />
                </button>
              </:actions>
            </.header>

            <.list>
              <:item title="ID">
                <%= @selected_user.id %>
              </:item>
              <:item title="First name">
                <%= @selected_user.first_name %>
              </:item>
              <:item title="Last name">
                <%= @selected_user.last_name %>
              </:item>
              <:item title="Email">
                <%= @selected_user.email %>
              </:item>
              <:item title="Age">
                <%= @selected_user.age %>
              </:item>
            </.list>
          </div>
          <div class="flex flex-shrink-0 justify-end p-4">
            <button type="button" class="btn" phx-click={JS.push("select_user", value: %{id: nil})}>
              Close
            </button>
          </div>
        </div>
      </:secondary>
      <:portal>
        <.modal id="show_modal" responsive backdrop={false}>
          <.simple_form
            :let={f}
            for={%{}}
            as={:user}
            phx-submit={JS.push("save_user") |> JS.dispatch("submit:close")}
          >
            <.fieldset legend="Create new user" text="This won't be persisted into DB, memory only">
              <.fieldgroup>
                <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 sm:gap-4">
                  <.input field={f[:first_name]} label="First name" required />
                  <.input field={f[:last_name]} label="Last name" required />
                </div>
                <div class="grid grid-cols-1 gap-8 sm:grid-cols-3 sm:gap-4">
                  <div class="sm:col-span-2">
                    <.input field={f[:email]} label="EMail" type="email" required />
                  </div>
                  <.input field={f[:age]} label="Age" type="number" required />
                </div>
              </.fieldgroup>
            </.fieldset>
            <:actions>
              <button type="button" class="btn btn-ghost" onclick="show_modal.close()">
                Cancel
              </button>
              <button type="reset" class="btn btn-ghost">Reset</button>
              <button type="submit" class="btn">Save user</button>
            </:actions>
          </.simple_form>
        </.modal>
        <.flash_group class="isolate psb-z-20" flash={@flash} />
      </:portal>
    </.page>
    """
  end

  @impl true
  def handle_event("save_user", %{"user" => params}, socket) do
    user = %__MODULE__{
      first_name: params["first_name"],
      last_name: params["last_name"],
      email: params["email"],
      age: params["age"],
      id: socket.assigns.current_id + 1
    }

    {:noreply,
     socket
     |> put_flash(:info, "User created successfully")
     |> update(:users, &(&1 ++ [user]))
     |> update(:current_id, &(&1 + 1))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> put_flash(:info, "User deleted successfully")
     |> update(:users, &List.delete_at(&1, find_index(socket, id)))}
  end

  @impl true
  def handle_event("select_user", %{"id" => id}, socket) do
    socket =
      assign(socket, :selected_user, find_user(socket, id))

    {:noreply, socket}
  end

  def full_name(%__MODULE__{} = user) do
    "#{user.first_name} #{user.last_name}"
  end

  defp find_user(socket, id) do
    Enum.find(socket.assigns.users, &(&1.id == id))
  end

  def find_index(socket, id) do
    Enum.find_index(socket.assigns.users, &(&1.id == id))
  end
end
