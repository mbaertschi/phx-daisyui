defmodule DaisyuiWeb.Layouts.Primary do
  @moduledoc """
  Primary layout component.
  """

  use Phoenix.Component
  use DaisyuiWeb.Components
  use DaisyuiWeb, :verified_routes

  import DaisyuiWeb.Gettext

  embed_templates "shared/*"

  attr :current, :string, required: true, doc: "Current page"

  slot :inner_block, required: true
  slot :portal, doc: "Portal slot for modal, dialog, etc."

  def page(assigns) do
    ~H"""
    <.drawer id="sidebar-nav" class="isolate md:drawer-open" side_class="pr-px" overlay>
      <.main {assigns} />

      <:side>
        <.sidebar current={@current} />
      </:side>
    </.drawer>

    <%!-- All registered portals are rendered in an isolated stack--%>
    <div id="portal-root" class="isolate">
      <%!-- <.alert id="alert" size="xs" /> --%>
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
