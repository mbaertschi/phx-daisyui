defmodule DaisyuiWeb.Storybook do
  @moduledoc false

  use PhoenixStorybook,
    otp_app: :daisyui_web,
    content_path: Path.expand("../../storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/storybook.css",
    js_path: "/assets/storybook.js",
    sandbox_class: "daisyui-web",
    themes: [
      default: [name: "Default"],
      light: [name: "Light"],
      dark: [name: "Dark"]
    ]
end
