defmodule DaisyuiWeb.CustomComponents do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      import DaisyuiWeb.{
        Drawer,
        Dropdown,
        LocaleSelect
      }

      use DaisyuiWeb.ThemeSelect
    end
  end
end
