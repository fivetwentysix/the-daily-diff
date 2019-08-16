defmodule DailyDiffWeb.RepoControllerTest do
  use DailyDiffWeb.ConnCase

  alias DailyDiff.Git

  @create_attrs %{url: "some url"}
  @update_attrs %{url: "some updated url"}
  @invalid_attrs %{url: nil}

  def fixture(:repo) do
    {:ok, repo} = Git.create_repo(@create_attrs)
    repo
  end

  describe "index" do
    test "lists all repos", %{conn: conn} do
      conn = get(conn, Routes.repo_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Repos"
    end
  end

  describe "new repo" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.repo_path(conn, :new))
      assert html_response(conn, 200) =~ "New Repo"
    end
  end

  describe "create repo" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.repo_path(conn, :create), repo: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.repo_path(conn, :show, id)

      conn = get(conn, Routes.repo_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Repo"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.repo_path(conn, :create), repo: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Repo"
    end
  end

  describe "edit repo" do
    setup [:create_repo]

    test "renders form for editing chosen repo", %{conn: conn, repo: repo} do
      conn = get(conn, Routes.repo_path(conn, :edit, repo))
      assert html_response(conn, 200) =~ "Edit Repo"
    end
  end

  describe "update repo" do
    setup [:create_repo]

    test "redirects when data is valid", %{conn: conn, repo: repo} do
      conn = put(conn, Routes.repo_path(conn, :update, repo), repo: @update_attrs)
      assert redirected_to(conn) == Routes.repo_path(conn, :show, repo)

      conn = get(conn, Routes.repo_path(conn, :show, repo))
      assert html_response(conn, 200) =~ "some updated url"
    end

    test "renders errors when data is invalid", %{conn: conn, repo: repo} do
      conn = put(conn, Routes.repo_path(conn, :update, repo), repo: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Repo"
    end
  end

  describe "delete repo" do
    setup [:create_repo]

    test "deletes chosen repo", %{conn: conn, repo: repo} do
      conn = delete(conn, Routes.repo_path(conn, :delete, repo))
      assert redirected_to(conn) == Routes.repo_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.repo_path(conn, :show, repo))
      end
    end
  end

  defp create_repo(_) do
    repo = fixture(:repo)
    {:ok, repo: repo}
  end
end
