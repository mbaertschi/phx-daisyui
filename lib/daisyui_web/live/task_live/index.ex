defmodule DaisyuiWeb.TaskLive.Index do
  @moduledoc false

  use DaisyuiWeb, :live_view

  import DaisyuiWeb.Page, only: [page: 1]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="tasks">
      <header>
        <h1 class="text-base-content text-2xl font-bold leading-7 md:truncate md:text-3xl md:tracking-tight">
          <%= ~t"Tasks"m %>
        </h1>
      </header>
    </.page>
    """
  end
end
