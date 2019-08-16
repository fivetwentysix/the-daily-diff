defmodule DailyDiff.Git.Repo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "repos" do
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(repo, attrs) do
    repo
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
