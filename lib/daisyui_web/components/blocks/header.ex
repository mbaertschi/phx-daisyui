defmodule DaisyuiWeb.Blocks.Header do
  @moduledoc """
  Header component.
  """

  use Phoenix.Component

  @doc """
  Renders a header with title, subtitle and actions.
  """
  attr :class, :string, default: nil, doc: "the header class"
  attr :action_class, :string, default: "flex gap-x-3"
  attr :id, :string, default: nil

  slot :inner_block, required: true
  slot :subtitle, doc: "the optional subtitle displayed below the title"
  slot :actions, doc: "the optional actions displayed on the right side of the header"
  slot :before_title, doc: "the optional content displayed before the title"
  slot :after_title, doc: "the optional content displayed after the title"

  def header(assigns) do
    ~H"""
    <header class={["min-h-12 w-full", @class]}>
      <%= render_slot(@before_title) %>
      <div class="flex flex-col flex-col-reverse items-start justify-between gap-3 p-6 sm:flex-row sm:gap-6 lg:px-8">
        <div class="min-w-0 flex-1 sm:pr-6">
          <h1 class="text-base-content text-lg/9 line-clamp-2 font-semibold">
            <%= render_slot(@inner_block) %>
          </h1>
          <p :if={@subtitle != []} class="text-base-content/50 text-sm/6 line-clamp-3 mt-2">
            <%= render_slot(@subtitle) %>
          </p>
        </div>
        <div class={@action_class}><%= render_slot(@actions) %></div>
      </div>
      <%= render_slot(@after_title) %>
    </header>
    """
  end
end
