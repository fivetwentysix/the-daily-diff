defmodule DailyDiffWeb.PageController do
  use DailyDiffWeb, :controller
  
  alias DailyDiff.Git
  alias DailyDiff.Git.Repo

  def index(conn, _params) do
    repos = Git.list_repos()
    changeset = Git.change_repo(%DailyDiff.Git.Repo{})
    render(conn, "index.html", changeset: changeset, repos: repos)
  end
end
