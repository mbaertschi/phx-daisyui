defmodule DaisyuiWeb.Blocks do
  @moduledoc """
  This module is used to import all blocks at once.
  """

  defmacro __using__(_) do
    quote do
      import DaisyuiWeb.Blocks.EmptyState
      import DaisyuiWeb.Blocks.Header
      import DaisyuiWeb.Blocks.SecondaryNavigation
      import DaisyuiWeb.Blocks.Slideover
    end
  end
end
