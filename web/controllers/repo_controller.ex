defmodule Astrologer.RepoController do
  use Astrologer.Web, :controller

  def index(conn, params) do
    conn
    |> assign(:repos, Astrologer.Github.StarredRepo.index(params["page"]))
    |> render("index.html")
  end
end
