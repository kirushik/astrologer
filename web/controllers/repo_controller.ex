defmodule Astrologer.RepoController do
  use Astrologer.Web, :controller

  def index(conn, params) do
    {page, ""} = (params["page"] || "1") |> Integer.parse
    conn
    |> assign(:repos, Astrologer.Github.StarredRepo.index(page))
    |> assign(:page, page)
    |> assign(:pages, Astrologer.Github.StarredRepo.pages)
    |> render("index.html")
  end
end
