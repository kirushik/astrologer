defmodule Mix.Tasks.Database.Migrate do
  use Mix.Task

  import RethinkDB.Query

  @shortdoc "Creates desired table structure in RethinkDB"

  @moduledoc """
    This will connect to the current environment's database and create all missing tables for our schema
  """

  def run(_args) do
    Astrologer.Database.start_link([host: "localhost", port: 28015, db: "development"])
    table_create("repos", primaryKey: "full_name") |> Astrologer.Database.run
  end
end
