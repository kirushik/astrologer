use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :astrologer, Astrologer.Endpoint,
  http: [port: 4001],
  server: false

config :astrologer, Astrologer.Database,
  [host: "localhost", port: 28015, db: "test"]

# Print only warnings and errors during test
config :logger, level: :warn
