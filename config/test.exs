import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wol, WolWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "j00l2IfJ2dYzRRK6KTOzS5j+l0UKfG1XrcL6Z8Zy9scxTmQXRxDH22tq6uH5SomE",
  server: false

# In test we don't send emails.
config :wol, Wol.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
