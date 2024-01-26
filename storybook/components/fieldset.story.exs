defmodule Storybook.Components.Fieldset do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Components

  def function, do: &Components.Form.fieldset/1

  def imports,
    do: [{Components.Form, [simple_form: 1, fieldgroup: 1]}, {Components.Input, [input: 1]}]

  def template do
    """
    <.simple_form :let={f} for={%{}} as={:story} class="w-full">
      <.psb-variation/>
    </.simple_form>
    """
  end

  def variations do
    [
      %Variation{
        id: :basic_example,
        attributes: %{
          legend: "Shipping details",
          text: "Without this your odds of getting your order are low."
        },
        slots: [default_form_content()]
      },
      %Variation{
        id: :without_legend,
        attributes: %{
          "aria-label": "Shipping details"
        },
        slots: [default_form_content()]
      },
      %Variation{
        id: :with_grid_layout,
        attributes: %{
          legend: "Shipping details",
          text: "Without this your odds of getting your order are low."
        },
        slots: [grid_form_content()]
      }
    ]
  end

  def default_form_content do
    """
    <.fieldgroup>
      <.input field={f[:street_address]} label="Street address" required />
      <.input
        field={f[:country]}
        label="Country"
        description="We currently only ship to North America."
        required
        type="select"
        options={["Canada", "Mexico", "United States"]}
      />
      <.input
        field={f[:notes]}
        label="Delivery notes"
        description="If you have a tiger, we'd like to know about it."
        type="textarea"
        required
      />
    </.fieldgroup>
    """
  end

  def grid_form_content do
    """
    <.fieldgroup>
      <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 sm:gap-4">
        <.input field={f[:first_name]} label="First name" required />
        <.input field={f[:last_name]} label="Last name" required />
      </div>

      <.input field={f[:street_address]} label="Street address" required />
      <div class="grid grid-cols-1 gap-8 sm:grid-cols-3 sm:gap-4">
        <div class="sm:col-span-2">
          <.input
            field={f[:country]}
            label="Country"
            description="We currently only ship to North America."
            required
            type="select"
            options={["Canada", "Mexico", "United States"]}
          />
        </div>
        <.input field={f[:postal_code]} label="Postal code" required />
      </div>
      <.input
        field={f[:notes]}
        label="Delivery notes"
        description="If you have a tiger, we'd like to know about it."
        type="textarea"
        required
      />
      <.input
        field={f[:field]}
        label="Checkbox input"
        description="Checkbox input description"
        type="checkbox"
        required
      />
    </.fieldgroup>
    <.fieldgroup class="space-y-0">
      <.input
        field={f[:field]}
        label="Private"
        description="Your data is private and will not be shared with anyone."
        type="radio"
        required
      />
      <.input
        field={f[:field]}
        label="Public"
        description="Your data is public and will be shared with everyone."
        type="radio"
        required
      />
    </.fieldgroup>
    """
  end
end
