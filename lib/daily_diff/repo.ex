defmodule DailyDiff.Repo do
  use Ecto.Repo,
    otp_app: :daily_diff,
    adapter: Ecto.Adapters.Postgres
end
