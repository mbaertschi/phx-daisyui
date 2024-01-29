defmodule DaisyuiWeb.Components.Input do
  @moduledoc """
  Input components.
  """

  use Phoenix.Component

  alias Phoenix.HTML.Form

  import DaisyuiWeb.Components.Icon, only: [icon: 1]

  @doc """
  Renders an input with label and error messages.

  A `Phoenix.HTML.FormField` may be passed as argument,
  which is used to retrieve the input name, id, and values.
  Otherwise all attributes may be passed explicitly.

  ## Types

  This function accepts all HTML input types, considering that:

    * You may also set `type="select"` to render a `<select>` tag

    * `type="checkbox"` is used exclusively to render boolean values

    * For live file uploads, see `Phoenix.Component.live_file_input/1`

  See https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input
  for more information.

  ## Examples

      <.input field={@form[:email]} type="email" />
      <.input name="my-input" errors={["oh no!"]} />
  """
  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any

  attr :type, :string,
    default: "text",
    values: ~w(checkbox color date datetime-local email file hidden month number password
               range radio search select tel text textarea time url week)

  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :description, :string, default: nil, doc: "the description for the input"

  attr :errors, :list, default: []
  attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  attr :prompt, :string, default: nil, doc: "the prompt for select inputs"
  attr :options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2"
  attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"
  attr :class, :string, default: nil, doc: "additinal css class for input"

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  slot :inner_block

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn -> Form.normalize_value("checkbox", assigns[:value]) end)

    ~H"""
    <div
      phx-feedback-for={@name}
      class="form-control grid-cols-[1.125rem] grid items-center gap-x-4 gap-y-1 sm:grid-cols-[1rem]"
    >
      <input type="hidden" name={@name} value="false" />
      <input
        type="checkbox"
        id={@id}
        name={@name}
        value="true"
        checked={@checked}
        class={[
          "checkbox col-start-1 row-start-1 justify-self-center",
          @errors != [] && "phx-feedback:checkbox-error",
          @class
        ]}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      />
      <.label
        :if={@label}
        for={@id}
        class="col-start-2 row-start-1 justify-self-start pb-0"
        required={@rest[:required]}
        disabled={@rest[:disabled]}
      >
        <%= @label %>
      </.label>
      <.description :if={@description && @errors == []} class="col-start-2 row-start-2">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="col-start-2 row-start-2" />
    </div>
    """
  end

  def input(%{type: "radio"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn -> Form.normalize_value("radio", assigns[:value]) end)

    ~H"""
    <div
      phx-feedback-for={@name}
      class="form-control grid-cols-[1.125rem] grid items-center gap-x-4 gap-y-1 sm:grid-cols-[1rem]"
    >
      <input type="hidden" name={@name} value="false" />
      <input
        type="radio"
        id={@id}
        name={@name}
        value="true"
        checked={@checked}
        class={[
          "radio col-start-1 row-start-1 justify-self-center",
          @errors != [] && "phx-feedback:radio-error",
          @class
        ]}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      />
      <.label
        :if={@label}
        for={@id}
        class="col-start-2 row-start-1 justify-self-start pb-0"
        required={@rest[:required]}
        disabled={@rest[:disabled]}
      >
        <%= @label %>
      </.label>
      <.description :if={@description && @errors == []} class="col-start-2 row-start-2">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="col-start-2 row-start-2" />
    </div>
    """
  end

  def input(%{type: "select"} = assigns) do
    ~H"""
    <div
      phx-feedback-for={@name}
      class={["form-control w-full", @errors != [] && "[&_select]:phx-feedback:select-error"]}
    >
      <.label :if={@label} for={@id} required={@rest[:required]} disabled={@rest[:disabled]}>
        <%= @label %>
      </.label>

      <select
        id={@id}
        name={@name}
        class={["select select-bordered", @class]}
        multiple={@multiple}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      >
        <option :if={@prompt} value=""><%= @prompt %></option>
        <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
      </select>

      <.description :if={@description && @errors == []} class="mt-3">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="mt-3" />
    </div>
    """
  end

  def input(%{type: "textarea"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="form-control w-full">
      <.label :if={@label} for={@id} required={@rest[:required]} disabled={@rest[:disabled]}>
        <%= @label %>
      </.label>

      <textarea
        name={@name}
        id={@id}
        class={["textarea textarea-bordered", @errors != [] && "phx-feedback:textarea-error", @class]}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>

      <.description :if={@description && @errors == []} class="mt-3">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="mt-3" />
    </div>
    """
  end

  def input(%{type: "range"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="form-control w-full">
      <.label :if={@label} for={@id} required={@rest[:required]} disabled={@rest[:disabled]}>
        <%= @label %>
      </.label>

      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value("range", @value)}
        class={["range", @errors != [] && "phx-feedback:range-error", @class]}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      />

      <.description :if={@description && @errors == []} class="mt-3">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="mt-3" />
    </div>
    """
  end

  def input(%{type: "search"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="form-control w-full">
      <.label :if={@label} for={@id} required={@rest[:required]} disabled={@rest[:disabled]}>
        <%= @label %>
      </.label>

      <div class="relative w-full">
        <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
          <.icon name="hero-magnifying-glass" class="w-5 h-5 text-base-content/50" />
        </div>

        <input
          type="search"
          name={@name}
          id={@id}
          value={Phoenix.HTML.Form.normalize_value(@type, @value)}
          class={[
            "input input-bordered !pl-10 w-full rounded-full",
            @errors != [] && "phx-feedback:input-error",
            @class
          ]}
          aria-invalid={@errors != []}
          aria-describedby={@errors != [] && "#{@id}-error"}
          {@rest}
        />
      </div>

      <.description :if={@description && @errors == []} class="mt-3">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="mt-3" />
    </div>
    """
  end

  # All other inputs text, datetime-local, url, password, etc. are handled here...
  def input(assigns) do
    ~H"""
    <div phx-feedback-for={@name} class="form-control w-full">
      <.label :if={@label} for={@id} required={@rest[:required]} disabled={@rest[:disabled]}>
        <%= @label %>
      </.label>

      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={["input input-bordered", @errors != [] && "phx-feedback:input-error", @class]}
        aria-invalid={@errors != []}
        aria-describedby={@errors != [] && "#{@id}-error"}
        {@rest}
      />

      <.description :if={@description && @errors == []} class="mt-3">
        <%= @description %>
      </.description>
      <.errors errors={@errors} id={@id} class="mt-3" />
    </div>
    """
  end

  @doc """
  Renders a label.
  """
  attr :for, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :string, default: nil
  slot :inner_block, required: true

  def label(assigns) do
    ~H"""
    <label for={@for} class={["label px-0 pt-0", @class]}>
      <span class={[
        "label-text text-base/6 font-medium sm:text-sm/6",
        @required && "after:content-['*']",
        @disabled && "text-base-content/50"
      ]}>
        <%= render_slot(@inner_block) %>
      </span>
    </label>
    """
  end

  attr :class, :string, default: nil, doc: "additinal css class for description"
  slot :inner_block, required: true

  def description(assigns) do
    ~H"""
    <p class={["text-base-content/60 text-base/6 sm:text-sm/6", @class]}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  @doc """
  Generates a generic error message.
  """
  attr :id, :string, required: true
  attr :class, :string, default: nil
  attr :errors, :list, required: true

  def errors(assigns) do
    ~H"""
    <p
      :if={@errors != []}
      id={"#{@id}-error"}
      class={["text-base/6 phx-no-feedback:hidden sm:text-sm/6", @class]}
    >
      <span :for={msg <- @errors} class="text-error"><%= msg %></span>
    </p>
    """
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(DaisyuiWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(DaisyuiWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end
end
