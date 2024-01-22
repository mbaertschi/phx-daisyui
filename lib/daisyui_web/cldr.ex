defmodule DaisyuiWeb.Cldr do
  @moduledoc false

  use Cldr,
    locales: DaisyuiWeb.Locale.locales(),
    gettext: DaisyuiWeb.Gettext,
    otp_app: :daisyui,
    providers: [],
    force_locale_download: false,
    generate_docs: true
end
