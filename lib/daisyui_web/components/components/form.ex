defmodule DaisyuiWeb.Components.Form do
  @moduledoc """
  Simple form components.
  """
  use Phoenix.Component

  @doc """
  Renders a simple form.

  ## Examples

      <.simple_form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:email]} label="Email"/>
        <.input field={@form[:username]} label="Username" />
        <:actions>
          <button type="submit" class="btn btn-primary">Save</button>
        </:actions>
      </.simple_form>
  """
  attr :for, :any, required: true, doc: "the datastructure for the form"
  attr :as, :any, default: nil, doc: "the server side parameter to collect all input under"

  attr :rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target multipart),
    doc: "the arbitrary HTML attributes to apply to the form tag"

  slot :inner_block, required: true

  slot :actions, doc: "the slot for form actions, such as a submit button" do
    attr :class, :string, doc: "the class to apply to the actions container"
  end

  def simple_form(assigns) do
    ~H"""
    <.form :let={f} for={@for} as={@as} {@rest}>
      <%= render_slot(@inner_block, f) %>
      <div :for={action <- @actions} class={[action[:class] || "modal-action"]}>
        <%= render_slot(action, f) %>
      </div>
    </.form>
    """
  end

  @doc """
  Something has to hold all these form controls together.

  Use the <.fieldset /> and <.fieldgroup /> components to group a subset of form
  controls together:

  ## Examples

      <.simple_form :let={f} for={%{}} as="user" phx-change="validate" phx-submit="save">
        <.fieldset legend="Personal Information">
          <.input field={@f[:email]} label="Email"/>
          <.input field={@f[:username]} label="Username" />
        </.fieldset>
        <.fieldset legend="Address">
          <.input field={@f[:address]} label="Address"/>
          <.input field={@f[:city]} label="City" />
          <.input field={@f[:state]} label="State" />
          <.input field={@f[:zip]} label="Zip" />
        </.fieldset>
        <:actions>
          <button type="submit" class="btn btn-primary">Save</button>
        </:actions>
      </.simple_form>
  """
  attr :legend, :string, default: nil, doc: "the legend for the fieldset"
  attr :text, :string, default: nil, doc: "the text for the fieldset"
  attr :class, :string, default: nil, doc: "the class to apply to the fieldset"
  attr :disabled, :boolean, default: false, doc: "whether the fieldset is disabled"
  attr :rest, :global, doc: "the arbitrary HTML attributes to apply to the fieldset tag"

  slot(:inner_block, required: true)

  def fieldset(assigns) do
    ~H"""
    <fieldset class={["[&>*+[data-slot=control]]:mt-6", @class]} role="group" {@rest}>
      <legend
        :if={@legend}
        class={[
          "label-text text-base/6 font-semibold sm:text-sm/6",
          @disabled && "text-base-content/50"
        ]}
      >
        <%= @legend %>
      </legend>
      <p
        :if={@text}
        class={[
          "mt-1 text-base leading-6 sm:text-sm",
          if(@disabled, do: "text-base-content/50", else: "text-base-content/60")
        ]}
      >
        <%= @text %>
      </p>
      <%= render_slot(@inner_block) %>
    </fieldset>
    """
  end

  attr :class, :string, default: "space-y-8", doc: "the class to apply to the fieldgroup"
  slot :inner_block, required: true

  def fieldgroup(assigns) do
    ~H"""
    <div class={@class} data-slot="control">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
