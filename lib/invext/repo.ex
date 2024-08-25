defmodule Invext.Repo do
  use Ecto.Repo,
    otp_app: :invext,
    adapter: Ecto.Adapters.Postgres
end
