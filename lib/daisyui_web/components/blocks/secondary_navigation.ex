defmodule DaisyuiWeb.Blocks.SecondaryNavigation do
  @moduledoc """
  Secondary navigation component.
  """

  use Phoenix.Component

  @doc """
  Renders a secondary, horizontal navigation which will scroll on small screens.
  """

  attr :id, :string, default: "secondary_navigation", doc: "ID of the navigation"
  attr :class, :string, default: nil, doc: "Class of the navigation"
  attr :gradient, :boolean, default: false, doc: "Whether to show a gradient on the edges"

  slot :inner_block, required: true, doc: "The navigation items"

  def secondary_navigation(assigns) do
    ~H"""
    <div class={[
      "border-black-white/10 bg-base-200/95 relative z-10 border-y backdrop-blur lg:scroll-px-8",
      @class
    ]}>
      <nav aria-labelledby={@id} class="no-scrollbar flex snap-x scroll-px-6 overflow-x-auto py-4">
        <h2 id={@id} class="sr-only">Secondary navigation</h2>
        <ul
          role="list"
          class="text-sm/6 text-base-content/75 flex min-w-full flex-none items-center gap-x-6 px-6 font-semibold lg:px-8"
        >
          <%= render_slot(@inner_block) %>
        </ul>
      </nav>
      <div
        :if={@gradient}
        class="from-base-200/95 absolute inset-x-0 top-0 h-14 w-6 bg-gradient-to-r"
      />
      <div :if={@gradient} class="from-base-200/95 absolute top-0 right-0 h-14 w-6 bg-gradient-to-l" />
      <div
        :if={@gradient}
        class="from-base-100 top-[calc(3.5rem+1px)] absolute h-6 w-full bg-gradient-to-b"
      />
    </div>
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
    <li class="snap-start">
      <.link
        navigate={@href}
        class={[
          @active && "text-primary",
          @active == false && "hover:text-base-content"
        ]}
      >
        <%= @label %>
      </.link>
    </li>
    """
  end
end
