defmodule Storybook.Components.Input do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Components

  def function, do: &Components.Input.input/1
  def imports, do: [{Components.SimpleForm, [simple_form: 1]}]

  def template do
    """
    <.simple_form :let={f} for={%{}} as={:story} class="w-full">
      <.psb-variation-group field={f[:field]}/>
    </.simple_form>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :basic_inputs,
        variations:
          for type <- ~w(text textarea number date color range checkbox)a do
            %Variation{
              id: type,
              attributes: %{
                type: to_string(type),
                label: String.capitalize("#{type} input")
              }
            }
          end
      },
      %Variation{
        id: :select,
        attributes: %{
          label: "Select input",
          type: "select",
          options: ["Option 1", "Option 2", "Option 3"]
        }
      }
    ]
  end
end