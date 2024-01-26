defmodule DaisyuiWeb.Helpers do
  @moduledoc """
  Helper functions for the application.
  """

  @doc ~S"""
  Returns a string of class names from a list of class names.

  ## Examples

      iex> DaisyuiWeb.Helpers.class_names(["foo", "bar"])
      "foo bar"

      iex> DaisyuiWeb.Helpers.class_names(["foo", nil, "bar"])
      "foo bar"

      iex> DaisyuiWeb.Helpers.class_names(["foo", "", "bar"])
      "foo bar"

      iex> DaisyuiWeb.Helpers.class_names(["foo", false, "bar"])
      "foo bar"

      iex> DaisyuiWeb.Helpers.class_names(["foo", true, "bar"])
      "foo true bar"

      iex> DaisyuiWeb.Helpers.class_names(["foo", 1, "bar"])
      "foo 1 bar"

      iex> DaisyuiWeb.Helpers.class_names(["foo", 0, "bar"])
      "foo 0 bar"
  """
  @spec class_names([String.t()]) :: String.t()
  def class_names(class_names) do
    class_names
    |> Enum.filter(& &1)
    |> Enum.join(" ")
    |> String.trim()
    |> String.replace(~r/\s+/, " ")
  end
end
