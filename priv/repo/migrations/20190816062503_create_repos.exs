defmodule DailyDiff.Repo.Migrations.CreateRepos do
  use Ecto.Migration

  def change do
    create table(:repos) do
      add :url, :text

      timestamps()
    end

  end
end
