defmodule DaisyuiWeb.Components do
  @moduledoc """
  This module is used to import all components, blocks, and live_components at once.
  """

  defmacro __using__(_) do
    quote do
      import DaisyuiWeb.Components.{
        Drawer,
        Dropdown,
        Flash,
        Icon,
        Input,
        List,
        LocaleSelect,
        Modal,
        SimpleForm,
        Table,
        Transitions
      }

      use DaisyuiWeb.LiveComponents.ThemeSelect
    end
  end
end
