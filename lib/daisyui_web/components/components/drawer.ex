defmodule DaisyuiWeb.Components.Drawer do
  @moduledoc """
  A component to render a generic drawer.
  """

  use Phoenix.Component

  attr :id, :string, required: true, doc: "ID of the drawer"
  attr :class, :string, default: nil, doc: "Class to add to the drawer"
  attr :content_class, :string, default: nil, doc: "Class to add to the drawer content"
  attr :side_class, :string, default: nil, doc: "Class to add to the side content"
  attr :overlay, :boolean, default: false, doc: "Whether to show an overlay or not"
  attr :checked, :boolean, default: nil, doc: "Manually set the drawer to be open or not"

  slot :inner_block, required: true, doc: "Actual content of the drawer"
  slot :side, required: true, doc: "Sidebar wrapper"

  def drawer(assigns) do
    ~H"""
    <div class={["drawer", @class]}>
      <input id={@id} type="checkbox" class="drawer-toggle" checked={@checked} />
      <div class={["drawer-content", @content_class]}>
        <%= render_slot(@inner_block) %>
      </div>
      <aside class={["drawer-side z-10", @side_class]}>
        <label :if={@overlay} for={@id} class="drawer-overlay" aria-label={"Close #{@id}"} />
        <%= render_slot(@side) %>
      </aside>
    </div>
    """
  end
end
