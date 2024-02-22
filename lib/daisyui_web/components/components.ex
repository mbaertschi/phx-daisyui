defmodule DaisyuiWeb.Components do
  @moduledoc """
  This module is used to import all components, blocks, and live_components at once.
  """

  defmacro __using__(_) do
    quote do
      use DaisyuiWeb.LiveComponents.ThemeSelect

      import DaisyuiWeb.Components.Alert
      import DaisyuiWeb.Components.Badge
      import DaisyuiWeb.Components.Breadcrumbs
      import DaisyuiWeb.Components.Drawer
      import DaisyuiWeb.Components.Dropdown
      import DaisyuiWeb.Components.Field
      import DaisyuiWeb.Components.Flash
      import DaisyuiWeb.Components.Form
      import DaisyuiWeb.Components.Icon
      import DaisyuiWeb.Components.Input
      import DaisyuiWeb.Components.List
      import DaisyuiWeb.Components.LocaleSelect
      import DaisyuiWeb.Components.Modal
      import DaisyuiWeb.Components.Progress
      import DaisyuiWeb.Components.Table
      import DaisyuiWeb.Components.Transitions
    end
  end
end
