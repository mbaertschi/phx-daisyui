defmodule DaisyuiWeb.Blocks.SecondaryNavigation do
  @moduledoc """
  Secondary navigation component.
  """

  use Phoenix.Component

  @doc """
  Renders a secondary, horizontal navigation which will scroll on small screens.
  """

  slot :inner_block, required: true, doc: "The navigation items"

  def secondary_navigation(assigns) do
    ~H"""
    <nav
      aria-labelledby="secondary_navigation"
      class="border-black-white/10 bg-base-200/80 no-scrollbar flex overflow-x-auto border-y py-4"
    >
      <h2 id="secondary_navigation" class="sr-only">Secondary navigation</h2>
      <ul
        role="list"
        class="text-sm/6 text-base-content/75 flex min-w-full flex-none gap-x-6 px-6 font-semibold lg:px-8"
      >
        <%= render_slot(@inner_block) %>
      </ul>
    </nav>
    """
  end

  @doc """
  Renders a secondary navigation item.
  """

  attr :label, :string, required: true, doc: "Label of the item"
  attr :href, :string, required: true, doc: "URL of the item"
  attr :active, :boolean, default: false, doc: "Whether the item is active"

  def secondary_navigation_item(assigns) do
    ~H"""
    <li>
      <.link
        navigate={@href}
        class={[@active && "text-primary", @active == false && "hover:text-base-content"]}
      >
        <%= @label %>
      </.link>
    </li>
    """
  end
end
