defmodule DaisyuiWeb.Layouts.Secondary do
  @moduledoc """
  Secondary column layout component.
  """

  use Phoenix.Component
  use DaisyuiWeb.Components
  use DaisyuiWeb, :verified_routes

  import DaisyuiWeb.Gettext

  embed_templates("shared/*")

  attr(:current, :string, required: true, doc: "Current page")

  slot(:inner_block, required: true)
  slot(:portal, doc: "Portal slot for modal, dialog, etc.")
  slot(:secondary, doc: "Aside slot for secondary column")

  def page(assigns) do
    ~H"""
    <.drawer id="sidebar-nav" class="isolate md:drawer-open" side_class="pr-px" overlay>
      <.drawer
        id="secondary-column"
        class="drawer-end 3xl:drawer-open fix-drawer-end-pointer-events"
        side_class="pl-px"
        checked={@secondary != []}
      >
        <.main {assigns} />
        <:side>
          <%= render_slot(@secondary) %>
        </:side>
      </.drawer>

      <:side>
        <.sidebar current={@current} />
      </:side>
    </.drawer>

    <%!-- All registered portals are rendered in an isolated stack--%>
    <div id="portal-root" class="isolate">
      <%= for portal <- @portal do %>
        <%= render_slot(portal) %>
      <% end %>
    </div>
    """
  end

  defp version_tag do
    {:ok, vsn} = :application.get_key(:daisyui, :vsn)
    List.to_string(vsn)
  end
end