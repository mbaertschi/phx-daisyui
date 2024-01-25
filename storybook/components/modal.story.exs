defmodule Storybook.Components.Modal do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Blocks
  alias DaisyuiWeb.Components

  def function, do: &Components.Modal.modal/1

  def imports,
    do: [
      {Blocks.Header, [header: 1]},
      {Components.Input, [input: 1]},
      {Components.SimpleForm, [simple_form: 1]}
    ]

  def template do
    """
    <button type="button" class="btn" onclick="document.getElementById(':variation_id').showModal()" psb-code-hidden>
      Open modal
    </button>
    <.psb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        slots: [content()]
      },
      %Variation{
        id: :no_backdrop,
        attributes: %{
          backdrop: false
        },
        slots: [content()]
      },
      %Variation{
        id: :responsive,
        attributes: %{
          responsive: true
        },
        slots: [content()]
      },
      %Variation{
        id: :with_close_button,
        attributes: %{
          responsive: true
        },
        slots: [content_with_close("modal-single-with-close-button")]
      },
      %Variation{
        id: :with_on_close,
        attributes: %{
          responsive: true,
          on_cancel: JS.dispatch("storybook:console:log")
        },
        slots: [content_with_close("modal-single-with-on-close")]
      },
      %Variation{
        id: :with_form,
        attributes: %{
          backdrop: false,
          responsive: true
        },
        slots: [content_with_form("modal-single-with-form")]
      }
    ]
  end

  def content do
    """
    <.header>
      Title
      <:subtitle>With a subtitle</:subtitle>
    </.header>
    """
  end

  def content_with_close(id) do
    """
    <.header>
      Title
      <:subtitle>With a subtitle</:subtitle>
    </.header>
    <div class="modal-action">
      <button type="button" class="btn btn-ghost" onclick="getElementById('#{id}').close()">
        Close
      </button>
    </div>
    """
  end

  def content_with_form(id) do
    """
    <.header>
      Create new user
      <:subtitle>This won't be persisted into DB, memory only</:subtitle>
    </.header>

    <.simple_form
      :let={f}
      for={%{}}
      as={:user}
      phx-submit={JS.push("save_user") |> JS.dispatch("submit:close")}
    >
      <.input field={f[:first_name]} label="First name" />
      <.input field={f[:last_name]} label="Last name" />
      <.input field={f[:email]} label="EMail" type="email" />
      <.input field={f[:age]} label="Age" type="number" />

      <:actions class="modal-action">
        <button type="button" class="btn btn-ghost" onclick="document.getElementById('#{id}').close()">
          Cancel
        </button>
        <button type="reset" class="btn btn-ghost">Reset</button>
        <button type="submit" class="btn">Save user</button>
      </:actions>
    </.simple_form>
    """
  end
end
