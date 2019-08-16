defmodule DailyDiffWeb.RepoController do
  use DailyDiffWeb, :controller

  alias DailyDiff.Git
  alias DailyDiff.Git.Repo

  def index(conn, _params) do
    repos = Git.list_repos()
    render(conn, "index.html", repos: repos)
  end

  def new(conn, _params) do
    changeset = Git.change_repo(%Repo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repo" => repo_params}) do
    case Git.create_repo(repo_params) do
      {:ok, repo} ->
        conn
        |> put_flash(:info, "Repo created successfully.")
        |> redirect(to: Routes.repo_path(conn, :show, repo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    repo = Git.get_repo!(id)
    render(conn, "show.html", repo: repo)
  end

  def edit(conn, %{"id" => id}) do
    repo = Git.get_repo!(id)
    changeset = Git.change_repo(repo)
    render(conn, "edit.html", repo: repo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "repo" => repo_params}) do
    repo = Git.get_repo!(id)

    case Git.update_repo(repo, repo_params) do
      {:ok, repo} ->
        conn
        |> put_flash(:info, "Repo updated successfully.")
        |> redirect(to: Routes.repo_path(conn, :show, repo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", repo: repo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    repo = Git.get_repo!(id)
    {:ok, _repo} = Git.delete_repo(repo)

    conn
    |> put_flash(:info, "Repo deleted successfully.")
    |> redirect(to: Routes.repo_path(conn, :index))
  end
end
