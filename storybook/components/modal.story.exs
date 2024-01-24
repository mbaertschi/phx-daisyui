defmodule Storybook.Components.Modal do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Components

  def function, do: &Components.Modal.modal/1
  def imports, do: [{Components.Modal, [hide_modal: 1, show_modal: 1]}]

  def template do
    """
    <button type="button" class="btn" phx-click={show_modal(":variation_id")} psb-code-hidden>
      Open modal
    </button>
    <.psb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        slots: ["Modal body"]
      }
    ]
  end
end
