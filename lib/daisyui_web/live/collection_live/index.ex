defmodule DaisyuiWeb.CollectionLive.Index do
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
    <.page current="collections">
      <.page_header class="px-6 lg:px-8 md:py-6"><%= ~t"Collections"m %></.page_header>
    </.page>
    """
  end
end
