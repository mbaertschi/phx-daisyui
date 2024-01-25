defmodule DaisyuiWeb.DashboardLive.Index do
  @moduledoc false

  use DaisyuiWeb, :live_view

  import DaisyuiWeb.Layouts.Secondary, only: [page: 1]

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :show, false)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="home">
      <div class="grid gap-y-4">
        <.header><%= ~t"Home"m %></.header>

        <section class="h-screen">
          <button type="button" class="btn btn-primary drawer-button mt-10" phx-click="toggle">
            <span :if={@show}><%= ~t"Hide"m %></span>
            <span :if={!@show}><%= ~t"Open"m %></span>
          </button>
        </section>
      </div>

      <:secondary :if={@show}>
        <div class="bg-base-100 border-white/5 outline-black/5 min-h-screen w-80 border-l p-4 outline outline-1">
        </div>
      </:secondary>
    </.page>
    """
  end

  @impl true
  def handle_event("toggle", _, socket) do
    socket = update(socket, :show, &(!&1))

    {:noreply, socket}
  end
end
