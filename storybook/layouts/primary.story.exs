defmodule Storybook.Layouts.Primary do
  use PhoenixStorybook.Story, :example

  import DaisyuiWeb.Layouts.Primary, only: [page: 1]

  def doc, do: "Sidebar navigation with sticky app-bar and main content area."

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="records">
      <header>
        <h1 class="text-base-content text-2xl font-bold leading-7 md:truncate md:text-3xl md:tracking-tight">
          Records
        </h1>
      </header>
    </.page>
    """
  end
end
