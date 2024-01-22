defmodule DaisyuiWeb.ThemeSelectTest do
  @moduledoc false

  use DaisyuiWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "theme select" do
    test "applies default theme to system", %{conn: conn} do
      {:ok, _, html} = live(conn, "/")
      assert html =~ "hero-computer-desktop size-6 swap-off"
      assert html =~ "hero-moon size-6 swap-on"
      assert html =~ "hero-sun size-6 swap-on"
    end

    test "cycles theme to dark on click", %{conn: conn} do
      {:ok, view, html} = live(conn, "/")
      assert html =~ "hero-computer-desktop size-6 swap-off"
      assert html =~ "hero-moon size-6 swap-on"
      assert html =~ "hero-sun size-6 swap-on"

      html =
        assert view
               |> element("#theme-selector")
               |> render_click()

      assert html =~ "hero-computer-desktop size-6"
      assert html =~ "hero-moon size-6 swap-off"
      assert html =~ "hero-sun size-6 swap-on"
    end

    test "cycles theme to light on click", %{conn: conn} do
      {:ok, view, html} = live(conn, "/")
      assert html =~ "hero-computer-desktop size-6 swap-off"
      assert html =~ "hero-moon size-6 swap-on"
      assert html =~ "hero-sun size-6 swap-on"

      html =
        assert view
               |> element("#theme-selector")
               |> render_click()

      assert html =~ "hero-computer-desktop size-6"
      assert html =~ "hero-moon size-6 swap-off"
      assert html =~ "hero-sun size-6 swap-on"

      html =
        assert view
               |> element("#theme-selector")
               |> render_click()

      assert html =~ "hero-computer-desktop size-6"
      assert html =~ "hero-moon size-6 swap-on"
      assert html =~ "hero-sun size-6 swap-off"
    end
  end
end
