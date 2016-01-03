defmodule Astrologer.Github do
  defmodule Client do
    use HTTPoison.Base
    @endpoint "https://api.github.com"
    @token Application.get_env(:astrologer, Astrologer.Endpoint)[:access_token]

    defp process_url(<<"http", _ :: binary>>=url), do: url
    defp process_url(url), do: Path.join(@endpoint, url)
    defp process_request_headers(headers), do: headers ++ [{"Authorization", "token #{@token}"}]
  end

  defmodule StarredRepo do
    defstruct [:full_name, :description, :html_url, :homepage]

    import RethinkDB.Query

    defp repos, do: table("repos")

    def persist(%StarredRepo{} = repo) do
      repos |> insert(Map.from_struct(repo)) |> Astrologer.Database.run
    end
  end

  defp extract_next links do
    next = links |> String.split(", ")
                 |> Enum.map(&(String.split(&1)))
                 |> Enum.find( &( List.last(&1) == "rel=\"next\"" ) )
    case next do
      nil -> nil
      [next, _] -> Regex.run(~r/<(.+)>;/, next) |> List.last
    end
  end

  defp get_starred(path \\ "/user/starred") do
    {:ok, %HTTPoison.Response{body: body, headers: headers}} = Client.get path

    {"Link", links} = List.keyfind headers, "Link", 0
    next = extract_next(links)

    {Poison.decode!(body, as: [StarredRepo]), next}
  end

  defp pop_starred({[], nil}) do
    {:halt, :ok}
  end
  defp pop_starred({[], next}) do
    {[repo | repos], next} = get_starred next
    {[repo], {repos, next}}
  end
  defp pop_starred({[repo | repos], next}) do
    {[repo], {repos, next}}
  end

  def starred do
    Stream.resource(&get_starred/0, &pop_starred/1, fn(_) -> :ok end)
  end

end
