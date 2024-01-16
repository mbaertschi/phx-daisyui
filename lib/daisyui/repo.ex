defmodule Daisyui.Repo do
  use Ecto.Repo,
    otp_app: :daisyui,
    adapter: Ecto.Adapters.Postgres
end
