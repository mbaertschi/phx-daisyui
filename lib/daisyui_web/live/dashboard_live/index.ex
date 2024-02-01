defmodule DaisyuiWeb.DashboardLive.Index do
  @moduledoc false

  use DaisyuiWeb, :live_view

  import DaisyuiWeb.Layouts.Primary, only: [page: 1]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="home">
      <.header><%= ~t"Home"m %></.header>
    </.page>
    """
  end
end
