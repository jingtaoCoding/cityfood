defmodule Cityfood.Repo do
  use Ecto.Repo,
    otp_app: :cityfood,
    adapter: Ecto.Adapters.Postgres
end
