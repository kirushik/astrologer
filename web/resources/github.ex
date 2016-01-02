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
    defstruct [:full_name, :stargazers_count, :forks_count]
  end

  defp get_starred(path \\ "/user/starred") do
    {:ok, %HTTPoison.Response{body: body, headers: headers}} = Client.get path
    {"Link", links} = List.keyfind headers, "Link", 0
    links = links |> String.split(", ") |> Enum.map(&(String.split(&1)))
    [next, _] = links |> Enum.find( &( [_ , "rel=\"next\""] = &1 ) )
    {Poison.decode!(body, as: [StarredRepo]), next}
  end

  #defp pop_starred({[], nil}) do
  #end
  #defp pop_starred({[], next}) do
  #end
  defp pop_starred({[repo | repos], next}) do
    {[repo], {repos, next}}
  end

  def starred do
    Stream.resource(&get_starred/0, &pop_starred/1, fn(_) -> end) # Last function is basically noop/1
  end

end
