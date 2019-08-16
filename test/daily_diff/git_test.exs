defmodule DailyDiff.GitTest do
  use DailyDiff.DataCase

  alias DailyDiff.Git

  describe "repos" do
    alias DailyDiff.Git.Repo

    @valid_attrs %{url: "some url"}
    @update_attrs %{url: "some updated url"}
    @invalid_attrs %{url: nil}

    def repo_fixture(attrs \\ %{}) do
      {:ok, repo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Git.create_repo()

      repo
    end

    test "list_repos/0 returns all repos" do
      repo = repo_fixture()
      assert Git.list_repos() == [repo]
    end

    test "get_repo!/1 returns the repo with given id" do
      repo = repo_fixture()
      assert Git.get_repo!(repo.id) == repo
    end

    test "create_repo/1 with valid data creates a repo" do
      assert {:ok, %Repo{} = repo} = Git.create_repo(@valid_attrs)
      assert repo.url == "some url"
    end

    test "create_repo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Git.create_repo(@invalid_attrs)
    end

    test "update_repo/2 with valid data updates the repo" do
      repo = repo_fixture()
      assert {:ok, %Repo{} = repo} = Git.update_repo(repo, @update_attrs)
      assert repo.url == "some updated url"
    end

    test "update_repo/2 with invalid data returns error changeset" do
      repo = repo_fixture()
      assert {:error, %Ecto.Changeset{}} = Git.update_repo(repo, @invalid_attrs)
      assert repo == Git.get_repo!(repo.id)
    end

    test "delete_repo/1 deletes the repo" do
      repo = repo_fixture()
      assert {:ok, %Repo{}} = Git.delete_repo(repo)
      assert_raise Ecto.NoResultsError, fn -> Git.get_repo!(repo.id) end
    end

    test "change_repo/1 returns a repo changeset" do
      repo = repo_fixture()
      assert %Ecto.Changeset{} = Git.change_repo(repo)
    end
  end
end
