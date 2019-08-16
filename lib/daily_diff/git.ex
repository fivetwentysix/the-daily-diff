defmodule DailyDiff.Git do
  @moduledoc """
  The Git context.
  """

  import Ecto.Query, warn: false
  alias DailyDiff.Repo

  require DailyDiff.Git.Repo

  @doc """
  Returns the list of repos.

  ## Examples

      iex> list_repos()
      [%Repo{}, ...]

  """
  def list_repos do
    Repo.all(DailyDiff.Git.Repo)
  end

  @doc """
  Gets a single repo.

  Raises `Ecto.NoResultsError` if the Repo does not exist.

  ## Examples

      iex> get_repo!(123)
      %Repo{}

      iex> get_repo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repo!(id), do: Repo.get!(DailyDiff.Git.Repo, id)

  @doc """
  Creates a repo.

  ## Examples

      iex> create_repo(%{field: value})
      {:ok, %Repo{}}

      iex> create_repo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repo(attrs \\ %{}) do
    %DailyDiff.Git.Repo{}
    |> DailyDiff.Git.Repo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repo.

  ## Examples

      iex> update_repo(repo, %{field: new_value})
      {:ok, %Repo{}}

      iex> update_repo(repo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repo(%DailyDiff.Git.Repo{} = repo, attrs) do
    repo
    |> Repo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Repo.

  ## Examples

      iex> delete_repo(repo)
      {:ok, %Repo{}}

      iex> delete_repo(repo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repo(%DailyDiff.Git.Repo{} = repo) do
    Repo.delete(repo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repo changes.

  ## Examples

      iex> change_repo(repo)
      %Ecto.Changeset{source: %Repo{}}

  """
  def change_repo(%DailyDiff.Git.Repo{} = repo) do
    DailyDiff.Git.Repo.changeset(repo, %{})
  end
end
