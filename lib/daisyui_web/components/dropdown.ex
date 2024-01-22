defmodule DaisyuiWeb.Dropdown do
  @moduledoc """
  A component to render a dropdown with esc and click-away to close support.
  """

  use Phoenix.LiveComponent

  import DaisyuiWeb.CoreComponents, only: [icon: 1]

  alias Phoenix.LiveView.JS

  attr :id, :string, required: true, doc: "ID of the dropdown"
  attr :class, :string, default: nil, doc: "Class to add to the dropdown"
  attr :tooltip, :string, default: nil, doc: "Tooltip to add to the dropdown"
  attr :icon, :string, default: nil, doc: "Icon to add to the dropdown"
  attr :label, :string, default: nil, doc: "Label to add to the dropdown"

  slot :inner_block, required: true, doc: "Actual content of the dropdown"
  slot :summary, required: false, doc: "Custom summary of the dropdown"

  def dropdown(assigns) do
    ~H"""
    <details
      id={@id}
      class={[
        "dropdown hover:text-base-content",
        @class,
        @tooltip && "tooltip tooltip-bottom before:text-xs"
      ]}
      data-tip={@tooltip}
      phx-click-away={JS.remove_attribute("open", to: "##{@id}")}
      phx-window-keydown={JS.remove_attribute("open", to: "##{@id}")}
      phx-key="escape"
    >
      <%= if @summary != [] do %>
        <%= render_slot(@summary) %>
      <% else %>
        <summary class="btn btn-ghost text-base-content/75 hover:text-base-content">
          <.icon :if={@icon} name={@icon} class="size-6" />
          <span :if={@label}><%= @label %></span>
        </summary>
      <% end %>
      <%= render_slot(@inner_block) %>
    </details>
    """
  end
end
