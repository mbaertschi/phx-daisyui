defmodule Storybook.Components.Table do
  use PhoenixStorybook.Story, :component
  alias DaisyuiWeb.Components

  def function, do: &Components.Table.table/1
  def aliases, do: [Storybook.Components.Table.User]

  def variations do
    [
      %Variation{
        id: :table,
        attributes: %{
          rows:
            {:eval,
             ~s"""
             [
               %User{id: 1, username: "jose"},
               %User{id: 2, username: "chris"}
             ]
             """}
        },
        slots: [
          """
          <:col :let={user} label="Id">
            <%= user.id %>
          </:col>
          """,
          """
          <:col :let={user} label="User name">
            <%= user.username %>
          </:col>
          """
        ]
      }
    ]
  end
end

defmodule Storybook.Components.Table.User do
  defstruct [:id, :username]
end
