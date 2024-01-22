defmodule DaisyuiWeb.Page do
  @moduledoc """
  Generic page component, rendering the page layout and portal slot in isolated stacks.
  """

  use DaisyuiWeb, :live_component

  embed_templates("shared/*")

  attr :current, :string, required: true, doc: "Current page"
  attr :with_secondary, :boolean, default: false, doc: "Whether to render layout secondary column"

  slot :inner_block, required: true
  slot :portal, doc: "Portal slot for modal, dialog, etc."
  slot :secondary, doc: "Aside slot for secondary column"

  def page(assigns) do
    ~H"""
    <.drawer id="sidebar-nav" class="isolate md:drawer-open" side_class="pr-px" overlay>
      <%= if @with_secondary do %>
        <.drawer
          id="secondary-column"
          class="drawer-end 3xl:drawer-open fix-drawer-end-pointer-events"
          side_class="pl-px"
          checked={@secondary != []}
        >
          <%= main_content(assigns) %>
          <:side>
            <%= render_slot(@secondary) %>
          </:side>
        </.drawer>
      <% else %>
        <%= main_content(assigns) %>
      <% end %>

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

  defp main_content(assigns) do
    ~H"""
    <div id="main-wrapper" class="h-dvh overflow-y-auto" phx-hook="MainScrollListener">
      <%!-- Static topbar --%>
      <.appbar />

      <%!-- Main area --%>
      <main class="p-6 lg:px-8">
        <%= render_slot(@inner_block) %>
      </main>
    </div>
    """
  end

  defp version_tag do
    {:ok, vsn} = :application.get_key(:daisyui, :vsn)
    List.to_string(vsn)
  end
end
