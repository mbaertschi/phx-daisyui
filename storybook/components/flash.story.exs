defmodule Storybook.Components.Flash do
  @moduledoc false
  use PhoenixStorybook.Story, :component

  alias DaisyuiWeb.Components

  def function, do: &Components.Flash.flash/1
  def imports, do: [{Components.Transitions, [show: 1]}]

  def template do
    """
    <button type="button" class="btn btn-primary" phx-click={show("#:variation_id")} psb-code-hidden>
      Open flash
    </button>
    <.psb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :info_no_title,
        attributes: %{
          kind: :info,
          hidden: true
        },
        slots: ["Info message"]
      },
      %Variation{
        id: :error_with_title,
        attributes: %{
          kind: :error,
          hidden: true,
          title: "Flash title"
        },
        slots: ["Error message"]
      },
      %Variation{
        id: :no_close_button,
        attributes: %{
          kind: :info,
          hidden: true,
          close: false
        },
        slots: ["Info message"]
      }
    ]
  end
end
