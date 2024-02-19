defmodule DaisyuiWeb.Blocks do
  @moduledoc """
  This module is used to import all blocks at once.
  """

  defmacro __using__(_) do
    quote do
      import DaisyuiWeb.Blocks.{
        EmptyState,
        Header,
        SecondaryNavigation,
        Slideover
      }
    end
  end
end
