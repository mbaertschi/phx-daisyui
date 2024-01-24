defmodule Storybook.Layouts.Secondary do
  use PhoenixStorybook.Story, :example

  import DaisyuiWeb.Layouts.Secondary, only: [page: 1]

  def doc,
    do:
      "Sidebar navigation with sticky app-bar and main content area and an dynamic secondary sidebar on the right side."

  @impl true
  def render(assigns) do
    ~H"""
    <.page current="home">
      <header>
        <h1 class="text-base-content text-2xl font-bold leading-7 md:truncate md:text-3xl md:tracking-tight">
          Dashbaord
        </h1>
      </header>
      <:secondary>
        <div class="bg-base-100 border-white/5 outline-black/5 min-h-screen w-80 border-l p-4 outline outline-1">
        </div>
      </:secondary>
    </.page>
    """
  end
end
