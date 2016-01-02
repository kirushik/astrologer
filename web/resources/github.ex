defmodule Astrologer.Github do
  defmodule Client do
    use HTTPoison.Base
    @endpoint "https://api.github.com"
    @token Application.get_env(:astrologer, Astrologer.Endpoint)[:access_token]

    defp process_url(url), do: @endpoint <> url
    defp process_request_headers(headers), do: headers ++ [{"Authorization", "token #{@token}"}]
  end

  def starred do
    {:ok, %HTTPoison.Response{body: body}} = Client.get "/user/starred"
    body
  end

end
