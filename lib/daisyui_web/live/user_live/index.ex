defmodule DaisyuiWeb.UserLive.Index do
  @moduledoc false

  use DaisyuiWeb, :live_view

  import DaisyuiWeb.Layouts.Secondary, only: [page: 1]

  defstruct [:id, :first_name, :last_name, :email, :age]

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       current_id: 20,
       selected_user: nil,
       users: seed_users()
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="users" open={@selected_user != nil}>
      <div>
        <.page_header class="max-sm:mt-2" title_class="px-6 lg:px-8 mb-6 sm:mt-2" break_at="sm">
          <:breadcrumbs class="sm:-mb-1">
            <div class="flex items-center justify-between px-6 lg:px-8">
              <.breadcrumbs
                class="text-sm text-base-content/60 font-medium"
                items={[
                  %{label: ~t"Home"m, link: "#"},
                  %{label: ~t"Users"m, link: "#"},
                  %{label: ~t"Overview"m, link: "#"}
                ]}
              />
              <button
                type="button"
                class="btn btn-primary btn-sm sm:hidden"
                onclick="user_modal.showModal()"
              >
                <%= ~t"Create user"m %>
              </button>
            </div>
          </:breadcrumbs>
          <%= ~t"List of users"m %>
          <:subtitle><%= ~t"Feel free to add any missing user!"m %></:subtitle>
          <:actions class="max-sm:hidden">
            <button
              type="button"
              class="btn btn-primary max-lg:btn-sm"
              onclick="user_modal.showModal()"
            >
              <%= ~t"Create user"m %>
            </button>
          </:actions>
        </.page_header>
        <.secondary_navigation class="sticky top-[calc(4rem-1px)]" gradient>
          <.secondary_navigation_item label={~t"Overview"m} href={~p"/users"} active />
          <.secondary_navigation_item label={~t"Details"m} href={~p"/users"} />
          <.secondary_navigation_item label={~t"Settings"m} href={~p"/users"} />

          <li
            id="dynamic_add_button"
            class="-my-2 ml-auto snap-start opacity-0 transition-opacity duration-150 ease-in-out"
            data-show_y="40,sm:60,lg:76"
            phx-hook="ShowHideOnScroll"
          >
            <button type="button" class="btn btn-primary btn-sm" onclick="user_modal.showModal()">
              <%= ~t"Create user"m %>
            </button>
          </li>
        </.secondary_navigation>
        <div class="overflow-x-auto py-4">
          <.table
            id="user_table"
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
            <:col :let={user} label={~t"First name"m}>
              <%= user.first_name %>
            </:col>
            <:col :let={user} label={~t"Last name"m}>
              <%= user.last_name %>
            </:col>
            <:col :let={user} label={~t"Email"m}>
              <%= user.email %>
            </:col>
            <:col :let={user} label={~t"Age"m} class="text-right">
              <%= user.age %>
            </:col>

            <:action :let={user} class="-mx-3 -my-1.5 sm:-mx-2.5">
              <.table_actions id={"user_#{user.id}"}>
                <li>
                  <button
                    type="button"
                    class="hover:bg-primary hover:text-primary-content"
                    phx-click={JS.push("select_user", value: %{id: user.id})}
                  >
                    <%= ~t"View"m %>
                  </button>
                </li>
                <li>
                  <button type="button" class="hover:bg-primary hover:text-primary-content">
                    <%= ~t"Edit"m %>
                  </button>
                </li>
                <li>
                  <.link
                    phx-click={JS.push("delete", value: %{id: user.id})}
                    class="hover:bg-primary hover:text-primary-content"
                    data-confirm={~t"Are you sure?"m}
                  >
                    <%= ~t"Delete"m %>
                  </.link>
                </li>
              </.table_actions>
            </:action>
          </.table>
        </div>
      </div>
      <:secondary>
        <.slideover
          title={~t"User details"m}
          subtitle={~t"Displays the user settigns"m}
          open={@selected_user != nil}
          on_cancel={JS.push("select_user", value: %{id: nil})}
        >
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

          <:footer>
            <button
              type="button"
              class="btn btn-primary"
              phx-click={JS.push("select_user", value: %{id: nil})}
            >
              Close
            </button>
          </:footer>
        </.slideover>
      </:secondary>
      <:portal>
        <.modal id="user_modal" responsive backdrop={false}>
          <.simple_form
            :let={f}
            for={%{}}
            as={:user}
            phx-submit={JS.push("create") |> JS.dispatch("submit:close")}
          >
            <.fieldset
              legend={~t"Create new user"m}
              text={~t"This won't be persisted into DB, memory only"m}
            >
              <.fieldgroup>
                <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 sm:gap-4">
                  <.field field={f[:first_name]} label={~t"First name"m} required />
                  <.field field={f[:last_name]} label={~t"Last name"m} required />
                </div>
                <div class="grid grid-cols-1 gap-8 sm:grid-cols-3 sm:gap-4">
                  <div class="sm:col-span-2">
                    <.field field={f[:email]} label={~t"EMail"m} type="email" required />
                  </div>
                  <.field field={f[:age]} label={~t"Age"m} type="number" required />
                </div>
              </.fieldgroup>
            </.fieldset>
            <:actions>
              <button type="submit" class="btn btn-primary"><%= ~t"Save user"m %></button>
              <button type="reset" class="btn btn-ghost"><%= ~t"Reset"m %></button>
              <button type="button" class="btn btn-ghost" onclick="user_modal.close()">
                <%= ~t"Cancel"m %>
              </button>
            </:actions>
          </.simple_form>
        </.modal>
      </:portal>
    </.page>
    """
  end

  @impl true
  def handle_event("create", %{"user" => params}, socket) do
    user = %__MODULE__{
      first_name: params["first_name"],
      last_name: params["last_name"],
      email: params["email"],
      age: params["age"],
      id: socket.assigns.current_id + 1
    }

    {:noreply,
     socket
     |> put_flash(:info, ~t"User created successfully"m)
     |> update(:users, &(&1 ++ [user]))
     |> update(:current_id, &(&1 + 1))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> put_flash(:info, ~t"User deleted successfully"m)
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

  defp seed_users do
    for i <- 1..20 do
      %__MODULE__{
        id: i,
        first_name: "John-#{i}",
        last_name: "Doe",
        email: "john-$#{i}.doe@example",
        age: 20 + i
      }
    end
  end
end
