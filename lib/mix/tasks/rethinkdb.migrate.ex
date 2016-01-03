defmodule Mix.Tasks.Database.Migrate do
  use Mix.Task

  import RethinkDB.Query

  @shortdoc "Creates desired table structure in RethinkDB"

  @moduledoc """
    This will connect to the current environment's database and create all missing tables for our schema
  """

  def run(_args) do
    Astrologer.Database.start_link(Application.get_env(:astrologer, Astrologer.Database))
    table_create("repos", %{primary_key: "full_name"}) |> Astrologer.Database.run
  end
end
