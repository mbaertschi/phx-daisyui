defmodule DaisyuiWeb.Components.Modal do
  @moduledoc """
  Modal components.
  """

  use Phoenix.Component

  alias Phoenix.LiveView.JS

  import DaisyuiWeb.Gettext

  @doc """
  Renders a modal.

  ## Examples

      <.modal id="confirm-modal">
        This is a modal.
      </.modal>

  JS commands may be passed to the `:on_cancel` to configure
  the closing/cancel event, for example:

      <.modal id="confirm" on_cancel={JS.navigate(~p"/posts")}>
        This is another modal.
      </.modal>

  """
  attr :id, :string, required: true
  attr :class, :string, default: nil, doc: "Additional CSS classes to add to the modal box."
  attr :show, :boolean, default: false, doc: "Whether the modal visibility is controlled."
  attr :on_cancel, JS, default: %JS{}, doc: "JS commands to run when the modal is closed."
  attr :responsive, :boolean, default: false, doc: "Show at bottom on small screens."
  attr :backdrop, :boolean, default: true, doc: "Show a backdrop behind the modal."
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the modal box."

  slot :inner_block, required: true, doc: "The modal content."

  def modal(assigns) do
    ~H"""
    <dialog
      id={@id}
      class={["modal", @responsive && "modal-bottom sm:modal-middle"]}
      phx-hook="ModalHook"
      data-show={@show}
      data-cancel={@on_cancel}
    >
      <div class={["modal-box", @class]} {@rest}>
        <.focus_wrap id={"#{@id}-content"}>
          <form method="dialog">
            <button
              class="btn btn-sm btn-circle btn-ghost absolute top-2 right-2"
              aria-label={~t"close"m}
            >
              ✕
            </button>
          </form>
          <%= render_slot(@inner_block) %>
        </.focus_wrap>
      </div>
      <form :if={@backdrop} method="dialog" class="modal-backdrop">
        <button><%= ~t"close"m %></button>
      </form>
    </dialog>
    """
  end
end
