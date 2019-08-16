defmodule DailyDiffWeb.PageController do
  use DailyDiffWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
