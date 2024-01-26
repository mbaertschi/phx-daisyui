defmodule Storybook.Examples.ControlledModal do
  use PhoenixStorybook.Story, :example
  use DaisyuiWeb.Components
  use DaisyuiWeb.Blocks

  alias Phoenix.LiveView.JS

  def doc do
    "An example of how to use a modal in a controlled way."
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       show: false
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section>
      <button type="button" class="btn" phx-click="show">
        Open modal
      </button>

      <.modal :if={@show} id="modal" show responsive backdrop={false} on_cancel={JS.push("hide")}>
        <.header>
          Create new user
          <:subtitle>This won't be persisted into DB, memory only</:subtitle>
        </.header>
        <.simple_form :let={f} for={%{}} as={:user} phx-submit={JS.push("save")}>
          <.input field={f[:first_name]} label="First name" required value="First" />
          <.input field={f[:last_name]} label="Last name" required value="Second" />
          <.input field={f[:email]} label="EMail" type="email" required value="email@example.com" />
          <.input field={f[:age]} label="Age" type="number" required value="33" />
          <:actions class="modal-action">
            <button type="button" class="btn btn-ghost" onclick="modal.close()">
              Cancel
            </button>
            <button type="reset" class="btn btn-ghost">Reset</button>
            <button type="submit" class="btn">Save user</button>
          </:actions>
        </.simple_form>
      </.modal>

      <.flash_group flash={@flash} />
    </section>
    """
  end

  @impl true
  def handle_event("save", %{"user" => params}, socket) do
    {:noreply,
     socket
     |> put_flash(:info, inspect(params))
     |> assign(:show, false)}
  end

  @impl true
  def handle_event("show", _, socket) do
    {:noreply, assign(socket, :show, true)}
  end

  @impl true
  def handle_event("hide", _, socket) do
    {:noreply, assign(socket, :show, false)}
  end
end
