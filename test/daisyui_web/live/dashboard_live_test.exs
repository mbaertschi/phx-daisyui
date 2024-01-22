defmodule DaisyuiWeb.DashboardLiveTest do
  @moduledoc false

  use DaisyuiWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "Index" do
    test "renders dashboard", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Home"
    end
  end
end
