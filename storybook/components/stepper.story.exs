defmodule Storybook.Components.Stepper do
  @moduledoc false
  use PhoenixStorybook.Story, :component

  alias DaisyuiWeb.Components.Stepper

  def function, do: &Stepper.stepper/1

  def variations do
    [
      %Variation{
        id: :default,
        attributes: %{
          steps: 4,
          current: 2
        }
      },
      %Variation{
        id: :with_links,
        attributes: %{
          links: ["#", "#", "#", "#"],
          current: 2
        }
      },
      %Variation{
        id: :with_disabled_links,
        attributes: %{
          steps: 4,
          links: [nil, "#", "#", nil],
          current: 2
        }
      }
    ]
  end
end
