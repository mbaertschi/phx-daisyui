defmodule Storybook.Blocks.Header do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Blocks

  def function, do: &Blocks.Header.header/1

  def imports,
    do: [{Blocks.SecondaryNavigation, [secondary_navigation: 1, secondary_navigation_item: 1]}]

  def variations do
    [
      %Variation{
        id: :default,
        slots: [
          "Hello World"
        ]
      },
      %Variation{
        id: :with_a_subtitle,
        slots: [
          "Hello World",
          "<:subtitle>I'm a header subtitle</:subtitle>"
        ]
      },
      %Variation{
        id: :with_actions,
        slots: [
          "Hello World",
          "<:subtitle>I'm a header subtitle</:subtitle>",
          """
          <:actions>
            <button type="button" class="btn btn-neutral max-sm:btn-sm">Link</button>
          </:actions>
          """
        ]
      },
      %Variation{
        id: :with_actions_long,
        slots: [
          "This is a very very very long title to test what happens on the screen. Let's have a look at it.",
          "<:subtitle>This is alos a very very very long subtitle to test what happens on the screen. Let's have a look at it as well</:subtitle>",
          """
          <:actions>
            <button type="button" class="btn btn-neutral max-sm:btn-sm">Link</button>
          </:actions>
          """
        ]
      },
      %Variation{
        id: :with_secondary_navigation,
        slots: [
          "Hello World",
          "<:subtitle>I'm a header subtitle</:subtitle>",
          """
          <:actions>
            <button type="button" class="btn btn-neutral max-sm:btn-sm">Link</button>
          </:actions>
          <:after_title>
            <.secondary_navigation>
              <.secondary_navigation_item label="Overview" href="#" active />
              <.secondary_navigation_item label="Details" href="#" />
              <.secondary_navigation_item label="Settings" href="#" />
            </.secondary_navigation>
          </:after_title>
          """
        ]
      }
    ]
  end
end
