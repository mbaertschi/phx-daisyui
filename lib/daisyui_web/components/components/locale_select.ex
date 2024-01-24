defmodule DaisyuiWeb.Components.LocaleSelect do
  @moduledoc """
  A component to select the current color mode.
  """

  use Phoenix.Component

  alias Phoenix.LiveView.JS

  import DaisyuiWeb.Components.Dropdown, only: [dropdown: 1]

  @locales DaisyuiWeb.Locale.locales()

  attr :id, :string, default: "locale-selector"

  def locale_select(assigns) do
    ~H"""
    <div id={"#{@id}-wrapper"} phx-hook="LocaleSelect">
      <.dropdown id={@id} class="dropdown-end" label={short(current())} icon="hero-language">
        <ul class="dropdown-content menu menu-sm bg-base-200 rounded-box border-white/5 outline-black/5 top-px mt-16 w-44 gap-1 border p-2 shadow-2xl outline outline-1">
          <li :for={option <- options()}>
            <button
              class={option.selected && "active"}
              phx-click={
                JS.dispatch("set-locale", to: "#locale-selector-wrapper", detail: option.value)
              }
            >
              <span class="badge badge-sm badge-outline font-mono text-[.6rem] pt-px pr-1 pl-1.5 font-bold tracking-widest opacity-50">
                <%= option.short %>
              </span>
              <span class="font-[sans-serif]"><%= option.name %></span>
            </button>
          </li>
        </ul>
      </.dropdown>
    </div>
    """
  end

  defp options do
    Enum.map(@locales, fn locale ->
      option(locale)
    end)
  end

  defp option(value) do
    %{
      value: value,
      short: short(value),
      name: name(value),
      selected: current?(value)
    }
  end

  defp short(%Cldr.LanguageTag{} = locale) do
    short(to_string(locale))
  end

  defp short(locale) when is_binary(locale) do
    case locale do
      "de-CH" -> "DE"
      "fr-CH" -> "FR"
      _ -> "EN"
    end
  end

  defp name(%Cldr.LanguageTag{} = locale) do
    name(to_string(locale))
  end

  defp name(locale) when is_binary(locale) do
    case locale do
      "de-CH" -> "Deutsch"
      "fr-CH" -> "Français"
      _ -> "English"
    end
  end

  defp current?(%Cldr.LanguageTag{} = locale) do
    locale == current()
  end

  defp current?(locale) when is_binary(locale) do
    locale == to_string(current())
  end

  defp current do
    DaisyuiWeb.Locale.current()
  end
end
