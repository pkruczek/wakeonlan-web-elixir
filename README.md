# Wol

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Helper
Run tcpdump to test magic packets:
```bash
tcpdump -UlnXi eth0 ether proto 0x0842 or udp port 9 2>/dev/null | sed -nE 's/^.*20:  (ffff|.... ....) (..)(..) (..)(..) (..)(..).*$/\2:\3:\4:\5:\6:\7/p'
```