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

  def starred do
    {:ok, %HTTPoison.Response{body: body}} = Client.get "/user/starred"
    body |> Poison.decode!(as: [StarredRepo])
  end

end
